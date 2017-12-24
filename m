Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0D441F406
	for <e@80x24.org>; Sun, 24 Dec 2017 10:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752084AbdLXKzD (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Dec 2017 05:55:03 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:42996 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751941AbdLXKzC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Dec 2017 05:55:02 -0500
Received: by mail-wm0-f68.google.com with SMTP id b199so28774406wme.1
        for <git@vger.kernel.org>; Sun, 24 Dec 2017 02:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tiVfZQIjDg3i8/p61LT1WtFWKssxR0y7taEmE2XiJ1o=;
        b=OigS+8rhfwcuDY+/reTLlnABehlMtCiLqQ2lSZwMJyqQp9ZQQu23Mmf0JAfsr+l82U
         4uKZrt51erz5KlWKgoiYuC0xRJFb7W7oXUl/rWftdA7lgL92JWm7iqEnjejXkA9WlMK3
         HhrJYZ92506VYGIVp9eVUWMPomMKzMiNMAqiJCC2+ukP08Ov+JuODi6r/ik0qH8ePy4Q
         P8A+bKAtkJk6jUqaVi75ZOuJQtGRlBuDFl/PaA+otTvdkK4fzJuIz80Ba2RZb3IuX15H
         BBizm7WVdGdC43ku5wgNnTFPVrfjNewxJvbR8hdhbcY9ZI5XTikusnRSgAjx3umwDN1S
         iNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tiVfZQIjDg3i8/p61LT1WtFWKssxR0y7taEmE2XiJ1o=;
        b=B0iMZMRCaW+YGhe9GuRdyuX37yOiaLkmcBzS1BYgc3TdRc9sfV+vC/Vs+DrnGs4L6H
         LIMMz3a1k5vH2CsVHMSrZuJyY/ZoYZrH/Xc70xYAFjsVXRQ0YDDLzLBB0ehpd1/NShse
         qD5gTkaYQieKv9O3xBPcQzD8jiEeZ83srK/fsaE5EEzSgqbajPr04ql3kWTDnUrURsFH
         OsWww3n+tn4IE0PhTZdz/YafM9Fjg/qN8RylTtBtUCmtZOreMAUy/JUJA0rLOn15upHr
         jsh6q86cEGBSLEphFp0sCZMNB4R5cUmCDwGqn3lyCkOkSY1vxzmROF3aXAtb1F0tZX3T
         Fdvg==
X-Gm-Message-State: AKGB3mL4pBNemoBTpdMIdHsK8A9exzUTjivHTThME2bADQjSTHGghSHc
        gyCGDOFSLzc9CDR8oblW43Ql0Q==
X-Google-Smtp-Source: ACJfBosURJVsIQK1/HgkgYqKmw1whx7gGRJHjsdjGtvuM8S2MoTFiuJXE7if2LYCVOchW/FPLY3LcA==
X-Received: by 10.80.165.109 with SMTP id z42mr21842942edb.18.1514112900542;
        Sun, 24 Dec 2017 02:55:00 -0800 (PST)
Received: from icid.telenet.be (d8D86700B.access.telenet.be. [141.134.112.11])
        by smtp.gmail.com with ESMTPSA id j27sm28560716eda.59.2017.12.24.02.54.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Dec 2017 02:54:59 -0800 (PST)
From:   Mark Nauwelaerts <mark.nauwelaerts@gmail.com>
To:     git@vger.kernel.org
Cc:     Mark Nauwelaerts <mnauw@users.sourceforge.net>
Subject: [PATCH 0/2] restore fast-export full filecopy detection
Date:   Sun, 24 Dec 2017 11:52:07 +0100
Message-Id: <1514112729-31647-1-git-send-email-mark.nauwelaerts@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Mark Nauwelaerts <mnauw@users.sourceforge.net>

When using fast-export/fast-import to interface/bridge with another VCS
that explicitly tracks copy/rename as metadata, fast-export's ability
to report filecopy/filerename is quite useful (if not essential).

There has been a fix in this area recently with as side-effect that
in some scenarios a filecopy is no longer reported as such.
These few patches provide an alternative fix for the original problem
while still retaining previous fast-export's filecopy reporting.

See patches for additional details and commit references.


Mark Nauwelaerts (2):
  fast-export: ensure proper order of modify, copy and rename entries
  fast-export: remove now obsolete filtering of modified files

 builtin/fast-export.c  | 60 +++++++++++++++++++++++---------------------------
 t/t9350-fast-export.sh |  2 +-
 2 files changed, 28 insertions(+), 34 deletions(-)

-- 
2.7.4

