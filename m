From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Sources for 3.18-rc1 not uploaded
Date: Tue, 21 Oct 2014 11:59:58 -0700
Message-ID: <xmqqoat5z1sh.fsf@gitster.dls.corp.google.com>
References: <20141020115943.GA27144@gmail.com>
	<CA+55aFyDuHskYE66rBVL_P-T2pxg6f2m6mUicfz-mk+ysePBxg@mail.gmail.com>
	<20141020222809.GB223410@vauxhall.crustytoothpaste.net>
	<54459E49.3040908@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	infra-steering@kernel.org, Git Mailing List <git@vger.kernel.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
X-From: git-owner@vger.kernel.org Tue Oct 21 21:00:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgefM-0006B7-G8
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 21:00:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932672AbaJUTAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 15:00:07 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63074 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932232AbaJUTAF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 15:00:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A81A715BBB;
	Tue, 21 Oct 2014 15:00:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AbQsQhPW8N32ux1rdyAj5PZZIU4=; b=NOMIU/
	a7oIwYOB/WvdNzhi2KAbCxrzWE5WsgT5VQr2tUy7XTfTrHRsvnfrwCv9wYxfG0Zj
	RQYZ1J3fFJ2bs8wklG4DzjD1eJqg/KpDoHkbHmEAecvr++QOkSGgGOeR503XLe8G
	aRTNVHikKEx+KDfK2jy9Buyg+QROKW2oeAyCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w6fE2BmMZblElV2gAzgqnemhdPnN27uZ
	FQrEFzwF/AnALgTMAzQ3/BZEHCtsAGoPDZojukQW22jgYW6niWPidJk4B43V4CS6
	n12hmTJErmyh0aVVlGd8lfTpF+WKwvfOYlkl/Wh2+2hzCaZVqjlEZVimolXQvBXU
	JO3Nhm6DkhU=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C76115BBA;
	Tue, 21 Oct 2014 15:00:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D7D0415BA6;
	Tue, 21 Oct 2014 14:59:59 -0400 (EDT)
In-Reply-To: <54459E49.3040908@linuxfoundation.org> (Konstantin Ryabitsev's
	message of "Mon, 20 Oct 2014 19:44:09 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 74CDED78-5954-11E4-A774-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> On 20/10/14 06:28 PM, brian m. carlson wrote:
>>> Junio, quite frankly, I don't think that that fix was a good idea. I'd
>>> > suggest having a *separate* umask for the pax headers, so that we do
>>> > not  break this long-lasting stability of "git archive" output in ways
>>> > that are unfixable and not compatible. kernel.org has relied (for a
>>> > *long* time) on being able to just upload the signature of the
>>> > resulting tar-file, because both sides can generate the same tar-fiel
>>> > bit-for-bit.
>> It sounds like kernel.org has a bug, then.  Perhaps that's the
>> appropriate place to fix the issue.
>
> It's not a bug, it's a feature (TM). KUP relies on git-archive's ability
> to create identical tar archives across platforms and versions. The
> benefit is that Linus or Greg can create a detached PGP signature
> against a tarball created from "git archive [tag]" on their system, and
> just tell kup to create the same archive remotely, thus saving them the
> trouble of uploading 80Mb each time they cut a release.
>
> With their frequent travel to places where upload bandwidth is both slow
> and unreliable, this ability to not have to upload hundreds of Mbs each
> time they cut a release is very handy and certainly helps keep kernel
> releases on schedule.
>
> So, while it's fair to point out that git-archive was never intended to
> always create bit-for-bit identical outputs, it would be *very nice* if
> this remained in place, as at least one large-ish deployment (us) finds
> it really handy.

While I agree that it is a nice "feature", I wish KUP folks thought
more about what should happen when the archive output _must_ change
when a more serious bug is discovered, and coordinated with us
better.

During a period where older and buggy versions of "git archive" are
used by some uploaders while a new version is used by others, KUP
could:

 - avail itself to a version (or versions) of "git archive" so that
   it can recreate both older and newer output;

 - upon receiving a tarball and signature, try recreating newer
   output and see if signature matches, and when the signature does
   not match, recreate older output and try again.

And we could supply "git archive --compatible=v1.7" option in the
newer version if that is easier on KUP folks than having to keep
multiple installations of versions of "git archive" around.

While I am on the topic of KUP, one feature I wish, which is the
only thing that is preventing me from updating the preformatted
documentation https://www.kernel.org/pub/software/scm/git/docs/, is
to allow me to upload a single tarball and extract it at one
location (e.g. /pub/software/scm/git/docs/) while removing existing
files in that location (i.e. removing deleted files).  Where do I
file such a feature request?
