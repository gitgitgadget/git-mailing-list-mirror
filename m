Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40ECE1F404
	for <e@80x24.org>; Sun, 11 Mar 2018 13:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932214AbeCKN00 (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Mar 2018 09:26:26 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36145 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932138AbeCKN0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Mar 2018 09:26:25 -0400
Received: by mail-wr0-f194.google.com with SMTP id d10so623621wrf.3
        for <git@vger.kernel.org>; Sun, 11 Mar 2018 06:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4l+T+NutymtBncKfmujYaQwF7WnYD6HwN2rYLYCWazI=;
        b=VFq5W1e/t3Lz322zJ2jVsTqP/i4TQ46InZ70RNj2Vdvgeo1MXRblEM2WJsMbK8Jhq+
         3hW4UtZq7ucVQcoZ7jcZHuuV3TAmpxyRrczuKtdxLlZYLPTDeV6Pofqu3jFiYNrM4Ddc
         z/E2Jq0EJDSP8Ew1Zvn445pB4wiZsQ776fqsxi1h+2fPSAEd2qNutWyHRl+q7f0MN700
         HmQHt+be8sSlHJTD2fEOGwJAwXccOPfcDHRo08bBSewSza+B0ro8gXMIKQuh2CB2jRpO
         jrtoLxyBFdorhg3IHUfeXEd22Dhm7mCNQI40b0BNEkCx06dv/TAIR2XiVHuq6MA3NGrG
         DZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4l+T+NutymtBncKfmujYaQwF7WnYD6HwN2rYLYCWazI=;
        b=XD8f8Bsh0I+GUgcK6YZATorFGkdFfZEuOyvEyMnBM59jBc4ZgL8U5QjrR4Iaq7lttn
         2rCzEYLaEP2YJ3QuEVadtLUJ7QMVtLjtub7Jv/mgr49pn/2Tz6btCFhCGuXsvTZV3XWC
         VZU04YX6OMwOXDmXn6Rlso+wWWDz0FWCzwhZZefboMRbqb6C+GO59Sw4cctNJzd+/+f4
         ao1PRDdeyUrfGAsj4uA65BDH3+/lSc4eV1wt3dnmzTYZjX+9BHLkZJSEVE11UwCFrSIi
         +Hp+zxNgKedc2pBpCmei5mUpTMo9rHINJaFD+XuVEN4cu2njlejQ2IdmyDQKBHzvXlWN
         Jfxw==
X-Gm-Message-State: AElRT7EcJvKfimmgVEAuC77BR2no8KM8SMwt8z7VvSv5o4X19ARVoggq
        KGo2l9/M9C61/wCFbTW5mE2w3EOi
X-Google-Smtp-Source: AG47ELtUarIEU3Ts36/KNwowSTLfT/yoWvvimnlcorIrwb/n6UgWdUv4WBtnPLglzlKuMaPTAFgfIg==
X-Received: by 10.223.133.214 with SMTP id 22mr3964119wru.130.1520774783406;
        Sun, 11 Mar 2018 06:26:23 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id d23sm3868563wma.20.2018.03.11.06.26.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Mar 2018 06:26:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/3] configure: fix a regression in PCRE v1 detection
Date:   Sun, 11 Mar 2018 13:26:07 +0000
Message-Id: <20180311132609.32154-2-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180311132609.32154-1-avarab@gmail.com>
References: <20180311132609.32154-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the check for PCRE v1 to disable the --with-libpcre1 option if
the pcre_version() function can't be found in the pcre library. I
unintentionally changed this in my 94da9193a6 ("grep: add support for
PCRE v2", 2017-06-01) while renaming moving some variables.

The intent of this check ever since it was added in
a119f91e57 ("configure: Check for libpcre", 2011-05-09) is to
second-guess the user and turn off an explicitly provided
--with-libpcre if the library can't be found.

I don't think that behavior makes any sense, we shouldn't be
second-guessing the user with an auto-detection, but changing that
needs a bigger refactoring of this script, and only has marginal
benefits. So let's fix it to work as it was intended to work again.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 configure.ac | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 7f8415140f..41ceb2ac81 100644
--- a/configure.ac
+++ b/configure.ac
@@ -549,8 +549,8 @@ if test -n "$USE_LIBPCRE1"; then
 GIT_STASH_FLAGS($LIBPCREDIR)
 
 AC_CHECK_LIB([pcre], [pcre_version],
-[USE_LIBPCRE=YesPlease],
-[USE_LIBPCRE=])
+[USE_LIBPCRE1=YesPlease],
+[USE_LIBPCRE1=])
 
 GIT_UNSTASH_FLAGS($LIBPCREDIR)
 
-- 
2.15.1.424.g9478a66081

