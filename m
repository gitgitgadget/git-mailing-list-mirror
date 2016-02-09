From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9100: fix breakage when SHELL_PATH is not /bin/sh
Date: Tue, 09 Feb 2016 09:30:21 -0800
Message-ID: <xmqqwpqd4wr6.fsf@gitster.mtv.corp.google.com>
References: <982f6f499c988e1063275e2951c9856d622a83f3.1454872161.git.git@drmicha.warpmail.net>
	<20160208135013.GA27054@sigill.intra.peff.net>
	<CAA19uiRSu_6Os3b498obSNec7b2uiYv20SZ=y93CkjsWqhqHzA@mail.gmail.com>
	<20160208163700.GA22929@sigill.intra.peff.net>
	<alpine.DEB.2.20.1602082027550.2964@virtualbox>
	<20160208193509.GA30554@sigill.intra.peff.net>
	<xmqqlh6v7zu0.fsf@gitster.mtv.corp.google.com>
	<20160208195630.GB30693@sigill.intra.peff.net>
	<alpine.DEB.2.20.1602091054430.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 09 18:30:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTC7b-0008SR-5I
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 18:30:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755982AbcBIRae (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 12:30:34 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53505 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752244AbcBIRaa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 12:30:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D690F403A0;
	Tue,  9 Feb 2016 12:30:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QEnXzcWtZ8pWDqqDya3RveIK8DM=; b=M0bNIm
	AEWW15AWIFTlj88o5e8FRo7LRlPdJCrZcXoTN4ohCeJTuqqY4QcxFuVmuOHUCLmz
	ZUlbxezNDSXwldhYw8uC5vF/TjPoulO4iJ/eUVP8rib16yBlq+nDYbxbdgmIcv0Z
	hfM7lGLE5EzdajmToQ1HQqnQVSVKe7MiTLIS0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g3bhL1SS5foYuQDU5ubT1gPkwDt5qfVD
	W/YmYRu4NQSroJmHGQTvtDReGy36EBXW/DRl1csjvesm9usU3g+5D0u6HxqL7k5/
	b9HF+1/8P27lM5x0Hvjrp6zHSHulXUev+AIACByi3So4RQrHU0jA6lWQhLBZDIo/
	cXsJA9rJUy0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C3C0B4039F;
	Tue,  9 Feb 2016 12:30:23 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 14B654039D;
	Tue,  9 Feb 2016 12:30:23 -0500 (EST)
In-Reply-To: <alpine.DEB.2.20.1602091054430.2964@virtualbox> (Johannes
	Schindelin's message of "Tue, 9 Feb 2016 11:00:43 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CC915B42-CF52-11E5-A65E-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285840>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Besides, I am pretty certain that there is a test in t9100 that *does*
> test the executable bit, properly requiring POSIXPERM.
>
> So I still would be in favor of using write_script: 1) our *intention* is
> to write a script, even if we do not currently execute it, and 2) if
> anybody is interested in supporting MSys1 (*cough* Hannes & Sebastian
> *cough*), they have a *much* easier time to fix it.

I do not think our intention is to write a script there, though.
You have commented out a different test, where a file called "file"
whose executable bit is flipped, and the result of the test depends
on the filesystem actually flipping the bit, using POSIXPERM.  I do
not see anything more special in the way "exec.sh" is used in the
test compared to the use of that "file".  They both are merely used
as a payload, with expected contents and expected setting of the
executable bit at each points in the test sequence.

By using POSIXPERM, js/mingw-tests topic cleanly identifies and
skips the tests that rely on the "chmod +x" acting as expected, but
by hiding the creation and setting of the executable bit behind
write_script for "exec.sh" (and for this file alone), the reader is
still forced to know the subtle linkage between write_script and
permission bits.  On a system where executable bit is not needed to
execute a script (perhaps the file extension tells if a file is
executable on such a system), it is a plausible enhancement to
write_script to make it not to even attempt "chmod +x" on a system
without executable bit--after all, the helper _is_ about writing a
script.  The executable bit is an implementation detail that nobody
cares about.

But the way "exec.sh" is used by that test is different.  It merely
wants to have a file with that name with a fixed contents that has
executable bit set.  As I already said, I didn't notice that during
the review and incorrectly suggested use of write_script, but that
was a mistake.

Ideally, it would have been better if the test was structured in
such a way that a set of pure-contents tests that do not involve the
executable bit and symbolic links are done first, with separate set
of tests that require POSIXPERM and/or SYMLINK.  Then we wouldn't be
having this conversation.  You would skip the whole thing in the
latter category.  As the test that originally was written needs
POSIXPERM (but curiously not SYMLINK) even in the very initial
'setup' stage, a hack to make the set-up step behave differently
depending on POSIXPERM is unavoidable and tolerable, if we do not
want to rewrite the entire script (and I do not think neither of us
want to see that).

But that needs to be spelled out explicitly to allow people follow
what is going on more easily, e.g.

    echo "#!/bin/sh" >exec.sh &&
    { test_have_prereq !POSIXPERM || chmod +x exec.sh } &&

The "file" test would not need such a construct as the whole thing
is skipped without POSIXPERM (and SYMLINK where it is aliased to
exec-2.sh).

While reviewing the change to this script, another thing I noticed
is this bit:

    name='remove executable bit from a file'
    test_expect_success POSIXPERM "$name" '
            rm -f "$GIT_DIR"/index &&
            git checkout -f -b mybranch5 ${remotes_git_svn} &&
            chmod -x exec.sh &&
            git update-index exec.sh &&
            git commit -m "$name" &&
            git svn set-tree --find-copies-harder --rmdir \
                    ${remotes_git_svn}..mybranch5 &&
            svn_cmd up "$SVN_TREE" &&
            test ! -x "$SVN_TREE"/exec.sh'

This uses "chmod -x", but it does not need to.  The only thing it
cares about is that the tree object that contains exec.sh record
that path with executable bit off, so "update-index --chmod" would
have allowed a !POSIXPERM system to record the same result.

There probably are more instance of similar "chmod" that you do not
have to skip with !POSIXPERM.
