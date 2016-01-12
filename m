From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Can't diff against the 00000000 revision
Date: Tue, 12 Jan 2016 10:52:41 -0800
Message-ID: <xmqqpox6tyti.fsf@gitster.mtv.corp.google.com>
References: <jwv4meiygrc.fsf-monnier+gmane.comp.version-control.git@gnu.org>
	<20160112153239.GA8041@sigill.intra.peff.net>
	<jwvr3hmwz1n.fsf-monnier+gmane.comp.version-control.git@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Monnier <monnier@iro.umontreal.ca>
X-From: git-owner@vger.kernel.org Tue Jan 12 19:52:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ43l-0007Xc-Sm
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 19:52:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752941AbcALSwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 13:52:46 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50007 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752409AbcALSwp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 13:52:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B565939F01;
	Tue, 12 Jan 2016 13:52:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Cv777kMAguepDUXsClDQYMEb+iE=; b=Rqo7fZ
	5MXR0slwpkf8Tf7h7mCiNzLlJzsPk9w8uXNKvwbevInAdC+O5y3n0BYQfHgEx8K7
	Tw/z5pCuHubNNOEicKkot3blskxJuKnUyxlbUHkJJ21ufvjf+sWhArwuA0I/xYPV
	pc+xf2J1GG3/O+LpjoVqQCLpH+qZkjW7uqoSc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QsykN0+jbwS32w7c+PJtu6pM3UHNmg3Z
	iQuUywkEa0P9G/VtIrVYelxig3cqlZFx0ON6bF2sdFhoyqtdLi+G08L8sfRCnfwd
	ZQocvOoXS8wEqci+0BzCYOwYKU46qImMyr6i5s2hMDQzlNsRalFCYEQkDiuaeOV4
	anSLaCgNsTY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AC47C39F00;
	Tue, 12 Jan 2016 13:52:44 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 38F3939EFF;
	Tue, 12 Jan 2016 13:52:43 -0500 (EST)
In-Reply-To: <jwvr3hmwz1n.fsf-monnier+gmane.comp.version-control.git@gnu.org>
	(Stefan Monnier's message of "Tue, 12 Jan 2016 11:26:24 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A98E97B4-B95D-11E5-8B06-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283837>

Stefan Monnier <monnier@iro.umontreal.ca> writes:

>> And hopefully that explains why "000000" does not necessarily make a
>> good placeholder for "the empty thing". There are multiple empty things,
>> and it is not clear what:
>
>>   git diff 0000000 1234abcd
>
>> means. Is 0000000 a tree? A blob?
>
> Well, Git is the one who uses 000000 to refer to an empty thing, but
> indeed it seems like it does inconsistently: it's sometimes used as the
> "empty blob" and sometimes as an "empty tree".

Git does not use 0*40 to refer to "an empty thing" at all.  It is
used to denote a "missing thing".  A change to _create_ a new file
and a diff to _modify_ an existing empty file are conceptually two
different things, and are shown differently.

It would be incorrect to say "it used to be an empty blob" by using
e69de29bb2d1d on the left hand side of a patch that creates a new
file.
