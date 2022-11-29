Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF2BC4332F
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 17:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235688AbiK2RqH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 12:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbiK2RqE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 12:46:04 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B745CD3D
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 09:46:02 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id b2so19351908eja.7
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 09:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dTG67rGd/IZsavkF051Xu8fOwaOMGGKycW0XYOmIetU=;
        b=LA0o+3iX996kopehRlFjL10/cmLMpUFk8hmqge3Vx88YvJeloZk5MUHRqJb68a758r
         /t40zgty1sRz0Na5DgUEl7ERdVsZSo6T5l2yxHuMLJ/z8OhRWcO0xi/n29VU89IBnbXo
         3ey3/O7fmA8Z/Lh9Uq6+Bmt2xNhRGewOkLglM1AVL0mpSAVZV+HerEOJ+3lhlXzxROh9
         npoQMHn9kzMRRsvbd8FuMlC8+l0GOen1wl6ATJhamTaikO+283+Nzbxk3ElENiD7TXKX
         LQ0l0ftTAN2WqTG+WWP4VKvRS9jBF4/9GqeW18bGHkKwvdX1H3p+ZfOUsCnm8+JYjxA7
         79iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTG67rGd/IZsavkF051Xu8fOwaOMGGKycW0XYOmIetU=;
        b=SDuhc8J91fkB2f3T5V7VEDGkfXEJwQq0qTr5HPv78KqBz5OHmOgh9poMoeOlCK4Rq3
         VHYRoYSK0JCXp87gBFSXTlSwqAos0M8zkFqYGKkgaE60XzUwPTPsesVIFS7yBcDxFT07
         K2QwxBS/kGmeC99J6Mrf/RMIaQO5LWAZ7960l+GLLYtQCd28VSmIydxLipMKDdOn0976
         GJPB+N9NX3q2Y+f7gKsx7qIh0bhF1emgc9QOdHiR0iOgqsfgZPs6EreFk3J1+v5VUMUR
         K6WERYQORAczKQuht2emtZkvz74Dv3Sc1IKIh3G7tpcS/uMsq6n8stsj7U/OAnvD6d8n
         Xcow==
X-Gm-Message-State: ANoB5pmP2SwEA81MkAOxbzVqM7sypU34n2XE6G+Rb380ZjdF+YAnox8b
        xir/zG1+JsjdBYcygwX0sRE=
X-Google-Smtp-Source: AA0mqf563Sr7p6NX+LCy6Dt5IdSS4s1NIpHGV1YBEc238ea3WOoenY+TRB6n85bOTRabzjxdJwUhSQ==
X-Received: by 2002:a17:906:6403:b0:7b2:9667:241e with SMTP id d3-20020a170906640300b007b29667241emr49885403ejm.115.1669743960411;
        Tue, 29 Nov 2022 09:46:00 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id i25-20020a056402055900b0046730154ccbsm6500204edx.42.2022.11.29.09.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 09:46:00 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p04gA-001VKn-2s;
        Tue, 29 Nov 2022 18:45:58 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Alison Winters <alisonatwork@outlook.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alison Winters via GitGitGadget <gitgitgadget@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Sibi Siddharthan <sibisiv.siddharthan@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] add case insensitivity option to bash completion
Date:   Tue, 29 Nov 2022 18:40:40 +0100
References: <pull.1374.git.git.1667669315.gitgitgadget@gmail.com>
 <xmqqedtm4h93.fsf@gitster.g>
 <PRAP192MB1506B74F9BB25061419FA228DE129@PRAP192MB1506.EURP192.PROD.OUTLOOK.COM>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <PRAP192MB1506B74F9BB25061419FA228DE129@PRAP192MB1506.EURP192.PROD.OUTLOOK.COM>
Message-ID: <221129.86y1rtirhl.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 29 2022, Alison Winters wrote:

> On 2022-11-29 10:38, Junio C Hamano wrote:
>> I did not try to figure out the reason but the topic with its tests
>> seem to break in 'seen' the linux-cmake-ctest CI job.
>>
>> https://github.com/git/git/actions/runs/3570230611/jobs/6001013549
>>
>> but the same test does not break under usual "make test".
>
> I cannot speak for how the changes of the ab/cmake-nix-and-ci impact
> the aw/complete-case-insensitive branch, but the failure seems to be
> pointing to a test that I have since changed in the v2 patch, on the
> suggestion of Szeder Gabor. The variable is no longer exported and
> the script is no longer sourced a second time. I don't know if those
> v2 changes would change the results of this test, but they might be a
> starting point for the other people CC:ed here to consider.

The breakage is due to a semantic conflict between the two, which is
solved thusly:
	
	diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
	index d45d820da28..2aa128075ca 100755
	--- a/t/t9902-completion.sh
	+++ b/t/t9902-completion.sh
	@@ -2261,7 +2261,7 @@ test_expect_success 'checkout does not match ref names of a different case' '
	 
	 test_expect_success 'checkout matches case insensitively with GIT_COMPLETION_IGNORE_CASE' '
	 	(
	-		. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
	+		. "$GIT_SOURCE_DIR/contrib/completion/git-completion.bash" &&
	 		GIT_COMPLETION_IGNORE_CASE=1 && export GIT_COMPLETION_IGNORE_CASE &&
	 		test_completion "git checkout M" <<-\EOF
	 		main Z
	@@ -2279,7 +2279,7 @@ test_expect_success 'checkout completes pseudo refs' '
	 
	 test_expect_success 'checkout completes pseudo refs case insensitively with GIT_COMPLETION_IGNORE_CASE' '
	 	(
	-		. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
	+		. "$GIT_SOURCE_DIR/contrib/completion/git-completion.bash" &&
	 		GIT_COMPLETION_IGNORE_CASE=1 && export GIT_COMPLETION_IGNORE_CASE &&
	 		test_completion "git checkout h" <<-\EOF
	 		HEAD Z

Junio: I don't think this warrants kicking out the cmake topic. This
sort of problem is just going to occur while something like that is
in-flight, or Alison would have otherwise presumably seen it as a CI
failure if based off "master".

With hindsight I could have made e74e51a9154 (cmake & test-lib.sh: add a
$GIT_SOURCE_DIR variable, 2022-11-03) do the migration in two phases,
but I didn't expect another topic to rely on the relatively obscure bits
that were being copied to the $GIT_BUILD_DIR, we weren't exactly
drowning in git-completion.bash patches...
