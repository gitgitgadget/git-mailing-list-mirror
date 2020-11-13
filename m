Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BE2C388F7
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 12:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F77F2224B
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 12:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vCDH9m2T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgKMMLD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 07:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbgKMMLB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 07:11:01 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874C3C0613D1
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 04:11:01 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a3so8232912wmb.5
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 04:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=88UgrApuDK/5WFwxAwEQqOcvRWzJ5zO7ae5kWhBPjVk=;
        b=vCDH9m2TZ85Eyg+xnFt4JjbEYWY/++vhPC4u9wTuskWrBVeSUdcsLcB5ZPh1hMRGHD
         ZWBdXTP9MrRgzdN6MxeyYneWQUOC2QTKCUzgzZRg5hFdoQKernvrXeELTKn/GxnssG66
         zrtjOhopDBkx3jivrrpnaSn5gzpDa6WNUWPYYDREG7HCkEZ5rI04zd/8mgvbAzgLO7YH
         NZTnFRYBftIZf/WhaXntc4tzpcC+tsOi5Bp5dEAf1Xv4O+xW1SVaVjVmb4yXmnMlkslF
         hKi0nF4oxCtzcpYkNq8zU8lsDXv5tvJc8kuoR+uBXr4Y6vfhh+1vHd2rSP8KitkPqRPP
         9+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=88UgrApuDK/5WFwxAwEQqOcvRWzJ5zO7ae5kWhBPjVk=;
        b=ETu3exW7aAgE5UscSm0X+BohV4GpWV2DCjHq6Y85vm/YjDm5RKT3+TFKAFHlfZ8OKR
         oHMbafuSi7sTMnRD0URQhUQJdXrcQ19soHJEROGf5KCHZHdX4X5uclhKTfCUbqTyfbUD
         NM+8YZGgDLvMc3Inmk1IEsUA46TZ3fvSVMLYYbZxxcE089Tn57w8FKtQ/LC2kpS2ZSAL
         dy1VpVChUO13tHpqTDrmLQ/8/IhzW0cSZ/H6S5mXqgg3n8B6r0YLTsQbrY5cVuEp6A/8
         llHcOpla0Cjeg9M6D4lCMpDBMHVU6K277KJL+PApiBEYT3n0nGkBM1sBk+avSu4IdGrx
         OW5Q==
X-Gm-Message-State: AOAM532W36+yW88FNxay++ENZTp54ActJaktnVOUGYvazS6ZA2v77cMB
        m//XEUcIT3qs5ynK30WQiggzxt7iJ9U=
X-Google-Smtp-Source: ABdhPJytEhn6o1ZqoBIHh7Abs9Un/JQCieZVV0YM8CgHOPuBj8enwYt2BSZ2ps19/84B3MRbA++kwA==
X-Received: by 2002:a1c:c2c3:: with SMTP id s186mr2311462wmf.160.1605269460060;
        Fri, 13 Nov 2020 04:11:00 -0800 (PST)
Received: from ylate.lan (atoulouse-654-1-426-233.w2-6.abo.wanadoo.fr. [2.6.209.233])
        by smtp.googlemail.com with ESMTPSA id g138sm10083697wme.39.2020.11.13.04.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 04:10:59 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v4 10/12] merge: use the "octopus" strategy without forking
Date:   Fri, 13 Nov 2020 12:04:26 +0100
Message-Id: <20201113110428.21265-11-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201113110428.21265-1-alban.gruin@gmail.com>
References: <20201005122646.27994-1-alban.gruin@gmail.com>
 <20201113110428.21265-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This teaches `git merge' to invoke the "octopus" strategy with a
function call instead of forking.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/merge.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/merge.c b/builtin/merge.c
index ddfefd8ce3..02a2367647 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -744,6 +744,9 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 	} else if (!strcmp(strategy, "resolve"))
 		return merge_strategies_resolve(the_repository, common,
 						head_arg, remoteheads);
+	else if (!strcmp(strategy, "octopus"))
+		return merge_strategies_octopus(the_repository, common,
+						head_arg, remoteheads);
 	else {
 		return try_merge_command(the_repository,
 					 strategy, xopts_nr, xopts,
-- 
2.20.1

