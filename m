From: Junio C Hamano <gitster@pobox.com>
Subject: Re: recipe to use git for deployment
Date: Fri, 04 May 2012 21:31:55 -0700
Message-ID: <7v4nrv8czo.fsf@alter.siamese.dyndns.org>
References: <jo283q$kna$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 05 06:32:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQWfH-0008Lo-CP
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 06:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264Ab2EEEb7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 May 2012 00:31:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44349 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751123Ab2EEEb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2012 00:31:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E3C6E87C5;
	Sat,  5 May 2012 00:31:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Rml6z2tLhq7SvIL+hKCufzKKjfo=; b=JyRZz5
	SWLPpNQry2ogCVNeiNBVj1rLEaeI/kTc7ptn12F4WWRRvhuOmaiQm56/VQswzCsc
	KcC0VWp+St8M35L2TEY9LLaT0TBo4NMtx+IuWLyOTyJVS3hDJBRo66MAbTRQvyk3
	F6+wN3VCejY2b3J5OIcSkxhdK2JlNE516Ix8E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vFEqBRc8QLH50VtG4/s/OF5lsF8Cp57J
	MltDECncuL1StC97V/F72J4+f4WRBr4OCgNQYTRRKsuJ+iqeH6jtBV4EYcskdKYj
	ybrGd7fsqf/OeVd0uCC8gh9g+PBBFyeopgEKzDvHoWGmhtC6GGzbkZbMdmgj9Szq
	9tW9IPZkE0c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB5DF87C4;
	Sat,  5 May 2012 00:31:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7240787C3; Sat,  5 May 2012
 00:31:57 -0400 (EDT)
In-Reply-To: <jo283q$kna$1@dough.gmane.org> (Neal Kreitzinger's message of
 "Fri, 04 May 2012 22:51:21 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3FDA827E-966B-11E1-993E-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197092>

Neal Kreitzinger <nkreitzinger@gmail.com> writes:

> I'm trying to cook up automated mass deployment using git as the main
> ingredient.

I think the standard answer to this is "don't do it".

You could of course add hooks to hack around it, but fundamentally Git was
designed to track source files (so the only sane behaviour for "checking
out" is to keep the timestamp of the working tree file to whatever the
underlying OS gives it when "checkout" happens, for example), so anything
that your "deployment strategy" wants conflicts with what the usual source
coutrol operation should do, you need to tweak around what Git does (the
same thing can be said for CVS or SVN, by the way).

Unless you do this with an understanding that you are merely using git "as
a better rsync" and take responsiblity of everything else that git-the-scm
does _not_ do for you, I suspect that you would be volunteering for a lot
of pain.
