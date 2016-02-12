From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Gated Merge?
Date: Fri, 12 Feb 2016 11:06:04 -0800
Message-ID: <xmqq1t8hvjdv.fsf@gitster.mtv.corp.google.com>
References: <xmqqvb5uvr40.fsf@gitster.mtv.corp.google.com>
	<CAH5451=rVmdTra0rVNEkfdfOeSyeETSMo7YGWdYozZr_=YyAtw@mail.gmail.com>
	<xmqqr3ghvn6a.fsf@gitster.mtv.corp.google.com>
	<20160212190017.GA20801@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 12 20:06:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUJ2k-0005oV-EV
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 20:06:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbcBLTGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2016 14:06:10 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62167 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750961AbcBLTGI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 14:06:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 636C94266A;
	Fri, 12 Feb 2016 14:06:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xskFuAkYij/TE33HSFyH4fCu8uY=; b=pAezRa
	/RkMycL6UincPpZO/SbWMU1TSPQeBOpaNCW2TkRexo2dqJxO8H74PIk/EHrJAk59
	4BIuM+REetgyc9VqEbGUkq0YnLjRdRXrjnxzyI6WQD09OnbuQdmFzdYke/8Ug6ph
	8IYMX50FDoiR4iPlEDPjQr/I5O4TerXBsaFwk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vg8mQi4c49ooPL7mzRUOtJyHlSVkcSPf
	L18QAHAGS6Jbheh9IwnxWtXb54zr3zrT7Clk5IdsIC7RzfZVw4s3x6d5YT2A1wMr
	yg6RtDSTU72azS2SZ9JwjWwaHaiqIeRn6Q5o94Vfm8oiJjPD8UmmnKAvNrXUa0fq
	3MTA7w5TWJQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5A25042669;
	Fri, 12 Feb 2016 14:06:06 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CEC6042668;
	Fri, 12 Feb 2016 14:06:05 -0500 (EST)
In-Reply-To: <20160212190017.GA20801@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 12 Feb 2016 14:00:17 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AAC26C2A-D1BB-11E5-A158-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286071>

Jeff King <peff@peff.net> writes:

> But I don't think this needs to have anything to do with merges in
> particular, or rules like "when merging a branch that does not have me
> in it". It is about saying "from here on out, the tree state should
> match this property, and we can test it by running this script". And
> then running "make code-lint-tests" becomes part of the acceptance
> testing for a proposed topic merge, just like "make test" is already
> (and likewise, people forking _new_ branches from master after the topic
> is merged would make sure they do not fail the code-lint tests before
> even submitting the topic).

That certainly is true, but this strays more and more from my
original motive of implementing an automated evil-merge scheme that
is better than what I currently have.

We try to do our tree-wide refactoring in such a way that it would
break the compilation (by changing function signature) when we can.
Catching with "make test" would certainly generalize it, but the
endgame result I was shooting for was to come up with a solution for
each topic in-flight just once and keep replaying it until it is
merged.
