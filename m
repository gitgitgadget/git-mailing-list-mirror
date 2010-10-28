From: Junio C Hamano <gitster@pobox.com>
Subject: Re: `git status --porcelain` disagrees with documentation about
 quoting filenames with spaces
Date: Thu, 28 Oct 2010 11:44:01 -0700
Message-ID: <7v39rqb1ji.fsf@alter.siamese.dyndns.org>
References: <4AC7298E-73D7-4074-91CD-7C10DE414532@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git mailing list <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Oct 28 20:44:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBXSS-0007sY-Fb
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 20:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757173Ab0J1SoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 14:44:12 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35551 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755776Ab0J1SoK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 14:44:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B32DD1C2A;
	Thu, 28 Oct 2010 14:44:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TB8RsHuB0JmnZ7n7G7cGiyl4fpA=; b=lsYtsX
	ANeq7uaDY8Y2OGkx8WqtTtWGMUxK+KXli8Ccjm7xuA8tETd72g5KuNkHQYxebxx/
	E2DhKu7iZpGijp3vplUbTkXOLsRsyX/HEucTEW/or5X5KSOOXG9Ujx17brAAMs00
	Nclm7LpbrbkNmSePLOrUjamHrMtHoUNKI85qE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qnqqyG3uYHwPM+nsmGxhmWO1skF2JhvK
	DPP/O8plRILyI+6z9jqkDsyvGY/586FaUgSffOWryluVTY9fAkrme0qSE/viGgih
	tE9w/JedCYjf1TovFaYtd96p5Qx22J+bTKVkUa7jTRBvWdNRxI1Mryn1Mpo5e57u
	a8XLCW/Wz3E=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 904201C25;
	Thu, 28 Oct 2010 14:44:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.169.49]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DEDB91C24; Thu, 28 Oct
 2010 14:44:03 -0400 (EDT)
In-Reply-To: <4AC7298E-73D7-4074-91CD-7C10DE414532@sb.org> (Kevin Ballard's
 message of "Wed\, 27 Oct 2010 16\:57\:52 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 57E5FF90-E2C3-11DF-95A0-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160207>

Kevin Ballard <kevin@sb.org> writes:

[jc: why do you send messages with toooooooooooo loooooong lines sometimes
and normal line lengths some other times...?]

> Given that the removal of quoting for filenames with spaces was an
> intentional change, does anybody have any strong opinions about whether
> we should restore the quotes in this scenario? The alternative is to
> simply change the documentation, but the un-parsability of the
> --porcelain format has me worried.

28fba29 (Do not quote SP., 2005-10-17) explicitly addressed a breakage
that quoted pathnames in contexts like this one:

    diff --git a/My Documents/hello.txt b/My Documents/hello.txt

I personally think people who add SP to their pathnames need to get their
head examined, and in that sense I do not strongly mind if the pathnames
in the above are quoted (that is why the original quotation before the
said commit quoted them), but apparently other people did mind.  I also
think people who have " -> " in their pathnames are even less sane beyond
salvation, and between the two insanity, I'd rather help less insane ones
by not quoting the above.

The best would probably be to special case SP (which is normally not to be
quoted) _only_ in the context of "something" -> "something".
