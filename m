Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32A648A2AB
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 16:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780590270; cv=none; b=rcEOwNSBaGoCGpIlGA0uT1anumQ8vtnLDDctCM8tNHbdWIdnx1Kr1keKroxvJ3gMbV+FqVY3DBj7jzRhtXboioxgkUx2lamp9MAlTU6KF9Hyt4gL7bFRddk3+nNnWPLJmeFkkJ3umHJiUZt8SFqxVkzRobMF+NsrX0e1ZwdoiC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780590270; c=relaxed/simple;
	bh=NfbJ+TGx6plFOSm0tB46lZi+mspKO6MNzhm5E6DOoBE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HWJOJD5vh3GIlDcgYoyGjR6cnELIU9b96W3SluJWQh5MWPs5n3MpA/BgkOuO5t5si5gQfiBZuCIm1Cbr0F+EKM6rRwGrv3PgU41yRpGoK2eP8cH0LuaorOWx9M3hrGusWG/BdLEPCVZFo5jmHyzp4chm6XRvIYe6E7YlgYXBc5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMpnv3u4; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMpnv3u4"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1363fe80fe8so1356034c88.0
        for <git@vger.kernel.org>; Thu, 04 Jun 2026 09:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780590264; x=1781195064; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXN6BtH3w8PInWcITKkOKZ2ji7qxyYavdXlsJERJLFs=;
        b=aMpnv3u4trY5qtWl78iELeZsk9KAZLN4gV7qocX+IHktyRA2h70b3DFV+TlVPZQmyC
         CsjNFidugyxpdesrjkDmdj1QJZxIZTFWsDYBdoL00kdbax6Oso14icAzijnxb0rELTUI
         VoKkGG8LCkYnIKL66MDpvQYuOUO9XBstK5JHzjALo2PAef0EKdjLmTWObZKwGldUKmWx
         aDhhcV/B1lfNe+4VtaEi31oDytGBksJpwANJ006aRcA60G80M7nE8lBcQ8/Mu7hDK+f5
         nnsbL/LBBPIlF2HvW+CBLuhIDvnwOQKJM55sH5DuE4B7emAesJDQgXDvEKe22fCGgH3Q
         IHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780590264; x=1781195064;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HXN6BtH3w8PInWcITKkOKZ2ji7qxyYavdXlsJERJLFs=;
        b=YjaLfXh3BD1qZ5BJGXAwURou+irNIKbjzxRbm2zg+21j35EdkmJTSiPAfrMlYoceVy
         w6qT/ixfca0nozcrNiqSmkDeGeUNVfRE7Jlryy9OhvolL0bI03LfcmaETegwCA9TcFEf
         Nu+jSgBa6Z5kU6t2W288thuFqy+lN4/NzUSAXXPCvCh6B7+iRGjKoPOUVBIS1blUl6s4
         bKu4TU3F7U7KrJqzSHTSZlS37g8/Inj5Is+ybV4RzBHK/Co2k3lDP4r5IVyajdmhGm4j
         29aPvwTTDX1uQ7Lf95w0TSDKHNuYgff34aGCP0sjMCCkYGqg0/0DkY1+NIU32L3M0fbK
         Suhw==
X-Gm-Message-State: AOJu0YwuWeFU9C/rbyTDvP/YXExHSYyFtG3ll9I80Fd46e9K57P4W95Q
	chqwLu83EIFCHG9SruQx2aXkuaehpyj7Hs4pDyN2m8d/l6r7YhbvOiVwaQyTiw==
X-Gm-Gg: Acq92OEObt3Ci73/9PMNfHgeubkWiQl50KCnPu9a5CvqHwSpRsP/8f/fDd2CdnmpEXf
	Ig+r01BAgDZP/ywfLYS4kUJCCzav+bEHhSqrPqtKGRkqnYk0Gi/CEb/vuThGo+GhM8KXuqQ8F4J
	hSTGKQGgiyb+L5HcQgaDSrIJ2v3olm6I4X0ePHyABgi7hAqVRpolXVctG+a5KwyNhChIAp52qxQ
	LhdmqIEo3iwAI7kXek6ufuQYC9onrtxabIZB+oiAk+ZnMMyyXEJ8CrbLA/2Q1YqGwRb/vM6bM95
	cR9PVx4TJPnEm9TuGfglVXk92Bxc8BrNdJo+CEqcqhddDxcuh2j/F4Wpar5pvTrl9qIuSBrb6kr
	Entnntkrqo2V/wQDdsENhaT6CLxSo/1arn8/jdpSuSNjoRn9pifONj9PTHgl47I0eEQvdh1WyLk
	EGSW3CVy3psVTgApVreJEWmh+onSqvSvL8r7Ka
X-Received: by 2002:a05:693c:68ca:b0:304:5db8:da95 with SMTP id 5a478bee46e88-3074fb8754bmr2321105eec.23.1780590264271;
        Thu, 04 Jun 2026 09:24:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.233.101])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db85f60sm7265145eec.8.2026.06.04.09.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 09:24:23 -0700 (PDT)
Message-Id: <8d6f16406415ab08aa3b188ae67ec03159928bfa.1780590261.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2130.git.1780590261.gitgitgadget@gmail.com>
References: <pull.2130.git.1780590261.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 04 Jun 2026 16:24:19 +0000
Subject: [PATCH 1/2] mingw: kill child processes in a gentler way
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The TerminateProcess() function does not actually leave the child
processes any chance to perform any cleanup operations. This is bad
insofar as Git itself expects its signal handlers to run.

A symptom is e.g. a left-behind .lock file that would not be left behind
if the same operation was run, say, on Linux.

To remedy this situation, we use an obscure trick: we inject a thread
into the process that needs to be killed and to let that thread run the
ExitProcess() function with the desired exit status. Thanks J Wyman for
describing this trick.

The advantage is that the ExitProcess() function lets the atexit
handlers run. While this is still different from what Git expects (i.e.
running a signal handler), in practice Git sets up signal handlers and
atexit handlers that call the same code to clean up after itself.

In case that the gentle method to terminate the process failed, we still
fall back to calling TerminateProcess(), but in that case we now also
make sure that processes spawned by the spawned process are terminated;
TerminateProcess() does not give the spawned process a chance to do so
itself.

Please note that this change only affects how Git for Windows tries to
terminate processes spawned by Git's own executables. Third-party
software that *calls* Git and wants to terminate it *still* need to make
sure to imitate this gentle method, otherwise this patch will not have
any effect.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c              |  29 +++++--
 compat/win32/exit-process.h | 165 ++++++++++++++++++++++++++++++++++++
 2 files changed, 186 insertions(+), 8 deletions(-)
 create mode 100644 compat/win32/exit-process.h

diff --git a/compat/mingw.c b/compat/mingw.c
index 2023c16db6..973049ffe3 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -13,6 +13,7 @@
 #include "symlinks.h"
 #include "trace2.h"
 #include "win32.h"
+#include "win32/exit-process.h"
 #include "win32/lazyload.h"
 #include "wrapper.h"
 #include <aclapi.h>
@@ -2208,16 +2209,28 @@ int mingw_execvp(const char *cmd, char *const *argv)
 int mingw_kill(pid_t pid, int sig)
 {
 	if (pid > 0 && sig == SIGTERM) {
-		HANDLE h = OpenProcess(PROCESS_TERMINATE, FALSE, pid);
-
-		if (TerminateProcess(h, -1)) {
+		HANDLE h = OpenProcess(PROCESS_CREATE_THREAD |
+				       PROCESS_QUERY_INFORMATION |
+				       PROCESS_VM_OPERATION | PROCESS_VM_WRITE |
+				       PROCESS_VM_READ | PROCESS_TERMINATE,
+				       FALSE, pid);
+		int ret;
+
+		if (h)
+			ret = exit_process(h, 128 + sig);
+		else {
+			h = OpenProcess(PROCESS_TERMINATE, FALSE, pid);
+			if (!h) {
+				errno = err_win_to_posix(GetLastError());
+				return -1;
+			}
+			ret = terminate_process_tree(h, 128 + sig);
+		}
+		if (ret) {
+			errno = err_win_to_posix(GetLastError());
 			CloseHandle(h);
-			return 0;
 		}
-
-		errno = err_win_to_posix(GetLastError());
-		CloseHandle(h);
-		return -1;
+		return ret;
 	} else if (pid > 0 && sig == 0) {
 		HANDLE h = OpenProcess(PROCESS_QUERY_INFORMATION, FALSE, pid);
 		if (h) {
diff --git a/compat/win32/exit-process.h b/compat/win32/exit-process.h
new file mode 100644
index 0000000000..d53989884c
--- /dev/null
+++ b/compat/win32/exit-process.h
@@ -0,0 +1,165 @@
+#ifndef EXIT_PROCESS_H
+#define EXIT_PROCESS_H
+
+/*
+ * This file contains functions to terminate a Win32 process, as gently as
+ * possible.
+ *
+ * At first, we will attempt to inject a thread that calls ExitProcess(). If
+ * that fails, we will fall back to terminating the entire process tree.
+ *
+ * For simplicity, these functions are marked as file-local.
+ */
+
+#include <tlhelp32.h>
+
+/*
+ * Terminates the process corresponding to the process ID and all of its
+ * directly and indirectly spawned subprocesses.
+ *
+ * This way of terminating the processes is not gentle: the processes get
+ * no chance of cleaning up after themselves (closing file handles, removing
+ * .lock files, terminating spawned processes (if any), etc).
+ */
+static int terminate_process_tree(HANDLE main_process, int exit_status)
+{
+	HANDLE snapshot = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
+	PROCESSENTRY32 entry;
+	DWORD pids[16384];
+	int max_len = sizeof(pids) / sizeof(*pids), i, len, ret = 0;
+	pid_t pid = GetProcessId(main_process);
+
+	pids[0] = (DWORD)pid;
+	len = 1;
+
+	/*
+	 * Even if Process32First()/Process32Next() seem to traverse the
+	 * processes in topological order (i.e. parent processes before
+	 * child processes), there is nothing in the Win32 API documentation
+	 * suggesting that this is guaranteed.
+	 *
+	 * Therefore, run through them at least twice and stop when no more
+	 * process IDs were added to the list.
+	 */
+	for (;;) {
+		int orig_len = len;
+
+		memset(&entry, 0, sizeof(entry));
+		entry.dwSize = sizeof(entry);
+
+		if (!Process32First(snapshot, &entry))
+			break;
+
+		do {
+			for (i = len - 1; i >= 0; i--) {
+				if (pids[i] == entry.th32ProcessID)
+					break;
+				if (pids[i] == entry.th32ParentProcessID)
+					pids[len++] = entry.th32ProcessID;
+			}
+		} while (len < max_len && Process32Next(snapshot, &entry));
+
+		if (orig_len == len || len >= max_len)
+			break;
+	}
+
+	for (i = len - 1; i > 0; i--) {
+		HANDLE process = OpenProcess(PROCESS_TERMINATE, FALSE, pids[i]);
+
+		if (process) {
+			if (!TerminateProcess(process, exit_status))
+				ret = -1;
+			CloseHandle(process);
+		}
+	}
+	if (!TerminateProcess(main_process, exit_status))
+		ret = -1;
+	CloseHandle(main_process);
+
+	return ret;
+}
+
+/**
+ * Determine whether a process runs in the same architecture as the current
+ * one. That test is required before we assume that GetProcAddress() returns
+ * a valid address *for the target process*.
+ */
+static inline int process_architecture_matches_current(HANDLE process)
+{
+	static BOOL current_is_wow = -1;
+	BOOL is_wow;
+
+	if (current_is_wow == -1 &&
+	    !IsWow64Process (GetCurrentProcess(), &current_is_wow))
+		current_is_wow = -2;
+	if (current_is_wow == -2)
+		return 0; /* could not determine current process' WoW-ness */
+	if (!IsWow64Process (process, &is_wow))
+		return 0; /* cannot determine */
+	return is_wow == current_is_wow;
+}
+
+/**
+ * Inject a thread into the given process that runs ExitProcess().
+ *
+ * Note: as kernel32.dll is loaded before any process, the other process and
+ * this process will have ExitProcess() at the same address.
+ *
+ * This function expects the process handle to have the access rights for
+ * CreateRemoteThread(): PROCESS_CREATE_THREAD, PROCESS_QUERY_INFORMATION,
+ * PROCESS_VM_OPERATION, PROCESS_VM_WRITE, and PROCESS_VM_READ.
+ *
+ * The idea comes from the Dr Dobb's article "A Safer Alternative to
+ * TerminateProcess()" by Andrew Tucker (July 1, 1999),
+ * http://www.drdobbs.com/a-safer-alternative-to-terminateprocess/184416547
+ *
+ * If this method fails, we fall back to running terminate_process_tree().
+ */
+static int exit_process(HANDLE process, int exit_code)
+{
+	DWORD code;
+
+	if (GetExitCodeProcess(process, &code) && code == STILL_ACTIVE) {
+		static int initialized;
+		static LPTHREAD_START_ROUTINE exit_process_address;
+		PVOID arg = (PVOID)(intptr_t)exit_code;
+		DWORD thread_id;
+		HANDLE thread = NULL;
+
+		if (!initialized) {
+			HINSTANCE kernel32 = GetModuleHandleA("kernel32");
+			if (!kernel32)
+				die("BUG: cannot find kernel32");
+			exit_process_address =
+				(LPTHREAD_START_ROUTINE)(void (*)(void))
+				GetProcAddress(kernel32, "ExitProcess");
+			initialized = 1;
+		}
+		if (!exit_process_address ||
+		    !process_architecture_matches_current(process))
+			return terminate_process_tree(process, exit_code);
+
+		thread = CreateRemoteThread(process, NULL, 0,
+					    exit_process_address,
+					    arg, 0, &thread_id);
+		if (thread) {
+			CloseHandle(thread);
+			/*
+			 * If the process survives for 10 seconds (a completely
+			 * arbitrary value picked from thin air), fall back to
+			 * killing the process tree via TerminateProcess().
+			 */
+			if (WaitForSingleObject(process, 10000) ==
+			    WAIT_OBJECT_0) {
+				CloseHandle(process);
+				return 0;
+			}
+		}
+
+		return terminate_process_tree(process, exit_code);
+	}
+
+	return 0;
+}
+
+#endif
-- 
gitgitgadget

