Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98CA1CFB9
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 14:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712413923; cv=none; b=kUIp/IHr9ua8vh8BxTLM5+fQTRtSkH3hOfZIg7npTujfIqAli4IBZmJhmT35GvylNwVt60h666d9sD2XNaAA4Dsj1bHx4xH/e7uvWDJUxgHMnhxGiRSD00fouV9bVyX0e2k5320UWL109vU0LvmMM/wKf/mqThuT6sqnUei6YtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712413923; c=relaxed/simple;
	bh=Jj5scjrZuibs6OABZKZ6ZO3ePEPtibyNDL/iszNowKc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=fBdlycHb0P1SEuHkh52dmlapuuXXtTkN5m/rx/lmMGGdeuJJpzYPFp48wDD+2utnZEYTYqJCsAEVHkOGkwI/SHWD1zbIcMuTOd/6+Xbj1rNkrFMgxGZPGSx0tbxIKC8HzHEWFPlk06PIeWqr1YrGVSOB3XOxKMrUdTggmVexmSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0Xhxf+R; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0Xhxf+R"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-345600106d3so139930f8f.0
        for <git@vger.kernel.org>; Sat, 06 Apr 2024 07:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712413920; x=1713018720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJ+P6qKQDdXYIqfy9/BwKhPifK2njnWDt/UHuaDhigs=;
        b=e0Xhxf+RkH7YTGLGPlk6nu2yXi8SRG6gQCoZboXTQiZx5YzhzuXX0JaJiRPAH+1v+c
         g6DYmkJbWDU+h9tPaiV9Cqo9jsCeIP5PVVYqNsp9JFbU+HJsxnF8IBjQbVmQbHkxnymW
         1iHVyWAaD64FgGV4mMBbPGVTdiBpVK5StEOR0JNWY//bWgSYljvY9aTjk9nsLwwHZIsM
         Hw1n3K6QbyNE4NkMycPcFh1RQpB3M60kco/XXXSTmbbRGuwhSvFz2K4Yi3sicC4MjdYk
         jzJWzhzgd39GxYuOIGIj2gBADl24NL65TiduldHb+y8ROaIOJ/E75HgShjQVJgxpy8Yu
         zw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712413920; x=1713018720;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PJ+P6qKQDdXYIqfy9/BwKhPifK2njnWDt/UHuaDhigs=;
        b=F2ZPQCGc9kEdMcgxYUfhkPktj4bNiRBVqeBGFjUxY9uRTtiwBo0t8HkPu0+/UAVjTY
         VllGbkuTDo/GgNGm2877Iy6rhylqmzBcNxgtvmfUPvnKfPqbiTGfq6ljQmsrJdGezcjg
         NfHX8g9jfzFI8TDyJSSouK/AilY+RTdqWQ0DBXWqV7IoMHDJi7DmzgadbKLycZsRCVxH
         aHsDyyi7XciIWCUTdh2gGIKEkHWXHG7/KNKEk/gNiFros2FOmMNXk70UkT05S9YgKN9P
         FO5zW3QxOAcJBSyN3WuxcKo8IKELyNozVi5ngDAPmbpRUh/k+j2U5nus1eDdVBtiafaK
         WnkQ==
X-Gm-Message-State: AOJu0Yx6izBGLGc3tPhgGzq7sI9kJW39r9GRv6I+z15fDU6bv159/XVP
	i/g+yfK2G9a3RXq2t9EdX+sRAWP3aCzXD+ZULTANOLu4vFInKn7pAvV4y8vp
X-Google-Smtp-Source: AGHT+IF8B1FC1jz85G4vRnjhpi68aA4ND8+sPac1xtj8pkdy+7IWvBesya6PHiQelGO758uHEPFqZg==
X-Received: by 2002:a05:6000:cc:b0:343:7c16:34df with SMTP id q12-20020a05600000cc00b003437c1634dfmr3040438wrx.49.1712413919818;
        Sat, 06 Apr 2024 07:31:59 -0700 (PDT)
Received: from gmail.com (4.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.4])
        by smtp.gmail.com with ESMTPSA id r10-20020a05600c35ca00b0041622c88852sm10263353wmq.16.2024.04.06.07.31.59
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Apr 2024 07:31:59 -0700 (PDT)
Message-ID: <eb40f012-e910-49a3-9e3f-2dbab2b169a6@gmail.com>
Date: Sat, 6 Apr 2024 16:31:56 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/4] path.c: introduce strbuf_interpolate_path
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
References: <f4af1e88-5bd9-4b3c-8691-84dbf0ca3ee2@gmail.com>
Content-Language: en-US
In-Reply-To: <f4af1e88-5bd9-4b3c-8691-84dbf0ca3ee2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Factorize interpolate_path to have a similar function that uses a
strbuf, instead of allocating a new string, to return the interpolated
path.

It will allow us to avoid some allocs and also some frees, which we will
take advantage of in the next commits.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 path.c | 20 ++++++++++++++------
 path.h |  1 +
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/path.c b/path.c
index 8bb223c92c..7a1a1a9bc0 100644
--- a/path.c
+++ b/path.c
@@ -737,8 +737,16 @@ static struct passwd *getpw_str(const char *username, size_t len)
 char *interpolate_path(const char *path, int real_home)
 {
 	struct strbuf user_path = STRBUF_INIT;
+
+	return strbuf_interpolate_path(path, real_home, &user_path);
+}
+
+char *strbuf_interpolate_path(const char *path, int real_home, struct strbuf* dst)
+{
 	const char *to_copy = path;
 
+	strbuf_reset(dst);
+
 	if (!path)
 		goto return_null;
 
@@ -754,9 +762,9 @@ char *interpolate_path(const char *path, int real_home)
 			if (!home)
 				goto return_null;
 			if (real_home)
-				strbuf_add_real_path(&user_path, home);
+				strbuf_add_real_path(dst, home);
 			else
-				strbuf_addstr(&user_path, home);
+				strbuf_addstr(dst, home);
 #ifdef GIT_WINDOWS_NATIVE
 			convert_slashes(user_path.buf);
 #endif
@@ -764,14 +772,14 @@ char *interpolate_path(const char *path, int real_home)
 			struct passwd *pw = getpw_str(username, username_len);
 			if (!pw)
 				goto return_null;
-			strbuf_addstr(&user_path, pw->pw_dir);
+			strbuf_addstr(dst, pw->pw_dir);
 		}
 		to_copy = first_slash;
 	}
-	strbuf_addstr(&user_path, to_copy);
-	return strbuf_detach(&user_path, NULL);
+	strbuf_addstr(dst, to_copy);
+	return dst->buf;
 return_null:
-	strbuf_release(&user_path);
+	strbuf_release(dst);
 	return NULL;
 }
 
diff --git a/path.h b/path.h
index e053effef2..da7e5384a3 100644
--- a/path.h
+++ b/path.h
@@ -185,6 +185,7 @@ int calc_shared_perm(int mode);
 int adjust_shared_perm(const char *path);
 
 char *interpolate_path(const char *path, int real_home);
+char *strbuf_interpolate_path(const char *path, int real_home, struct strbuf *dst);
 const char *enter_repo(const char *path, int strict);
 const char *remove_leading_path(const char *in, const char *prefix);
 const char *relative_path(const char *in, const char *prefix, struct strbuf *sb);
-- 
2.44.0.697.g9b33b46f29
