Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327B24A0141
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 15:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789052795; cv=none; b=EDMRAG5Lom32pPt50M58hLTjc8ktidP60ekT4+MKWUeZInc0y6mbg5G7MqNRBHkWp4F/zGa6ZCNH7X20V1Za3UaG/lTWrJLFAUIbGuBs0SHgRTpEw7iPUsa7Qc3ak3BTsAGFtbInQQs+6K+wMXm7MsGBR23/IKuUafXdRflH/4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789052795; c=relaxed/simple;
	bh=08L21RAwPUDWcT0JYmqzBCCp1BvSU/OYCK5YGYhNgGI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J+Sq/QW+zRp3HgXwPrUZgJlGHqW+CwWGKM/Q8PBOkF3sml+/5g1VOvtEXxu4dbk0OXsUgP0fVbbscKrvmjVPTrjzkueHsg+C+p6MhmAh9Q7jSRfAFZ22zCpBnVxPCEUbT6LfV1pTeDRgfTlnB9Hrbdbt2lr0GeNV73KU1mTGxwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HbAguZPY; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HbAguZPY"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49d097b4939so8036755e9.0
        for <git@vger.kernel.org>; Thu, 10 Sep 2026 08:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789052788; x=1789657588; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l6cRJZlrllYV4SBcY124i9DMGxE30prndBtbNzE1PI0=;
        b=HbAguZPYsfEEHa+lU5wJU2/lRHoVA4dpqEZ70XX1zzYJDf2MlqNyPbxJliecj3/2xW
         3g++T12S+NQRaEdDJKOaZlc4SR0Oe0JtBhzPIOvezSN0IWI4IdW2NN2nt+amNMKVMRFx
         y9KbzH/pqUCA1J0BoaCyB4ocuzobbTh18mkC/iCIiwQXUVeFEfOVP/o83+Vka4vINe2+
         61B7CdGrs5iPUhy2LkKtGwBWF+7oHenaNSBTHo4fnQ6o/U7MdlPtz0Fo6CeFXq7zT9NV
         JnmclKFKFOZyLjBDIddVxD9AWKNbXxjqoxmd2CMguTYXcNV9w8wVEwAv4HwL8vOZky94
         CgMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789052788; x=1789657588;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l6cRJZlrllYV4SBcY124i9DMGxE30prndBtbNzE1PI0=;
        b=Nmfz6sYoL1v/ULotaR05INsREOWSr4av+wvXBw508VLFChkdNGmUQf24lBdQqta4+m
         DALIGht0jK5Q0AQLjRC+I5nPERwFOoG7QSgvDie9FHVRjelLt0aSnar/UdNt4eNUxfwD
         KjByL/54z/DNO4f/c8Wwft5pqbknb0ZB/Gcf2xYk0IcSztIVvRBpF4HXZswXA5DH2u2V
         +iYz7c3J5mw3/4itKMt3YqGS1uwCvVd1f1HtkhJWa+a0VPekyM3x3pC5O2iCFcehNhez
         53BPoJG5mgC1reG5PqwWn1688Uxb5wQcYxUTd6NvlzCFV9D8YbeG3N2vLQJvw78n4E4d
         ctKQ==
X-Gm-Message-State: AFuF++mbcwsMjWw9AT6xUI3gnT32AGCrqTVuwhbdIERghGKQvK+W8bmT
	paDRtB4KxLaEwbe3VkPA3DSG0/s/hfitwdmuzfdzXTYuE0qIktrWY5SkPK2mCzMzmoUA2bvLdtX
	uVR0jpKs=
X-Gm-Gg: AYBFou1EtYlRlGN1256UA5ewcqtPRwacFckgX6FQGH46LC7iROzO0UAVXH3KWoChrM2
	xRfq/F5oBwSf6g92q9KTCWeAhYM3+qiNmTR69e8jce+z3H53G+LUnfn2Vs2rmwuFydKOUpvnCY9
	pHdL2Xi+88OBmCnHNFGVBZIF+nyZju8o+pPOc6VzIk6NDjkq2BGXu3XV+MID5w5A2BCEr0AcRAM
	ODG1zVncn+MOryZ14/CyIXfDTrWlXLskzNIrfRRgHiNGig964Fhs3wOOw/25yNyconJRHQPnQtA
	JS17eWJ28Qs/82tRI6Y8L80l1brr6PnHqbL5t6o7EslfQEwwV8uzeA3TrwjGklMcD2+aIE2VThv
	yovGQU6WXGgGAp5ad8hKJR1TkZtDDL6i8Rj9aED6D26ehxLWCNAQCM6IAA1lIP7MxGqgxxA2sr8
	OajSexrclAZUcMtxp9AJ8G4cMxuno9sirWjJSi5ldI8/NED81HenjvxmBspBi/Xi2ysLsn0DqS
X-Received: by 2002:a05:600d:644e:10b0:49d:1916:59c7 with SMTP id 5b1f17b1804b1-49d258cdb0dmr55464755e9.7.1789052787725;
        Thu, 10 Sep 2026 08:06:27 -0700 (PDT)
Received: from localhost.cz ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26d4e3f3sm85327375e9.15.2026.09.10.08.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 08:06:27 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jean Delvare <jdelvare@suse.de>,
	Elijah Newren <newren@gmail.com>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>,
	Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH] merge-ll: Cleanup merge driver temporaries after interrupt
Date: Thu, 10 Sep 2026 17:06:07 +0200
Message-ID: <20260910150608.1867930-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When there's a long(er) running merge driver helper, the user may just
decide to terminate it with Ctrl+C. That sends a signal to the driver
prog and to the whole process group as well, including the git merge
command proper. Hence the cleanup code would not run and .merge_file_*
files are left behind.

Transfer the idiom [1] from editor.c where the (process group) signal
delivery is approximated from the return code of the child process and
do the cleanup before going for good.

[1] Note: when the helper SIGINTs alone, it'd tear down the git-merge too.

Reported-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 merge-ll.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/merge-ll.c b/merge-ll.c
index ef5287dee8..bee30fb5dd 100644
--- a/merge-ll.c
+++ b/merge-ll.c
@@ -17,6 +17,7 @@
 #include "quote.h"
 #include "strbuf.h"
 #include "gettext.h"
+#include "sigchain.h"
 
 struct ll_merge_driver;
 
@@ -201,7 +202,7 @@ static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
 	struct strbuf cmd = STRBUF_INIT;
 	const char *format = fn->cmdline;
 	struct child_process child = CHILD_PROCESS_INIT;
-	int status, fd, i;
+	int status, fd, i, sig;
 	struct stat st;
 	enum ll_merge_result ret;
 	assert(opts);
@@ -240,7 +241,13 @@ static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
 
 	child.use_shell = 1;
 	strvec_push(&child.args, cmd.buf);
-	status = run_command(&child);
+	status = -1;
+	if (start_command(&child) < 0)
+		goto bad;
+	sigchain_push(SIGINT, SIG_IGN);
+	sigchain_push(SIGQUIT, SIG_IGN);
+	status = finish_command(&child);
+
 	fd = open(temp[1], O_RDONLY);
 	if (fd < 0)
 		goto bad;
@@ -262,9 +269,15 @@ static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
 		ret = LL_MERGE_OK;
 	else if (status <= 128)
 		ret = LL_MERGE_CONFLICT;
-	else
+	else {
 		/* died due to a signal: WTERMSIG(status) + 128 */
+		sig = status - 128;
+		sigchain_pop(SIGINT);
+		sigchain_pop(SIGQUIT);
+		if (sig == SIGINT || sig == SIGQUIT)
+			raise(sig);
 		ret = LL_MERGE_ERROR;
+	}
 	return ret;
 }
 
-- 
2.55.0

