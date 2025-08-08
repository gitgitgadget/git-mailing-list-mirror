Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE51D1C8633
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 22:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754693558; cv=none; b=H5v1eEFeeRpJFp11FHaiqH0fmLEzj1T/l+X0kJJGYoxdSyZAxcp7xBErBfbzh3/e9OLs96eJtopMFZ9fdqPLBogkd3WJe/vZqUpvlLhm6Wynh/XEHX/KIFHeu8K4C50iGCRq+X47CgOPvr36TaL3t47CRahzv0kOA5Gvyz/tUlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754693558; c=relaxed/simple;
	bh=GwwITLNrFdwyo5wDr6lvV6IZicEizV3B39frREV5FT0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BXsEEIshwY8QH9JHgE0zyQZClx9d6AiRd9q5Xx7VPTlPsaJwCvV16pawO9mBcxrcP2sYs86DmoY88IHof0HVLWHS1v24gVnYgxN/2UXapuUMFthkccaWmim6N3m3STAKNnCV2zcMpKPEJ/nvcjjwwD6d47WpbP5iRgAoJi2h9dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Akg0MlEa; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Akg0MlEa"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b7834f2e72so1351190f8f.2
        for <git@vger.kernel.org>; Fri, 08 Aug 2025 15:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754693555; x=1755298355; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ndt4ntVDvjqyp49SZQYTinSgZIt6HUAOOzIGm3XQTSI=;
        b=Akg0MlEaCiM3Y7L2ZHHssLMeUrVmQXmhDByQeLwajx19rqmxXh0pksaDMqEgEuNSg0
         +jwK8ycAs1ligcmitqEjO6OwxnYayEVVNkEcdw48WCaSC2JC6i7QAqGPoliUBsDhqpJ6
         fsmg0Cde3p7x4de02akexTBo1UbE8XcanXoVuht8pryX3DwcKEZbE433gGJEElRq4i2p
         froFaPNDvd3bu5ahRXtjen60HpuG+atPLesgeQf6S57LaFG236RR/WlaCioVDnTbVy/a
         Pubr+Y/xI3Oe4QlsIMlEKVPsbarusev3Cm1YNN26Kd2MnVMegJERY52xtXJjKDzDdmPI
         FoQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754693555; x=1755298355;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ndt4ntVDvjqyp49SZQYTinSgZIt6HUAOOzIGm3XQTSI=;
        b=W1LpaPsPSUr8jAYl5LAE25DCRIkqLpuo1tvcqvFvx6yGo3TgaZ850I04NcOfE9HJPy
         /L95DjLmbdEj6nZXfSoI0bjstJyjvpKEosvZ8e7eDu8Zk3ytY5Wj7PBjM8UZttdz8E6J
         mBzMXw+f7VCqkjksJGN0jt1U/LtD49SbwzXYY3CZLF3cbQLKiswxdt7gz7o1P+N6tnXj
         4qvWh8lTB9IaillN2fj6xTDgy2QcqxrlCWbsdOykJWDRilnYH9aYeg4wob4xstv8kkkA
         JGDfiiZo86CMbt5ywk5Lt4hNXouioElfligxwSH1D0R6du6OnYnnlDmnE9/sKX3gZtPq
         PTQw==
X-Gm-Message-State: AOJu0YxHvSp4luN4TOYCkkBK5aaSH4lNFXyW7GtVxMMgCnZ1B2pmfzhO
	gfQhLa4yqxre00qbVaESc2SkpU6dloyfUWrf6qtH+FbiYbc3P0L93rn7oFhIiw==
X-Gm-Gg: ASbGncvXamf1vUnVRuA8WPINigf8SJa5pRrL/1ZzJxhAPTJlLPKhLCMr2BoQjYT4QO9
	W3ELqCI7bOCp9PNXnHNoV3Zg192n7YISSol55/iKsq5AEVSbGFaKa52LKkuDSaH3DgRgwOydgmM
	B/grnxDFrVm612k009ff1ey3taZ4/Lb90VR+Vrkr5VvApGYTkPSHl6TZ3wdZoiyxgd0RbgA3io8
	AaJqr5T+itX9Mkjxvu6KtOF9XN5BZdX7L1EGBPEXgfnOucC3kAMxobrqPuzOQKr8cqFKN7FQkIs
	mR57q5SyRECgF3DARiL9+rqo5vay+19sWwtD8rNOIsyBgthrlXt/UWLcs/K46MlWM9IH9w+H0Nq
	0zm/+0bB4tWwKC7/bPeTFrPY=
X-Google-Smtp-Source: AGHT+IGe+AdLdCKTJJvBgE/deWXgnOzP3wCmmptbAztKhN7iqvFYl/ONoOVWLGA7/Y0SVsyJOvccaw==
X-Received: by 2002:a5d:64e7:0:b0:3b7:58be:8fc with SMTP id ffacd0b85a97d-3b900b51133mr3558147f8f.43.1754693554736;
        Fri, 08 Aug 2025 15:52:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45923c34af8sm253841745e9.24.2025.08.08.15.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 15:52:34 -0700 (PDT)
Message-Id: <26b742eb49f935147ac373bf9435827a6f85e531.1754693552.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v3.git.1754693552.gitgitgadget@gmail.com>
References: <pull.1949.v2.git.1754680525.gitgitgadget@gmail.com>
	<pull.1949.v3.git.1754693552.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 08 Aug 2025 22:52:28 +0000
Subject: [PATCH v3 1/5] doc: git-rebase: start with an example
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
Cc: Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Start with an example that mirrors the example in the `git-merge` man
page, to make it easier for folks to understand the difference between a
rebase and a merge.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-rebase.adoc | 49 ++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 26 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index 956d3048f5a6..6dacf693bd71 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -16,6 +16,29 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
+Transplant a series of commits onto a different starting point.
+
+For example, imagine that you have been working on the `topic` branch in this
+history, and you want to "catch up" to the work done on the `master` branch.
+
+------------
+          A---B---C topic
+         /
+    D---E---F---G master
+------------
+
+You want to transplant the commits you made on `topic` since it diverged from
+`master` (i.e. A, B, and C), on top of the current `master`.  You can do this
+by running `git rebase master` while the `topic` branch is checked out.  If you
+want to rebase `topic` while on another branch, `git rebase master topic` is a
+short-cut for `git switch topic && git rebase master`.
+
+------------
+                  A'--B'--C' topic
+                 /
+    D---E---F---G master
+------------
+
 If `<branch>` is specified, `git rebase` will perform an automatic
 `git switch <branch>` before doing anything else.  Otherwise
 it remains on the current branch.
@@ -58,32 +81,6 @@ that caused the merge failure with `git rebase --skip`.  To check out the
 original `<branch>` and remove the `.git/rebase-apply` working files, use
 the command `git rebase --abort` instead.
 
-Assume the following history exists and the current branch is "topic":
-
-------------
-          A---B---C topic
-         /
-    D---E---F---G master
-------------
-
-From this point, the result of either of the following commands:
-
-
-    git rebase master
-    git rebase master topic
-
-would be:
-
-------------
-                  A'--B'--C' topic
-                 /
-    D---E---F---G master
-------------
-
-*NOTE:* The latter form is just a short-hand of `git checkout topic`
-followed by `git rebase master`. When rebase exits `topic` will
-remain the checked-out branch.
-
 If the upstream branch already contains a change you have made (e.g.,
 because you mailed a patch which was applied upstream), then that commit
 will be skipped and warnings will be issued (if the 'merge' backend is
-- 
gitgitgadget

