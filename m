Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620AA43637A
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 16:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770307518; cv=none; b=Dih69Rnt1Gue0PLunoNzwio4It0CS9yt7VdgJurrnJwEbLe3Zt51mPvMwuqLQ3RhJrw44EWwFHelOafSt21OOrKz5DsrNTzZiXHSXrNdJQnBUwDZgd0gmzk9RmABT64PFiSUxtySRQyF5kq4gB/tZhQ3mscAI8YCGUWA8J4mHt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770307518; c=relaxed/simple;
	bh=Vfk3ov7VvCTgyo2JNeIjSbKOSH2wrN7qENw47zjQlTo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=iuN6yO9yKIHN/RIne0oCtv3GWhA05ZzIBQo39LU06n0lre74LPncFO2VymKYMKSxihtwHJRjWSj4r4zlybsvQ9NJ3I8cNwU7N6//AvF+MzaZBgkioXqv/CN5em+uHhpAcLSG3eFr1u2i79cVogLm6HJhJVAQOSZICErMEdBE5nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fc7+CLQJ; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fc7+CLQJ"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-126ea4b77adso1291721c88.1
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 08:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770307517; x=1770912317; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pErFi2lUNvckVQduw/oMSNllUSe/lZnNxBmk27TPvZk=;
        b=fc7+CLQJ45qn7dAR2JrwhlIp7X13q6MpXgxyEA0txmIW5j2csOBcIT95GdJ79IxFMe
         ppATJdBVTzwdhpcmCYAm44fBAvOWNv0HLLT8tprc3eRqE7E2FoDnlFcSypRvdmXJ3Que
         SpndCWYaujLT1wQFwywWhNk7TeaUzpicVBI3HbzjBVpwfxVWhn3mj+ufmfAJZ3+m/8Kh
         Vpz15EWSj1ZlVzxwTUU8zgPW7fNGTyihsSN3G14gJaQE1zWIQ//7p3cWIDome2D7fuMt
         SVwTlgLowFu0PDvYMfggq2WXDd4Bs2b8MVrCMmq1e4louwku32D+RX8/7N7NtkBu5L4c
         lDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770307517; x=1770912317;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pErFi2lUNvckVQduw/oMSNllUSe/lZnNxBmk27TPvZk=;
        b=uzPWq11y0s1aSTDRcij0rTAVd26nCXTDsNyUq7BqCoHXWgq10z9yWLc2GXjqV4lrzn
         hYBPfktNcSZSsiU8duKCixkzaVaRzChstgWkc0JL7v/E2GL2qywJEKksIToPqknnvxUa
         Ju0cYcxkWGFJtK+nWnGidHZhyJEBPdDtfYIVRpuAOCAKls7LooQn0SCaTcU6sQWO/7Yh
         BjzWWTsSBtn98i0Ih1KGpxRbVTt+MZXqg8Wp/Dl/4zsTtd/7/oHN230Dpkr34XX4NbBn
         COcHMEprPIgTCRuGGKfreP9CtW+G03Ub0s/d+7PgehX/CylFfJ4nBl0tkG/BA+8/Rlso
         NiFw==
X-Gm-Message-State: AOJu0Yxcu3rZBcULgQeCpaDnBWpO+FYVvpi6yhRYMbPeRjZG9LHw0gR9
	MDlueNlF+UXJCMom8bSTIb5aT9Oz/PfWSzXznVSit9aobfQOjChFAss05qfH4lvH
X-Gm-Gg: AZuq6aKeBQTeiGu3PRMrDC5o3jL05aGxXsYDbExJKuv6jrWvrO1BCB735BJMDPiLTmT
	w7au580/MzaLJzCJpHVMUyz3k1ifDHTTYTc/D6/mGDTC4R7160NoUCcEzNQF8pNulvGGez6T9We
	1WPTstnVeT9HxnmvVQspN8S/AyWD+Apsw4Hl/QloZHkDn8x4O3sHetPXWi3dCirsVXbWX8O27Uz
	1d1WxBo8b792DfOMg1IJAPcgFednyADjkWaJ9Uo6VzO+xkzib3VoAbn6h1rlZIm52sxHjv8npbR
	ERkO2oTePULBAvYcxRJpR6ndHcKRiXHUMjL1jxvX0nI091EXoYHORXqRjWLhySalExftGgN16LB
	E4a72TFwc+JLSb1bHR22cMzH+2TqzaaEgV+GbiTiokBKZIayD/FpiafEKoYUHRaFrUGKU4sAjUY
	eYAltZkeRfOtLpEdo=
X-Received: by 2002:a05:7022:92a:b0:11b:9386:a37d with SMTP id a92af1059eb24-126f48d6035mr2594382c88.44.1770307516749;
        Thu, 05 Feb 2026 08:05:16 -0800 (PST)
Received: from [127.0.0.1] ([172.182.194.212])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-126f5030e22sm4879950c88.10.2026.02.05.08.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 08:05:15 -0800 (PST)
Message-Id: <7ccd0a9a6d89decaa5856494a184c71bc0d678e9.1770307510.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2040.git.1770307510.gitgitgadget@gmail.com>
References: <pull.2040.git.1770307510.gitgitgadget@gmail.com>
From: "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Feb 2026 16:05:09 +0000
Subject: [PATCH 3/4] trace2: refactor Windows process ancestry trace2 event
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
Cc: gitster@pobox.com,
    stolee@gmail.com,
    johannes.schindelin@gmx.de,
    Matthew John Cheetham <mjcheetham@outlook.com>,
    Matthew John Cheetham <mjcheetham@outlook.com>

From: Matthew John Cheetham <mjcheetham@outlook.com>

In 353d3d77 (trace2: collect Windows-specific process information) we
added process ancestry information for Windows to TRACE2 via a data_json
event. It was only later in 2f732bf1 (tr2: log parent process name) that
the specific cmd_ancestry event was added to TRACE2.

In a future commit we will emit the ancestry information with the newer
cmd_ancestry TRACE2 event. Right now, we rework this implementation of
trace2_collect_process_info to separate the calculation of ancestors
from building and emiting the JSON array via a data_json event.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 compat/win32/trace2_win32_process_info.c | 50 ++++++++++++------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/compat/win32/trace2_win32_process_info.c b/compat/win32/trace2_win32_process_info.c
index f147da706a..aceea05430 100644
--- a/compat/win32/trace2_win32_process_info.c
+++ b/compat/win32/trace2_win32_process_info.c
@@ -3,6 +3,7 @@
 #include "../../git-compat-util.h"
 #include "../../json-writer.h"
 #include "../../repository.h"
+#include "../../strvec.h"
 #include "../../trace2.h"
 #include "lazyload.h"
 #include <psapi.h>
@@ -32,12 +33,7 @@ static int find_pid(DWORD pid, HANDLE hSnapshot, PROCESSENTRY32 *pe32)
 }
 
 /*
- * Accumulate JSON array of our parent processes:
- *     [
- *         exe-name-parent,
- *         exe-name-grand-parent,
- *         ...
- *     ]
+ * Accumulate array of our parent process names.
  *
  * Note: we only report the filename of the process executable; the
  *       only way to get its full pathname is to use OpenProcess()
@@ -73,7 +69,7 @@ static int find_pid(DWORD pid, HANDLE hSnapshot, PROCESSENTRY32 *pe32)
  * simple and avoid the alloc/realloc overhead.  It is OK if we
  * truncate the search and return a partial answer.
  */
-static void get_processes(struct json_writer *jw, HANDLE hSnapshot)
+static void get_processes(struct strvec *names, HANDLE hSnapshot)
 {
 	PROCESSENTRY32 pe32;
 	DWORD pid;
@@ -82,19 +78,19 @@ static void get_processes(struct json_writer *jw, HANDLE hSnapshot)
 
 	pid = GetCurrentProcessId();
 	while (find_pid(pid, hSnapshot, &pe32)) {
-		/* Only report parents. Omit self from the JSON output. */
+		/* Only report parents. Omit self from the output. */
 		if (nr_pids)
-			jw_array_string(jw, pe32.szExeFile);
+			strvec_push(names, pe32.szExeFile);
 
 		/* Check for cycle in snapshot. (Yes, it happened.) */
 		for (k = 0; k < nr_pids; k++)
 			if (pid == pid_list[k]) {
-				jw_array_string(jw, "(cycle)");
+				strvec_push(names, "(cycle)");
 				return;
 			}
 
 		if (nr_pids == NR_PIDS_LIMIT) {
-			jw_array_string(jw, "(truncated)");
+			strvec_push(names, "(truncated)");
 			return;
 		}
 
@@ -105,24 +101,14 @@ static void get_processes(struct json_writer *jw, HANDLE hSnapshot)
 }
 
 /*
- * Emit JSON data for the current and parent processes.  Individual
- * trace2 targets can decide how to actually print it.
+ * Collect the list of parent process names.
  */
-static void get_ancestry(void)
+static void get_ancestry(struct strvec *names)
 {
 	HANDLE hSnapshot = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
 
 	if (hSnapshot != INVALID_HANDLE_VALUE) {
-		struct json_writer jw = JSON_WRITER_INIT;
-
-		jw_array_begin(&jw, 0);
-		get_processes(&jw, hSnapshot);
-		jw_end(&jw);
-
-		trace2_data_json("process", the_repository, "windows/ancestry",
-				 &jw);
-
-		jw_release(&jw);
+		get_processes(names, hSnapshot);
 		CloseHandle(hSnapshot);
 	}
 }
@@ -176,13 +162,27 @@ static void get_peak_memory_info(void)
 
 void trace2_collect_process_info(enum trace2_process_info_reason reason)
 {
+	struct strvec names = STRVEC_INIT;
+
 	if (!trace2_is_enabled())
 		return;
 
 	switch (reason) {
 	case TRACE2_PROCESS_INFO_STARTUP:
 		get_is_being_debugged();
-		get_ancestry();
+		get_ancestry(&names);
+		if (names.nr) {
+			struct json_writer jw = JSON_WRITER_INIT;
+			jw_array_begin(&jw, 0);
+			for (size_t i = 0; i < names.nr; i++)
+				jw_array_string(&jw, names.v[i]);
+			jw_end(&jw);
+			trace2_data_json("process", the_repository,
+					 "windows/ancestry", &jw);
+			jw_release(&jw);
+		}
+
+		strvec_clear(&names);
 		return;
 
 	case TRACE2_PROCESS_INFO_EXIT:
-- 
gitgitgadget

