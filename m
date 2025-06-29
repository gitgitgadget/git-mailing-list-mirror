Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B81221273
	for <git@vger.kernel.org>; Sun, 29 Jun 2025 13:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751203250; cv=none; b=cABSbOyzlUZfroiYvvOqm6y9tiFMn/um5h1RCHPP8AuF//PjqkU5R6Le/WA5clYtgtMyPQ6KMoYkwYtSR4XkEISmVKIC4uKbBshFX5KEmYMVGxquuusZYrQVTS1e3miHnkc4TkTKpC90UkUAS0QDMxvhz7mIGsRtfUsQ0O1ckug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751203250; c=relaxed/simple;
	bh=V1TKFkj2avks98qi+QPmVnNSntCFyy/q85tSEtKIXT8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=ebMKmaWb2bzNbgmaKFvC8lNyBBkh/+VCd4UcuT6XJaMOiLO09CV66T1TWd5gidnHYeTsxIdWWMmb16jBEmkOXiW01FekIbP5jGLnJEZDaiApJYrwaz7qOdpRbh7mVz3dQwLMtSGMbTzgnXDXa1ysWnyOEctzQOcB8fMO38WjX8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eawei1q8; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eawei1q8"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-453066fad06so22271415e9.2
        for <git@vger.kernel.org>; Sun, 29 Jun 2025 06:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751203246; x=1751808046; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scvdSUiBmyCG5vF0CjLET40XEP076IKjDasqgPx5raM=;
        b=eawei1q8BGqL92NCqoaDJ1coyZEpDDMMQ/jMF7+RJyX+sPHxcLRHMUSRnyJLH2gRF0
         FYqOfztrWSuJVtf57B5mLS7CZA/JfO27uDcni+vTkr19P8S1uIG8UyaiyjoGy5J38nTU
         97RJplOfCvE060Q81xvPCAZkSAv8amRefrBFIXJ+qj42rnsvtxnBn1SbRUnq0W6nkn/8
         Zekgpg3/pzhbeW09O5E5/Bkul0gqzIRXYiMItvF7tOzjzpEGB18B0xO4bEodNTm+JhiX
         Vmr+nbJ0wD8UBcJrdNOkJsnWelmuUmALhhI3PzvTKq4I7FIN6MJ/77gjFlD3pX/bmB5P
         0eyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751203246; x=1751808046;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=scvdSUiBmyCG5vF0CjLET40XEP076IKjDasqgPx5raM=;
        b=a4+XfxhFx4ESUCJ/VHy+lbZol4LDo47W8cFo2s4PHsM04VG5JXNuSU1mp9iYMdd7ku
         cnUeX6X18GQlW7sRjuKRDetODHv1NUaSCihTD3156RH3shUa1D6DsE80bIOpXzfWgoY9
         NyWMwN2UPVAQ/3S62xoChMclZRqVj0EkqyzAplFgojRjeyYXGonitNkMx2Kvz/tvL2ty
         suiBDQMN7k+sGKTLzkqH5RPaGGw7xMhab6oqMvmhwST2X+IKhs7rVW6x7oZUmg+FGdzi
         TOZzGXnVLEtV4el2aq6OAy4g1JVwDcpfx5Itfy0gHXMwRhCJCcxwcfM8YNqHG0pq+UUb
         WcdA==
X-Gm-Message-State: AOJu0YzHioAxGuEFAQRiORlwG+mELsgz4tQx7GMvTKUMdYpowM+z98zu
	VZlLGLDOvpDSRSgH+PiyQ4jbZnPga5iQn7t7qNbBJ6fw9thHxdJcGK60FuTSww==
X-Gm-Gg: ASbGnctxC50ElaOlydO9seJj+R6aTICdEJoQJOb7zx43tkS/6VSBC8nqMZ7Q8+RXqpe
	m5lbr4n7uybddp18WdmuEKMWMZTp5cV92G58YYKlh95L1FPsFO/tM66gMoPpPEMOfoyakSSjrm6
	RqSRST9Jm8nnjtKbGxq/McKixplvP/WFohnJWoA6xq4zpbbBEs4EvC/W8fLwXK/TKpOSgDr3wdP
	r8cGQFnJf/vEqAcPI0M8RqjEjcaFK43s7KOqK3Gur1kcfTyLGUKgVQk5tplXyBqhN2jVajwuZg+
	ogphj4NMnc3Xr677lpQv2wdIh7bOprsm+wm9WpAKNq72wOGj8J0cQcqIATxTnQtSjtjBtgw48w=
	=
X-Google-Smtp-Source: AGHT+IEdxZ1Z4f3tri/aqIs6tBCbZ8yM8bqYd/nyrkjn+hbRCjntUFVubWRTG3OvF7a8TUKOc14rlA==
X-Received: by 2002:a05:600c:a4d:b0:43c:ec4c:25b4 with SMTP id 5b1f17b1804b1-4538ee5d1famr119840575e9.10.1751203246026;
        Sun, 29 Jun 2025 06:20:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a4215dbsm104352695e9.35.2025.06.29.06.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 06:20:45 -0700 (PDT)
Message-Id: <7bab515e136bcb144757285104647c38c73ac505.1751203241.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1933.v2.git.1751203241.gitgitgadget@gmail.com>
References: <pull.1933.git.1749373787.gitgitgadget@gmail.com>
	<pull.1933.v2.git.1751203241.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 29 Jun 2025 13:20:35 +0000
Subject: [PATCH v2 3/9] doc: git-log: convert line range options to new doc
 format
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

  format placeholders in italics and keywords in monospace
- Use _<placeholder>_ instead of <placeholder> in the description
- Use `backticks` for keywords and more complex option
descriptions. The new rendering engine will apply synopsis rules to
these spans.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/line-range-options.adoc | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/line-range-options.adoc b/Documentation/line-range-options.adoc
index f275df3b69fa..c44ba05320f9 100644
--- a/Documentation/line-range-options.adoc
+++ b/Documentation/line-range-options.adoc
@@ -1,12 +1,12 @@
--L<start>,<end>:<file>::
--L:<funcname>:<file>::
+`-L<start>,<end>:<file>`::
+`-L:<funcname>:<file>`::
 
-	Trace the evolution of the line range given by '<start>,<end>',
-	or by the function name regex '<funcname>', within the '<file>'. You may
+	Trace the evolution of the line range given by `<start>,<end>`,
+	or by the function name regex _<funcname>_, within the _<file>_. You may
 	not give any pathspec limiters.  This is currently limited to
 	a walk starting from a single revision, i.e., you may only
 	give zero or one positive revision arguments, and
-	'<start>' and '<end>' (or '<funcname>') must exist in the starting revision.
+	_<start>_ and _<end>_ (or _<funcname>_) must exist in the starting revision.
 	You can specify this option more than once. Implies `--patch`.
 	Patch output can be suppressed using `--no-patch`, but other diff formats
 	(namely `--raw`, `--numstat`, `--shortstat`, `--dirstat`, `--summary`,
-- 
gitgitgadget

