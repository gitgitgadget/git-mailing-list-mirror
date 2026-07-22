Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704E6480359
	for <git@vger.kernel.org>; Wed, 22 Jul 2026 08:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784709546; cv=none; b=emJnz0EjlnI35JJS51y7Op7oQMlUKfle8XiJ3b6VN53dFetqLIhjGuzJUcwvHmyO4zK26YtVBVhcPzUGRGOBw1otZ2UBLpjNOF8pn8tpB5Rj/bsn0LGL3cc36RxwB0X6S3aWY53rCefJwoWGHTTivolvQAlw3GX4WHBHWioMaBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784709546; c=relaxed/simple;
	bh=ZatsvDX7wHFRcz2mi2IQkDSmf+pP3ekxSPXsLhux3rE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VaETTjrU+vYHwfXe3FIxg8OX83g3Db5/o7wtfeqdSPhNlRAzhpRRwwHsPob3iD7XFZyep+1fd4HbjP3emfSDFQ1HbDrb5Kc+0cbWDsBAcoVP9GiYBKU73pN6yQfIPe48q2DZc1kJm3ZPvaADruP1ZlMt4jYWcZurHB9Jh/75Q38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYtBJ9c3; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYtBJ9c3"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38e08baf860so9889168a91.2
        for <git@vger.kernel.org>; Wed, 22 Jul 2026 01:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784709536; x=1785314336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7OU37POCPsdi3Mz9eJ3frvEMwgqODgeRdkCL+dwb3v0=;
        b=CYtBJ9c3KIKSS/EbJ7DLJcosWAaH2fTuvLoeyEvCEGFEI9ZsuKwCA1AeBcVjNZ02Ik
         KAbcpW9/lioKwslDck30PMpLeJA3SGX8ud1hBjMqHkIm+Nz5FJg1Lnoa2ki97ZIxXAWg
         dxFJxMKcl38i2OsnaRKz6nfwZssXkGykNPGxh+DXC/jI490qnrud5I00Shqelj4K37ZD
         ZfAlK6dV2fMz8cDyU0xqIOQueQf471IvEBP2Bkkn56DUEKAnhaVUNxvP4KhB+X2xKPNK
         XiwTAj1knojS67Hlq0OtYL432p/izBPmZFjPfDqBdkSSfmkQYzcseHuMh2giy+4edqOM
         KQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784709536; x=1785314336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7OU37POCPsdi3Mz9eJ3frvEMwgqODgeRdkCL+dwb3v0=;
        b=K5ity8iaZsuKjt1u53SA5+ZpXik+mOcm9L/nqqhqDQx22q+IsxNgPSHyGsYDhJKK93
         +BxwT6PUfnIvC4LsOu0j5N/Qck9eO6htbYaIq/XmrsmqADgeSKtw/MsivNjTXaSUMtWo
         2e+0n6yK4v5p2WLYvdJw3OGa8vY/CkrcMe3dn6hDjP8c4MFpa/wGNBtxZL/5eyo+GG1y
         xAMUU/7dW7UFKYu3jxcb+jz5Syvm0N/0Zic28ZA+MIemFdIoy/J9AHEMCPy5PgBTCspN
         5opDozEH4SN5qf2sWQ49mGhIM6GdctXo6d9BYuDt6d4JsMPNHuxzyoj0RrHP/PMFU0Ws
         xIlg==
X-Gm-Message-State: AOJu0Yy6XjMItq0GSyMOk9hkHXhX7tnpxmrNFLhYSKL4mLWOgIVpSd1+
	wuw6MVoAYGbiOwUglTkUhQbf8PgysnAxCUSKgn9Kd1ajqwKnPvzouz+lCT5vyfdd
X-Gm-Gg: AR+sD10ErGbYknLvjeVEyQgz9nMYEsa6ReiWFcapp6YR1wZa9tql8TNeUzUfPIjCa3p
	jtAoO+oj4is8FfmdxuMCKTtQWG+DeDyRdZ6Sk7+E8O49Y5XC84O2b/ldMzTsBqu1ludavaK1kpr
	/VTTwwafHXANFqtvVBqcK4AvATe6mXSv0bLFFMkeJ4xH9UUwheyiQVPhF21ydesjB17YtYD+52V
	w2SP8GZBseiHShkjhVVGnXQAAJX0ORJCukMG/G5SMYREtD36Q1ktyMYqkpCfw+5uwee1NGbtqRk
	CIlzZ8+wJO0wmCsM/DwVI4o+hiRuf8w47YJv8SBVO9iZcI8QB/+pzPzI5tg+EcNf3d/s6S1e5J3
	0zHX6odMomIxrMQn7G9ByF9L11pws1TIMSq2MFTGiv+jGC7bMQMWHsYALluJAQPH9t+ah7nhVSW
	/pGXpdhP0sMM+nfPXK24Q=
X-Received: by 2002:a17:90b:3d43:b0:387:e0db:3d8d with SMTP id 98e67ed59e1d1-38e4b5ace92mr22858430a91.40.1784709535648;
        Wed, 22 Jul 2026 01:38:55 -0700 (PDT)
Received: from fedora.tail0f6912.ts.net ([112.133.220.139])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130f55c6sm7203763c88.15.2026.07.22.01.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 01:38:55 -0700 (PDT)
From: hardikxk <hardikxk@gmail.com>
To: git@vger.kernel.org
Cc: hardikxk <hardikxk@gmail.com>
Subject: [PATCH 1/1] Extract only the message body from git commit.
Date: Wed, 22 Jul 2026 14:08:36 +0530
Message-ID: <20260722083836.744338-2-hardikxk@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722083836.744338-1-hardikxk@gmail.com>
References: <20260722083836.744338-1-hardikxk@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch fixes the `extractLogMessageFromGitCommit` function to skip all the metada of the commit object and only return back the message body.

Previously the function would return the entire data of the objects
including authors tree and SHAs. This patch fixes that to skip over all
that and just return the body of the log message.

Signed-off-by: hardikxk <hardikxk@gmail.com>
---
 git-p4.py | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index c0ca7be..589efcd 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1003,12 +1003,18 @@ def branchExists(ref):
 def extractLogMessageFromGitCommit(commit):
     logMessage = ""
 
-    # fixme: title is first line of commit, not 1st paragraph.
+    foundNewLine = False
     foundTitle = False
     for log in read_pipe_lines(["git", "cat-file", "commit", commit]):
-        if not foundTitle:
+        if not foundNewLine:
+            # skip anything that is not the commit message
             if len(log) == 1:
-                foundTitle = True
+                foundNewLine = True
+            continue
+
+        # everything from here is the commit message
+        if not foundTitle:
+            foundTitle = True
             continue
 
         logMessage += log
-- 
2.55.0

