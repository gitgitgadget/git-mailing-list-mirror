Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633D7C56201
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 16:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEEAA216FD
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 16:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gLubPrP1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbgKLQuP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 11:50:15 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58072 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728643AbgKLQuO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 11:50:14 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CC6A9A9A5E;
        Thu, 12 Nov 2020 11:50:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1XZOO687W7jQJw30mPYgCw+ho9g=; b=gLubPr
        P1/ey2cdD3e/N8LhauV8RXvu7MFKwPAs8QtTdz+jep7D64RnkSjoDYPkQaxWwEm7
        3CS/3ZJVP4KEDKm2tCUWZc1D5JuRkeFzYPdjTvBzfnI7Zsdmnfz8xm1+87Fj5vbm
        +Bkdm5hVDmVu6FIvgeKgu/wZ+zhNlGpqQCDkA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BRuF+1fRASdbTcAbsWGbStbrncnxz/I6
        nnwmtuIcS4FQFBS46Fbgtlb8Zm1PDoi/6B24763F+EJkB8GJ9/lQ/XCGC1k4JlcI
        w8ALa5ss75q/HL87K1ZBQd0cC9qsm8ldiFfUNpldgXMms9ZW/EfwLUtWWvPkzZOo
        eTyCRxWhyH4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C2AC7A9A5D;
        Thu, 12 Nov 2020 11:50:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 18D84A9A5C;
        Thu, 12 Nov 2020 11:50:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH] t4013: prepare for the new default branch name "main"
References: <pull.783.git.1604829561838.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2011112137390.18437@tvgsbejvaqbjf.bet>
        <xmqqsg9f36nu.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2011121443100.18437@tvgsbejvaqbjf.bet>
Date:   Thu, 12 Nov 2020 08:50:08 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2011121443100.18437@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Thu, 12 Nov 2020 14:48:36 +0100
        (CET)")
Message-ID: <xmqqwnyqjz9b.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2043A718-2507-11EB-876B-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Unfortunately not because at that stage, `HOME` is still not overridden.
> It will be overridden in `test-lib.sh`. Which is also where the initial
> repository (and hence, the initial branch) will be created.
>
> So: the suggested command with work neither before `. test-lib.sh` nor
> after it.

Why doesn't it work after it?

Ahh, the top-level test repository at $TRASH_DIRECTORY may have
already been created with an unborn branch that is 'main'---but we
can easily rename it to a hardcoded value that the rest of the test
wants to see with just a little bit of code (see below).

> What's wrong with the test cases in t0001-init.sh ...

They are not wrong at all.  I am only saying there is no reason to
declare that no tests other than them are allowed to test with
different branch name.

But it seems that we do not even have to muck with $HOME/.gitconfig
or the configuration variable, as t4013 happily stays in the
initially created repository and conducts its various tests, without
creating secondary repositories.  What matters is on which branch
that Initial commit gets created in the 'setup' step.

Something along this line, but except the first two commented-out
commands that I added when testing manually without an updated
version of Git whose default is already changed to 'main', would
unbreak the tests, no?

 t/t4013-diff-various.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git c/t/t4013-diff-various.sh w/t/t4013-diff-various.sh
index f72d456d3b..b37e1e04cc 100755
--- c/t/t4013-diff-various.sh
+++ w/t/t4013-diff-various.sh
@@ -8,8 +8,23 @@ test_description='Various diff formatting options'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/diff-lib.sh
 
+# git symbolic-ref HEAD refs/heads/main
+# git config init.defaultbranch main
+
 test_expect_success setup '
 
+	# Since there are too many references of "master" in the
+	# golden-master that output from the test commands is
+	# compared against, we fix (not in the sense to "correct",
+	# but in the sense to "make unmovable") the choice made
+	# in this test repository to use the historical branch name
+	# to avoid churning the test and affect in-flight topics.
+	git symbolic-ref HEAD refs/heads/master &&
+
+	# Just in case---we do not create separate repositories in
+	# this test, so it should not make any difference.
+	git config --global init.defaultbranch master &&
+
 	GIT_AUTHOR_DATE="2006-06-26 00:00:00 +0000" &&
 	GIT_COMMITTER_DATE="2006-06-26 00:00:00 +0000" &&
 	export GIT_AUTHOR_DATE GIT_COMMITTER_DATE &&
