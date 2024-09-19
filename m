Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F213B3AC0D
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 18:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726770891; cv=none; b=AT0FNfI33RgoaomXdxq83wPwcrsPJCrdVRexP+qBfA3UgpJiDlOBZru9U3bMoFP32LEbDXy2rEYbstB9VLZ5Y8rLLDKeXT5qOrBci1GIDIiC9T9/0HlqHBvPLGWm3f7+u3PSu/x0tcv2hn1vHG6zqVE1S6Qxq1crnxkBSgOD9P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726770891; c=relaxed/simple;
	bh=akW++PJFKSCNJ4lVp6syr1tpmVCbWdcFEfwGCaWHUMo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WcFtzCs4IDicxIcgQxDpso1IsppsIlVeJR+aGZmqSLHmnLFcd5Zuyn4Qda1Tvu4Rtf1+tT06QEcHVqdxZsI69DGiAjSW5gWPid1w5NhXPNvczGc1VvaosS71mQv58Lb+t5PBediUZfxS0Yh1AyBaHz7DoRo5FFkaK2F9AZ1CSLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zle7H0Ke; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zle7H0Ke"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8d6d0fe021so169317966b.1
        for <git@vger.kernel.org>; Thu, 19 Sep 2024 11:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726770888; x=1727375688; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OhqVjmksBUUwYYJMSfxI754m2o9+dVS28hD1yx0fi7Q=;
        b=Zle7H0KeERPUP7BIKoIRCy7WGJ3ZhS882PaCyJ/m2qgD60nA0/px2L8uBj9psigtRC
         uGekBhSOcrWNypZgHJiuRw2vaMaeWOThVELvflR1A5AxFkX1dHQrmMODRzEOpl/v+JLV
         G61PkYB8xPMJ/INkm9WsrrLUP3CxEyTKO91VmYy721UkB7LI9bPnOPoq6D0HxORPsoP4
         YgWgaKURhVqSdM4TEp7v9/oSb7WyIwG74O7mu9Wg3fQ6rGBy/o6V3BOS6OQbgKMXJJNS
         YOjy2JLex24wk36kT/JP10QBeBdYz0CgYl1yD8gxdG1oy+UdTSA8lEp69UDKUoo7VZOm
         0Ugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726770888; x=1727375688;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OhqVjmksBUUwYYJMSfxI754m2o9+dVS28hD1yx0fi7Q=;
        b=AFyysYCyc5tCRkdq2CxTBwOBA5PW3XS/FloSGY7mcFxwtPhRM2Z+/vHZdFKfmZh+vO
         LmbDD8tCjkly9l1IYMGNXOnNZF242DPNDMZYxPWjBBnDBmRj9EnDULHrNOzLFpoS3m7j
         Lc9pJUghSDyf3nnJbzpRDAljjJ8bqhA3gkiRstqva30UQgSoK0bO3h28gvJ/Zxru17d2
         sd80EQpwpmlu+MWVjrPLJLouPqSopiXIy790pEJXyNUjMdoLsZyvZDeFBBdckSC4ywFX
         g0yHIxxcwwHgyTwzXQz5uo5gKPPJWmT0TBSZztD/aCNQpZWWySt3/2YzObRikWzdYa0C
         tgmQ==
X-Gm-Message-State: AOJu0YxKeIIAplKymHzjZvqMR5UX3EG0WGcwCqWTVSlXuoUSIwUKHNrA
	x1avOPGTSCAzvOyXrh3SaWPd3SWUCih3N0w6IpQmvrY9wxJR+tiMlgzwXQ==
X-Google-Smtp-Source: AGHT+IFvb4+L8WCR21p3FLkR3OJ/z1gihEqUeiaRhSwP1LdS1eJe/A/2cOXqmO8Tn2/ato3a6FmC1A==
X-Received: by 2002:a17:907:96a3:b0:a8d:302e:e1fe with SMTP id a640c23a62f3a-a90d516abf6mr11203966b.63.1726770887817;
        Thu, 19 Sep 2024 11:34:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612b3833sm750489166b.128.2024.09.19.11.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 11:34:46 -0700 (PDT)
Message-Id: <9ced7ed80d0905cc44769a70786f83763dece56a.1726770881.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
References: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
From: "Andrew Kreimer via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 19 Sep 2024 18:34:25 +0000
Subject: [PATCH 05/20] git-p4: fix typos
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
 git-p4.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index f1ab31d5403..c0ca7becaf4 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -54,7 +54,7 @@ import time
 import zipfile
 import zlib
 
-# On python2.7 where raw_input() and input() are both availble,
+# On python2.7 where raw_input() and input() are both available,
 # we want raw_input's semantics, but aliased to input for python3
 # compatibility
 # support basestring in python3
@@ -1804,7 +1804,7 @@ class P4Submit(Command, P4UserMap):
     status from the script will abort the process.
 
     The purpose of the hook is to edit the message file in place, and it is not
-    supressed by the `--no-verify` option. This hook is called even if
+    suppressed by the `--no-verify` option. This hook is called even if
     `--prepare-p4-only` is set.
 
     The `p4-changelist` hook is executed after the changelist message has been
-- 
gitgitgadget

