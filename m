Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7060320248
	for <e@80x24.org>; Fri,  8 Mar 2019 09:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfCHJ7t (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 04:59:49 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42087 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbfCHJ7s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 04:59:48 -0500
Received: by mail-pg1-f194.google.com with SMTP id b2so13752705pgl.9
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 01:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e5CmMoWK+sGPkTokrfOhj43CY1+2HLbyq9u1oQMYj+A=;
        b=hP956ErZMUL+Zo7k78+pIgQt3FVXqAHJ/3aXbAA1C+jH3CrPlCfHxpuS2szvMt32e1
         0JNlinVe/waZLr9ve1/643OcUjK+5lDlvkrJI2WPXq1NqBaTEGTTzIbcJlIHgcp1Uyk5
         ZgdJLwmN6CsaE+NW+M8MFvls4OFiZlSMylj1C6bLFgBjL3kQ2o8qvoinxwJATuI0o8wm
         V9w0tc8TtbEqZ8EYxuZeyt3FDNDOrOpkkwmJT33OYIX1avbG22qPTogwl8CdObLU10/s
         +Iow0Gp5hpDAQO1HirNscNdfdkG5pq+cD0pS0Q+jPt9mGK77xLTxy7hhyfC+Jd6oR8Hp
         L8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e5CmMoWK+sGPkTokrfOhj43CY1+2HLbyq9u1oQMYj+A=;
        b=NbgWjbZXkc0hQJhp8q0MhUrYSf6IWjzqjQQW2PPsD9xP9mhJD5VUegQQyntKaIhYCB
         qBtPXKciSRseVinK/2SvWCxq8UXmr57dh0j+eBkXW67BSW3apD1I/CBUJ/uoXHmpNzK/
         AsIsg0tJ2m3ybZI9EX4hl+bo7zAa07rvAJVAoZ57eguXHdDwqBZSpxWo7XzhbTPP2nRE
         Rn3nkhgAxai+ub4hCUMN0j7vkR/7m3Xwpm7xFCG4UPIKFPZT7vBvax4vEYLQ3jRnCwzf
         IrP/9djsLDlVkIP6N1n9y2yl0T/7yfgOJQ/UIgguMkbQmq6+/UAuJuodFjiVZaBeVo8q
         /pwg==
X-Gm-Message-State: APjAAAX6CsPhtUs+pe7d/XRhI8EaCJWknPXrQJsYJo3bMmnTooRrokO1
        bBlWXM/OlOfbfle9ZTQrSfU=
X-Google-Smtp-Source: APXvYqwTdsfEel/kegJw9TDozjCSXNrjPgeTb6R2f9Alb5ULNSSliWg3kkMoUtZvPsDo8BSArUw6Jg==
X-Received: by 2002:a62:f5c8:: with SMTP id b69mr17368020pfm.128.1552039187444;
        Fri, 08 Mar 2019 01:59:47 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id l2sm8477740pgj.64.2019.03.08.01.59.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 01:59:46 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Mar 2019 16:59:42 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v3 20/21] completion: support switch
Date:   Fri,  8 Mar 2019 16:57:51 +0700
Message-Id: <20190308095752.8574-21-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190308095752.8574-1-pclouds@gmail.com>
References: <20190208090401.14793-1-pclouds@gmail.com>
 <20190308095752.8574-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Completion support for --guess could be made better. If no --detach is
given, we should only provide a list of refs/heads/* and dwim ones,
not the entire ref space. But I still can't penetrate that
__git_refs() function yet.
---
 contrib/completion/git-completion.bash | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 976e4a6548..7fcf28d437 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2158,6 +2158,33 @@ _git_status ()
 	__git_complete_index_file "$complete_opt"
 }
 
+_git_switch ()
+{
+	case "$cur" in
+	--conflict=*)
+		__gitcomp "diff3 merge" "" "${cur##--conflict=}"
+		;;
+	--*)
+		__gitcomp_builtin switch
+		;;
+	*)
+		# check if ---guess was specified to enable DWIM mode
+		local track_opt= only_local_ref=n
+		if [ -n "$(__git_find_on_cmdline "-g --guess")" ]; then
+			track_opt='--track'
+		fi
+		if [ -z "$(__git_find_on_cmdline "-d --detach")" ]; then
+			only_local_ref=y
+		fi
+		if [ $only_local_ref = y -a -n "$track_opt"]; then
+			__gitcomp_direct "$(__git_heads "" "$cur" " ")"
+		else
+			__git_complete_refs $track_opt
+		fi
+		;;
+	esac
+}
+
 __git_config_get_set_variables ()
 {
 	local prevword word config_file= c=$cword
-- 
2.21.0.rc1.337.gdf7f8d0522

