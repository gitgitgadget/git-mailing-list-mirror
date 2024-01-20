Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5771172D
	for <git@vger.kernel.org>; Sat, 20 Jan 2024 18:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705775155; cv=none; b=Lbij4v9S+JwV6rfstI4+lxI/WgBjHsEOHiVTMTx3xlkKu0ztn5+xElDGx71ejPcX+45IDn8izK34TaMMDJtltTaYHoZ9yXSroY55fYVUjS1mmXhkfocVBRxRZLjaMzSm7tMJaBfv9cGUMSZFgxeY5noT0tkPQKHdKndhXlFxm+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705775155; c=relaxed/simple;
	bh=gaiXBLn3VpI958R88QSBTG0wQjbUslToU2eaIac16mc=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=lNZnYueUenOyIsj89Lb8Vfo1FxSVpO7lxQUMVMWHij8pRx1OMBDsBIqE9YWfA7sYPGIsrnVs8kSvvCjY73dh9DK8q3umn7gihtf2vB6HdSH3MUsARZBBOfXdn54K2SQIDo/AfpoNnBSlaa+ZpWJrNmHDCbr1x3/jsacKAqaYQiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xe/+sG0s; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xe/+sG0s"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e5afc18f5so20473805e9.3
        for <git@vger.kernel.org>; Sat, 20 Jan 2024 10:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705775151; x=1706379951; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Fd/BvZWrlj92u0bynMA5DwtkOVSlNbRr7wHO9gh5ba8=;
        b=Xe/+sG0swvFoy7kEZB51HyIRm3gpAzSXx+62UPP9xDy7E4k68z5eOVk4mQxtG92ZyO
         LauB3wjEKYpzEqMbCHn2pTnVJ8R4zO+G3Ri+kynrXWVjKjkQsPZKq/c5Tc3J4j1vb/aK
         5191wfKj+vZpdmc1p03V9y0Erm0U1Z4G74kVrQamVccPoOWL4TdxJVSt1t0cFYt38KsY
         STpbZS5rXQomfG/Z1UwWy1wfZwwDGHBOM9YDlTHsLSk1MHB68c3/4KHL72Qo6/8x3uuI
         at8OLiKrHpYXJqbyBgzD+vGXBkxAl47iDsDtx3zlgdPxLixbJSQI8esPMUUUPBVDM5ug
         BFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705775151; x=1706379951;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fd/BvZWrlj92u0bynMA5DwtkOVSlNbRr7wHO9gh5ba8=;
        b=j/TzKSwqEtQUaazC0JU3ewlNOZoR4pSiocN4q0yWaF7CO81rTExcl32tq2vLnGb2fd
         74wM7uw3K4Pesd8JZYP+QzFyhe6v/SMRT/WFkPyIbUbQ72ddILYIeRTGO1BhoSjbM7XS
         zCOgCqXRb3509p4G00SfN8CK019w1XHdhsdKVyQ8p0YYWlgpHTadO9A3EZI6OSg8evz2
         KI4RWCroErUiGK1+/dljG1UuO09bXLiDICW2y75IbMzraMhGFcN8Wpmwc0HcwYzgL/I0
         jRhnlo5oc1AQTCh4wdzUH52g1ZUCwIf0OfOQRsUbMhmrhhVqdlr9RBKzQUiFFjOhVM+t
         8o3Q==
X-Gm-Message-State: AOJu0YyUhghNsPbbOcungay5/ad2z1HD22VkYMdY0sS24zYBCPyMWg0S
	dcxIUJd/5JUiQYeSy/tCO9LV4X4iNkLJKDFFaFqIYOs81kiaB3vKyflxiUAK
X-Google-Smtp-Source: AGHT+IF4wpowv8KcsmhRG0lLEdRkyVQkm/ab0fyz2Zbdt9/zRuT6MrfIr1XC67Jt0ds+Uo7dsM0s/w==
X-Received: by 2002:a7b:ce18:0:b0:40e:4ca6:1017 with SMTP id m24-20020a7bce18000000b0040e4ca61017mr1047735wmc.57.1705775150827;
        Sat, 20 Jan 2024 10:25:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m35-20020a05600c3b2300b0040e541ddcb1sm33488265wms.33.2024.01.20.10.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jan 2024 10:25:50 -0800 (PST)
Message-ID: <pull.1639.git.1705775149642.gitgitgadget@gmail.com>
From: "James Touton via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 20 Jan 2024 18:25:49 +0000
Subject: [PATCH] git-p4: use raw string literals for regular expressions
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

Fixes several Python diagnostics about invalid escape sequences.

Signed-off-by: James Touton <bekenn@gmail.com>
---
    git-p4: use raw string literals for regular expressions

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1639%2FBekenn%2Fp4-raw-strings-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1639/Bekenn/p4-raw-strings-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1639

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
