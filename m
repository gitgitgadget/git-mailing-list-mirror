Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97474C64ED6
	for <git@archiver.kernel.org>; Wed,  1 Mar 2023 18:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjCASZu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Mar 2023 13:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjCASZu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2023 13:25:50 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD2F2E837
        for <git@vger.kernel.org>; Wed,  1 Mar 2023 10:25:48 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id r27so18838799lfe.10
        for <git@vger.kernel.org>; Wed, 01 Mar 2023 10:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:subject:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wV7qQ8rD9Djg9HPACyepscmgVx+Ixs1Fa0Tx7QTZzGs=;
        b=nCgWIlOGd8iSiZOXYNSYUE/ZJ3JseLBtb3z2xa3Ha1OuoWf3L/12QTihFEopp9Qvww
         0jemDVeRd23JdGitSOp3PdzKN+wY9JiWPzlq/TYM2qgD7Ua/Mpxfsb7EPFq2g+jSLKgr
         ItHSwH1X5zeCjTdzNz0OSWZKAB06VcdDJJa2w7Xwmgi9O+ueqJZEhRUjYlHFdCZ2xenr
         5KQuCPD+EJtJNUAf3wfLA1RpOUo9jrwGz1lqDl5Z7C1mCFTE1CsDOaAXIJY7qGUsD+HX
         p1VpjJLZl2Mouq+PBtrLYg5gFB13zp5ctaUDxCaZkpIPCgRkyWOaWFOPSb5KARXOX8rZ
         c9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wV7qQ8rD9Djg9HPACyepscmgVx+Ixs1Fa0Tx7QTZzGs=;
        b=omV6F8Cglw4v+UThPdNP1ODAUoCXjnd5Fm0ku6X1ja/jTBGZMHmLGyDH7EOW9AHc14
         Sa2sLocWh28IvYjlfNWPy7Qj/Wt/iW/6YIthINCZ/PbFlBQ6A9Fq8zoT5C2m1H0PMNXF
         g+FfxM+34lYhlK6Dio3pb75lmflz6hkivQUUS0xcbRPVhCEI01Q1Y+l4qTYkujYnTWyH
         QIzbOe1WUtiprHRfTdIi1NLmPT/5HUoLV/53W70VbQWKn5tJngpihlL8QImPmSG2GONC
         y1iANdf5cfP3EfyhcCeIMHWQOuv8VnWLsqgV1QVuV7Yxhzj+syxsy8Fq7THNNjA/ASmj
         nC5w==
X-Gm-Message-State: AO0yUKVS3tVA5/OIzsFpgjJP9Wg1+jHRGcAgBRg2aMk2xHRRaC5/MWVW
        y0PKA57N8dPBtjwjFgrJ1n7jX0Zked4=
X-Google-Smtp-Source: AK7set9WQzsicirrMViIl3GExBsPK9kCgdCU09ax8zng4xPAXmX2v50ABIuC8Uf0KVBztJmN84iBCA==
X-Received: by 2002:ac2:4e66:0:b0:4dc:4e1e:ebfc with SMTP id y6-20020ac24e66000000b004dc4e1eebfcmr1905450lfs.62.1677695145719;
        Wed, 01 Mar 2023 10:25:45 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id q6-20020ac25146000000b004cc8196a308sm1822117lfd.98.2023.03.01.10.25.44
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 10:25:44 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     git@vger.kernel.org
Subject: "git diff" surprising default output
Date:   Wed, 01 Mar 2023 21:25:43 +0300
Message-ID: <871qm849co.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

By default, 'git diff' produces an output that is often rather
surprising and difficult to grok, here is a simple example:

$ git diff --no-index -- f0.txt f1.txt
diff --git a/f0.txt b/f1.txt
index 3af00a929..35478f7bd 100644
--- a/f0.txt
+++ b/f1.txt
@@ -3,9 +3,6 @@
 #endif
 #if CANOPEN > 0
     IMD_CANOPEN,
-#endif
-#if MDL_LASER > 0
-    IMD_LASER,
 #endif
     IMD_AUTO,
     IMD_NONE,

I figured the offender is --indent-heuristic that is described in the
manual as:

      Enable the heuristic that shifts diff hunk boundaries to make
      patches easier to read. This is the default.

but apparently rather makes patches harder to read, at least at some
conditions. Turning it off helps to get the expected result:

$ git diff --no-index --no-indent-heuristic -- f0.txt f1.txt
diff --git a/f0.txt b/f1.txt
index 3af00a929..35478f7bd 100644
--- a/f0.txt
+++ b/f1.txt
@@ -4,9 +4,6 @@
 #if CANOPEN > 0
     IMD_CANOPEN,
 #endif
-#if MDL_LASER > 0
-    IMD_LASER,
-#endif
     IMD_AUTO,
     IMD_NONE,
     IMD_COUNT


Changing --diff-algorithm doesn't change the outcome.

So the questions are:

- Is there an example of an advantage the option has?

- Is it possible to flip the default?

Thanks,
-- Sergey Organov
