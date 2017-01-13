Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA96F20756
	for <e@80x24.org>; Fri, 13 Jan 2017 14:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751893AbdAMOv0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 09:51:26 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:32874 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751867AbdAMOvZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 09:51:25 -0500
Received: by mail-oi0-f66.google.com with SMTP id j15so7066228oih.0
        for <git@vger.kernel.org>; Fri, 13 Jan 2017 06:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=I8m2CC73r7DjDYMAFrylG/9yIARd/aZHvrWpsjUV1R0=;
        b=e+iYM+jU+r2poKC0ay8Lh1xVDvyerwGRx3C1mL66lJ5GLA52b+TiH+HgZe79+/bAnj
         0/BkfMDzRP47F/JuO6+rOC2tmiwizVjdfxeEflZi6bD1m5sOmUjAXbrJB/uwMCiUnPiB
         rOPxnci5qRsdtdFMsomgDpBLbNw6UQ3tQInz5+SIAu8HZxpwZuJY0GRg5/taZ1JUpLTr
         +B5iE4FkwpcB4alOXd0Fi+r8Mj2qSUUDNV8gv6QydXbmrD59Q07HXZprvFsWT/wcK14B
         85UY107rviGPy1q9IK+v5WtU9Z8LN0YSiTYfDPHbABmi5n+V1xp2H3DvnlH7z3+jnrEQ
         V9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=I8m2CC73r7DjDYMAFrylG/9yIARd/aZHvrWpsjUV1R0=;
        b=a//l+7WjkqLOXW748JdztqrecBURaLVC9PsvBswyBz4E7IK1n984XEdSI4jqwF88Mh
         oy2ZHkWrPmJFkGC5nQOgEmjAalCCs5UBqErBxVPV/rj5hR8GUdCTN+bB/3yIuZbDU6tf
         cupxhXh4ftb0/d3SMSJV3cC5sPsuawEO4O/J6h5EiONzTZxogYJgSfJq/fxaOJtVv+aJ
         7iyxKxXUmdNMW4+NdQif684Pga3RekHUmhzSmDhgqMsKqeK4LmobDFtjEHmvmfyFdaVp
         JGQ3AyYrgj43QfxRUfz7vD1kYX/yiSVR+ciyopebNQbSSpaiAAAOHu1AgxIBVY+N6ubu
         JHyg==
X-Gm-Message-State: AIkVDXKzXW+ZeVC53bd1D4suCv99/qefauiCmzhFJSsz+iGSEb6+2jRlXFDkfKKeZAVagA==
X-Received: by 10.202.102.227 with SMTP id m96mr9230814oik.5.1484318668226;
        Fri, 13 Jan 2017 06:44:28 -0800 (PST)
Received: from christian-Latitude-E6330.singledigits.sdus (201.166.23.226.cable.dyn.cableonline.com.mx. [201.166.23.226])
        by smtp.gmail.com with ESMTPSA id z34sm5776288ota.35.2017.01.13.06.44.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Jan 2017 06:44:26 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Manuel Ullmann <ullman.alias@posteo.de>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Documentation/bisect: improve on (bad|new) and (good|bad)
Date:   Fri, 13 Jan 2017 15:44:05 +0100
Message-Id: <20170113144405.3963-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.313.g11b7cc88e6.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The following part of the description:

git bisect (bad|new) [<rev>]
git bisect (good|old) [<rev>...]

may be a bit confusing, as a reader may wonder if instead it should be:

git bisect (bad|good) [<rev>]
git bisect (old|new) [<rev>...]

Of course the difference between "[<rev>]" and "[<rev>...]" should hint
that there is a good reason for the way it is.

But we can further clarify and complete the description by adding
"<term-new>" and "<term-old>" to the "bad|new" and "good|old"
alternatives.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-bisect.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 2bb9a577a2..bdd915a66b 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -18,8 +18,8 @@ on the subcommand:
 
  git bisect start [--term-{old,good}=<term> --term-{new,bad}=<term>]
 		  [--no-checkout] [<bad> [<good>...]] [--] [<paths>...]
- git bisect (bad|new) [<rev>]
- git bisect (good|old) [<rev>...]
+ git bisect (bad|new|<term-new>) [<rev>]
+ git bisect (good|old|<term-old>) [<rev>...]
  git bisect terms [--term-good | --term-bad]
  git bisect skip [(<rev>|<range>)...]
  git bisect reset [<commit>]
-- 
2.11.0.313.g11b7cc88e6.dirty

