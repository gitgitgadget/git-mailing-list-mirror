Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1A4C433FE
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 18:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiKXSrh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 13:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiKXSrQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 13:47:16 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE514B751
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 10:46:18 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id ha10so5879740ejb.3
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 10:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z0N2Vlhx9uI0JjtaiooSCUVeUfuFEkWna0eE3K2/1u4=;
        b=KaXHRKLX3pjdo0ZZsJCdSA82fSibruUcj193enZYwVO9LHD2DTiY+SrpTSSL/q3ArL
         PNJhhCQbVmQvcDINEXdEH4Jiy885ba8cxTY793nrG46729wNkbzQ7xoTYAlTPnAk5GNu
         /frkJhsdBF40Y2UEFIcRwXCTG8xU8QHqsRHot6Uo5X8UngLgA5SXYJ5aooSovi+CMCtP
         tfUk5miB/ywpMNmiPXUq3u7fV1O+L/fq4MbhPcApNP1OmWR8jUevKKdgmQ1vwQ0Bw0lO
         Xr48+3JMnzAtDGJ3jGjfsuGGaXKYg6FeBIKRyLouqDp2S/MBcyvLXErSR03KLxph5cLP
         WXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0N2Vlhx9uI0JjtaiooSCUVeUfuFEkWna0eE3K2/1u4=;
        b=PJ7cUkTMcimnXpDVDIzpmaoVF8NpjwIh2+jRfcRAFStIXegYu223AFalZHy7TLmnhg
         NGcnwWzGvkCmTeLivY9/gsZi1JTR7M3ugiy+YBjwvEO8jjviLkDeoNIepXWdEmR21B+V
         1Ot/R148uTvz1AS4CKqOSyysbWuOkdBvxCMH7hrDb4Y+lIzgnSrNmdNNo4pwIJ+HGNEP
         GSEEmzirhp/jiupnPsx98DuaaQEerX8pyrHQiIJNUCLad9K003J9tHQQ7gHLdXx92pFl
         bU3ZLHxkNrQaCEjyf4K6QmSeXPrrgfZDLXvIMMTQqpyFgPmUTUoqkwSI1FxgzDrzgoEV
         v6ow==
X-Gm-Message-State: ANoB5pmpX1GLgtmpH3uvIij+tCkqLYXZarLn+2ELnGR27UgyPoPQXcBP
        5JidF4gfk0lvxdGsn+xQ+B2VEVeoNPsSIQ==
X-Google-Smtp-Source: AA0mqf41oCbzNykRlBt4+UuqPnCI7LGC9QoWHKqc3sx+heTmpRwfbPQJYbKYFhXZ/EGuj6B7ZdqEpQ==
X-Received: by 2002:a17:906:2dc2:b0:7ae:c1af:a078 with SMTP id h2-20020a1709062dc200b007aec1afa078mr29996656eji.294.1669315567614;
        Thu, 24 Nov 2022 10:46:07 -0800 (PST)
Received: from gmgdl ([213.143.127.178])
        by smtp.gmail.com with ESMTPSA id de52-20020a1709069bf400b007ae566edb8bsm711783ejc.73.2022.11.24.10.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 10:46:07 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oyHEc-000JyA-1f;
        Thu, 24 Nov 2022 19:46:06 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     rsbecker@nexbridge.com
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [BUG} t2201.7+ Failure to Create Thread in 2.39.0-rc0
Date:   Thu, 24 Nov 2022 19:40:45 +0100
References: <010201d9002e$8e2f9940$aa8ecbc0$@nexbridge.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <010201d9002e$8e2f9940$aa8ecbc0$@nexbridge.com>
Message-ID: <221124.86o7swnqc1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


[CC-ing Jeff, this is from the "stopwatch timers" topic]

On Thu, Nov 24 2022, rsbecker@nexbridge.com wrote:

> While running t2201.7 (and subsequent) for 2.39.0-rc0, I hit a condition
> where:

Don't you mean t0211-trace2-perf.sh?

> <snip>
> + test_when_finished rm trace.perf actual
> + test_config_global trace2.perfBrief 1
> + pwd
> + test_config_global trace2.perfTarget
> /home/ituglib/randall/jenkins/.jenkins/workspace/Git_Pipeline/t/trash
> directory.t0211-trace2-perf/trace.perf
> + test-tool trace2 101timer 5 10 3
> fatal: failed to create thread[0]
>
> was encountered, causing the test to fail. Pointers on resolving this would
> be helpful.

Apparently we really could use a NO_PTHREADS=Y CI setup, because that's
all that's needed to reproduce this on linux & elsewhere. Running the
test with that:
	
	+ test-tool trace2 101timer 5 10 3
	fatal: failed to create thread[0]
	error: last command exited with $?=128

For that all that's needed is this:
	
	diff --git a/t/t0211-trace2-perf.sh b/t/t0211-trace2-perf.sh
	index 0b3436e8cac..cfba6861322 100755
	--- a/t/t0211-trace2-perf.sh
	+++ b/t/t0211-trace2-perf.sh
	@@ -203,7 +203,7 @@ test_expect_success 'stopwatch timer test/test1' '
	 	have_timer_event "main" "timer" "test" "test1" 5 actual
	 '
	 
	-test_expect_success 'stopwatch timer test/test2' '
	+test_expect_success PTHREADS 'stopwatch timer test/test2' '
	 	test_when_finished "rm trace.perf actual" &&
	 	test_config_global trace2.perfBrief 1 &&
	 	test_config_global trace2.perfTarget "$(pwd)/trace.perf" &&
	@@ -249,7 +249,7 @@ test_expect_success 'global counter test/test1' '
	 	have_counter_event "main" "counter" "test" "test1" 15 actual
	 '
	 
	-test_expect_success 'global counter test/test2' '
	+test_expect_success PTHREADS 'global counter test/test2' '
	 	test_when_finished "rm trace.perf actual" &&
	 	test_config_global trace2.perfBrief 1 &&
	 	test_config_global trace2.perfTarget "$(pwd)/trace.perf" &&

I think that's the correct fix here, and it should go into rc1.
