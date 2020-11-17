Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C46C2D0E4
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 20:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20A7121D7E
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 20:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xU/2LFfz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730746AbgKQUOW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 15:14:22 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50100 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgKQUOV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 15:14:21 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 22FC59E946;
        Tue, 17 Nov 2020 15:14:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=O6H7CGqOImfA+xmFd26Ng8bgcLY=; b=xU/2LF
        fzm0bZVtc73f3tvAJzM7zxU3FOosKp1qAnW9UrlrScw1F4kx/UWdfM5xfSU715u4
        /UskzINUxwxR75FADYAjGEqv4gdZxEfdg2M8DZVoTHvUZhWlE2ogyidIT6X9wwmw
        JADT+HnPAqBMtg8Zd9ptWbIK85kzMFfDNfN90=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=koJOlmBNoZwPdiD/zV8O+jW8l2hckaCS
        hdwXNLZU6pAiHL1D/2c/Ge0I1ofeMFglow8QcTPcFrD6PWyso1+MJ/Qp/8nkftgW
        GqCdi1HoPXcWOzhGeR4f7BFsAOEbxoDfgG/vg1cyibKRjIi3COz9bFTe5PlgZ7/b
        0zdPnlorAIg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1B2AD9E945;
        Tue, 17 Nov 2020 15:14:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 92B9F9E944;
        Tue, 17 Nov 2020 15:14:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, "Chris. Webster" <chris@webstech.net>
Subject: Re: [PATCH] ci: avoid using the deprecated `set-env` construct
References: <pull.781.git.1604712106219.gitgitgadget@gmail.com>
        <xmqq8sb07bfa.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2011171620180.18437@tvgsbejvaqbjf.bet>
Date:   Tue, 17 Nov 2020 12:14:19 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2011171620180.18437@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Tue, 17 Nov 2020 16:21:33 +0100
        (CET)")
Message-ID: <xmqq8saz68ro.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7A31CF80-2911-11EB-97B1-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Perhaps like the following (which is copied-and-pasted without
>> understanding what is going on or without doing nothing more than
>> skimming [*1*])?
>
> Yes, of course, this precisely what we need.

Thanks.

--- >8 ------ >8 ------ >8 --- cut here --- >8 ------ >8 ------ >8 ---

Subject: [PATCH] ci: avoid `set-env` construct in print-test-failures.sh

Imitating cac42e47 (ci: avoid using the deprecated `set-env`
construct, 2020-11-07), avoid deprecated ::set-env and use the
recommended alternative instead in print-test-failures.sh

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ci/print-test-failures.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
index 92a983a265..c70d6cdbf2 100755
--- a/ci/print-test-failures.sh
+++ b/ci/print-test-failures.sh
@@ -48,7 +48,7 @@ do
 			;;
 		github-actions)
 			mkdir -p failed-test-artifacts
-			echo "::set-env name=FAILED_TEST_ARTIFACTS::t/failed-test-artifacts"
+			echo "FAILED_TEST_ARTIFACTS=t/failed-test-artifacts" >>$GITHUB_ENV
 			cp "${TEST_EXIT%.exit}.out" failed-test-artifacts/
 			tar czf failed-test-artifacts/"$test_name".trash.tar.gz "$trash_dir"
 			continue
-- 
2.29.2-458-g8cf0a80384

