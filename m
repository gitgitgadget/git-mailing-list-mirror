Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B57E20B35
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 18:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726770887; cv=none; b=PtXoKZacx9Dg9QoF7Sn7nmjdb1/hL2L1xWmoGsGHm9IJ+tNiXLey2GT7tpISg8aw1lcB2DNqKhZgqnJi7WEr2H5b8k5hxLSm9VYti34ZMDm8xM9c+i0MV9dN41wRwBGtnBBbDItqOz/NctUCjCnjIdY3SxxHSDSbvMrG1hTld78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726770887; c=relaxed/simple;
	bh=TqEoKmR2jk8CEGA58Ca/m1Z+VKAFLs8lYupxvctRDZw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SoV8vPCaoO0KKWq+mvKWxsVP0sDIMFeAz1cgPRgOBR0YVbsn8vSqJ4Cng1iQ5QVI8yGs282mXuM4hUhwAbf3aXedgVgnPvE9MS323fb5mUbbrbc8gUePFO4qpBMGBL9GfvZfw7tlujsj2GxTm7DdG6p7PrOk4QIbmund+Zy86s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYuR18Md; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYuR18Md"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8d24f98215so154931366b.1
        for <git@vger.kernel.org>; Thu, 19 Sep 2024 11:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726770884; x=1727375684; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+azNqlfLFEg9eHiiCgtfSSVHPTIRQau81jYNGT6U1u4=;
        b=DYuR18MdagDTlL0mPF9/nIw0AdbzwwnCm/Sh6t1uePYHpD8vgKqgQmKqXnscaa2hF1
         O42dvDFXjrnbJW07ZE4vkInJXwZ797hzX1OLWArSwLhk1hEKARI+3jFZsK98UUJmd3Cr
         JRczAQDLzDtOusIbjidXFwubOVyTOODhzqhnw/MBl2F/TsmeT7anb6CT/naB+vlZloTo
         J0m/+vhPtpQdnyNbMLoyz94YI7bs6MojAv4hCanXfURIOytggTGG1W2VwEkgqxAF/g0t
         KlGrJesnF6AoYRs0sn2Zuho5Vm/PRZWwRzHPgWq66JxP4ShZv3+eK3OIt+1GW8gpwKPG
         Cz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726770884; x=1727375684;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+azNqlfLFEg9eHiiCgtfSSVHPTIRQau81jYNGT6U1u4=;
        b=BZvaKq0rDhcs8EmprlZ23oeZtXAkEALoi3OGSiD6Q0ltururAFeFFDCSbzOJQJJEt0
         2OkIHffZyH0GnAg5/AJIGVIyT2D6k8kasFwmx6LD/VJohD6Z87fxCs/9o1UaMpdP59bG
         di0kDbTkZLOsPbEM12kJaaxEprEWaKCM+Fuezq6oS6pO7nM/WNbMn5w4DkyJiJclwnkl
         BZO65TTMvinOou/S3aziKJsug4QS0/8ifair7kcVnBfD2vgIk/EzEXioBTnakKhOKDOG
         QWhUGvWoJOm/zRClX8nuz65JJ2OUlNRoHUHKAQ15zXGLKFD3VyvayTxUc6EX2Yi9KDbV
         0DSQ==
X-Gm-Message-State: AOJu0Yww7U7FeVIQ89W7cDqfj78TEGgoelvQPfx9ppi+ZlfjBuI4PS4+
	jzOBAV+UmcpQwDsMUqecKR52XWesXu/mO3B488uRUlDTfxSjO/5MxZ1Gyw==
X-Google-Smtp-Source: AGHT+IELhZ28xMPOUrwoQaXDu1B7pT14RPB3LaIu1BbUYXIcDAWFRH0iNqziU42sd111fWFz/XIekg==
X-Received: by 2002:a17:906:d262:b0:a86:851e:3a2b with SMTP id a640c23a62f3a-a90d4ffc82dmr13256766b.29.1726770883789;
        Thu, 19 Sep 2024 11:34:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612df5cfsm760209766b.146.2024.09.19.11.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 11:34:43 -0700 (PDT)
Message-Id: <f469df28c89974185377661a01d927390a11b23f.1726770880.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
References: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
From: "Andrew Kreimer via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 19 Sep 2024 18:34:22 +0000
Subject: [PATCH 02/20] diffcore-rename: fix typos
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Andrew Kreimer <algonell@gmail.com>,
    Andrew Kreimer <algonell@gmail.com>

From: Andrew Kreimer <algonell@gmail.com>

Fix typos in comments.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 diffcore-rename.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index fab45b10d7e..3d6826baa3a 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -933,7 +933,7 @@ static int find_basename_matches(struct diff_options *options,
 	 * spend more cycles to find similarities between files, so it may
 	 * be less likely that this heuristic is wanted.  If someone is
 	 * doing break detection, that means they do not want filename
-	 * similarity to imply any form of content similiarity, and thus
+	 * similarity to imply any form of content similarity, and thus
 	 * this heuristic would definitely be incompatible.
 	 */
 
@@ -1534,7 +1534,7 @@ void diffcore_rename_extended(struct diff_options *options,
 		 *   - remove ones not found in relevant_sources
 		 * and
 		 *   - remove ones in relevant_sources which are needed only
-		 *     for directory renames IF no ancestory directory
+		 *     for directory renames IF no ancestry directory
 		 *     actually needs to know any more individual path
 		 *     renames under them
 		 */
-- 
gitgitgadget

