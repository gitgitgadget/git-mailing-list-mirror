Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A07CC433EF
	for <git@archiver.kernel.org>; Tue, 19 Apr 2022 16:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354646AbiDSQfB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Apr 2022 12:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343889AbiDSQe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Apr 2022 12:34:59 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F1428E1C
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 09:32:16 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id x3so11027453wmj.5
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 09:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=p1sec-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject
         :content-language:to:cc:organization:content-transfer-encoding;
        bh=QeHx557fkuygYETmEeZlBaYIBlD658gwOMhn5Jdxkag=;
        b=e7xVNlVCspQgrJ5qTMbHx3z3iocjN1vOMsZLRvcDqV82z7vL0My6cHXanDnezJLiVL
         Pk/5yltk++g88bkxLHUdS4LvLJ/LbBmiemwMzB8GbtdypzHhADGDf6F399Kb+ONar/vV
         vzJRjpcYRDV6YEL5762cPTPSigPk3BbagafZ8X2dSATkYprB2acxdhCIOXv/Ma3DSXXs
         fB/V5Q0OFY5NYdH7HiYCTydVvmgBDJEMw4Bb5JASLP61R2aF8O5b+Y6wc7U57t1nIb7F
         KA2ORJBEuMP763dDMqn3v5GPWfj1TCFWXXSSdq0uBkbS9W+BsfSr0sRpAzo51wHdYo1c
         Aa3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:organization
         :content-transfer-encoding;
        bh=QeHx557fkuygYETmEeZlBaYIBlD658gwOMhn5Jdxkag=;
        b=L3/HeFIRtaf1mehJzxrGtHz+2+uU7aMDYBf1YHSau36xa2lyDk8+mtWxEbJ7mZqbql
         xBzvzj5tkPvODrnX661l5lGzcUAlvSi+9T75qPvlv2ieKBFLE8yRo/+h0edWfKq6WPvf
         Bgch5wpCsEXcutTdADj//JFW6GXl2BxP6PXknkDPmNcVaERyFxbpn9/q18KH5y8F7W8C
         bN9c9VpY2qs6v9GwJ/YXD2wp4G4obUeFoMRQrXpYC5J8UEh0xBZ/pGwo3/BYLokMFRBg
         AiTGIZY/1aRiLhTOSlOLwoyVoonNLVbO8OWyukNQPEWCUAfgijs2pQtABHerxmNDqAwp
         CjAw==
X-Gm-Message-State: AOAM530iggmbzQm78JyADszsvZi8GRt1TDfbmFgS12ibFguoJAGUSogP
        vbq2kWvsNK4dk4ycz2Wv11fpvLshFx/Scg==
X-Google-Smtp-Source: ABdhPJznwiMXGcPGS6sqtJDZBhu3+zfMA50oLM243dS4wN9jBL0sv6P6OupLQ9+ndA3aXup3e7XKoQ==
X-Received: by 2002:a1c:6a01:0:b0:37f:1b18:6b17 with SMTP id f1-20020a1c6a01000000b0037f1b186b17mr20901046wmc.146.1650385935259;
        Tue, 19 Apr 2022 09:32:15 -0700 (PDT)
Received: from ?IPV6:2a01:cb14:835c:3e00:30f6:190a:c095:20f8? ([2a01:cb14:835c:3e00:30f6:190a:c095:20f8])
        by smtp.gmail.com with ESMTPSA id d18-20020a05600c34d200b0038ed14b7ac3sm15897493wmq.40.2022.04.19.09.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 09:32:14 -0700 (PDT)
Message-ID: <a36fd2b0-0573-b93e-a765-ce57a651934e@p1sec.com>
Date:   Tue, 19 Apr 2022 16:32:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
From:   Gregory David <gregory.david@p1sec.com>
Subject: [PATCH] show-branch: fix SEGFAULT when `--current` and `--reflog`
 together
Content-Language: en-US
To:     git@vger.kernel.org
Cc:     ptm-dev <ptm-dev@p1sec.com>
Organization: P1 security
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If run `show-branch` with `--current` and `--reflog` simultaneously, a
SEGFAULT appears.

The bug is that we read over the end of the `reflog_msg` array after
having `append_one_rev()` for the current branch without supplying a
convenient message to it.

It seems that it has been introduced in:
Commit 1aa68d6735 (show-branch: --current includes the current branch.,
2006-01-11)

Signed-off-by: Gregory DAVID <gregory.david@p1sec.com>
Thanks-to: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/show-branch.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index e12c5e80e3..892241ce0d 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -812,6 +812,26 @@ int cmd_show_branch(int ac, const char **av, const
char *prefix)
 		}
 		if (!has_head) {
 			const char *name = head;
+			struct object_id oid;
+			char *ref;
+			unsigned int flags = 0;
+			char *log_msg;
+			char *end_log_msg;
+			timestamp_t timestamp;
+			int tz;
+
+			if (!dwim_ref(*av, strlen(*av), &oid, &ref, 0))
+				die(_("no such ref %s"), *av);
+			if(read_ref_at(get_main_ref_store(the_repository),
+					ref, flags, 0, i, &oid, &log_msg,
+					&timestamp, &tz, NULL)) {
+				end_log_msg = strchr(log_msg, '\n');
+				if (end_log_msg)
+					*end_log_msg = '\0';
+			}
+			if(log_msg == 0 || *log_msg == '\0')
+				log_msg = xstrfmt("(none)");
+			reflog_msg[ref_name_cnt] = xstrfmt("(%s) (current) %s",
show_date(timestamp, tz, DATE_MODE(RELATIVE)), log_msg);
 			skip_prefix(name, "refs/heads/", &name);
 			append_one_rev(name);
 		}
-- 
2.35.1
