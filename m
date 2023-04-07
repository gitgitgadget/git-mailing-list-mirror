Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D394C76196
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 21:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjDGVXH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 17:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjDGVXF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 17:23:05 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A4BB769
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 14:23:04 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54c119a5c44so56707987b3.2
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 14:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680902583;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sTSlBx5Mg0IrXG33odGtlbK7og65tdv+Gwed5kzms9A=;
        b=aJRqV2qsFK7o8h/OuunZ8dA/1BFPPgw6PppDZes4u6j6exxeedyCYsKYPEQA5NcB6L
         ZDk2EVPlxU6HZgUmlKYKOmhLn1jEbrHADPNYb71s2DU5FIQad6eSvXNSdFKY6qXOP6GT
         vRiSY4OVK/sTypY03H9PXWh3usw5zekqTyW3EHdoD+f9+Zc2RbDoIsdqLF4cvyb1Cdm5
         X4VQJlLCsTqvBTW59hi62Aejt2YSxLAzwH717KZ+W+V6N0TQzsHDd0oLuSB+DUrjJPkU
         wnnNkWrGZGwxRwJ4pbOq2MYr/sXg9iSHbyaWvOK7MotWUQmIOva3JVe0p6x0n4ydl4zl
         zZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680902583;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTSlBx5Mg0IrXG33odGtlbK7og65tdv+Gwed5kzms9A=;
        b=gADO+tVQQu6TvnlFi2xcvu09Wz0cRxMpWfcIemaz4qsWGAz+PLlr7OBArOrxNjaJSt
         AZvveOwluZ4LOlYhk/sQHvt2ct62aNkJpj67Z8cM5mBaFbcAxPKIWWmvXSy50FdLGybv
         DxCsy9kkrx3Myj4qF+inVEIyWD9/BpKyjfENIspdiKqaZEO2Ty7KXWzMHJX8nsQUu3KO
         eynNU0I4P43TnEciRoDXb/g3GS5CWJRssXhcsLHbQ6whsNKBxRqHlEG1q+U2VkVUrRQK
         lSa+BOSL0V/iKoRzjYZ0AKalogcvE1EqYlI4exzQdexWMjSidf16YSiPPFztfHZYATjx
         WaBg==
X-Gm-Message-State: AAQBX9cXSfU/V2T5B5z0tiotg/XFOGTdREnXurBKOhEH0a1smOA5FuTs
        ZMa7jDrlR/dszVK7Xyvob6HUjBOQOoM4D3ld1KrsbMmrelbD2T2dtlw7SHXou/o02eSEtpkMJOS
        PRst3u90JuWwCYuWtFrR6qf3plDU9JacNE3qzAFLwf1HPQtVOzStKEo1s4puznpCBZvVC3Jl16Q
        ==
X-Google-Smtp-Source: AKy350b5yEnkXMC3l+vn6xPjYyDn1h64WzDQIxwYYNem+FYq3nzis+UuUCDoh6LuDEbyfae/TMvRLnpzv8F3z6QxHA0=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2d3:202:3cbf:c928:3960:94f5])
 (user=emilyshaffer job=sendgmr) by 2002:a25:3007:0:b0:b76:ceb2:661b with SMTP
 id w7-20020a253007000000b00b76ceb2661bmr2529926ybw.3.1680902583366; Fri, 07
 Apr 2023 14:23:03 -0700 (PDT)
Date:   Fri,  7 Apr 2023 14:22:49 -0700
Message-Id: <20230407212249.1541509-1-nasamuffin@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Subject: [PATCH] mailmap: change primary address for Emily Shaffer
From:   emilyshaffer@google.com
To:     git@vger.kernel.org
Cc:     Emily Shaffer <nasamuffin@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily finally figured out how to set up their alias at DayJob, and would
prefer to use nasamuffin@google.com, partially to reduce confusion
between IRC and list, and partially because they just like the alias a
lot more.

Signed-off-by: Emily Shaffer <nasamuffin@google.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 95aaa1c833..733e047aa8 100644
--- a/.mailmap
+++ b/.mailmap
@@ -65,6 +65,7 @@ Derrick Stolee <derrickstolee@github.com> <dstolee@micros=
oft.com>
 Deskin Miller <deskinm@umich.edu>
 =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gmail.com> Doan Tra=
n Cong Danh
 Dirk S=C3=BCsserott <newsletter@dirk.my1.cc>
+Emily Shaffer <nasamuffin@google.com> <emilyshaffer@google.com>
 Eric Blake <eblake@redhat.com> <ebb9@byu.net>
 Eric Hanchrow <eric.hanchrow@gmail.com> <offby1@blarg.net>
 Eric S. Raymond <esr@thyrsus.com>
--=20
2.40.0.577.gac1e443424-goog

