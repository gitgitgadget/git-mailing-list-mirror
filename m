Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328DC7DA71
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 08:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726820918; cv=none; b=C2i0/M83c7zgMAif76zzFIkAf8M4kRyEHhJSjbsb7MjhmFyp5iAqFhsXg5ob06qNOEBahdgSVWRp5CWJu19kf0tYFUE+4Fn37DK5VNfWL4TmRQDG/utIHFNcV5/MOfrI0iU+FWHGLsAT4Dnqnhua6Q2poBz6loqtOZPtEGOhu4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726820918; c=relaxed/simple;
	bh=EVYRsYVsUPgDaLP4O4Oykwr8OekxbE+zAH98fjwDsac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AFj3r877xYfc01iTq9Owt5U80vA1uGNVlbKJNSzw4Riw5fzqPRE7zw/lG9TEhIv4PDw3Uxgg2767aLlGyCE3eDTECrpSB8irnG1oKMdf0zIRBWDIgNHENRDEcu2L4Ekco/e5SA0/JfLvA3+A3id/iC01+L7LgjAObxxJW1pCT2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8Z7RCe4; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8Z7RCe4"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cbface8d6so21118275e9.3
        for <git@vger.kernel.org>; Fri, 20 Sep 2024 01:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726820915; x=1727425715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRGXGI8yxA8erSfz+oXA0JpB+/bn2eea3AY7mhz7YXw=;
        b=l8Z7RCe4z81jjoJCe1ZTLihIxpglOcngF3gVlATHvweX1FsmSKYmX7MDXT0y8yW9Tj
         ckM6MKUTGy9zFJn26jMCP7i2L85s0LJjkcDNDa67Wqyh32f7+8GXimHGKKKCpNcl8LWY
         g7vIiMCWhVi4M+JeUnK1WE5nfALX0GWx5dfMCo4IRhttXMtKiu3I0isuf6NMvFp1W696
         TZu5HPjoCLSOCALntkKUkHifFGk2jFz5km5/2/gu3sEzroZEfrhfpPt5AoCZF/fNZ4Ue
         giQEDS5YPj58J6SjciXmQiyhSOx/X69K9KpabP2F+GmV3VUbS/7qpX5OfNkg7wB/VuSP
         k6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726820915; x=1727425715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CRGXGI8yxA8erSfz+oXA0JpB+/bn2eea3AY7mhz7YXw=;
        b=bPjfsId7Omq3nSdCufqpAXsavFSFyOmWQwlYFiU5RTf4/0bPYq/PsH/jz20+/EConO
         j4OvgoCWFw1jEjTAOcxfRSdKjWY8I62IFPVxJ3pZT3cfYnf25ikOLUzJeAl8fJ7EKheV
         W828uVApv2Z3KA6WBJdt5hoqX7B/HvvP3S7emDIiQXv2JOHCMi5YYKCZyD/YCRek5zGO
         Bfq5hhDMa21jrF5T28neYZbG2V1GK1HC/TzRxXkDKYeH/Ficgiw+9Ed2goCPzqqtGb4A
         ravgqrSxOu/HwM8oz/pgjrcMx/YGNdbCrs8MzO+1O+GLXY2BmSS6jC2HYTIMSMc8ZJhS
         HS8w==
X-Gm-Message-State: AOJu0Yy/TNSalbG1E8WdSUBc0JvY46K35uNH0+7jW+dfhRbS4otbvU5G
	mAj7p2sA3+051WHrQDS6ygDM+eYL/x1Gsk5ig/9vB9EOyzm7NGapFZQPKHlb
X-Google-Smtp-Source: AGHT+IHWxUFDDp1IkGjqjgPikOhoX8F2mj4ESDLkM6lbZvkFjwdfoioWtsUs95faWyrm5CLQxvOQXw==
X-Received: by 2002:a05:600c:4f0f:b0:42c:b62c:9f0d with SMTP id 5b1f17b1804b1-42e7ac4b1d4mr21483315e9.17.1726820914641;
        Fri, 20 Sep 2024 01:28:34 -0700 (PDT)
Received: from void.void ([141.226.14.97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e75450ec6sm42514965e9.21.2024.09.20.01.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 01:28:34 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: git@vger.kernel.org
Cc: Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH 3/3] Documentation: fix typos
Date: Fri, 20 Sep 2024 11:28:15 +0300
Message-Id: <20240920082815.8192-3-algonell@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240920082815.8192-1-algonell@gmail.com>
References: <20240920082815.8192-1-algonell@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in documentation.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 Documentation/BreakingChanges.txt        | 2 +-
 Documentation/CodingGuidelines           | 2 +-
 Documentation/DecisionMaking.txt         | 2 +-
 Documentation/gitformat-commit-graph.txt | 2 +-
 Documentation/gitweb.txt                 | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/BreakingChanges.txt b/Documentation/BreakingChanges.txt
index 2b64665694..112770a9da 100644
--- a/Documentation/BreakingChanges.txt
+++ b/Documentation/BreakingChanges.txt
@@ -117,7 +117,7 @@ Cf. <20140304174806.GA11561@sigill.intra.peff.net>.
 
 * The git-pack-redundant(1) command can be used to remove redundant pack files.
   The subcommand is unusably slow and the reason why nobody reports it as a
-  performance bug is suspected to be the absense of users. We have nominated
+  performance bug is suspected to be the absence of users. We have nominated
   the command for removal and have started to emit a user-visible warning in
   c3b58472be (pack-redundant: gauge the usage before proposing its removal,
   2020-08-25) whenever the command is executed.
diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 3263245b03..8a5e0b7dad 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -838,7 +838,7 @@ Markup:
  When literal and placeholders are mixed, each markup is applied for
  each sub-entity. If they are stuck, a special markup, called
  unconstrained formatting is required.
- Unconstrained formating for placeholders is __<like-this>__
+ Unconstrained formatting for placeholders is __<like-this>__
  Unconstrained formatting for literal formatting is ++like this++
    `--jobs` _<n>_
    ++--sort=++__<key>__
diff --git a/Documentation/DecisionMaking.txt b/Documentation/DecisionMaking.txt
index dbb4c1f569..b43c472ae5 100644
--- a/Documentation/DecisionMaking.txt
+++ b/Documentation/DecisionMaking.txt
@@ -54,7 +54,7 @@ implementation, for very large changes).
 
 For non-technical decisions such as community norms or processes, it is up to
 the community as a whole to implement and sustain agreed-upon changes.
-The project leadership committe (PLC) may help the implementation of
+The project leadership committee (PLC) may help the implementation of
 policy decisions.
 
 
diff --git a/Documentation/gitformat-commit-graph.txt b/Documentation/gitformat-commit-graph.txt
index 3e906e8030..14d1631234 100644
--- a/Documentation/gitformat-commit-graph.txt
+++ b/Documentation/gitformat-commit-graph.txt
@@ -122,7 +122,7 @@ All multi-byte numbers are in network byte order.
       for commits with corrected commit date offsets that cannot be
       stored within 31 bits.
     * Generation Data Overflow chunk is present only when Generation Data
-      chunk is present and atleast one corrected commit date offset cannot
+      chunk is present and at least one corrected commit date offset cannot
       be stored within 31 bits.
 
 ==== Extra Edge List (ID: {'E', 'D', 'G', 'E'}) [Optional]
diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
index 56d24a30a3..5e2b491ec2 100644
--- a/Documentation/gitweb.txt
+++ b/Documentation/gitweb.txt
@@ -234,7 +234,7 @@ from the template during repository creation, usually installed in
 configuration variable, but the file takes precedence.
 
 category (or `gitweb.category`)::
-	Singe line category of a project, used to group projects if
+	Single line category of a project, used to group projects if
 	`$projects_list_group_categories` is enabled.  By default (file and
 	configuration variable absent), uncategorized projects are put in the
 	`$project_list_default_category` category.  You can use the
-- 
2.39.5

