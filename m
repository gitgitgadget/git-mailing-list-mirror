Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9E7C433FE
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 19:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A422A61221
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 19:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbhJUUAe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 16:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbhJUUAX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 16:00:23 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03250C061348
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 12:58:07 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r7so1213931wrc.10
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 12:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H40BODoaEwWJ/h8RBJsOcP6vlgeNeTbLFeZczmlQgYU=;
        b=FHVaduouEu8SjmxMPc04NaibauGjx9n7qXgTfzuc8SGU8+8cgkCbupLGwcCfvfFjv+
         47jn8ZvLwHyMPPkXuHHiRGfb+oSY1XZqPXFta8BG/uVK9/wG9u0vBG6VpbnAosmuQCPb
         qSLafmY//PimTPs/mvtzNTOvHEA5tktOrlvzdvALEQ/nxLB9+3i/4HLXe5w5PZVZJYsM
         8NKHg4Tw96n5N+Z6iRRfwaCCxC9d84VLRlIIWNPlairU6hpxU+HHYBrI5mlaKUCsR/L6
         6QzAiikY+8idoi//R8SoszdxduKaTrP/Gb2bPlSfX8uTdzGssIuO5hIbk7hI7PghOfuM
         D8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H40BODoaEwWJ/h8RBJsOcP6vlgeNeTbLFeZczmlQgYU=;
        b=NI6fSfX+VOiI+XG5UPVWQcu5g3MZHqNqynX3Y8W8f0OPYdTRfihyDULw3y5Tss0Fq6
         cDJOVfuLwELGHfbcnB23tIZXDIfhgHu6HXtYbLuWkoIBcVfUCkkPViufrw8oU/rRSFbk
         tBWy/OcieXPPptIRvAAVaI4xYzhwyir6y3yR2dxc0Mi99A3pMUodWaM6wWoHdlm6VFZl
         wwrwc82UHbBJEUbKacJdmaPeurag4Dl9XchuiqgTkkUdtl/XgmS06n6REbmQeAW+/Qaa
         Nalxq35AITSJRcM6RD9E9qRSdSZKq8OmPN/5UFwVkgDDkFS8VCHKGY71hvAQFH+D/jpm
         VkFw==
X-Gm-Message-State: AOAM533K4xWeueOzv1uaR+minA8+bDmC6PAeiWER/6lzxSlvBYLnMn0O
        cpk9JoAiSuVlgIaPzbXrCwfTsxzHRTJ1Iw==
X-Google-Smtp-Source: ABdhPJyLHpxef2+JwBHi+bupEH7esJEbicM/RfApFHuXkRDGs/FbwZrD+Y0Go3stzFehF1qUH13XGg==
X-Received: by 2002:a5d:63ca:: with SMTP id c10mr9972949wrw.407.1634846285291;
        Thu, 21 Oct 2021 12:58:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o40sm388765wms.10.2021.10.21.12.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 12:58:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/6] git-instaweb: unconditionally assume that gitweb is mod_perl capable
Date:   Thu, 21 Oct 2021 21:57:58 +0200
Message-Id: <patch-4.6-4feeeb12aca-20211021T195538Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1494.g88b39a443e1
In-Reply-To: <cover-0.6-00000000000-20211021T195538Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20211021T195538Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove a check for whether mod_perl is a supported mode of gitweb.cgi
added in a51d37c1df6 (Add git-instaweb, instantly browse the working
repo with gitweb, 2006-07-01).

The reason for the check was to support users who had a newer version
of git and an older version of gitweb, it was then subsequently
adjusted for changes in the script in f0e588dffc1 (git-instaweb: fix
mod_perl detection for apache2, 2009-08-08).

It's a fair bet that nobody's running a git from 2021 and gitweb from
pre-2007 anymore, so we can unconditionally assume that this will be
supported by gitweb.cgi.

This allows a subsequent commit to remove the sane_grep() wrapper,
this change is split up from that since this is the only case where
the "grep" invocation could be removed entirely.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-instaweb.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index 7c55229773e..54094fbe8de 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -380,10 +380,7 @@ TypesConfig "$fqgitdir/mime.types"
 DirectoryIndex gitweb.cgi
 EOF
 
-	# check to see if Dennis Stosberg's mod_perl compatibility patch
-	# (<20060621130708.Gcbc6e5c@leonov.stosberg.net>) has been applied
-	if test -f "$module_path/mod_perl.so" &&
-	   sane_grep 'MOD_PERL' "$root/gitweb.cgi" >/dev/null
+	if test -f "$module_path/mod_perl.so"
 	then
 		# favor mod_perl if available
 		cat >> "$conf" <<EOF
-- 
2.33.1.1494.g88b39a443e1

