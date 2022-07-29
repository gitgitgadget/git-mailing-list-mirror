Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89EAC04A68
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 17:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237296AbiG2RMP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 13:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbiG2RMO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 13:12:14 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011B96C116
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 10:12:10 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id z17so2038703wrq.4
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 10:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fyL3xY6X5zYi9WlZWPCL7SKHIujEQ5pgPDx9ouoanUE=;
        b=c/9geieItN6upZWQYubtVnQ72sFgDMZy+bmTWqFzXmn1yhNYrq5BsU03t/hnfdvoXG
         7uL6GXODNl7e/fwGdCiO//w5TFCDogExremm0+7cvyDYw6pDs4u41ddLSFTu/ipW987x
         HgZXfizXgtau9Yu27c92JC0uLZcfEKOzm7GlXi5JWN5zdmuE9F6p/d2UZS4MS0X8WM+z
         TjOrK89Spq77/YtDF9IDXeEcNvCVWqydF8r+4Ts2hkvm1Qh4CQK71PvlvzmexNtj+nrc
         GVibLrZaUafQHh9MKXVJjO+1vJ7C/sbZa4Pug1nuyZoJfmeaUckZbfxQng1w/8F5teiU
         t66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fyL3xY6X5zYi9WlZWPCL7SKHIujEQ5pgPDx9ouoanUE=;
        b=TA/GPZpj9pN+NBceuv5Mb9w8tVnmIpeoKb4hmyXLsM7zUo79d09EYDySGKShuwSbH8
         NYXXZITDGNC8ul80TQxp3rnotv4o7CtZpzjtvg8likCfgefX9OUVHdBe1gyHabGVKWgS
         jMT+sAh5lakeR0pFtMk/skt6sKdqbuZi49g792LCd7mz/ZZDehS6Hz+2I7Bzg+2+URWs
         gqgEq1l/zC8S3OvqZW2uKYdRQi2QEpS3cHMagThbrBpweDiWW8HfyH1jLg7Ie/ZcP1Rn
         CggJ9gCJqTVISQkTiw8Bylt8iD6dm+EJklLaVByfKrOFDo469byF4pQQIYyVkEb2ouj9
         2v7Q==
X-Gm-Message-State: ACgBeo2vow/Vtvb8YOpuMTlGC/HxdPvfHfOD3p+Jv2HJe95OTbgxUoTO
        FQhFxc1Ad/u5j2hANhuawgSchCStrjI=
X-Google-Smtp-Source: AA6agR6Ep9y56OEZctqUcRqJjSzRa9tVjuplJIf2Q85XGBLraPtVLsS7/S5DUbyDEd42/UsQ9QkHEg==
X-Received: by 2002:a5d:453a:0:b0:21e:cfb2:b325 with SMTP id j26-20020a5d453a000000b0021ecfb2b325mr2961086wra.540.1659114728839;
        Fri, 29 Jul 2022 10:12:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r10-20020a05600c284a00b003a3561d4f3fsm4694482wmb.43.2022.07.29.10.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 10:12:08 -0700 (PDT)
Message-Id: <pull.1307.v2.git.1659114727.gitgitgadget@gmail.com>
In-Reply-To: <pull.1307.git.1659084748350.gitgitgadget@gmail.com>
References: <pull.1307.git.1659084748350.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Jul 2022 17:12:05 +0000
Subject: [PATCH v2 0/2] merge-ort: clean up after failed merge
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was investigating why seen's CI runs fail, and came up with this fix.

Changes since v1:

 * Rebased onto en/merge-ort-perf.
 * Now we're not only cleaning up the merge data structure, but also leaving
   the Trace2 region when returning early from merge_switch_to_result().

Johannes Schindelin (2):
  merge-ort: clean up after failed merge
  merge-ort: do leave Trace2 region even if checkout fails

 merge-ort.c | 5 +++++
 1 file changed, 5 insertions(+)


base-commit: 557ac0350d9efa1f59c708779ca3fb3aee121131
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1307%2Fdscho%2Fmerge-ort-impl-leakfix-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1307/dscho/merge-ort-impl-leakfix-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1307

Range-diff vs v1:

 1:  128f77f7f34 ! 1:  082c7ffa41f merge-ort: clean up after failed merge
     @@ merge-ort.c: void merge_switch_to_result(struct merge_options *opt,
      +			merge_finalize(opt, result);
       			return;
       		}
     - 
     + 		trace2_region_leave("merge", "checkout", opt->repo);
      @@ merge-ort.c: void merge_switch_to_result(struct merge_options *opt,
       						    &opti->conflicted)) {
       			/* failure to function */
     @@ merge-ort.c: void merge_switch_to_result(struct merge_options *opt,
      +			merge_finalize(opt, result);
       			return;
       		}
     - 	}
     + 		trace2_region_leave("merge", "record_conflicted", opt->repo);
 -:  ----------- > 2:  d2e1af0f922 merge-ort: do leave Trace2 region even if checkout fails

-- 
gitgitgadget
