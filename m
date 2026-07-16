Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5135D280CC1
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 05:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784180164; cv=none; b=je5Q9ok2cpDzoJvEwj8B5fdi8GluOOI5FqzOWqKCgatS+hHotJQ/+NKEaonQgKeJyyCe9UNSFzHRuKfgRgISoJacUbuHn0nSCw4hs/EU2jxJfDrrXYft19qruQWhMB5r4U3zeIMzGjEACownu1tW1qA/l0bPRYUjEKfxr7c5j/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784180164; c=relaxed/simple;
	bh=AGaVUt2ZvOIQWdxBBzj9tl7Jia1CVvKOpLtme1R4HMY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Bz0ZeD42g5DIX4J67z5X8EmwntC+qQjxCVd9VPXoZOq5T5pj0YU2dgdnTdaeN4+CO9faY0j+D7ALBpD8Hh5v89113njNe3O4/4EeXnI6deqx9jf+oqr5Jhl2rlBu4dvpmOBJXkBMECQOZRbjW2b7g/yOyAllgujhg0+Xr8vDQ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ieuOTbJC; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieuOTbJC"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92eafc94c9cso494604085a.0
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 22:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784180162; x=1784784962; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=S87sMjbartAVp6uh7+kgSMGxXIEO4OaNWMLuC3VscSk=;
        b=ieuOTbJCgrbPqHKsL8qT3kyEqt0PtQ3H/Wv6dfQF4O2z0dwli9YA8YpBW/pOZW7LIF
         RvPMoV5l/eyaG3OvSNRi2BG/lcSdkYUw0VVmMzOzkiIbcPlhdTL5AIQ1BHeYoySjpU+j
         EEyRi41I64KtMPjxve7iRmOxxz2E6xX15hoLYSSTaSVL/pcgpvIDLk7jY+C/b355v0O7
         o2ZYCGPa62lqFycW0irg4xibmnLWSxEpBcsNlPsZkkgxO4B1OPBt1bQsm2wpxOw+WN2A
         1T6ZMw3hPocfXywn2w/oYHqovyEATm8m9jHRTwAo8qgMwuNCRe4JiCvSMXZQpzh1nr6e
         vmtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784180162; x=1784784962;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S87sMjbartAVp6uh7+kgSMGxXIEO4OaNWMLuC3VscSk=;
        b=GAFW+GhHbiASlALr5r8cwBByKBAGvBu1jmGs/6c8jg551b+diCvniNkIMQvHb7H3t3
         /Ffqww22W2poh+pTo8SLslpbvDNBCqDlPB21len9bueUd1k4Fu0jPB4ZjhKTXhH39z8j
         Cqh+/Og2SVZudphK6XgyDQJxPeUTfvzLijivqro0J/cgLoANeYMKlr99auIQmPNe0t8y
         qLNxnZExF0oOEBIZJxZwngxZcmk81SkGHwc2Ma42/OE3NMhM3r3LlUQrHFSrup+jH9oU
         zBjD+MBYDqw5NvmbD/U16lzLJ96oduUVxlywZqAYJ02VVc9ZyJJhniXIye5Pdl7Iujia
         dZCg==
X-Gm-Message-State: AOJu0YxRSgakWnD9FyTgqDKiXSZwShTdzDXc+XNV0tyfP3Qvo8pnELMv
	rMAOlfcKC0l9YgPdoSkiR70xwnt/Fs2TTg4mqqKBwmLZsdgzrUVzI0oWDZPSMMsx
X-Gm-Gg: AfdE7cm8Z43k8LYWfwsRWOIjHiUhBExDjpuW2TpFBlzXEmc6hFDhv0GrATBV5uiTsA1
	BXc92wa1qtVeHuj9p2V6taYwWmr4IRtmk5/3bCHNARvRi48Zfh+OTwmKiNPhNxCKIaP8/nx27BU
	pXJVMV12pU3jwCPRVxHvmWUv33fkHlaOfF3dTYwua5XyylcrRGL+0T/uK2R51uGptxlQGlC8g98
	PkVcOMxtAlcoAOA3TaqyWu4jWIo+1PKYZqQAqy4q83Dn5B78Ip99gItuGamUk9nyHD8CpgYTZRb
	nwSeC+rk4J1fEyK8VjQbNnY9CBWhmzSpaB3kD5Vb7YSGPq04+SOY0kfjlePJac8jjigGjYJHLu+
	fdaCudmNhdF/EtxnDuh+sst+ParnRC5x0bUcoi71vOWy0/Pag65uZvWi/8wn59xcMTKY3tNfLI9
	DOJjG024yl0Ps7
X-Received: by 2002:a05:620a:4149:b0:92f:196:20a0 with SMTP id af79cd13be357-93086c228bfmr983892485a.65.1784180161949;
        Wed, 15 Jul 2026 22:36:01 -0700 (PDT)
Received: from [127.0.0.1] ([20.51.199.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b4a082sm1839779185a.7.2026.07.15.22.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 22:36:01 -0700 (PDT)
Message-Id: <3fd365835d004c3b1463d8abd18dc7bc171466a0.1784180159.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2335.git.git.1784180159.gitgitgadget@gmail.com>
References: <pull.2335.git.git.1784180159.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 16 Jul 2026 05:35:57 +0000
Subject: [PATCH 1/3] bisect: read run output from the open descriptor
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

"git bisect run" redirects each step's output into BISECT_RUN, then
prints it back by reopening the file by name. Read it from the already
open descriptor instead; this behaves the same and no longer needs the
file to be reachable by name.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/bisect.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/builtin/bisect.c b/builtin/bisect.c
index 798e28f501..69ea14b1b6 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -178,17 +178,13 @@ static int append_to_file(const char *path, const char *format, ...)
 	return res;
 }
 
-static int print_file_to_stdout(const char *path)
+static int print_fd_to_stdout(int fd)
 {
-	int fd = open(path, O_RDONLY);
-	int ret = 0;
-
-	if (fd < 0)
-		return error_errno(_("cannot open file '%s' for reading"), path);
+	if (lseek(fd, 0, SEEK_SET) < 0)
+		return error_errno(_("failed to rewind BISECT_RUN output"));
 	if (copy_fd(fd, 1) < 0)
-		ret = error_errno(_("failed to read '%s'"), path);
-	close(fd);
-	return ret;
+		return error_errno(_("failed to read BISECT_RUN output"));
+	return 0;
 }
 
 static int check_term_format(const char *term, const char *orig_term)
@@ -1291,7 +1287,7 @@ static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
 		else
 			new_state = terms->term_bad;
 
-		temporary_stdout_fd = open(git_path_bisect_run(), O_CREAT | O_WRONLY | O_TRUNC, 0666);
+		temporary_stdout_fd = open(git_path_bisect_run(), O_CREAT | O_RDWR | O_TRUNC, 0666);
 
 		if (temporary_stdout_fd < 0) {
 			res = error_errno(_("cannot open file '%s' for writing"), git_path_bisect_run());
@@ -1307,9 +1303,9 @@ static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
 		fflush(stdout);
 		dup2(saved_stdout, 1);
 		close(saved_stdout);
-		close(temporary_stdout_fd);
 
-		print_file_to_stdout(git_path_bisect_run());
+		print_fd_to_stdout(temporary_stdout_fd);
+		close(temporary_stdout_fd);
 
 		if (res == BISECT_ONLY_SKIPPED_LEFT)
 			error(_("bisect run cannot continue any more"));
-- 
gitgitgadget

