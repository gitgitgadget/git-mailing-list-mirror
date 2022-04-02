Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B99C433EF
	for <git@archiver.kernel.org>; Sat,  2 Apr 2022 19:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242345AbiDBT0w (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Apr 2022 15:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240018AbiDBT0q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Apr 2022 15:26:46 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B802F6361
        for <git@vger.kernel.org>; Sat,  2 Apr 2022 12:24:54 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id k23so8862060ejd.3
        for <git@vger.kernel.org>; Sat, 02 Apr 2022 12:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tvjrerMtXcVQ+oON0nfvBm56oHkxATOmFyhLxIzxt1w=;
        b=AXrW9VKpM8Fm5zLtHKFk/LTkGQVg0DjjWFtqlp4xOVKLVZ4nWLhwdS10AiZucpiPTd
         9L5EjZ+mRG+dIGrEcGnreMUhBJ76fg8z+/vz2/RvRGXD++lgfWeKN26N+fGG8Mvxicte
         OWIKqpl7uJP6mbmzoVkY7ApKMCCR/453jrllUCnWDYIfZJz2JDj/+vSJlBhvBLxMY6Jq
         PHJs4zqXv7GwGzBC8wC3YZQz7bQKCVpeBX5duNKq/uyxG1tI6DNqxi1AASW3eX78EKjZ
         rtikE2D1pistfGVyR/rtHfX7nTLi//WCqu+pFwDoPGmPLwjkDMpx6AD42XQ8lJ8gKAJ/
         pdow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tvjrerMtXcVQ+oON0nfvBm56oHkxATOmFyhLxIzxt1w=;
        b=F3HQsT/W94AmJ+xZZ1aOkgptp0FWBXulgKqpAG/BE7t128IsG5A4BmJo9Ln/CUeBtb
         k47XxueCIpxqPfh9jdzxxYvsSfwg4+7kTK9vmKqMd5M88i0ZKdXxbMBXKz99QiNtVtMf
         IFJPvQwVyOhjGNGwzSOGzrDW1NGLfib0ziNWd0Yw4ZKicmcOVYOnutQxSOqeHQfyIrFP
         iGFGii14BOFs2BKIZvOcLCseh/qscjyddk0RMMpY6fq0a/6j4j/OfUPAIFxgOrM0USHh
         rN2FlqR5kkac3lU/m1+CZmkIaH7ui6WjI4+HqcPaXW4xft2EhIx8GqW4cQYbCWPNSS4G
         qVYw==
X-Gm-Message-State: AOAM531cYsgL3tyxBA6QQVIKShUFk6A6L/r2hrOecVoBhkgC49C2PESa
        dIkQe5TwAvDCUDLcGOc2IAI=
X-Google-Smtp-Source: ABdhPJyavrMTltkYXar0W+EpkXS9siFwH+FOWP9P4ktcakiWMzoczphWp0aSTsJDiD+A3K/nx5YwGg==
X-Received: by 2002:a17:907:1687:b0:6df:877e:c81d with SMTP id hc7-20020a170907168700b006df877ec81dmr4567119ejc.306.1648927493369;
        Sat, 02 Apr 2022 12:24:53 -0700 (PDT)
Received: from 4b99411c802f.europe-west4-b.c.codatalab-user-runtimes.internal (167.113.90.34.bc.googleusercontent.com. [34.90.113.167])
        by smtp.gmail.com with ESMTPSA id p14-20020aa7cc8e000000b0040f13865fa9sm2777910edt.3.2022.04.02.12.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 12:24:52 -0700 (PDT)
From:   Labnann <khalid.masum.92@gmail.com>
To:     khalid.masum.92@gmail.com
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com,
        Labnan <khalidmasum@iut-dhaka.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/1][GSoC] t3501: remove redundant file checking and stop ignoring git <cmd> exit code
Date:   Sat,  2 Apr 2022 19:24:14 +0000
Message-Id: <20220402192415.19023-1-khalid.masum.92@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331191525.17927-1-khalid.masum.92@gmail.com>
References: <20220331191525.17927-1-khalid.masum.92@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Labnan <khalidmasum@iut-dhaka.edu>

T3501 contains two test cases where we used to check if a file exists using
test -f which is not necessary because we already have grep after it. Also 
the use of git rev-parse can be hidden using test_cmp_rev.

This patch tries to resolve these two issues in T3501.

Sorry for the extra email that was not sent to the right place. I am still
struggling to work with the mailing list.

Labnann (1):
  t3501: remove redundant file check and stop ignoring git <cmd> exit
    code

 t/t3501-revert-cherry-pick.sh | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

Range-diff against v2:
1:  8b7d38a66f < -:  ---------- t3501: use test_path_is_* functions
2:  04b0bf1c5d < -:  ---------- t3501: don't ignore "git <cmd>" exit code
3:  36445b40fb < -:  ---------- t3501: test cherry-pick revert with oids
-:  ---------- > 1:  aeb28e3249 t3501: remove redundant file check and stop ignoring git <cmd> exit code
-- 
2.35.1.windows.2

