Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5C337F8C1
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 18:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784312861; cv=none; b=K2q3IWfc5TGT9qfpDh3v1Zd7hffjYwG6uThkRAViYmCPex44GkTLZI8FUJJzfwuiEQMF88TsuWo0UFypI6aibpxMq7F5OnY7gGzbXfwNeHa7tbNx7VWsoZqRPeDKaTy4DGFlm0975VY0KN3ySYIUa7C6ZDUAKebhRIeZkwRvqOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784312861; c=relaxed/simple;
	bh=AGaVUt2ZvOIQWdxBBzj9tl7Jia1CVvKOpLtme1R4HMY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=q4aVVSRZY9kp/dQD5TEgjwTO6ajWn3narYhhyeQGBKgeX652qavq1jaeyzS/anaITxqpwDrbUPMidw99wbMEcHnAoG5k5PcjPJWEuFL4+PMN7L3m+B3leeS/18gbfOKaiaYW4u8ZoaMzIq9f/GSJ4gJuEetQl2kMWmgpb73ahio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjXKNTI8; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjXKNTI8"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92ea24a2dbfso651883085a.0
        for <git@vger.kernel.org>; Fri, 17 Jul 2026 11:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784312858; x=1784917658; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=S87sMjbartAVp6uh7+kgSMGxXIEO4OaNWMLuC3VscSk=;
        b=QjXKNTI8czR0qANygjs2VGmD4Jh9lON/lZeOQe02lZ+0fiVdVobwlCP/iUbhR6AGsN
         tXwBhWJmWXKti7L6zM8WNGhBeC4brs0W0Wt30HMkqlXHnf0g/bwjs1Dq6QDBKDLYp93k
         5ljdr0EGIlJCsc14Uly2l/eRF3OPxsP0tStrUSHUmrwKc8cGV5vCR05krGVeYb7uV62S
         cYzpi2BM6DePEXObC7wWseLtAKxcVdOk6/KqfNX+o7wyVSiCyDvX/CEow3JMwBMEqvmx
         Y1a0NXBTbA4/BnYGPOzvfX7eoDrxno3ONbzQoRCG5v1/0zCKMFaI1+jeG9p5LiKsI8Fo
         4v8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784312858; x=1784917658;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S87sMjbartAVp6uh7+kgSMGxXIEO4OaNWMLuC3VscSk=;
        b=Jb/YPrmzWLd1B5ws9UGNs/hcyypl1vP7ktIZvvWvuCe5GZw+JwueWFt/fV+47SURoW
         NwetrgsCAltheqmZXBnaKZhLqRGAUonyK5dEDESY6unTWmWA5R1LsX2spHJF52BuNsn2
         s+1ErA3afLokxIOcKluqcDjYqeXOg98Kvd0lB+v8kTEG2exu8i3fgfNKEf8llSjJkzYv
         ydUoyCxGqfTjxMlQjrtZ96F9siRxJuNGQTAwz1d12AepPBPNmSM7iA4Oqbvr1seU7Xxx
         iCXBPZMpYGSZjfYoIvpW1Y1ZOC/Eg+yb7rGrk4aDJ/Odvo1oGho/rL3xPYChg4Np/5co
         lzUA==
X-Gm-Message-State: AOJu0YxhrdNXFB3ioDyE3L4wM4cVWvcPqy2iFq/Q/VV73lBJZYtWxxnB
	YLmL/obRp5gljb4Mk6S46TN7TPhWIVobT94kGsFm0BRT4s4ewsPNUes5RDNUoZAi
X-Gm-Gg: AfdE7cljxawYEfOXoIE01UpNtr2BWmGwFvRWHm86oErrgq3Gfv4rR72ymLWFVO/+geA
	t8zSAAgSWNi+Y+Be2gyZ4pt0uQpZRx2eXsLTNOJyPyNZogmmiF91Vxu1ZIcbm4nGSGYhOST5K4z
	CsxxKQfY9wQCKFGhLhOQRgrDCKUoDAzV39NdcOQ8cd93TkcQD0jQuRS/C40/bRdFamCjSUB78se
	XWqMCrrsTKt/KFqPKgU1qvmEruoLCc4h7rRiIZPjowfgqsrI0v2lE6GB5Q+f7OUpXFruB3SO4BV
	ubpRamytooUTB5I/m+oQOfFI3vcu3qszsDVM//VZ/sRVBgkSAxxh9MaMKWDFSGVqTAlyznnhz90
	YXK3SxxcT5G9uifiaK07OKeMSB/rzdxmkjgRaWPB+x2l7WXl0TBPJhSYjO2bhGYX/VpftFAW5Ty
	Qxj7MCBA==
X-Received: by 2002:a05:620a:46a6:b0:92e:51ee:7944 with SMTP id af79cd13be357-930b3ef6142mr434670285a.34.1784312857990;
        Fri, 17 Jul 2026 11:27:37 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.156.84])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b52fa8dfsm216823785a.11.2026.07.17.11.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 11:27:37 -0700 (PDT)
Message-Id: <0de8b12f65530497320b6a4bca395dfd0556c959.1784312854.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2335.v2.git.git.1784312854.gitgitgadget@gmail.com>
References: <pull.2335.git.git.1784180159.gitgitgadget@gmail.com>
	<pull.2335.v2.git.git.1784312854.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 17 Jul 2026 18:27:32 +0000
Subject: [PATCH v2 1/3] bisect: read run output from the open descriptor
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

