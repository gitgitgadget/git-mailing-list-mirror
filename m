Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B2F3EBF07
	for <git@vger.kernel.org>; Sun, 15 Feb 2026 17:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771175305; cv=none; b=JqPG2qbsoQcPDnTvC8jsUorgMIY4N8EGwX9FXurUaVufV+gl0yb7iWJVVcRmRjsgtfNJ3asY4xdBQ3D+80kUqDNw5VdvvfBR9wFjguMyNc4BfP/f+u5YTYbD8PgjtVar65jpPq6w84d1CXhka/CU/KPLqpHaGWLemUgOWNquLHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771175305; c=relaxed/simple;
	bh=Edd2Jsc8Vt3wi9h/Z/FmiEG3Ka6A/QnfLBTk55AOLnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BekLOi2goDrxQ672N5gBrjS5xaiwEdl1rtkCWzI2HnTGpqdwqZE0ijIQkGbzJoNZtiqxzd+TvwLZNN3aiJDATAi3gH5TIgEmiK7h4yo49kl25u6KorevZQsZxZ/QuVh7f2IGV+ErRKB/lge5g41MLKdzMj9+Ab0ymAiOicdpOtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GnwLAtR5; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnwLAtR5"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c6dbfab1b73so211723a12.0
        for <git@vger.kernel.org>; Sun, 15 Feb 2026 09:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771175304; x=1771780104; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WoeqMCYiykBf6MZpqKE/VNocDiyF4VRt0D4X5tUKgB8=;
        b=GnwLAtR5ZKlZTfDRg0LHbEHQNO1HKMg/6eZrmlj07xFoiTrLZrTYphjge12dvf6zCp
         hTPyCOsdRE4dnhW4Vlf4rHkQETcmpNzMcfv+0ndi29ymDl/NylJta30MskFYfdCWGATi
         cDvH7uwAp+RGSZg6BNVXtwsD2wH3R85W40q8mPX10k8Ei8CAOV2LwSZH3GQj9Pp1juYG
         FHS0sFZThHpBC/bvE/g/g0S97z9TLdJsT8BD1fGDoa3JOQyUfLVyxfgcK99OSfUG5oHn
         4K/2SAC+zUwo5J7CGKF/6PbBqyTn2yWCjOgEbNTp0wgYt28TCvmexfK6FuJ0bq1sxs2/
         Cotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771175304; x=1771780104;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WoeqMCYiykBf6MZpqKE/VNocDiyF4VRt0D4X5tUKgB8=;
        b=wZ/va67MNtsf7dP+woYZR0s2kCFX+43Xh9ooVL0FF5hl8xZzTULW9UIm5wmJTPBW49
         K2pzjk3oOa+J07bjG8SAEpmt8znZKdrncrPI3LUsEwxy+TLraz/VXf2OPVvKG4kB31R2
         Ow/Gssx9ceWxf3KS4w8C4detmGopUqozvOlLWdml1zc3IOFAUuepFdlSC0eK5eVHBfoZ
         D8UDWHogSOXH2oT11RWwfrf/BZlbutawjqIhBhqe5W/TkXql/RnF8iMNO9u976yYcdtg
         t6JnAnqTY5mG62gbV9XFlUdd87+997TSWiWjQMR5F48hMp81JdaYYwYePNLtpgOvyk2Z
         S6WA==
X-Gm-Message-State: AOJu0YwlHpNrCR9xtVUmpAf6QPaO6mgl3Ypvcz2zY5TaWXc4POTMXvla
	T8WvRuga5I+HJZ/LKBlNfyZr07e0NiP3kX2adYfzg/qvEmOec3OAEyNU
X-Gm-Gg: AZuq6aIYqc53joeYwaRNSprOYk/uzLARnwnMvFHxXqe90fkzAwkybEEXt1gnf44mQtC
	SNgUk8wORFnft4gj084xuALr+36mEUOdEG4tKleUd6nuhvvmH/V6t7c6Lnhq/FEoloweaKzlqb/
	U1IvjxQAQ0CmpwEEYd5Zmk9p7AcMB+ALQeHf2ZaHhhF3A9/r03vq7i+yyyKUdI8D2NPaIKepdyo
	jHRnzUglQEodS0VnsJ7kRe069+pJPV8rFT+q9aTHxIvx1YCvanbD6RYDlPYHHWFbKIaKuu+7sVV
	1EOiuhl3JXA0sr2fQsLhYlXK2bOtRxfL07mLJeuRGP2gBgYsBeLhc2gbgrtJncbGDYBF1Sek5th
	R2tyz8Ab1p88tk6r5rD0xhgoFDxE0HTYOmmJVWP7HNLb4ti0KOPSl0qdyDTBrB+SoMYD8/1KMKp
	7XuhjbEDaw67Fixo910ZVZTfdka3Y=
X-Received: by 2002:a17:90b:3f4c:b0:343:e480:49f1 with SMTP id 98e67ed59e1d1-356a7ae7ca4mr6243946a91.5.1771175303661;
        Sun, 15 Feb 2026 09:08:23 -0800 (PST)
Received: from [192.168.0.102] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e52fe2300sm4855531a12.8.2026.02.15.09.08.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Feb 2026 09:08:23 -0800 (PST)
Message-ID: <eae3b31b-802a-4fbf-9c84-47d410081de9@gmail.com>
Date: Mon, 16 Feb 2026 01:08:20 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] setup: fail if .git is not a file or directory
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net
References: <20260212172405.48614-1-a3205153416@gmail.com>
 <20260214045247.118013-1-a3205153416@gmail.com> <xmqqfr72flga.fsf@gitster.g>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <xmqqfr72flga.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

diff --git a/setup.c b/setup.c
index 3a6a048620..269aa9faaa 100644
--- a/setup.c
+++ b/setup.c
@@ -939,8 +939,14 @@ const char *read_gitfile_gently(const char *path, 
int *return_error_code)
  	static struct strbuf realpath = STRBUF_INIT;

  	if (stat(path, &st)) {
-		/* NEEDSWORK: discern between ENOENT vs other errors */
-		error_code = READ_GITFILE_ERR_STAT_FAILED;
+		if (errno == ENOENT)
+			error_code = READ_GITFILE_ERR_STAT_ENOENT;
+		else
+			error_code = READ_GITFILE_ERR_STAT_FAILED;
+		goto cleanup_return;
+	}
+	if (S_ISDIR(st.st_mode)) {
+		error_code = READ_GITFILE_ERR_IS_A_DIR;
  		goto cleanup_return;
  	}
  	if (!S_ISREG(st.st_mode)) {
@@ -994,7 +1000,9 @@ const char *read_gitfile_gently(const char *path, 
int *return_error_code)
  cleanup_return:
  	if (return_error_code)
  		*return_error_code = error_code;
-	else if (error_code)
+	else if (error_code &&
+		error_code != READ_GITFILE_ERR_STAT_ENOENT &&
+		error_code != READ_GITFILE_ERR_IS_A_DIR)
  		read_gitfile_error_die(error_code, path, dir);

  	free(buf);
@@ -1576,20 +1584,27 @@ static enum discovery_result 
setup_git_directory_gently_1(struct strbuf *dir,
  		if (offset > min_offset)
  			strbuf_addch(dir, '/');
  		strbuf_addstr(dir, DEFAULT_GIT_DIR_ENVIRONMENT);
-		gitdirenv = read_gitfile_gently(dir->buf, die_on_error ?
-						NULL : &error_code);
+		gitdirenv = read_gitfile_gently(dir->buf, &error_code);
  		if (!gitdirenv) {
-			if (die_on_error ||
-			    error_code == READ_GITFILE_ERR_NOT_A_FILE) {
-				/* NEEDSWORK: fail if .git is not file nor dir */
+			if (error_code == READ_GITFILE_ERR_STAT_ENOENT) {
+				;
+			} else if (error_code == READ_GITFILE_ERR_IS_A_DIR) {
  				if (is_git_directory(dir->buf)) {
  					gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
  					gitdir_path = xstrdup(dir->buf);
  				}
-			} else if (error_code != READ_GITFILE_ERR_STAT_FAILED)
-				return GIT_DIR_INVALID_GITFILE;
-		} else
-			gitfile = xstrdup(dir->buf);
+			} else if (error_code == READ_GITFILE_ERR_NOT_A_FILE) {
+				if (die_on_error)
+					die(_("Invalid %s: not a regular file or directory"), dir->buf);
+				else
+					return GIT_DIR_INVALID_GITFILE;
+			} else if (error_code != READ_GITFILE_ERR_STAT_FAILED) {
+				if (die_on_error)
+					read_gitfile_error_die(error_code, dir->buf, NULL);
+				else
+					return GIT_DIR_INVALID_GITFILE;
+			}
+		}
  		/*
  		 * Earlier, we tentatively added DEFAULT_GIT_DIR_ENVIRONMENT
  		 * to check that directory for a repository.
diff --git a/setup.h b/setup.h
index d55dcc6608..0271cc8f93 100644
--- a/setup.h
+++ b/setup.h
@@ -36,6 +36,9 @@ int is_nonbare_repository_dir(struct strbuf *path);
  #define READ_GITFILE_ERR_NO_PATH 6
  #define READ_GITFILE_ERR_NOT_A_REPO 7
  #define READ_GITFILE_ERR_TOO_LARGE 8
+#define READ_GITFILE_ERR_STAT_ENOENT 9
+#define READ_GITFILE_ERR_IS_A_DIR 10
+


Still working on it.

Looks clearer, right? I just wanna confirm whether I'm on the right 
track. Notice that I didn't change the following part: (though you 
mentioned earlier)

 > cleanup_return:
 > 	if (return_error_code)
 > 		*return_error_code = error_code;
 >-	else if (error_code)
 >+	else if (error_code &&
 >+		error_code != READ_GITFILE_ERR_STAT_ENOENT &&
 >+		error_code != READ_GITFILE_ERR_IS_A_DIR)
 > 		read_gitfile_error_die(error_code, path, dir);

My understanding is that we haven't distinguished between “unexpected” 
(ENOENT, IS_A_DIR) and “errors” (NOT_A_FILE, format error) in the code 
using a categorical approach. Instead, we differentiate them solely 
based on whether they are listed in `read_gitfile_error_die()` (if I 
haven't missed anything). Consequently, retaining this code here seems 
to be the easiest and most readable approach to ensure that it doesn't 
return prematurely. However, I believe this check shouldn't reside here. 
That's why I'm replying to you again.

(By the way, I've always been a bit curious about how your name is 
pronounced :/)

Regards,

Yuchen







