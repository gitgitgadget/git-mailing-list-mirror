Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FDD2135D5
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 11:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743076392; cv=none; b=R65yQldS8/rvqUL+JKckukTAewv4BYANpkGrB91TUc/If8I6bip/VnEMbudJqjuZSxF+pDb/BlyvoKz1kRDYUCBTFX9BpZAHB75rGRatxm9/RoDPqMWaMasV6PbWtHrWr4uUi4ehGtyIUwFRGLWajNxT6rsXzRWOxrGKW3YxBXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743076392; c=relaxed/simple;
	bh=Rx+IWFiOi9U+zBq+NO8Yynl5AN1JAJZERx/mjKSB+Dw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XUdiVKSgEchTDuKmCUgwjsidpYNGyX1gQMrdAoK75gV5KTyLgDwwFdWFogjbDM8ct+eXMNs/6HevJPoad9EunGpsy+oU8oTUZ7xR2MpuANbKhHuGBD2A69QuQF7PTXesgiVbbHOHbu2t8/mmubKgB797/kqW/lCnu2207Nunr+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9DenSDG; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9DenSDG"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3912fdddf8fso1295925f8f.1
        for <git@vger.kernel.org>; Thu, 27 Mar 2025 04:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743076389; x=1743681189; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NX862AUOw2XXDICLlVHZCE9L8Px+F8OVvarM9gB1oFU=;
        b=U9DenSDGED24LNV1/5VVu2x1cn2STyC90HfJ6yejWhz2q3RQv3fMJ+DVjAufQZbJL2
         BlCKwTkRMFZs3hvP/1wcmSZBr+0Y40JuBxT9PKtUhSN5X5c1TqoO2wJHCKbnmzulpdT4
         IP7qwp8BewVLgUGA191kjQPCn1pkIr9MahG3w3UyhbomA97AL7wYBPRJIYl+xLi/TJi0
         5cexAY/1j0KzjI39tmCH/rxUbN400GR25eHGrz6fhwXUzIa9EVgv9JQSkNFNz9lduQ3Z
         +o6hayTD+e/MjxKZXaWWqwKLAxMTIGP7noQH+lBz59FlqJEL/HR/P2iBnXwlanEY4oYs
         NrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743076389; x=1743681189;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NX862AUOw2XXDICLlVHZCE9L8Px+F8OVvarM9gB1oFU=;
        b=ARCGba4tW+jkgSlanpBTYi84a1bWCVBB8pWicLqLBUo42rYuUSsslTKOpLwb7+DdL9
         7yZ31jDc1xhr1C+0uvEur5ISXkUiUETz/M17EFl9zgkIpxZNSp/V4NulZEL0UvWRtweT
         fwdxC6K/qcp/S59u2I+FPgt0OpRguL1gkK7/4hlqaqv49IyooQm32UcktI0BHnJTV4AM
         EOE/BAMQ9oKH6ss7rf1A2s16zOLhf7I2FoHDo98g3/5Ff7fFjtD+cwC+Y4/iepFuj6YW
         EXU5C0lVpDc0OkQ4xMf86afATqsK2VaK5k7NjQXcoOosYJcjM9Mh2JbR0Ft5P3YRB3Ib
         IE3A==
X-Gm-Message-State: AOJu0YztkyVEzAm8GSfe/A2AajjSI9+f4ECcTtF1Zz/NfxBxSTsmO5rD
	A9SMkgHUT7DlRUWHDhsbEy0WAggcE+jCcUH4hjYtGJZTZiVeZw578DN1CA==
X-Gm-Gg: ASbGnctlyOe++qMm7lHo6oGdZ78ZRvyIWbO2x1XEbgmoinTUU97idtmfaJTgl7f1IKc
	0nxj4jI2QuD+CiWqAfe/z6cl+KzldZtYcKVwBDK4wICA6LbXoKuMvf0QSHVaF3WfjBfx22uOIBn
	IW5VvWRpY3yEEuT16gv22z4vTw0cNg/JKYXkEhFhERj8bSVad2GcIZMfaQ4rYxCsVW6htkMX1j2
	RNzZaPSLKbMZocpKoX6NwISbPNoGBJEyV/vbucghMBWvi36bfjM5qqnSxyqGlnBdN4UuOkEgRtx
	NplNPGLD5BQCc/yPCu9GRPaoO/d56ptAYyYlQRaRRPq3ag==
X-Google-Smtp-Source: AGHT+IETuTlIU9LjJeIqvLQKCoLWIG9CS+ejdjxG8AjiA+yn+ZJolRS1EW6lnwoP+TpAKNRbFMZ9Rw==
X-Received: by 2002:a5d:59ab:0:b0:391:9b2:f496 with SMTP id ffacd0b85a97d-39acc455e06mr6322963f8f.16.1743076387721;
        Thu, 27 Mar 2025 04:53:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d7c111d83sm26923995e9.3.2025.03.27.04.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 04:53:06 -0700 (PDT)
Message-Id: <f601f4e74a5e8146f2926a725f3d1522b928eb51.1743076383.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1889.v3.git.1743076383.gitgitgadget@gmail.com>
References: <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
	<pull.1889.v3.git.1743076383.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Mar 2025 11:52:56 +0000
Subject: [PATCH v3 03/10] kwset: avoid using the comma operator unnecessarily
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
Cc: Philip Oakley <philipoakley@iee.email>,
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Karthik Nayak <karthik.188@gmail.com>,
    Jeff King <peff@peff.net>,
    Taylor Blau <me@ttaylorr.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Chris Torek <chris.torek@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The comma operator is a somewhat obscure C feature that is often used by
mistake and can even cause unintentional code flow. Better use a
semicolon instead.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 kwset.c | 54 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/kwset.c b/kwset.c
index 1714eada608..064329434e5 100644
--- a/kwset.c
+++ b/kwset.c
@@ -197,10 +197,13 @@ kwsincr (kwset_t kws, char const *text, size_t len)
       while (link && label != link->label)
 	{
 	  links[depth] = link;
-	  if (label < link->label)
-	    dirs[depth++] = L, link = link->llink;
-	  else
-	    dirs[depth++] = R, link = link->rlink;
+	  if (label < link->label) {
+	    dirs[depth++] = L;
+	    link = link->llink;
+	  } else {
+	    dirs[depth++] = R;
+	    link = link->rlink;
+	  }
 	}
 
       /* The current character doesn't have an outgoing link at
@@ -257,14 +260,14 @@ kwsincr (kwset_t kws, char const *text, size_t len)
 		  switch (dirs[depth + 1])
 		    {
 		    case L:
-		      r = links[depth], t = r->llink, rl = t->rlink;
-		      t->rlink = r, r->llink = rl;
+		      r = links[depth]; t = r->llink; rl = t->rlink;
+		      t->rlink = r; r->llink = rl;
 		      t->balance = r->balance = 0;
 		      break;
 		    case R:
-		      r = links[depth], l = r->llink, t = l->rlink;
-		      rl = t->rlink, lr = t->llink;
-		      t->llink = l, l->rlink = lr, t->rlink = r, r->llink = rl;
+		      r = links[depth]; l = r->llink; t = l->rlink;
+		      rl = t->rlink; lr = t->llink;
+		      t->llink = l; l->rlink = lr; t->rlink = r; r->llink = rl;
 		      l->balance = t->balance != 1 ? 0 : -1;
 		      r->balance = t->balance != (char) -1 ? 0 : 1;
 		      t->balance = 0;
@@ -277,14 +280,14 @@ kwsincr (kwset_t kws, char const *text, size_t len)
 		  switch (dirs[depth + 1])
 		    {
 		    case R:
-		      l = links[depth], t = l->rlink, lr = t->llink;
-		      t->llink = l, l->rlink = lr;
+		      l = links[depth]; t = l->rlink; lr = t->llink;
+		      t->llink = l; l->rlink = lr;
 		      t->balance = l->balance = 0;
 		      break;
 		    case L:
-		      l = links[depth], r = l->rlink, t = r->llink;
-		      lr = t->llink, rl = t->rlink;
-		      t->llink = l, l->rlink = lr, t->rlink = r, r->llink = rl;
+		      l = links[depth]; r = l->rlink; t = r->llink;
+		      lr = t->llink; rl = t->rlink;
+		      t->llink = l; l->rlink = lr; t->rlink = r; r->llink = rl;
 		      l->balance = t->balance != 1 ? 0 : -1;
 		      r->balance = t->balance != (char) -1 ? 0 : 1;
 		      t->balance = 0;
@@ -567,22 +570,22 @@ bmexec (kwset_t kws, char const *text, size_t size)
       {
 	while (tp <= ep)
 	  {
-	    d = d1[U(tp[-1])], tp += d;
-	    d = d1[U(tp[-1])], tp += d;
+	    d = d1[U(tp[-1])]; tp += d;
+	    d = d1[U(tp[-1])]; tp += d;
 	    if (d == 0)
 	      goto found;
-	    d = d1[U(tp[-1])], tp += d;
-	    d = d1[U(tp[-1])], tp += d;
-	    d = d1[U(tp[-1])], tp += d;
+	    d = d1[U(tp[-1])]; tp += d;
+	    d = d1[U(tp[-1])]; tp += d;
+	    d = d1[U(tp[-1])]; tp += d;
 	    if (d == 0)
 	      goto found;
-	    d = d1[U(tp[-1])], tp += d;
-	    d = d1[U(tp[-1])], tp += d;
-	    d = d1[U(tp[-1])], tp += d;
+	    d = d1[U(tp[-1])]; tp += d;
+	    d = d1[U(tp[-1])]; tp += d;
+	    d = d1[U(tp[-1])]; tp += d;
 	    if (d == 0)
 	      goto found;
-	    d = d1[U(tp[-1])], tp += d;
-	    d = d1[U(tp[-1])], tp += d;
+	    d = d1[U(tp[-1])]; tp += d;
+	    d = d1[U(tp[-1])]; tp += d;
 	  }
 	break;
       found:
@@ -649,7 +652,8 @@ cwexec (kwset_t kws, char const *text, size_t len, struct kwsmatch *kwsmatch)
     mch = NULL;
   else
     {
-      mch = text, accept = kwset->trie;
+      mch = text;
+      accept = kwset->trie;
       goto match;
     }
 
-- 
gitgitgadget

