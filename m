Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2B921F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 12:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405198AbfJWMEC (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 08:04:02 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42618 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405196AbfJWMEC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 08:04:02 -0400
Received: by mail-pf1-f193.google.com with SMTP id 21so1551032pfj.9
        for <git@vger.kernel.org>; Wed, 23 Oct 2019 05:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0XV9eRpYAap7odwETBIOK/c0KvQF4hNy+9IBmKi/5S8=;
        b=oRWrXuvvkwqC1cXe//D1NqYJWdbZHm3zqYuIgeNzV1pOQJJhReGGtKX/+AIpI26IoY
         IP4/IfTX0rb5oF4WMWg692mhhgWeE+wg6Zv2is+Hq/ALSN//zAeMfJPXTt28vyoF4BU+
         9dNxkftnrPKsRO0lciQWlJK+d7rxm7a5ij8JJmqcnTviJqvqpc0DilmF3pmvUUomMWiZ
         TUnh6RMxXf5vkwW4EgTfKdavqmcBZQrU9kco3QAbAKZYBNKatGU0K7Wygt2n5U6YlJJW
         U2GsATomQyWuWmeUhGthinPPvD04yqiSxmBgSQQiUBjZAtlxGVBXOWAvx3dFiHwUxYzY
         JnJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0XV9eRpYAap7odwETBIOK/c0KvQF4hNy+9IBmKi/5S8=;
        b=g4iCFgXawG3aIokTT/FvQ3SxPvB0+dlb3BmfEkxj+wS8IQh2PZajUBbEBM3OiR9x67
         snNkltifNZpFYOanN/rSMj50zu/mmKesNAVUI8xfIrR6kqqRY61V5C5Ewya1g7FT+R2t
         OlS8sj6Big2jO+ki0IK7aKtwFzwIaKtVv3VCdpY9woSDRtCENZFoYbsrBefQj0NgYrE1
         2quPubJa9PQpyOAAr0bZNUeeXwpVIp1FEU3xkqTPwkbbdRTptKp99z5J3lLchd9j1XMi
         47KeIP1eEGHLMeS3RWfrvuXw8AkDPbm//H/qXNeP1DDYskspN2a9SQS63wPMz+m/GlL8
         N2RQ==
X-Gm-Message-State: APjAAAWKREzKYL1KH5Dn7dtCcWoeN6dow4EDQXcR9i+cWdGNsEPxkvEt
        zYv33Df1kH6pRYO0K2dPwPq1D4Pu
X-Google-Smtp-Source: APXvYqwUpMSfXwFuwhz8PFXkn5PlMwrFgy7xwx7hI9/IjHJ60XljJHe8c2XFM81cId8XJ1GQ2FbXHg==
X-Received: by 2002:a63:3d41:: with SMTP id k62mr9181877pga.129.1571832241311;
        Wed, 23 Oct 2019 05:04:01 -0700 (PDT)
Received: from generichostname ([2601:646:280:1b30:80db:d816:4d15:ae2a])
        by smtp.gmail.com with ESMTPSA id b14sm24189238pfi.95.2019.10.23.05.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 05:04:00 -0700 (PDT)
Date:   Wed, 23 Oct 2019 05:03:58 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/5] apply: respect merge.conflictStyle in --3way
Message-ID: <56c31310db9358673af9905910e3332893d798de.1571832177.git.liu.denton@gmail.com>
References: <cover.1571832176.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571832176.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, when doing a 3-way merge, the merge.conflictStyle option was not
respected and the "merge" style was always used, even if "diff3" was
specified.

Call git_xmerge_config() at the end of git_apply_config() so that the
merge.conflictStyle config is read.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 apply.c                   | 2 +-
 t/t4108-apply-threeway.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/apply.c b/apply.c
index f8a046a6a5..b9291f5f7b 100644
--- a/apply.c
+++ b/apply.c
@@ -32,7 +32,7 @@ static void git_apply_config(void)
 {
 	git_config_get_string_const("apply.whitespace", &apply_default_whitespace);
 	git_config_get_string_const("apply.ignorewhitespace", &apply_default_ignorewhitespace);
-	git_config(git_default_config, NULL);
+	git_config(git_xmerge_config, NULL);
 }
 
 static int parse_whitespace_option(struct apply_state *state, const char *option)
diff --git a/t/t4108-apply-threeway.sh b/t/t4108-apply-threeway.sh
index 84347fc178..0e4eeac083 100755
--- a/t/t4108-apply-threeway.sh
+++ b/t/t4108-apply-threeway.sh
@@ -81,7 +81,7 @@ test_apply_with_3way () {
 }
 
 test_apply_with_3way success default true
-test_apply_with_3way failure 'merge.conflictStyle = diff3' 'test_config merge.conflictStyle diff3'
+test_apply_with_3way success 'merge.conflictStyle = diff3' 'test_config merge.conflictStyle diff3'
 
 test_expect_success 'apply with --3way with rerere enabled' '
 	test_config rerere.enabled true &&
-- 
2.24.0.rc0.197.g0926ab8072

