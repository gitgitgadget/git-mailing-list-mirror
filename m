Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21204C433FE
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 21:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiKXVwH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 16:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiKXVwE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 16:52:04 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9621B54ED
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 13:52:02 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id fy37so6503960ejc.11
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 13:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XBFqKrF4bT4SjU3s/mRJUIWQAG7/LgEuB0X2j5Wp7x8=;
        b=q0naD26yhwPP4sOx9dvVGFEhAeHoK0iQJFe3neH/VqZXMCJnfzkQIQN+699ONNOlYb
         RHODBRVRw+atOon51aV9loYz67OF0WBwEejyI5MKhvQQIiqHUddI3gjT/Hgkf2zPvVyx
         7AjdtUqmGHqjbSdVOv31QHSMck890Nx+bgC9oKyRvtQMPRsgdB1BVw8KveGCGfOMvsg9
         Rrsq3JC5fqKFbqvASxvrksYXed/5wFqwtNyCUdJeZp+6N1kR5aq2mviT72NtAECKXvxM
         Vh2nyaKTRvkoq+Tvf5WNI3SkKCff1Ri4C/zab4HyE9f+hGVmw63KnUqdXWhWr2HH4ZCN
         7bVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XBFqKrF4bT4SjU3s/mRJUIWQAG7/LgEuB0X2j5Wp7x8=;
        b=KqgmjzGmLL/YvnHs3uPiSwzUCAS3EmgfjFg2dUKj2Dd6r1YL9MMH1YMGmlqypABkDy
         93KCGH3zFAxPGqfXI25CROM6+DpPaU+vHrjyr/UYO1Wqz/5x4dDot7hkDu8ZJy93IzFJ
         fRkPXFImb7VW7LK9MhFcP4zbEk5UnLb7TeQTQIuSio01Ml9R5kthN6iqO+UYJFSdOZ2C
         r6FClg4OjX/K0ubtrOj70pr42Zm+2fHXbBY1HVvvX7GEr2sB3fjK83zS/xpiOvx6IK2G
         DG4mkHkxFT6pqAgkrcBi30bK2p7FAj0wZOIfKn9XlKbQA603160D71rCUdc+JuboIicj
         c3yg==
X-Gm-Message-State: ANoB5pm5wOuffDhb9b/5bI++DNaDWyRv1yukzUjNDCIGUsWpANLKh1Xl
        CTZ2USen2iZxpeSKIxiGqII=
X-Google-Smtp-Source: AA0mqf7jlW5CSB/8VLt9QgoCmRxeg/cJrLQumX9uC0kMbArPr7flAkl/nlzHX6CZ6mXFrBC6u2PfkA==
X-Received: by 2002:a17:906:22d0:b0:7b2:a7aa:173d with SMTP id q16-20020a17090622d000b007b2a7aa173dmr26463596eja.140.1669326721281;
        Thu, 24 Nov 2022 13:52:01 -0800 (PST)
Received: from gmgdl ([213.143.127.178])
        by smtp.gmail.com with ESMTPSA id o26-20020a170906289a00b0077d37a5d401sm863178ejd.33.2022.11.24.13.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 13:52:00 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oyK8Q-000PWE-2v;
        Thu, 24 Nov 2022 22:51:54 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     rsbecker@nexbridge.com
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [BUG} t2201.7+ Failure to Create Thread in 2.39.0-rc0
Date:   Thu, 24 Nov 2022 22:51:17 +0100
References: <010201d9002e$8e2f9940$aa8ecbc0$@nexbridge.com>
 <221124.86o7swnqc1.gmgdl@evledraar.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <221124.86o7swnqc1.gmgdl@evledraar.gmail.com>
Message-ID: <221124.86bkownhqd.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 24 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> [CC-ing Jeff, this is from the "stopwatch timers" topic]
>
> On Thu, Nov 24 2022, rsbecker@nexbridge.com wrote:
>
>> While running t2201.7 (and subsequent) for 2.39.0-rc0, I hit a condition
>> where:
>
> Don't you mean t0211-trace2-perf.sh?
>
>> <snip>
>> + test_when_finished rm trace.perf actual
>> + test_config_global trace2.perfBrief 1
>> + pwd
>> + test_config_global trace2.perfTarget
>> /home/ituglib/randall/jenkins/.jenkins/workspace/Git_Pipeline/t/trash
>> directory.t0211-trace2-perf/trace.perf
>> + test-tool trace2 101timer 5 10 3
>> fatal: failed to create thread[0]
>>
>> was encountered, causing the test to fail. Pointers on resolving this wo=
uld
>> be helpful.
>
> Apparently we really could use a NO_PTHREADS=3DY CI setup, because that's
> all that's needed to reproduce this on linux & elsewhere. Running the
> test with that:
>=20=09
> 	+ test-tool trace2 101timer 5 10 3
> 	fatal: failed to create thread[0]
> 	error: last command exited with $?=3D128
>
> For that all that's needed is this:
>=20=09
> 	diff --git a/t/t0211-trace2-perf.sh b/t/t0211-trace2-perf.sh
> 	index 0b3436e8cac..cfba6861322 100755
> 	--- a/t/t0211-trace2-perf.sh
> 	+++ b/t/t0211-trace2-perf.sh
> 	@@ -203,7 +203,7 @@ test_expect_success 'stopwatch timer test/test1' '
> 	 	have_timer_event "main" "timer" "test" "test1" 5 actual
> 	 '
>=20=09=20
> 	-test_expect_success 'stopwatch timer test/test2' '
> 	+test_expect_success PTHREADS 'stopwatch timer test/test2' '
> 	 	test_when_finished "rm trace.perf actual" &&
> 	 	test_config_global trace2.perfBrief 1 &&
> 	 	test_config_global trace2.perfTarget "$(pwd)/trace.perf" &&
> 	@@ -249,7 +249,7 @@ test_expect_success 'global counter test/test1' '
> 	 	have_counter_event "main" "counter" "test" "test1" 15 actual
> 	 '
>=20=09=20
> 	-test_expect_success 'global counter test/test2' '
> 	+test_expect_success PTHREADS 'global counter test/test2' '
> 	 	test_when_finished "rm trace.perf actual" &&
> 	 	test_config_global trace2.perfBrief 1 &&
> 	 	test_config_global trace2.perfTarget "$(pwd)/trace.perf" &&
>
> I think that's the correct fix here, and it should go into rc1.

I submitted a fix at
https://lore.kernel.org/git/patch-1.1-f7f21c94a6c-20221124T214813Z-avarab@g=
mail.com/;
but I see that since your message-id's contain "$" I got the In-Reply-To
wrong, sorry :)
