Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11C359144
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 23:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706312501; cv=none; b=AjSERuWxI/XmLF8taWqpeeDUsqiHM2m0pogkgENo1ugzWIh9oBld7u9RkI7rmfckbkN63rqDQ2rDxyplgNDRfQxawSwyov5g+ub1Oz7iCb6rLXYjgtdu3khZ30GVQF6UOD0ppmQs5vJuWdUNDw//LoRmAKnPFntOYpKZYQSzHH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706312501; c=relaxed/simple;
	bh=bHYRR7FkSl8FCDr4AChuh7EqUWaBKe0mhX0kgYZ4NWw=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=l4U+5WRf51mah1WVb6vMPce7i+0h/kG1YS2QFbBjt80vkF3fhpT7FeR7yN7tmOBLkXvXAcb59t3Ryv5hxA8zZdj3YeK9e/dr8lMn4sCPEkAN8kbiwZ4r+ZKwxUx5XhTAMJL2NvtCF8FBe6xtgqnkGiCpT8Q8bPhN/TvzjPLC/eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6wtrWmd; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6wtrWmd"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33929364bdaso883619f8f.2
        for <git@vger.kernel.org>; Fri, 26 Jan 2024 15:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706312498; x=1706917298; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H42SxsX40Az7mqMHVa3EEZErRNKC6ebyeuiGrpNpViQ=;
        b=Y6wtrWmdenYHNzvM3y/uJKz+HSUmOD+y1Y6nEzEHRYZDhE8M4SIU41y31gLzXjuODS
         O2T19E+bdJk8dpXS/7HJ2dzvKCHcDc9+cCnglgSxCi0oxaeRe/yXFR/WMccVR3k/0IHD
         TftDe7AnwOEVqMGSoXLEBbBJLpC39HrzhiH6WEjzmia44YoZlY044RD6FfTZuPf64d0j
         RCgqC0Wb70OmMJUGFxQLKza5r+gztOzgA+85AamI9Fkjgi3y3oIFMMJGK8HCEvcmffCq
         SDe+xAdKlFgOuzzsX1W4/PReLRQ/z/ATa5NOpt/76Gx8aP9y66b1X8hytG5826amP6dx
         E7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706312498; x=1706917298;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H42SxsX40Az7mqMHVa3EEZErRNKC6ebyeuiGrpNpViQ=;
        b=EuIBTJNMsaqunPTk35zDN5w8Akz0T+pENUOrWeixX5Uh4855A6HEIH8BJFrmSGY6s4
         0eoK/WIIQCCk5Rh7/pGv+iaZ0xjA0F8YzWF6xlSIM1fuclk92d83pcw+Ai/KiaBoCcMy
         q0/ChArZdeHNDi4ejhSmBj+cGQQrcLpx7UvZJoP9ScMgPsvcTrFJxBr+cPKVEsKMR39M
         TuTRmjqJS9Ke5XIEJ5bz5oM5gjzP772IoP26vaFSCrgtDUp3G0Cx+UGn4XntEo9eqCmm
         zI1DDQtgh2K+5FBkKuhnrkKrGvgXk7z4TEkEdfttVORJGFmKbNYR/7kNlmkCno6hqxjy
         CokQ==
X-Gm-Message-State: AOJu0YwmV/GNQtNLkBFFplhkMUGI9ypqNh4z2y9wXvIwFluF47OEmsQF
	I21JguAZYNOOG9WBZteizl9zdt1lYJ5ye2kA1tWK+WDf0cpxiVzbP9HQ6nee
X-Google-Smtp-Source: AGHT+IFl7XwtrwFg2tX6BQYMnG74rv5O7tpGimOuZhPL8RZTA1AOa63I7GuIEiwticf1FMGfifwcmw==
X-Received: by 2002:a5d:6da4:0:b0:337:b978:70c1 with SMTP id u4-20020a5d6da4000000b00337b97870c1mr332187wrs.140.1706312497583;
        Fri, 26 Jan 2024 15:41:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f7-20020a5d58e7000000b0033922f918f2sm2191378wrd.64.2024.01.26.15.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 15:41:37 -0800 (PST)
Message-ID: <pull.1639.v2.git.1706312496608.gitgitgadget@gmail.com>
In-Reply-To: <pull.1639.git.1705775149642.gitgitgadget@gmail.com>
References: <pull.1639.git.1705775149642.gitgitgadget@gmail.com>
From: "James Touton via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Jan 2024 23:41:36 +0000
Subject: [PATCH v2] git-p4: use raw string literals for regular expressions
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
Cc: James Touton <bekenn@gmail.com>,
    James Touton <bekenn@gmail.com>

From: James Touton <bekenn@gmail.com>

Fixes several Python diagnostics about invalid escape sequences. The
diagnostics appear for me in Python 3.12, and may appear in earlier
versions. The fix is to use raw string literals so that backslashes are
not interpreted as introducing escape sequences. Raw string literals
are already in use in this file, so adding more does not impact
toolchain compatibility.

Signed-off-by: James Touton <bekenn@gmail.com>
---
    git-p4: use raw string literals for regular expressions
    
    Changes since v1:
    
     * Updated commit message to include the Python version where the
       diagnostics were observed.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1639%2FBekenn%2Fp4-raw-strings-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1639/Bekenn/p4-raw-strings-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1639

Range-diff vs v1:

 1:  1ea38dc4643 ! 1:  122ff28ffbd git-p4: use raw string literals for regular expressions
     @@ Metadata
       ## Commit message ##
          git-p4: use raw string literals for regular expressions
      
     -    Fixes several Python diagnostics about invalid escape sequences.
     +    Fixes several Python diagnostics about invalid escape sequences. The
     +    diagnostics appear for me in Python 3.12, and may appear in earlier
     +    versions. The fix is to use raw string literals so that backslashes are
     +    not interpreted as introducing escape sequences. Raw string literals
     +    are already in use in this file, so adding more does not impact
     +    toolchain compatibility.
      
          Signed-off-by: James Touton <bekenn@gmail.com>
      


 git-p4.py | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 0eb3bb4c47d..156597adb59 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -689,8 +689,8 @@ def setP4ExecBit(file, mode):
 
     if not isModeExec(mode):
         p4Type = getP4OpenedType(file)
-        p4Type = re.sub('^([cku]?)x(.*)', '\\1\\2', p4Type)
-        p4Type = re.sub('(.*?\+.*?)x(.*?)', '\\1\\2', p4Type)
+        p4Type = re.sub(r'^([cku]?)x(.*)', r'\1\2', p4Type)
+        p4Type = re.sub(r'(.*?\+.*?)x(.*?)', r'\1\2', p4Type)
         if p4Type[-1] == "+":
             p4Type = p4Type[0:-1]
 
@@ -701,7 +701,7 @@ def getP4OpenedType(file):
     """Returns the perforce file type for the given file."""
 
     result = p4_read_pipe(["opened", wildcard_encode(file)])
-    match = re.match(".*\((.+)\)( \*exclusive\*)?\r?$", result)
+    match = re.match(r".*\((.+)\)( \*exclusive\*)?\r?$", result)
     if match:
         return match.group(1)
     else:
@@ -757,7 +757,7 @@ def parseDiffTreeEntry(entry):
 
     global _diff_tree_pattern
     if not _diff_tree_pattern:
-        _diff_tree_pattern = re.compile(':(\d+) (\d+) (\w+) (\w+) ([A-Z])(\d+)?\t(.*?)((\t(.*))|$)')
+        _diff_tree_pattern = re.compile(r':(\d+) (\d+) (\w+) (\w+) ([A-Z])(\d+)?\t(.*?)((\t(.*))|$)')
 
     match = _diff_tree_pattern.match(entry)
     if match:
@@ -918,9 +918,9 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
             if len(result) > 0:
                 data = result[0].get('data')
                 if data:
-                    m = re.search('Too many rows scanned \(over (\d+)\)', data)
+                    m = re.search(r'Too many rows scanned \(over (\d+)\)', data)
                     if not m:
-                        m = re.search('Request too large \(over (\d+)\)', data)
+                        m = re.search(r'Request too large \(over (\d+)\)', data)
 
                     if m:
                         limit = int(m.group(1))
@@ -1452,7 +1452,7 @@ def wildcard_encode(path):
 
 
 def wildcard_present(path):
-    m = re.search("[*#@%]", path)
+    m = re.search(r"[*#@%]", path)
     return m is not None
 
 
@@ -3048,7 +3048,7 @@ def stripRepoPath(self, path, prefixes):
             # Preserve everything in relative path name except leading
             # //depot/; just look at first prefix as they all should
             # be in the same depot.
-            depot = re.sub("^(//[^/]+/).*", r'\1', prefixes[0])
+            depot = re.sub(r"^(//[^/]+/).*", r'\1', prefixes[0])
             if p4PathStartsWith(path, depot):
                 path = path[len(depot):]
 
@@ -3603,7 +3603,7 @@ def importP4Labels(self, stream, p4Labels):
                     commitFound = True
                 else:
                     gitCommit = read_pipe(["git", "rev-list", "--max-count=1",
-                        "--reverse", ":/\[git-p4:.*change = %d\]" % changelist], ignore_error=True)
+                        "--reverse", r":/\[git-p4:.*change = %d\]" % changelist], ignore_error=True)
                     if len(gitCommit) == 0:
                         print("importing label %s: could not find git commit for changelist %d" % (name, changelist))
                     else:
@@ -4182,7 +4182,7 @@ def run(self, args):
                 if len(self.changesFile) == 0:
                     revision = "#head"
 
-            p = re.sub("\.\.\.$", "", p)
+            p = re.sub(r"\.\.\.$", "", p)
             if not p.endswith("/"):
                 p += "/"
 
@@ -4291,7 +4291,7 @@ def rebase(self):
             die("Cannot find upstream branchpoint for rebase")
 
         # the branchpoint may be p4/foo~3, so strip off the parent
-        upstream = re.sub("~[0-9]+$", "", upstream)
+        upstream = re.sub(r"~[0-9]+$", "", upstream)
 
         print("Rebasing the current branch onto %s" % upstream)
         oldHead = read_pipe(["git", "rev-parse", "HEAD"]).strip()
@@ -4320,8 +4320,8 @@ def __init__(self):
     def defaultDestination(self, args):
         # TODO: use common prefix of args?
         depotPath = args[0]
-        depotDir = re.sub("(@[^@]*)$", "", depotPath)
-        depotDir = re.sub("(#[^#]*)$", "", depotDir)
+        depotDir = re.sub(r"(@[^@]*)$", "", depotPath)
+        depotDir = re.sub(r"(#[^#]*)$", "", depotDir)
         depotDir = re.sub(r"\.\.\.$", "", depotDir)
         depotDir = re.sub(r"/$", "", depotDir)
         return os.path.split(depotDir)[1]

base-commit: 564d0252ca632e0264ed670534a51d18a689ef5d
-- 
gitgitgadget
