Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CB2C1F453
	for <e@80x24.org>; Thu, 25 Apr 2019 09:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbfDYJrM (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 05:47:12 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34548 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbfDYJrL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 05:47:11 -0400
Received: by mail-pg1-f196.google.com with SMTP id v12so10938509pgq.1
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 02:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zxOUyaH/vhxzpri4C+jN934F4g9PmISNfIxeeCWqyxA=;
        b=HXE/ArT3YWqPITAXSquuU05udqz3oe7tRU1OyAbW2o7iSgBjQDrSnhqjW5rUNc10/z
         m5PRSfrIBPn8RKFZtvFBkbPFHyOq9eBdNjmVYDqTMnmxuFCngktieelQEmIFlCB64hJI
         3jmfKm1pmoeynsFQoRCtIPH/7QzxKIjKl1AwGYiEO16E4sroxDCzN1iiFRWD44WphVdf
         dynzx2Gv6xL7KvrxcDQnCp0Ii0+kZDfNsDB8Xsi4/prj1j4CH+aZdAmaMsbEJjnB1/Xm
         OywP45pgsvEuSHrW6tlLKliFLzk3FYosCw6kZundV13P6+hPVtQWMmp84fsro3ThPNHt
         MR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zxOUyaH/vhxzpri4C+jN934F4g9PmISNfIxeeCWqyxA=;
        b=KgiwYjTlGONC7NJ+yAY/YyI09r90CANUPuzsglysgDQ20ltVG5Llui8XW0Byc+QUq/
         3lLwcU4zRBgnK+3ZvcY6KE0LMqgKnQh1yjtNz7U/cnD9PCLim9qMOsJ/3IcQVor3ctMt
         3mJOL7a/Aa3uUxuk0My7owh5CIgIH/Dn8+2RMd2OEVdXT5kwsI0OivXyIZTZR1a1Gac2
         sJP9LbElkyMJxwzGktlfCmAg7bBqlMJcB5pPlXRf8yS3/plTgvZFAovMo1nvyCXWdMww
         rdmlmXzJb9+DY5gXJbvz2t1SmJk1xAR5k1KG/nLe9B8QAvoD4y2V0569n8hppC18T2AY
         vUqA==
X-Gm-Message-State: APjAAAVsN49m0a/PoAPhnAMGKuu4dvxAmK8pZtao0egPyClDYbWT0/x3
        TNSaX4LtcPpw19Np6Cmq/Io=
X-Google-Smtp-Source: APXvYqz4nx657PyYkuja43BOivwgDXfZjTHStGvBWihG8oMy6RIQOIzasVBH96nCwZBev+tEPF80/A==
X-Received: by 2002:a63:5110:: with SMTP id f16mr17215438pgb.107.1556185631448;
        Thu, 25 Apr 2019 02:47:11 -0700 (PDT)
Received: from ash ([115.73.128.9])
        by smtp.gmail.com with ESMTPSA id p26sm46429024pfa.49.2019.04.25.02.47.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 02:47:10 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 25 Apr 2019 16:47:06 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        jacob.keller@gmail.com, newren@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com
Subject: [PATCH v3 12/16] completion: support restore
Date:   Thu, 25 Apr 2019 16:45:56 +0700
Message-Id: <20190425094600.15673-13-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.854.ge34a79f761
In-Reply-To: <20190425094600.15673-1-pclouds@gmail.com>
References: <20190411131218.19195-1-pclouds@gmail.com>
 <20190425094600.15673-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Completion for restore is straightforward. We could still do better
though by giving the list of just tracked files instead of all present
ones. But let's leave it for later.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b24bc48276..58d18d41a2 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2491,6 +2491,21 @@ _git_reset ()
 	__git_complete_refs
 }
 
+_git_restore ()
+{
+	case "$cur" in
+	--conflict=*)
+		__gitcomp "diff3 merge" "" "${cur##--conflict=}"
+		;;
+	--source=*)
+		__git_complete_refs --cur="${cur##--source=}"
+		;;
+	--*)
+		__gitcomp_builtin restore
+		;;
+	esac
+}
+
 __git_revert_inprogress_options="--continue --quit --abort"
 
 _git_revert ()
-- 
2.21.0.854.ge34a79f761

