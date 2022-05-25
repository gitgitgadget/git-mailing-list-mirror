Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CF5C433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 12:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbiEYMv3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 08:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbiEYMv2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 08:51:28 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2900C94192
        for <git@vger.kernel.org>; Wed, 25 May 2022 05:51:27 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id b11so7655080qvv.4
        for <git@vger.kernel.org>; Wed, 25 May 2022 05:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nbbHd7gjhZxzlm9Svnj4J2ohyEaGs0KXt4u/SP3qxlw=;
        b=p6+yxp5hejMx7YoTtHdq/Rr0N4+9Aj7Zv4TrAQRJkAZwY+iL8dLc87F3RsPTUF1LsC
         LFszz1g4xjnzDiHYrTYHZxDEgMyInkHBU3nIwyrhSE40OG349IDb3b8onfVud3XSLHN7
         ZNTC1EcscRfCoe7FkW2HpxyuCqql+lYo9GS6teChFtjlcbcmCunfYCu9Wkl7BCzKkIG5
         tSGnFowr7YqOlwblb47PVrOSaku90og7qEQZf1WlYzw/Fkl4LgssJzBgaqcZhYOfUHck
         AoWYdNXq4Wfa4TBqGrXBdr0nFt0aShd4uRXjJRyaeJyyGZRhmNeb21G1O5jVUklhz5vs
         bpKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nbbHd7gjhZxzlm9Svnj4J2ohyEaGs0KXt4u/SP3qxlw=;
        b=tA0Nx9URP6gepfbJ0IJNUxjjpZF5VF2Qt5utltX64GhPHmrgxI0RO9wt9Ez3Twu1v0
         0MgS+D8nAt5Bdxc6kakZcU96+iUTUhdm0dV5ZRDl8ypYh6FToYnyumvcGCkgI9HRc8jy
         b8cGlXusy7UtvSo4MyumIbJe+jyva/jsL+KJKV4dejGLazKp1Lm8swsAN3DupdI953zN
         QHUmTjwz9rlcoSmim8xgK0IsJvlJtsNMt0m8mePf6UDh3tdL5xE5PeeIkTrEkUCrnkt4
         xyqH/nsOh6b6IUGJwi9kkUqX/sd17ZYPwEIkdzffF8wANb0wpdrLNH2tR6ZZmGjPZe3C
         IC/g==
X-Gm-Message-State: AOAM5314hjqV+ME38/K8qz+CkFe36rvXyn8+82SSOrla3DhhgEh/3Pau
        0cn9nYduuNumSiZmOQ4uJHQvEnNoofBWng==
X-Google-Smtp-Source: ABdhPJwi+znhh3lsqBEJfil43mRAO7SsVYqlVcLAk36up6frVDtaHOcSnC1iUMUkr7MR35pprLm0DQ==
X-Received: by 2002:a05:6214:d6f:b0:462:446a:df0b with SMTP id 15-20020a0562140d6f00b00462446adf0bmr10839327qvs.111.1653483086013;
        Wed, 25 May 2022 05:51:26 -0700 (PDT)
Received: from localhost.localdomain (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id z193-20020a3765ca000000b0069fc13ce207sm1168410qkb.56.2022.05.25.05.51.25
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 25 May 2022 05:51:25 -0700 (PDT)
From:   Philippe Blain <levraiphilippeblain@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Ed Maste <emaste@FreeBSD.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2] ci: update Cirrus-CI image to FreeBSD 12.3
Date:   Wed, 25 May 2022 08:51:12 -0400
Message-Id: <20220525125112.86954-1-levraiphilippeblain@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220524165823.18804-1-levraiphilippeblain@gmail.com>
References: <20220524165823.18804-1-levraiphilippeblain@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The FreeBSD CI build (on Cirrus-CI) has been failing in
't9001-send-email.sh' for quite some time, with an error from the
runtime linker relating to the Perl installation:

    $ GIT_SEND_EMAIL_NOTTY=1 git send-email \
    '--from=Example <from@example.com>' '--to=nobody@example.com' \
    '--smtp-server=/tmp/cirrus-ci-build/t/trash directory.t9001-send-email/fake.sendmail' \
    --compose '--subject=foo' 0001-Second.patch
    ld-elf.so.1: /usr/local/lib/perl5/5.32/mach/CORE/libperl.so.5.32: Undefined symbol "strerror_l@FBSD_1.6"

This first instance is in t9001.6 but it fails similarly in several tests
in this file.

The FreeBSD image we use is FreeBSD 12.2, which is unsupported since
March 31st, 2022 [1]. Switching to a supported version, 12.3,
makes this error disappear [2].

Change the image we use to FreeBSD 12.3.

[1] https://www.freebsd.org/security/unsupported/
[2] https://lore.kernel.org/git/9cc31276-ab78-fa8a-9fb4-b19266911211@gmail.com/

Reviewed-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
    Changes since v1:
    - switch to FreeBSD 12.3 instead of 13.0
    - add the invocation triggering the error to the commit message
    - add Carlo's reviewed-by
    
    v1:
    Here is a proper patch following my earlier mail [1].
    
    [1] https://lore.kernel.org/git/CAPUEspgdAos4KC-3AwYDd5p+u0hGk73nGocBTFFSR7VB9+M5jw@mail.gmail.com/T/#t

 .cirrus.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index e114ffee1a..4860bebd32 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -9,7 +9,7 @@ freebsd_12_task:
     DEFAULT_TEST_TARGET: prove
     DEVELOPER: 1
   freebsd_instance:
-    image_family: freebsd-12-2
+    image_family: freebsd-12-3
     memory: 2G
   install_script:
     pkg install -y gettext gmake perl5

base-commit: 7a3eb286977746bc09a5de7682df0e5a7085e17c
-- 
2.29.2

