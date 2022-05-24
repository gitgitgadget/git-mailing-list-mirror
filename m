Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF3FC433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 16:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237314AbiEXQ6a (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 12:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbiEXQ63 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 12:58:29 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFC16E8FC
        for <git@vger.kernel.org>; Tue, 24 May 2022 09:58:28 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id j6so15490144qkp.9
        for <git@vger.kernel.org>; Tue, 24 May 2022 09:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FC9O2oUBpIot7IkMZFXrysqbaHb/Gn2H2EdCXp1HyZk=;
        b=hoTBpWhrpbAwwS10f5fxwYW2cj9KaeFpYiejp32R3CFygAapJe6gbDc5oPQJgvf2HK
         eM2dxELNXwtsoM0Re+ouzi3lxmJaqFe6HEAV/Q6JTS61GZjmZ+kvTPvrL7fQ8JGkumFu
         WiZWvT4/0rq812swuBx7yzPgJrs3Gz7iEVFX/62MleX/J/5v55u129LugEuZmpLrCjKS
         mh092KIw3lEFr3PEX6ws799Yy8Hs12hG73fJBvGjY21z1LAsi6WJRUFORny2p1uwV6fb
         Zh+gr1YTscz/lG2BIyO2vIJvRvIF0dTaFoHkbqNdPKUmq34mwydfkiykDZ33tX7ZeM46
         cu8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FC9O2oUBpIot7IkMZFXrysqbaHb/Gn2H2EdCXp1HyZk=;
        b=Zy07yhKd/b/h4drRXNoDGfrzCqN8R4d6FDPV/h62TyAzB7kCfbVRFp36VCh9Z+Ivch
         5aR+MvXurlgNsKxVPMjTNZSvnfewHKVvcGgliNSP0EHqBtVKVm5GzZPVhdSSivIfHX4I
         jAG6PT8L8UMflxNzQ1LXrdmxQlp/apOyAZ5NFQu7ZCzKZUt4EARS164/QpS8Egs16IM+
         s4Zwlws8kitKXNGn0KrfLwEbVx4iCsN+WlRQ9lBvfO+OSlCQ5LFlBCJikAakiCiXnRCj
         Mi/6O1pbLqUj4i5Gz7StZAv3ofHCcGVZZpZlCU8zGoGg40csohmTK73fFlcnEfmQLv/L
         yQUg==
X-Gm-Message-State: AOAM532a49RTumb3K2zNosgRrQPyP3ktfnkF8VUJaskEgHV2sHk7SNlQ
        fYk5C5GSh0woHJCBTpJNRiwxMpuuTTWRTg==
X-Google-Smtp-Source: ABdhPJyDZmEnS4csrJZvDtm7gNwjQlm2tWCEGQLlrNjtvxeBnS+yCcL8gP/owwwpd2PdYt7t4GBbsA==
X-Received: by 2002:a05:620a:2402:b0:6a5:3b28:d726 with SMTP id d2-20020a05620a240200b006a53b28d726mr3561134qkn.500.1653411507662;
        Tue, 24 May 2022 09:58:27 -0700 (PDT)
Received: from localhost.localdomain (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id r25-20020ac85219000000b002f942e6bd88sm1121876qtn.48.2022.05.24.09.58.26
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 24 May 2022 09:58:27 -0700 (PDT)
From:   Philippe Blain <levraiphilippeblain@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Ed Maste <emaste@FreeBSD.org>
Subject: [PATCH] ci: update Cirrus-CI image to FreeBSD 13.0
Date:   Tue, 24 May 2022 12:58:23 -0400
Message-Id: <20220524165823.18804-1-levraiphilippeblain@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The FreeBSD CI build (on Cirrus-CI) has been failing in
't9001-send-email.sh' for quite some time, with an error from the
runtime linker relating to the Perl installation:

    ld-elf.so.1: /usr/local/lib/perl5/5.32/mach/CORE/libperl.so.5.32: Undefined symbol "strerror_l@FBSD_1.6"

The first instance is in t9001.6 but it fails similarly in several tests
in this file.

The FreeBSD image we use is FreeBSD 12.2, which is unsupported since
March 31st, 2022 [1]. Switching to a supported version, 13.0,
makes this error disappear [2].

Change the image we use to FreeBSD 13.0.

[1] https://www.freebsd.org/security/unsupported/
[2] https://lore.kernel.org/git/9cc31276-ab78-fa8a-9fb4-b19266911211@gmail.com/

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---

    Here is a proper patch following my earlier mail [1].
    
    [1] https://lore.kernel.org/git/CAPUEspgdAos4KC-3AwYDd5p+u0hGk73nGocBTFFSR7VB9+M5jw@mail.gmail.com/T/#t

 .cirrus.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index e114ffee1a..20c85eef81 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -9,7 +9,7 @@ freebsd_12_task:
     DEFAULT_TEST_TARGET: prove
     DEVELOPER: 1
   freebsd_instance:
-    image_family: freebsd-12-2
+    image_family: freebsd-13-0
     memory: 2G
   install_script:
     pkg install -y gettext gmake perl5

base-commit: 7a3eb286977746bc09a5de7682df0e5a7085e17c
-- 
2.29.2

