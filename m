Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0C21E89A
	for <git@vger.kernel.org>; Wed,  8 May 2024 22:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715206272; cv=none; b=Etmtysd10F6+zRc2FLvP+QDWwWDEWwVmyy7MyNwFFZjUAuV7+EOuYmrjz+LH1PfGZHq5lKPOUwE9zTFwb8rGqllJSoHC+cDOXlkIz5he+oLOeGm9t2FWLirpkgiWTGuON2C4gzGEKr6TmbVc22s90vPYluCmiX4y+mSSHj24FTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715206272; c=relaxed/simple;
	bh=bKSp6cweuqLAvtehltfFAeNFSkK4QVRr3lOFRwyYZcQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=m0hmSynPrMVYPge4RoZ3aPuspV1t1nP3X5VuZ06yGWpaEPlz/tBktFii8XBwtvNxs5llRjFGLAt/drm+rPcIoayCj1XJwxNccyA/XxKJKm5MScNtDXAAD0Qw/y7Rjosg9VhS5WPEAhI2w8Pt3GYLnbEzV5TZfscCESbPJMlapRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ey/yhU6o; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ey/yhU6o"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41a72f3a20dso2401785e9.0
        for <git@vger.kernel.org>; Wed, 08 May 2024 15:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715206268; x=1715811068; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQZJdSm/u662cU31E1wfGEv77QG2/bKbrihNt36uzLs=;
        b=ey/yhU6ojAoVjSRrsEWRliIVHzVWfo/3QNYKkiq7vq1HQqSVpgv2W7+sUo+gzNjb4G
         2c/zc2x4YJJ+Pm+excw40SsqidGkxnVKy6IyYozAyINV4krx/wHcx4o08aYsgiiv//1U
         DBukB0TbyU76Q14QOZQe3J2TRbClPFcqAQVNnU4eEGitJu0N3Ev3VqFEkhnInmjYlXiF
         Bv7ckOWTNolU6fCPi4YONP6EAqmoUvToDKqILMenK4cJV5oS3Kh8jpjo2YYuId5k3bTX
         T2FQzq3CoSHy69IouFrE/YI0d92+slYqfuvQjn/Mm5na+RtRT7o41vCLw8irnR3EShMM
         6QdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715206268; x=1715811068;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NQZJdSm/u662cU31E1wfGEv77QG2/bKbrihNt36uzLs=;
        b=TzphUC00YkkpcpDZnIHHy03Fq4XNFsxa4/ca21TFPjtVOFQcxqIR5TUiQiquEwJV1/
         OOoIWfFlmpFVZ7bYTx6vr3Ve5pdEHFGn6ArnA6uJ2vJZ/t3J+SqSxNTcN1uR3w26LIW3
         VxSLm9ZyPmKP9eVhc+OHzmRCDP0mJ9S6bq4pVAcgySSqcWBIrpw/ErnwDbEwQQIC4qqw
         mu2rP1OHyEVMC4VPUhkNR6lSmaaehYvQq58qpCQtaidVb2yxJewtgVfS2zWSPS48v4so
         S0so+rW0kzlWhbNtxjGGfbnwbiE579FtvsXYrQtAA/R8phe/IcQznTwdwI8kFeopgteF
         NI4g==
X-Gm-Message-State: AOJu0Ywk43rWiXAoA5gu6zNTnrzvzWv2HT7jJZ3n7bYsDhzK6FzT+Idf
	au1kXWs8hpf0edGtVoj1wD0u+Gyqv6oRDkWFkPcyTpole3laDS9qFpv7iA==
X-Google-Smtp-Source: AGHT+IEklE/KylVmMSmg6xpkj4EQTeDRDCXlUI9ZGEPkxUT+DS81ixnTKwFzRYwxi3xNRSGDnI6DhA==
X-Received: by 2002:a05:600c:1396:b0:419:d841:d318 with SMTP id 5b1f17b1804b1-41f719d61f0mr32262765e9.29.1715206268226;
        Wed, 08 May 2024 15:11:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f882089cbsm36352385e9.48.2024.05.08.15.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 15:11:07 -0700 (PDT)
Message-Id: <pull.1668.v3.git.git.1715206266214.gitgitgadget@gmail.com>
In-Reply-To: <pull.1668.v2.git.git.1715168796873.gitgitgadget@gmail.com>
References: <pull.1668.v2.git.git.1715168796873.gitgitgadget@gmail.com>
From: "Fahad Alrashed via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 08 May 2024 22:11:05 +0000
Subject: [PATCH v3] git-p4: show Perforce error to the user
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
Cc: Karthik Nayak <karthik.188@gmail.com>,
    Fahad Alrashed <fahad@keylock.net>,
    Fahad Alrashed <fahad@keylock.net>

From: Fahad Alrashed <fahad@keylock.net>

During "git p4 clone" if p4 process returns an error from the server,
it will store the message in the 'err' variable. Then it will send a
text command "die-now" to git-fast-import. However, git-fast-import
raises an exception: "fatal: Unsupported command: die-now" and err is
never displayed. This patch ensures that err is shown to the end user.

Signed-off-by: Fahad Alrashed <fahad@keylock.net>
---
    In git p4, git fast-import fails from die-now command and err (from
    Perforce) is not shown
    
    When importing from Perforce using git p4 clone <depot location>,
    cloning works fine until Perforce command p4 raises an error. This error
    message is stored in err variable then git-fast-import is sent a die-now
    command to kill it. An exception is raised fatal: Unsupported command:
    die-now.
    
    This patch forces python to call die() with the err message returned
    from Perforce.
    
    This commit fixes the root cause of a bug that took me hours to find.
    I'm sure many faced the cryptic error and declared that git-p4 is not
    working for them.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1668%2Falrashedf%2Fmaster-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1668/alrashedf/master-v3
Pull-Request: https://github.com/git/git/pull/1668

Range-diff vs v2:

 1:  8d5b982bd08 ! 1:  16a0693b932 Bug fix: ensure P4 "err" is displayed when exception is raised.
     @@ Metadata
      Author: Fahad Alrashed <fahad@keylock.net>
      
       ## Commit message ##
     -    Bug fix: ensure P4 "err" is displayed when exception is raised.
     +    git-p4: show Perforce error to the user
      
          During "git p4 clone" if p4 process returns an error from the server,
          it will store the message in the 'err' variable. Then it will send a
          text command "die-now" to git-fast-import. However, git-fast-import
          raises an exception: "fatal: Unsupported command: die-now" and err is
     -    never displayed. This patch ensures that err is dispayed using
     -    "finally:".
     +    never displayed. This patch ensures that err is shown to the end user.
      
          Signed-off-by: Fahad Alrashed <fahad@keylock.net>
      


 git-p4.py | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 28ab12c72b6..f1ab31d5403 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -3253,17 +3253,19 @@ def streamP4FilesCb(self, marshalled):
             if self.stream_have_file_info:
                 if "depotFile" in self.stream_file:
                     f = self.stream_file["depotFile"]
-            # force a failure in fast-import, else an empty
-            # commit will be made
-            self.gitStream.write("\n")
-            self.gitStream.write("die-now\n")
-            self.gitStream.close()
-            # ignore errors, but make sure it exits first
-            self.importProcess.wait()
-            if f:
-                die("Error from p4 print for %s: %s" % (f, err))
-            else:
-                die("Error from p4 print: %s" % err)
+            try:
+                # force a failure in fast-import, else an empty
+                # commit will be made
+                self.gitStream.write("\n")
+                self.gitStream.write("die-now\n")
+                self.gitStream.close()
+                # ignore errors, but make sure it exits first
+                self.importProcess.wait()
+            finally:
+                if f:
+                    die("Error from p4 print for %s: %s" % (f, err))
+                else:
+                    die("Error from p4 print: %s" % err)
 
         if 'depotFile' in marshalled and self.stream_have_file_info:
             # start of a new file - output the old one first

base-commit: 235986be822c9f8689be2e9a0b7804d0b1b6d821
-- 
gitgitgadget
