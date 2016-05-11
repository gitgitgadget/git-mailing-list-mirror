From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 88/94] apply: don't print on stdout when be_silent is set
Date: Wed, 11 May 2016 15:17:39 +0200
Message-ID: <20160511131745.2914-89-chriscool@tuxfamily.org>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 15:21:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U5K-0005C3-Qn
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:21:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbcEKNVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:21:36 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34992 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932400AbcEKNVa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:21:30 -0400
Received: by mail-wm0-f66.google.com with SMTP id e201so9415579wme.2
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DORYMvybbiDl2HI1TFaUv0RSfE3LmcrmgrSu0gEJFuQ=;
        b=XFOvGzvLRciUNe4yThdOHNoauouI7h2lD6GG8dcsKDQtooKP4LTwH6SPDhQA2LXvjp
         1e5lKP0mWUEh9cWHJB8FKkdFwzeJKrKolbB210bWWetrRwHorgv0aVAkFfM6n5adzukz
         zbmYzMS4z7pLeOlKZRKz8TpcvZktWY/5MrGDVA+0aNNUhude4+oBWb1955qF15zvdl6O
         DcOCruuElBK9DaqpNICgB2DyqX/QSg5xfAGbieLpvq3qvGHiGFS7gmTH9hxI26SZ4/5J
         VIUctDD29jPvAppbFc0OKDsEcNi0tkgp0MxsT5FVq7u8ovDBHXYCXBRM/QUNJekkslyW
         jCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DORYMvybbiDl2HI1TFaUv0RSfE3LmcrmgrSu0gEJFuQ=;
        b=DC9VRt186IfVxvSTOVim98RNTIW6+ozaquCKZmdh1c/0OwI3pDQL+1vCfzh5Jejgvj
         JGAN0ZDiv47u4Xkn21enEe37vwahjnJgFqHpgMkbTfbPeElM9IP6mY3Q4pIbpQrm9rPN
         UWjxE3//1Izh9hLrLO2s8tlXigjQFWIuDrzEKQroqEoB2qImx+BtRLcmgWU+yy5ZUiBp
         0e6DOKtNdj2ynM+s8fVAflv7ck0Jsqv41Y6/cVUHxU8Eoo2kcvyPg0lnqlduvsJq/dP/
         rYqfI0C8DANBaXdKVkerTfpLspp/oHH1/MJ6Snz9BhJiiLp7DSffO+LE/pxqOMLEk4ze
         e4bw==
X-Gm-Message-State: AOPr4FVLPOfqdxfK238g85MCJcDTnlI+UBryl5BXwGrzEkYS7CYu/a3ySIBo2ff3crwGAA==
X-Received: by 10.28.127.81 with SMTP id a78mr94030wmd.34.1462972889228;
        Wed, 11 May 2016 06:21:29 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.21.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:21:28 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294304>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/apply.c b/apply.c
index 5459ee1..e0fdd1d 100644
--- a/apply.c
+++ b/apply.c
@@ -4669,13 +4669,13 @@ static int apply_patch(struct apply_state *state,
 		goto end;
 	}
 
-	if (state->diffstat)
+	if (state->diffstat && !state->be_silent)
 		stat_patch_list(state, list);
 
-	if (state->numstat)
+	if (state->numstat && !state->be_silent)
 		numstat_patch_list(state, list);
 
-	if (state->summary)
+	if (state->summary && !state->be_silent)
 		summary_patch_list(list);
 
 end:
-- 
2.8.2.490.g3dabe57
