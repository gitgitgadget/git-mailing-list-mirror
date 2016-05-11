From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 94/94] builtin/apply: add a cli option for be_silent
Date: Wed, 11 May 2016 15:17:45 +0200
Message-ID: <20160511131745.2914-95-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:21:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U5K-0005C3-8T
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:21:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbcEKNVt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:21:49 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34370 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932402AbcEKNVn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:21:43 -0400
Received: by mail-wm0-f65.google.com with SMTP id n129so9425934wmn.1
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=97TbJwq2XFdY9oqdTAp07iAj3XMaU+IdqmN/3g5owSw=;
        b=FdNYoPnRj1x0L9XEdH+AGFHA1vOaitK0Kbay4/T7VzlIU4NRvktIB19/eo+yGA6cwa
         71XETzouKgwYTrlZdduSG2oGnsBOEJsyQ58ZozAF6fdgO5yQJSMZJBotOgsCvzX8I7O3
         bD4uPlofTiMBLDdAGFT2KAxFEgSKi6p1ah9uQ3Lc8AQBsJWj4IqP1R1X7eX5Vk71gQis
         pyVRg3XQDLrqY7B+Su/17M55mbNq54h6IU+KLi7M9elF5s1K7hWd5nIhnubMjLmmOnGT
         6FP1sr/5CeTIiyb+YCCtyn27fj5XBYPc7NZ6j/BTTNdZi22VzCLeE/B1ggA5vtV2D1W3
         dkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=97TbJwq2XFdY9oqdTAp07iAj3XMaU+IdqmN/3g5owSw=;
        b=XshvqoL3LMySvepr6RIAA/0L99GMCGti4UaXVn6L312yxBFd9F+cioaCEhjpw7yk7s
         oE8orbmcJsG4L9+AHRzOFOyQG1DPqaB4qpYucfT8wS2hueMTd0CxvJ/KkPnvBXnkrRl0
         35nShT3qowx3rEPr2OME55MZTiP5uVs2KdJ5gOt1SMzmnQ6l3b8FCEppoYYWntx5iMmk
         FPRZm2eezh0DYIi8TasYSxNPunCu7B6uq0Ni8e433JENMzo0xQ2b56fX60qNSJ5GjnXc
         PW87KqKURXMFv9+PHxF8GEbNVgE965IXUzZ7iVzwlvKV78qT+x+VE7+bTnLozYO95hN1
         RZbA==
X-Gm-Message-State: AOPr4FV/79FJw0ehCSFNZdLHd8bOkiT3Xx6xPFKHXH2yTWWW3+JDyfZ2zBobZKTyGJ984g==
X-Received: by 10.194.107.6 with SMTP id gy6mr3862199wjb.20.1462972901976;
        Wed, 11 May 2016 06:21:41 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.21.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:21:41 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294307>

Let's make it possible to request a silent operation on the
command line.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/apply.c b/builtin/apply.c
index ce12769..397ef26 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -70,6 +70,8 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "allow-overlap", &state.allow_overlap,
 			N_("allow overlapping hunks")),
 		OPT__VERBOSE(&state.apply_verbosely, N_("be verbose")),
+		OPT_BOOL(0, "silent", &state.be_silent,
+			N_("do not print any output")),
 		OPT_BIT(0, "inaccurate-eof", &options,
 			N_("tolerate incorrectly detected missing new-line at the end of file"),
 			APPLY_OPT_INACCURATE_EOF),
-- 
2.8.2.490.g3dabe57
