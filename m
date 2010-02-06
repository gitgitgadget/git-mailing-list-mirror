From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add new options to git format-patch: --cover-subject and
 --cover-blurb
Date: Fri, 05 Feb 2010 17:10:34 -0800
Message-ID: <7vtytvjhit.fsf@alter.siamese.dyndns.org>
References: <1265405973-5670-1-git-send-email-larry@elder-gods.org>
 <201002051526.18205.wjl@icecavern.net>
 <7vfx5fwbws.fsf@alter.siamese.dyndns.org> <20100205225901.GA29821@cthulhu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Wesley J. Landaker" <wjl@icecavern.net>, git@vger.kernel.org
To: Larry D'Anna <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Sat Feb 06 02:10:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdZCF-0000Le-Pd
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 02:10:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933087Ab0BFBKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 20:10:46 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42109 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757495Ab0BFBKp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 20:10:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B7E49778A;
	Fri,  5 Feb 2010 20:10:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EujyELrTezEls4ibZXhhTLUJQ+Q=; b=Xzl5Ae
	fi1MyMh+/hJse+Oo1X5ee0FKqUEiUXOv/Enfd5CQbiM9fXiv2yeXkw5jW+NRBT+j
	HN6Om4giyk3xohDXExrv2C7CDLSYhZghKROcrMwYkAqZjXCa1csojQfTh4jcfxB8
	WzFT7TpzYXOmL4HPjTnceGXEqUB84TCnaJCqA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v6uGcRqNpTNIlfrffO5+x/6I9UIhGO9R
	La2VuoEwxdTbpeWtKj3pytMDm37e2zBrxJYhsYXs5WH5P8AA37VRZf0EPCeiBROu
	zUxkQqtQIADc4Oi6U9asWE8fABXNtt8aCLBoy0UmrX/utZ/AN1EiIXfdWurkKDTw
	4VKhoN6Z7AU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A56E97785;
	Fri,  5 Feb 2010 20:10:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2D1C997784; Fri,  5 Feb
 2010 20:10:36 -0500 (EST)
In-Reply-To: <20100205225901.GA29821@cthulhu> (Larry D'Anna's message of
 "Fri\, 5 Feb 2010 17\:59\:01 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 70D7F9CC-12BC-11DF-8800-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139133>

Larry D'Anna <larry@elder-gods.org> writes:

> 1) make your branch
>
> 2) git format-patch --cover-letter
>
> 3) edit the cover letter
>
> 3) review the series, and realize you need to fix something, fix it.

Hmph, this begs a natural question: why didn't you review and realize that
in step (1)?

> 4) git format-patch --cover-letter again
>
> 5) edit the cover letter, *again*.  hopefully you didn't overwrite the
> old one.

This step I can understand and am very sympathetic to the cause, even
though I may not be convinced that the patch under discussion is the best
solution to the issue.

What argument are you giving to the "-o" option?  If your series changed
(e.g. inserted or deleted a commit in the middle, retitled, etc.), and
your output is going to the same directory, you would end up with files
with duplicate serial numbers and you would need to purge the old one
before your next invocation of send-email.  For this reason, people
quickly learn to either give a different -o location (so that they can
compare two versions), or to purge the old contents before running
format-patch.  If the latter, it would be sufficient to save the old
0000-cover before removing them, and if the former, the old cover is
already there.  You can cut and paste from there while editing the new
one.

The thing I found suboptimal in your approach is that most often the cover
letter is written to explain what the overall goal of the series is and
how each patch relates to each other to achieve that goal.  In order to
effectively do so, the overview format-patch leaves in 0000-cover template
file helps a lot (actually that is half the reason why it shows the
overview---the other is for the recipients).

Your approach forces the user to write the blurb part in a separate file
on blank sheet of paper _before_ running format-patch, iow, without the
help of that series overview, if they want to take advantage of your "I
don't want to lose what I wrote already" feature.  To put it another way,
people who use --cover-blurb would write suboptimal (or maybe useless)
blurb text exactly because they don't look at the series overview while
they write it---the option encourages a bad cover letter to be sent to
reviewers.

I am hoping we can do better than that.

It might be sufficient for format-patch to notice a 0000-cover file that
is already there, read the subject and blurb part and carry that forward,
instead of unconditionally writing "*** SUBJECT HERE ***" and stuff.  That
way, the user does not have to prepare a separate file before running
format-patch.

By scanning from the bottom of the existing 0000-cover file, skipping
diffstat part (easy to spot with regexp) and then skip backwards a block
of text whose lines are one of:

 (1) two space indented---that's one-line-per-commit;

 (2) empty line---separator; or

 (3) unindented line that ends with '(' number ')' ':'---the author.

The remainder would be the BLURB.  And you know it is much easier to find
where the Subject: is ;-)
