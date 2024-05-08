Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EFC823C3
	for <git@vger.kernel.org>; Wed,  8 May 2024 11:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168803; cv=none; b=LVKBketgwkrpiCY2SPNmVkn5B3C4JpJ7FrmlaMhYvJ0pU+areWOMVuglMEf6skBcFd3lEStkZN3+aM4405/baPn1C+a6VaLp9/q1ebXTSggj6xSg8QRJDUHKxgjDSd8eVwH7psNAe8RBOPM7M879RFTpT7rEIxi3YByRcYSHn1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168803; c=relaxed/simple;
	bh=SQ7m8gZzSs3Ac/hnfvLDKs4kbbCbJaR4EJmsjUYBsYo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SyEgGKia3P5NoJE1f7jeO0AJhbYJG/Kw7NLmhknaxJw1lZZ17xHDVyBhrdX+dEt9wMK6nFJVKMTFu87jSEQNid48KLaHT3IcQunIUzLUYF5R3P8oSQf35i7RVTIhZEfY2g/7+NZHYsO+NFEcR3gAC7eS1/B8ADBRYUcvYc7RCAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q69E/sUj; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q69E/sUj"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2db17e8767cso53261441fa.3
        for <git@vger.kernel.org>; Wed, 08 May 2024 04:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715168800; x=1715773600; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7tyXyK/MhQ6YHOMlG5XBHQwmieOMr5jorFUEnEG06HQ=;
        b=Q69E/sUj6+biXkyaPSNSjBYpok+ikn8ZzLDmosM7FPgOXIBDXpZN1k+dgfwEoTTsLs
         1yVQYv8TowzwbmUCkTjDT3AHKKVKKkhiFPTeXo/sg/dbVmtOPOTKqNJzxDwbXmDtoo/a
         ws3rrUMCbYxRlwGbKvi3CW5ZDa7CuSEU5CIZAbzQGvzVs/ZdDbcdQBra+NvdBWagY4Er
         5isFRm4EnYfwTRuBtg/lJ6wQYy8He0PK12ZeyHqoh2Ce3hNzvqWr8cU+gFur02tcuKRp
         FzxJn7doaYpBCQv1a7vqyn3nAYJu/OvMUc0mSLvb25yBRrgl62vZzWT6qzZk9RgdEQEv
         u+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715168800; x=1715773600;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7tyXyK/MhQ6YHOMlG5XBHQwmieOMr5jorFUEnEG06HQ=;
        b=UeHJAtLrAdlQiw9pJPZLDn99NlWwzZ8AAAAuA0a0dOte2ZRgTu9HQeNoVvBPehBuNP
         s/Yhg6TIp9zHUVzCSiLgesttOZJo8E9HNbeKTeExE4DAaXrMT9LGY/AiGklYj2lNcwsV
         H3UmIUyNu6V/vEeMk7S+Xf5f1xAVBEmYbcplFReeD1Ibf253nA6b/44RKZWXtaKqr++E
         JguDQ5mjqSEt9UUMg/9zO6GoHnDvs5HdtYbqs98WvH1W1F06q4G/WQNu1Z9o3ipJOBt3
         zKblkmfL/zEagTWfuLZNBe99vUwfk5TektNutrFncosef0uLpxdbmYVys2i1P+rE0a6B
         TJYg==
X-Gm-Message-State: AOJu0YwPEcMxw+0tq5MxNEogEaEZInG/k62trdGaENKJzUuX6MIzkgJp
	ZWn2nmbc4QTlaU4V2q+Q2M4Lwebitbt3nFPNIJLa8n6NRx2HUi6fwk1JvQ==
X-Google-Smtp-Source: AGHT+IFCgUlf0gEW6tSN+IcisN/MVkSi/YHo/mEMS1ZapWENhmtEQO+o4b63meEdBS3mU8Wp7dQuNQ==
X-Received: by 2002:a2e:9e43:0:b0:2db:348f:5c33 with SMTP id 38308e7fff4ca-2e446f7fbb0mr13861121fa.16.1715168799337;
        Wed, 08 May 2024 04:46:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r17-20020a05600c35d100b0041bf5b9fb93sm2045471wmq.5.2024.05.08.04.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 04:46:38 -0700 (PDT)
Message-Id: <pull.1668.v2.git.git.1715168796873.gitgitgadget@gmail.com>
In-Reply-To: <pull.1668.git.git.1714802221671.gitgitgadget@gmail.com>
References: <pull.1668.git.git.1714802221671.gitgitgadget@gmail.com>
From: "Fahad Alrashed via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 08 May 2024 11:46:36 +0000
Subject: [PATCH v2] Bug fix: ensure P4 "err" is displayed when exception is
 raised.
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
never displayed. This patch ensures that err is dispayed using
"finally:".

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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1668%2Falrashedf%2Fmaster-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1668/alrashedf/master-v2
Pull-Request: https://github.com/git/git/pull/1668

Range-diff vs v1:

 1:  8dd2c730128 ! 1:  8d5b982bd08 Bug fix: ensure P4 "err" is displayed when exception is raised.
     @@ Metadata
       ## Commit message ##
          Bug fix: ensure P4 "err" is displayed when exception is raised.
      
     -    Bug fix: During "git p4 clone" if p4 process returns
     -    an error from the server, it will store it in variable
     -    "err". The it will send a text command "die-now" to
     -    git-fast-import. However, git-fast-import raises an
     -    exception: "fatal: Unsupported command: die-now"
     -    and err is never displayed. This patch ensures that
     -    err is dispayed using "finally:"
     +    During "git p4 clone" if p4 process returns an error from the server,
     +    it will store the message in the 'err' variable. Then it will send a
     +    text command "die-now" to git-fast-import. However, git-fast-import
     +    raises an exception: "fatal: Unsupported command: die-now" and err is
     +    never displayed. This patch ensures that err is dispayed using
     +    "finally:".
      
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
