Return-Path: <SRS0=BqTQ=5V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77856C2BA1B
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 15:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C287206B8
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 15:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwoyvsbd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgDEPuX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Apr 2020 11:50:23 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34015 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbgDEPuX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Apr 2020 11:50:23 -0400
Received: by mail-ed1-f66.google.com with SMTP id o1so15838772edv.1
        for <git@vger.kernel.org>; Sun, 05 Apr 2020 08:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IZPeXR3Jx+kNmwHAhtdprixwn51fWuM8wY7aPORGwqU=;
        b=bwoyvsbdC7nRS8iMSDPW8NljpTSYEK84Eojh3AVnSW9EjAnF4Dboj+HLR9hjSyse7R
         7CNLTmThUrn5cIDGACzY8g2vTkvFp2v0HaD9p6Exd7CgQgjhHfRvBHo9Ecf4VFty/muK
         n8i4/bFp2ETNiaB4Tq+y8g/dD4pHLjcCMVC+ivcCXQIWn58vOekV3xOnpuYkRW9JscFz
         KIlizfuYEVry6mfgUR+UBavvi0ZG7Y8UcaPUS9qhA6gIV8rPkK0VlNl3VxlivNaZ2knh
         Cvdhw6wA143asjMk/9g+5m/8MqyhToNiRnBKBomVTcPL3+C6mhybniZDN6dI32npDbX1
         GZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IZPeXR3Jx+kNmwHAhtdprixwn51fWuM8wY7aPORGwqU=;
        b=pJoyk2X/zyaR6d2nNSnhr0INJHHQ5mjeWPj6bZV3qVlm3JJqldcz/i7REFRVKyebFn
         mYbUGNS3MlZG5OTpHG60NH/2woN214KySLF37VT1bzYQA8AxjWzWgo7Gig7hTGBeBn2j
         I2c9Eh5AKmRCaNg+90YdDO0q3sxaiR1YSMZMbaC5tJh9euAHySsTHKwkoa3Irg+P9uhY
         NelLYQ1drH9T2uklv2GNaxh+bY58kdYQ0Bd1aocm3WujyZMyaKNZPZgK6wcb9i2QnZ2C
         N5bpuaCMGLavzpXlztJhzNne4JFf6UdHDoi/fkIfZNrgy8+wgfiZg4NGeuWCIHmxmS1G
         sZag==
X-Gm-Message-State: AGi0PuYuzHuIj+HXkKrtW0wiXT0Ar4wFBIdTA18KTqFXLTfr4s/g6LdI
        B2p9ZrTnoWlS4PGUr4Eus2XQgFeU
X-Google-Smtp-Source: APiQypJrl16i/+8cOxQvKuD7vJ4dPMtyrb0o6FjwxqcTo3DpOaf0XLe44z1o5hfjPfuS0ew9B7f/Gw==
X-Received: by 2002:a17:906:934f:: with SMTP id p15mr16503311ejw.86.1586101821121;
        Sun, 05 Apr 2020 08:50:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b2sm2703391ejv.61.2020.04.05.08.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 08:50:20 -0700 (PDT)
Message-Id: <9c94c2770f0eb1cbb9383cffde7c275d7d3f52c9.1586101819.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.751.git.git.1586101819.gitgitgadget@gmail.com>
References: <pull.751.git.git.1586101819.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 05 Apr 2020 15:50:18 +0000
Subject: [PATCH 1/2] pull doc: refer to a specific section in 'fetch' doc
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Marc Branchaud <marcnarc@xiplink.com>,
        Clemens Buchacher <drizzd@gmx.net>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The documentation for the `<refspec>` parameter in the `git fetch`
documentation refers to the section "CONFIGURED REMOTE-TRACKING
BRANCHES" in this same documentation page.

In the `git pull` documentation, let's also refer specifically to this
section instead of just linking to the `git fetch` documentation.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/pull-fetch-param.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index 7d3a60f5b93..95ea8499029 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -19,7 +19,8 @@ ifndef::git-pull[]
 	(see <<CRTB,CONFIGURED REMOTE-TRACKING BRANCHES>> below).
 endif::git-pull[]
 ifdef::git-pull[]
-	(see linkgit:git-fetch[1]).
+	(see the section "CONFIGURED REMOTE-TRACKING BRANCHES"
+	in linkgit:git-fetch[1]).
 endif::git-pull[]
 +
 The format of a <refspec> parameter is an optional plus
-- 
gitgitgadget

