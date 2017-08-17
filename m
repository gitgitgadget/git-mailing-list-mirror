Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 521831F667
	for <e@80x24.org>; Thu, 17 Aug 2017 02:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751695AbdHQCxt (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 22:53:49 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38736 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751621AbdHQCxs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 22:53:48 -0400
Received: by mail-pg0-f68.google.com with SMTP id 123so7434200pga.5
        for <git@vger.kernel.org>; Wed, 16 Aug 2017 19:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rsv679v+wX4cMHSUEVpx1IXEuphX/h0QMkZ7Zh0OL80=;
        b=Tf5xHc98M/u132FNtAveZCganolYg0W7/hpVGDL8QmrMvQYfyJggrlk9EfhtotSv+t
         q+Lpyp6FmnxStt0cRfSv0SuSE+YbIRn6ZL1i8JUoTk8JS9/GcqvAZ/GaOonFwdVmbwzc
         tJi0AwN1chV2c0gKf6ByOjo6vt3Hrm01bHZdlIIgrHKuKSfkwrJQQiUEf5n1ZVETJyvp
         13biAGvDkTKeJIldXvAEGqBv/sZYodw/nSwqNL1dflAFHvYt8A4ihIl6eHJWfHv/9CKs
         DaMSK05OoplKui9ePM6z/QK2FvsfNrBY+kptW0V6k2zGTuuowfasmVjZaMoGOcEWBmtL
         o13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rsv679v+wX4cMHSUEVpx1IXEuphX/h0QMkZ7Zh0OL80=;
        b=s28RuJkwlrna0Kx/6amaiV+vX5lx7JhGP5VKFjXHVnUxJFVd2OiX6MF/g7w5nn6bNF
         IwnP6upVmdGu2PEgJPtEVnBBbr7Ns3oGQgmpvgmfeVrcWHrvDn8gY0Sfl5voJj21EVwu
         fajPqYlRyYeHxz02X1T6tg2d+yw4u7ovNd6z6gBXw8F87snimh7KAXUOnCFpoTOgsTQO
         0KzvXyX6GNt7XgHK79SxbEcWrRQyyJRBvNW/kzl2xVpkhDEJtbP/jvKVr2++c0FaQsOz
         MgVryOvC1gGTV8nEsl0P3aYxlDjGwT2uxKOlVzNm/EDEysE8mh35O25hFkmJC692dMhB
         YVhw==
X-Gm-Message-State: AHYfb5ip2YvxDvqzJyRP1b+UxIJ5zZpipL+iaE9cZOa3yuVjVnT+l+xo
        VjhoEDs6LjpRHA==
X-Received: by 10.98.8.198 with SMTP id 67mr831988pfi.87.1502938428158;
        Wed, 16 Aug 2017 19:53:48 -0700 (PDT)
Received: from localhost.localdomain ([157.50.14.209])
        by smtp.gmail.com with ESMTPSA id 66sm4373696pfq.20.2017.08.16.19.53.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Aug 2017 19:53:47 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com, martin.agren@gmail.com
Cc:     git@vger.kernel.org
Subject: [PATCH v4 3/3] branch: quote branch/ref names to improve readability
Date:   Thu, 17 Aug 2017 08:24:25 +0530
Message-Id: <20170817025425.6647-3-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.14.0.rc1.434.g6eded367a
In-Reply-To: <20170817025425.6647-1-kaarticsivaraam91196@gmail.com>
References: <xmqqy3qluck4.fsf@gitster.mtv.corp.google.com>
 <20170817025425.6647-1-kaarticsivaraam91196@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 No changes in this one. Sending this just because of the change in the total number
 of commits.

 branch.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/branch.c b/branch.c
index ad5a2299b..a40721f3c 100644
--- a/branch.c
+++ b/branch.c
@@ -90,24 +90,24 @@ int install_branch_config(int flag, const char *local, const char *origin, const
 		if (shortname) {
 			if (origin)
 				printf_ln(rebasing ?
-					  _("Branch %s set up to track remote branch %s from %s by rebasing.") :
-					  _("Branch %s set up to track remote branch %s from %s."),
+					  _("Branch '%s' set up to track remote branch '%s' from '%s' by rebasing.") :
+					  _("Branch '%s' set up to track remote branch '%s' from '%s'."),
 					  local, shortname, origin);
 			else
 				printf_ln(rebasing ?
-					  _("Branch %s set up to track local branch %s by rebasing.") :
-					  _("Branch %s set up to track local branch %s."),
+					  _("Branch '%s' set up to track local branch '%s' by rebasing.") :
+					  _("Branch '%s' set up to track local branch '%s'."),
 					  local, shortname);
 		} else {
 			if (origin)
 				printf_ln(rebasing ?
-					  _("Branch %s set up to track remote ref %s by rebasing.") :
-					  _("Branch %s set up to track remote ref %s."),
+					  _("Branch '%s' set up to track remote ref '%s' by rebasing.") :
+					  _("Branch '%s' set up to track remote ref '%s'."),
 					  local, remote);
 			else
 				printf_ln(rebasing ?
-					  _("Branch %s set up to track local ref %s by rebasing.") :
-					  _("Branch %s set up to track local ref %s."),
+					  _("Branch '%s' set up to track local ref '%s' by rebasing.") :
+					  _("Branch '%s' set up to track local ref '%s'."),
 					  local, remote);
 		}
 	}
-- 
2.14.1.534.g641031ecb

