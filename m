Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5ED32E720
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 13:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760534021; cv=none; b=K7/9sBliq8bBwqhUpCaJxb1tQKi7BCq6Mb+1RNS23aRFtvMg2YMgS+4vD61unmDs44/OzK51st0jw6ovdfm5yHhsBdf3XEYUHjsuWpviQ4EEFOPA3Qi8XGwbPKfu1Yvo2NoxxLfwnRsqTcOieZNZHK1eDUr1E/JT1YwyPK7mbJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760534021; c=relaxed/simple;
	bh=OMt+/gYFUWS5HF4dvHLbI7QMVya98s6MCEEuPH9S0d0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MscLZKE0aS7MVV5UNtVTgg1jSQUyBaFrTY6KrJgJYK6+WFpqRL70fYAqYs1W4hIj7L7/PLOys/OVopKG7PyRkDIdHwtOpnw77H2IA38EAoFFZ77++5f4DuUH48E0bQPOgUgsJlYDc9sz0yPWI1iksp5OVMGnAPzAHyYwqVvO5hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bqdv+yS+; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bqdv+yS+"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-78118e163e5so847568b3a.0
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 06:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760534018; x=1761138818; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6DKYa6XMoVVZWFf13Or2rYWpupVvBcisKEO4JgwyXNw=;
        b=Bqdv+yS+k0EeQFTNixttLLUoFN/d20PiV0I3QDzJF4RpdunXOppThStdn+PaSNz4Kn
         jCUCjn3jM4ETYgFiLmhQ8LWvyv3oY9a4F05V47CDIQ+ubqrrKkQ1Nc+9ijO7lfH0Qu0z
         QvwxSYaroUrP1y2sYDwsj90CyI6Hzn9VODBQ4Ntm5B4e7lXo5Bd8WhQQK0N9U/JpSwk+
         PbzLe/LicaF6WRZZ/8lptdPxFXFDwW1bi1ZmS0YIpYJOjXJXO+eXJP0ZKIPNbuJkkygO
         jNKNQbetj/Qkw2kjy7kaapOo1HwCCNcHIwz6SPW/97jl86h9amiU25+cOnfuOg3Z2wP4
         CA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760534018; x=1761138818;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6DKYa6XMoVVZWFf13Or2rYWpupVvBcisKEO4JgwyXNw=;
        b=bhVpAg32CqCEwocXYxCTD5LqknCnTSpmEcJaLHJKX/V8weF127wLeGqY1lKQ4pbAIT
         ihQBpbg0kNHoRtFH0EXf8G3ExhUChCDSLY3au9pfUGl2BwbGb4gBm4F6+10kvq4z4VhK
         2rbY2Nau4qGfES/FK5Iwqfra1MueGqNxrpDKVvb3a92uSOBWBWj7JgDWpk2EK31iyriX
         X48NQd3IjGnOKek7Jpdhp3RXRxCLLjjwMPmShQbEur7zBubURN9yUm4Z9F6otNVbpSUn
         ZeqowydNhAIZMYpuyVJW03vVS5ejC2b6w1OrK06aOAM9/NA6vA8QIUxoETnP3X7aV/6B
         BcBA==
X-Gm-Message-State: AOJu0YxEo2ikTWoYI1bcsUCnKBU6EnLXuPnCm3mA1NjBV0FLehJy273g
	ZU9e7bHTlwHx1ZY9qp29ov3whcnO+GZxQec5bC9zqOb18qwmmGgE0L9EENJTjqZl
X-Gm-Gg: ASbGnctB54a8kpBF8pM6HN65KjPRlKddIXinFoVeOPjdtbRXDeMDfU0HquiVaHLLpEA
	pR8N79p9cHA2vOVb8f5syloOax2bxkfTxx2YHoE8XKCGiWufMwbLdGmDiEw6LYuyp3suLVUlzwq
	ncfR2dDQaiG5NYMnwb/QyZEHLmekaY43/7bjF8ErJeuJ7lDtcRvcessyrc9bLbSADOtGXzO2zWA
	/XA/621CRlWyKnIe/+sU7PZ4dnwhxmrWa4KeRHZOYkvgdDunWNARodCVrw4ziquW194xq4H7FQ3
	mMQ2VM4BMKlPos2WdMrgiE2iygfiqmCBcx2fbFxGTF6HzU1NxRhmQbfGP41abWEVWVxXEklnMdu
	bHoOMlMXirgiqWiG7ZwlgnNaHsRI/aqMeVt6QoY7C
X-Google-Smtp-Source: AGHT+IEzRi3lbQN7Tvh1fmOCsoyyn6OFTo9BiU0e2p9b72dhNA7CxPX9Yr/55C72MFtXesYgocrqiw==
X-Received: by 2002:a05:6a21:3399:b0:327:957:f915 with SMTP id adf61e73a8af0-33495dfb746mr30164637.24.1760534017734;
        Wed, 15 Oct 2025 06:13:37 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.60.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a101b8298sm1991478a12.37.2025.10.15.06.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 06:13:37 -0700 (PDT)
Message-Id: <2439c3d8474003571deaf632dddc9cf1f5478029.1760534011.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1976.v3.git.1760534011.gitgitgadget@gmail.com>
References: <pull.1976.v2.git.1759951536.gitgitgadget@gmail.com>
	<pull.1976.v3.git.1760534011.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Oct 2025 13:13:30 +0000
Subject: [PATCH v3 3/4] doc: git-pull: delete the example
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

From user feedback: this example is confusing because it implies that
`git pull` will run `git merge` by default, but the default is
`--ff-only`.

We could instead show an example of a fast-forward merge, but that may
not add a lot since fast-forward merges are relatively simple. This lets
us keep the description short.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-pull.adoc | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/Documentation/git-pull.adoc b/Documentation/git-pull.adoc
index 0686a9d666..273172aa80 100644
--- a/Documentation/git-pull.adoc
+++ b/Documentation/git-pull.adoc
@@ -36,32 +36,6 @@ There are 4 main options for integrating the remote branch:
 You can also set the configuration options `pull.rebase`, `pull.squash`,
 or `pull.ff` with your preferred behaviour.
 
-Assume the following history exists and the current branch is
-"`master`":
-
-------------
-	  A---B---C master on origin
-	 /
-    D---E---F---G master
-	^
-	origin/master in your repository
-------------
-
-Then "`git pull`" will fetch and replay the changes from the remote
-`master` branch since it diverged from the local `master` (i.e., `E`)
-until its current commit (`C`) on top of `master` and record the
-result in a new commit along with the names of the two parent commits
-and a log message from the user describing the changes.
-
-------------
-	  A---B---C origin/master
-	 /         \
-    D---E---F---G---H master
-------------
-
-See linkgit:git-merge[1] for details, including how conflicts
-are presented and handled.
-
 In Git 1.7.0 or later, to cancel a conflicting merge, use
 `git reset --merge`.  *Warning*: In older versions of Git, running 'git pull'
 with uncommitted changes is discouraged: while possible, it leaves you
-- 
gitgitgadget

