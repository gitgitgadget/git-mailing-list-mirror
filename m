Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCC3320248
	for <e@80x24.org>; Thu,  4 Apr 2019 02:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfDDCrQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 22:47:16 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35670 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfDDCrQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 22:47:16 -0400
Received: by mail-wm1-f67.google.com with SMTP id y197so1287579wmd.0
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 19:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QQJh/Yjbo0sGaRnti5167gBf8IUWinE2lID6obZH2uo=;
        b=o4s5zmgBGNfVuhVC8CGqGHXqhTk4KsEFc05iLaNo5Bc0Q8lLM4V6l6MtFPDPV7JqQA
         w8KMIt+tAg1oYH4FTBJykCO+kGlWNPorOfNj71qh6/sZ5cGpfozK8CbphGFUFx1oFEQx
         RySl8z0tqFWAmp27nGEDUvD4iFGVbazqO6XyEkSlCsH2yrm967SAjiQLXsNPRPMeH2dz
         Y+nZS0HNp90x11bUtmXu0xzGK7NGjRCKUpwDw9IK9dWKOcN283YEKDzM8Jm61xOsiBPV
         EDsK4d0G9JsAEixXCVCgbpdrTd1gQ3dMAOUXdnpRa/q/vSU+t3BIGYkBGrrcRiLapF9l
         DCIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QQJh/Yjbo0sGaRnti5167gBf8IUWinE2lID6obZH2uo=;
        b=m/TWUxMVtD5kinBGsZbnF5I0iZQTxvbOUU5nWvFexwTOTcRf3uVpITBDSQGLVHmP6R
         ZQgbUx6kG+X4SEAcTqLCHHryMwR6IzVDgYJH9Wtv0ibK3k0KWbXccGK6GxInwP79eTtu
         D70do9iZdb9z7627j7QFsNNDJ+owyLYncnUu6XWhxR9r0O9+J27xDlbQFFgc3zB2R3sN
         i6J5aF9xKfY4uXsBQ2QINtsuGOAlTlNpdZXY2Zr6fUGLH23mp16vikyGd1csivIdPFtO
         Myqi6E3FfrBKmVGLg/vUDKuuZOLSI6irfnN/XT8WyWxlFyS8pFXxEKO8iIQKRZcnuczY
         RoTA==
X-Gm-Message-State: APjAAAWZLyiIWzBXYY4/VwuipnsgdhJEbEl2ms/effvYmvD0uIgUH+y5
        QGPfGsVv/WeXRzmbuWe7psE=
X-Google-Smtp-Source: APXvYqwp55k0Zb3rP+Za03QDVeeZ4utkRQ31x/zoRV8h90ge2Ei2/a1YgaJIY596/x7GfEf1gN6mXA==
X-Received: by 2002:a1c:dc43:: with SMTP id t64mr2252346wmg.19.1554346033588;
        Wed, 03 Apr 2019 19:47:13 -0700 (PDT)
Received: from szeder.dev (x4db96230.dyn.telefonica.de. [77.185.98.48])
        by smtp.gmail.com with ESMTPSA id n4sm18389141wrx.39.2019.04.03.19.47.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 19:47:12 -0700 (PDT)
Date:   Thu, 4 Apr 2019 04:47:10 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        peff@peff.net, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v2 2/2] diff: batch fetching of missing blobs
Message-ID: <20190404024710.GO32732@szeder.dev>
References: <20190326220906.111879-1-jonathantanmy@google.com>
 <cover.1553895166.git.jonathantanmy@google.com>
 <44de02e584f449481e6fb00cf35d74adf0192e9d.1553895166.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <44de02e584f449481e6fb00cf35d74adf0192e9d.1553895166.git.jonathantanmy@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 29, 2019 at 02:39:28PM -0700, Jonathan Tan wrote:
> diff --git a/t/t4067-diff-partial-clone.sh b/t/t4067-diff-partial-clone.sh
> new file mode 100755
> index 0000000000..349851be7d
> --- /dev/null
> +++ b/t/t4067-diff-partial-clone.sh
> @@ -0,0 +1,103 @@
> +#!/bin/sh
> +
> +test_description='behavior of diff when reading objects in a partial clone'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'git show batches blobs' '
> +	test_when_finished "rm -rf server client trace" &&
> +	
> +	test_create_repo server &&
> +	echo a >server/a &&
> +	echo b >server/b &&
> +	git -C server add a b &&
> +	git -C server commit -m x &&
> +
> +	test_config -C server uploadpack.allowfilter 1 &&
> +	test_config -C server uploadpack.allowanysha1inwant 1 &&
> +	git clone --bare --filter=blob:limit=0 "file://$(pwd)/server" client &&
> +
> +	# Ensure that there is exactly 1 negotiation by checking that there is
> +	# only 1 "done" line sent. ("done" marks the end of negotiation.)
> +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client show HEAD &&
> +	grep "git> done" trace >done_lines &&
> +	test_line_count = 1 done_lines

These patches and 'cc/multi-promisor' don't seem to work well
together, and all tests checking 'test_line_count = 1 done_lines' in
this test script fail in current 'pu', because there are two
"git> done" lines.

> +'
> +
> +test_expect_success 'diff batches blobs' '
> +	test_when_finished "rm -rf server client trace" &&
> +
> +	test_create_repo server &&
> +	echo a >server/a &&
> +	echo b >server/b &&
> +	git -C server add a b &&
> +	git -C server commit -m x &&
> +	echo c >server/c &&
> +	echo d >server/d &&
> +	git -C server add c d &&
> +	git -C server commit -m x &&
> +
> +	test_config -C server uploadpack.allowfilter 1 &&
> +	test_config -C server uploadpack.allowanysha1inwant 1 &&
> +	git clone --bare --filter=blob:limit=0 "file://$(pwd)/server" client &&
> +
> +	# Ensure that there is exactly 1 negotiation by checking that there is
> +	# only 1 "done" line sent. ("done" marks the end of negotiation.)
> +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client diff HEAD^ HEAD &&
> +	grep "git> done" trace >done_lines &&
> +	test_line_count = 1 done_lines
> +'
> +
> +test_expect_success 'diff skips same-OID blobs' '
> +	test_when_finished "rm -rf server client trace" &&
> +
> +	test_create_repo server &&
> +	echo a >server/a &&
> +	echo b >server/b &&
> +	git -C server add a b &&
> +	git -C server commit -m x &&
> +	echo another-a >server/a &&
> +	git -C server add a &&
> +	git -C server commit -m x &&
> +
> +	test_config -C server uploadpack.allowfilter 1 &&
> +	test_config -C server uploadpack.allowanysha1inwant 1 &&
> +	git clone --bare --filter=blob:limit=0 "file://$(pwd)/server" client &&
> +
> +	echo a | git hash-object --stdin >hash-old-a &&
> +	echo another-a | git hash-object --stdin >hash-new-a &&
> +	echo b | git hash-object --stdin >hash-b &&
> +
> +	# Ensure that only a and another-a are fetched.
> +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client diff HEAD^ HEAD &&
> +	grep "want $(cat hash-old-a)" trace &&
> +	grep "want $(cat hash-new-a)" trace &&
> +	! grep "want $(cat hash-b)" trace
> +'
> +
> +test_expect_success 'diff with rename detection batches blobs' '
> +	test_when_finished "rm -rf server client trace" &&
> +
> +	test_create_repo server &&
> +	echo a >server/a &&
> +	printf "b\nb\nb\nb\nb\n" >server/b &&
> +	git -C server add a b &&
> +	git -C server commit -m x &&
> +	rm server/b &&
> +	printf "b\nb\nb\nb\nbX\n" >server/c &&
> +	git -C server add c &&
> +	git -C server commit -a -m x &&
> +
> +	test_config -C server uploadpack.allowfilter 1 &&
> +	test_config -C server uploadpack.allowanysha1inwant 1 &&
> +	git clone --bare --filter=blob:limit=0 "file://$(pwd)/server" client &&
> +
> +	# Ensure that there is exactly 1 negotiation by checking that there is
> +	# only 1 "done" line sent. ("done" marks the end of negotiation.)
> +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client diff -M HEAD^ HEAD >out &&
> +	grep "similarity index" out &&
> +	grep "git> done" trace >done_lines &&
> +	test_line_count = 1 done_lines
> +'
> +
> +test_done
> -- 
> 2.21.0.197.gd478713db0
> 
