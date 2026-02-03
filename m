Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AC0368260
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 05:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770096188; cv=none; b=bz18duDtFAo0/iWUbbh+hBenhgnxqv0kiHK+dcIaYoSJCVI4+T7V+2DYq3ONS6osJJz0hLFabJLZGSiKbF888yZX93vdoFEU+yfP0SNdf8sNyWXS/9vZrKw+ns8ZBMtwqnsWTvxizjEEBYfu/kS8E6bbfGrlJVveY9qbYYm8Flc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770096188; c=relaxed/simple;
	bh=KbDtmuVrPdo8LIJMvS2nRCY+z2bKLJ/VWYv6WnUKyfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RK6K5NF9kkmn1CAYmnqMjZEIx4hv0MjF08A1gzMWzALgDZyKGvo18FcPb6fcLuBG9PseMXE8rlvw9eMv9RyxClid8xKsDA02Oetz8Tc2l8qIjHWVmhCMPTSD2qRqLWFmlOcE7SBfkEmONw5OShb4OHQ6/84dw9Y2EV9ZTXCb5ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/Mm/IIt; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/Mm/IIt"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2b70abe3417so11264279eec.0
        for <git@vger.kernel.org>; Mon, 02 Feb 2026 21:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770096186; x=1770700986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ujJTHO0GuQTg8t4y1IAS9lVac29WLODqZ9jav3ioW/Q=;
        b=A/Mm/IItlc6w3XjPJjsOyC/GGEfF/VjZlQ7NnnkRhKnKJKuXQwas5wbibEHFoVKF5L
         wAekL8H2GpJIufvg9kZGi0Nms97iwBLPwWbifzo2rj80Nvz2W1s0tPSbvoZVdEqT8IaD
         AKoVb+7c1Ust28f0sesEdYe1YmPHRYJusKyUiWZcBewTU+ViLej0TZEBoHX6IxROVkHf
         n0bIh0fWN0z0mLLGShwdC6e1ijgtUx6TYjveaU1MtzRWybtIXDPnJhB7IvRY0g70gpSZ
         YenwsAG2W6awFZMZSJ1ovK+7GbH3d0ZctyVnGUq+/r9b3eTzj1farNrGwnQvr6p8ToA4
         KR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770096186; x=1770700986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujJTHO0GuQTg8t4y1IAS9lVac29WLODqZ9jav3ioW/Q=;
        b=Cbzd90PsoKv0G8HyEhmTb+AIVm2Wwu0USniqfHB4UcvSGinUZu9G/Qi3HybLygNYJF
         Cy7NQbkoWAqvDKqP4p0rSaj1zYsMnm/wQeNNibYo7FsAu4UIChI0TdSUmnL+3oJhz67J
         4zSZWG6JUYSvLeOjjpYfFBEnuFqCaMZkvmbZOzs81N/fsDwRf0To72adCq+hii3uyWoo
         QsEVfs6Fb5mcdvn9FYZTTGftchUnuAY4Rt+pC7ZwGXQinJeQSVs8fHCg2qaBNFDSfd5m
         4dDiByrcWUOpM3namW/Z+6UraBwPujQ2vYiekNP3hu26+1tVlQfSrk6Q4ne9W+H9k9Jq
         enfw==
X-Gm-Message-State: AOJu0YwLFqDcmPVTkS9Aj4oF8hCSK54UnVfar6vHSuE3Tq6FUNwvbYy7
	Uygr+z49+v8HRAKUKawlGO/SSFvZSIFD8/vNxLFWfTRw1DMg8hM4U5Vu41JsWw==
X-Gm-Gg: AZuq6aIEdFeS3hha0ANUzeWMzXbIRLQZdqXnsi0Ejl55pEKgHWKLVpqT9XRpdu3iIYo
	r/3lTIZ+gXMzZc6VakIzSOG0Lq+1KRuCH8O3dp6OvTDZzn3By3hi6j31he43SLyZOOOCHy0kNmU
	KuTn5gmWC32MdByrwWGTuCVLDTyISdRgJMtaGktpT4CiDoxBD9kKrej6j3nNKnhFOoNjs2Afdvb
	KieWXFGIgk7/N2XetfqnA26RY1pkV0XhDWaGEDmO5PZF1AVhv0OXdiP1dYXkOORFOKVui8PNG3b
	df9eH7xZ+jSoS7hKuKTR8iwQvLe6eMYFyAJY5l+BdfNyTGBlRTsBjbUTm4JAWA/NIpx4obthR1n
	qojHUiJQNJjr0zInJb1udRJpvaj91JLsw8D/Ltgh/ORPPzR4VE+YCFfZyipK54AjIbAJhWM1Wij
	qzABftYbNnGs1g
X-Received: by 2002:a05:7300:dc8c:b0:2b7:1cbe:fd1f with SMTP id 5a478bee46e88-2b7c8940615mr7061212eec.36.1770096185746;
        Mon, 02 Feb 2026 21:23:05 -0800 (PST)
Received: from localhost.localdomain ([2601:646:8081:3770::996e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a16cfaa8sm20895672eec.4.2026.02.02.21.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 21:23:05 -0800 (PST)
From: Collin Funk <collin.funk1@gmail.com>
To: git@vger.kernel.org
Cc: Collin Funk <collin.funk1@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Matthew John Cheetham <mjcheetham@outlook.com>,
	Victoria Dye <vdye@github.com>,
	Jeff King <peff@peff.net>,
	Derrick Stolee <stolee@gmail.com>
Subject: [PATCH] git-compat-util: make git_find_last_dir_sep return a const pointer
Date: Mon,  2 Feb 2026 21:19:01 -0800
Message-ID: <e6f7e2eddbc9aef1c21f661420a4b8cb9cd8e2c1.1770095829.git.collin.funk1@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Unsure if this should be tagged [RFC], but this patch clears up lots
of warning spam with glibc 2.43 because of a change mentioned in the
commit message.

I plan to handle the rest of them and try to organize the changes by
subsystem, for lack of a better term. But I figured it was best to
submit just this one for review first.

-- 8< --

The recent glibc 2.43 release had the following change listed in its
NEWS file:

    For ISO C23, the functions bsearch, memchr, strchr, strpbrk, strrchr,
    strstr, wcschr, wcspbrk, wcsrchr, wcsstr and wmemchr that return
    pointers into their input arrays now have definitions as macros that
    return a pointer to a const-qualified type when the input argument is
    a pointer to a const-qualified type.

When compiling with GCC 15, which defaults to -std=gnu23, this causes
many warnings like this:

        CC abspath.o
    In file included from abspath.c:1:
    git-compat-util.h: In function ‘git_find_last_dir_sep’:
    git-compat-util.h:344:16: warning: return discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
      344 |         return strrchr(path, '/');
          |                ^~~~~~~

Most of the warnings are from git_find_last_dir_sep which calls strrchr
on a "const char *" but returns a "char *". This patch addresses them by
changing the return type to be const, since only one location needs the
qualifier casted away.

Signed-off-by: Collin Funk <collin.funk1@gmail.com>
---
 config.c          | 2 +-
 git-compat-util.h | 2 +-
 remote.c          | 2 +-
 scalar.c          | 8 ++++----
 strbuf.c          | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/config.c b/config.c
index 7f6d53b473..156f2a24fa 100644
--- a/config.c
+++ b/config.c
@@ -160,7 +160,7 @@ static int handle_path_include(const struct key_value_info *kvi,
 	 * based on the including config file.
 	 */
 	if (!is_absolute_path(path)) {
-		char *slash;
+		const char *slash;
 
 		if (!kvi || kvi->origin_type != CONFIG_ORIGIN_FILE) {
 			ret = error(_("relative config includes must come from files"));
diff --git a/git-compat-util.h b/git-compat-util.h
index bebcf9f698..fb4251564a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -339,7 +339,7 @@ static inline int is_path_owned_by_current_uid(const char *path,
 #endif
 
 #ifndef find_last_dir_sep
-static inline char *git_find_last_dir_sep(const char *path)
+static inline const char *git_find_last_dir_sep(const char *path)
 {
 	return strrchr(path, '/');
 }
diff --git a/remote.c b/remote.c
index b756ff6f15..8c1a0a0c15 100644
--- a/remote.c
+++ b/remote.c
@@ -2753,7 +2753,7 @@ void remote_state_clear(struct remote_state *remote_state)
  */
 static int chop_last_dir(char **remoteurl, int is_relative)
 {
-	char *rfind = find_last_dir_sep(*remoteurl);
+	char *rfind = (char *) find_last_dir_sep(*remoteurl);
 	if (rfind) {
 		*rfind = '\0';
 		return 0;
diff --git a/scalar.c b/scalar.c
index c9df9348ec..54a75ad971 100644
--- a/scalar.c
+++ b/scalar.c
@@ -393,7 +393,7 @@ static int delete_enlistment(struct strbuf *enlistment)
 {
 	struct strbuf parent = STRBUF_INIT;
 	size_t offset;
-	char *path_sep;
+	const char *path_sep;
 
 	if (unregister_dir())
 		return error(_("failed to unregister repository"));
@@ -479,11 +479,11 @@ static int cmd_clone(int argc, const char **argv)
 		/* Strip suffix `.git`, if any */
 		strbuf_strip_suffix(&buf, ".git");
 
-		enlistment = find_last_dir_sep(buf.buf);
-		if (!enlistment) {
+		const char *last = find_last_dir_sep(buf.buf);
+		if (!last) {
 			die(_("cannot deduce worktree name from '%s'"), url);
 		}
-		enlistment = xstrdup(enlistment + 1);
+		enlistment = xstrdup(last + 1);
 	} else {
 		usage_msg_opt(_("You must specify a repository to clone."),
 			      clone_usage, clone_options);
diff --git a/strbuf.c b/strbuf.c
index 59678bf5b0..3939863cf3 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1119,6 +1119,6 @@ void strbuf_stripspace(struct strbuf *sb, const char *comment_prefix)
 
 void strbuf_strip_file_from_path(struct strbuf *sb)
 {
-	char *path_sep = find_last_dir_sep(sb->buf);
+	const char *path_sep = find_last_dir_sep(sb->buf);
 	strbuf_setlen(sb, path_sep ? path_sep - sb->buf + 1 : 0);
 }
-- 
2.52.0

