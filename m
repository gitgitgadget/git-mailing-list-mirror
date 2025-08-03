Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F205F2063FD
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 21:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754256324; cv=none; b=hYSAj7rm0KKn6lUMMg8vdBtxORGKkxYosbBdcqRQyfXgVfZhA417/umZ6dwYjeAOE/HX2kB1CTuIMWOUv/mujmpbOZMrcK7N64PpwuqMxan52R73GoU5zZTiZgkpYA6SoEPggy00Rm97AthCe+Fwe3yr1Y6jXyEiL7WtqatKjx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754256324; c=relaxed/simple;
	bh=LyIFbNg3M124h8IieNFOApALOd+6qXLR5CTLk9sokm8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EXiiEwKlEYoKEqtSxPJhP9JcE6OEk+tAyQVz8IudCFe2Mr7U6CCQs0X7EWnTRTWWQxDOFyqsWL0osHCvxYJ6HNzIxBpzAd7vpsgYbehCKehuC6A9axpbH8azbn/b7U8iRaebI8C3z7CNx5VCejyOdWorIkp2Bko7iU9HXpqXbeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8zyEKEf; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8zyEKEf"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-60bfcada295so4392537a12.1
        for <git@vger.kernel.org>; Sun, 03 Aug 2025 14:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754256321; x=1754861121; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRV4hilGJorUr0RUNDzPOghnY/if2G2+zLcrsBRFTmM=;
        b=U8zyEKEfBenKlzEolGH0FSvnvguNWB6a9USexpYf6LbtsLDiAnwz8X24tGM3gTu+3M
         BeCdW640/fV3cttyAqRnkhe+R/PfNsWzGjxNgYzQGUD40E9VSb/B8XzIZ4X7qoZ5uPol
         cBmyTKaXr9AZ7v2WDF7ROQQyWkwT59dvQIlN9lTI/6SmzXoBK61kwCWvVqMZs82uh67h
         YxdgoX340UGorxPnryA92aPKwDfj2A7Aj6KuJzw4exUElQIhRweeDMlp1PN3JfZYqskz
         xFa6Bicq1+0r6pdjfQoJhXOnrEOWndXnrcUeaQelH5vGPXm/6S5ARRAMt242FXIsqVOU
         LtsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754256321; x=1754861121;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRV4hilGJorUr0RUNDzPOghnY/if2G2+zLcrsBRFTmM=;
        b=rIGysrO1mfHwD17ML/22wEFTiTv5e1HQTRWBxvr/+fAyfvQA7lld8K/C1CPyWAo0YK
         OW50t+Gha2tAZ/0/HErtYSo5FwkONMuEaceR88YLdnb5CNDH632l+Vn9Qq0i924cRwrs
         n26TNhva3VFVpU28UOnIwl0X3g0xo7/m6pbQn7rE5gTRXBgLy2Ukbj4Q/KuXgvWPMVdI
         +dOtHChet0Jzr7GjijkxmvU+LcvMdg2M0hsMQ9r4UQl9PNIhx25XRfhfZUbru0sqcW/f
         9TjDP8ZQjesm9kPra9H2oBLHdBCj2eCCAkLr4CfOJS83m+GRPN00KBlnIlb4zIuYcOTj
         1HFw==
X-Gm-Message-State: AOJu0Yw1AC8bsnzCd53V7hXgDG5bycgBMeY7aofYBbe/B4zsHOV5UAMi
	rMAI9IAhfro1f9MjadOCS8K7R/nchy2AsmC9ecOWdXWtHuf8kC6sCDBl7tNqwg==
X-Gm-Gg: ASbGncs9XsxhdHj0iVJBVyzl8Qlv/snIch0Ub/3uJ64MEv+btK0VJkpGdrwsvG+tVgW
	qUsq9UH+y7nI53ciEhMbKJkZ6HmQgap5pdbBAnrmkP4bE3CLjEDkwTofKPelt760Q/cdWrtahR+
	lOS4q1pwXMu0CQAGb1W3WB9ImKfABeJpSofc5CGumP1nc3AAlMW4jKVy/7DlN4Sxqdi6RKma+4P
	kdQ3MaNpkuGlxGq386RBLSZoew7z8V7EoAksL2snqlza71AiywV687dN9XuD9ULH3x+8DhKUYJO
	hX5Z9zoJIArbBefw1RDl4DcQfatBjbCPdpoa3Y1vqr0OwSkOrzkZSxnoqVqxXScspjZRqOKzOHN
	QJDdrUDw2HA2Vq0tsmlYb5VZE83UE55WECQ==
X-Google-Smtp-Source: AGHT+IEZM6Y6eR+gZbyudcuJqKXY87UiA3fQgPQ4sdCE600O+TnvaUNfE4KxCRBymuFTxcmjpQKkgQ==
X-Received: by 2002:a05:6402:1e8a:b0:615:62bb:c24 with SMTP id 4fb4d7f45d1cf-615e6ce146amr5441648a12.0.1754256320870;
        Sun, 03 Aug 2025 14:25:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a9113e40sm5868313a12.57.2025.08.03.14.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 14:25:20 -0700 (PDT)
Message-Id: <6b4f062d82a80d82eb927cda7304d053b2984aba.1754256318.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1948.git.1754256318.gitgitgadget@gmail.com>
References: <pull.1948.git.1754256318.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 03 Aug 2025 21:25:16 +0000
Subject: [PATCH 2/4] mingw: drop Windows 7-specific work-around
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

In ac33519ddfa8 (mingw: restrict file handle inheritance only on Windows
7 and later, 2019-11-22), I introduced code to safe-guard the
defense-in-depth handling that restricts handles' inheritance so that it
would work with Windows 7, too.

Let's revert this patch: Git for Windows dropped supporting Windows 7 (and
Windows 8) directly after Git for Windows v2.46.2. For full details, see
https://gitforwindows.org/requirements#windows-version.

Actually, on second thought: revert only the part that makes this handle
inheritance restriction logic optional and that suggests to open a bug
report if it fails, but keep the fall-back to try again without said
logic: There have been a few false positives over the past few years
(where the warning was triggered e.g. because Defender was still
accessing a file that Git wanted to overwrite), and the fall-back logic
seems to have helped occasionally in such situations.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config/core.adoc |  6 ---
 compat/mingw.c                 | 68 ++--------------------------------
 2 files changed, 4 insertions(+), 70 deletions(-)

diff --git a/Documentation/config/core.adoc b/Documentation/config/core.adoc
index 9fde1ab63a70..3fbe83eef161 100644
--- a/Documentation/config/core.adoc
+++ b/Documentation/config/core.adoc
@@ -696,12 +696,6 @@ core.unsetenvvars::
 	Defaults to `PERL5LIB` to account for the fact that Git for
 	Windows insists on using its own Perl interpreter.
 
-core.restrictinheritedhandles::
-	Windows-only: override whether spawned processes inherit only standard
-	file handles (`stdin`, `stdout` and `stderr`) or all handles. Can be
-	`auto`, `true` or `false`. Defaults to `auto`, which means `true` on
-	Windows 7 and later, and `false` on older Windows versions.
-
 core.createObject::
 	You can set this to 'link', in which case a hardlink followed by
 	a delete of the source are used to make sure that object creation
diff --git a/compat/mingw.c b/compat/mingw.c
index 2dd5cbcaee0d..c331c3ac32a8 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -244,7 +244,6 @@ enum hide_dotfiles_type {
 	HIDE_DOTFILES_DOTGITONLY
 };
 
-static int core_restrict_inherited_handles = -1;
 static enum hide_dotfiles_type hide_dotfiles = HIDE_DOTFILES_DOTGITONLY;
 static char *unset_environment_variables;
 
@@ -268,15 +267,6 @@ int mingw_core_config(const char *var, const char *value,
 		return 0;
 	}
 
-	if (!strcmp(var, "core.restrictinheritedhandles")) {
-		if (value && !strcasecmp(value, "auto"))
-			core_restrict_inherited_handles = -1;
-		else
-			core_restrict_inherited_handles =
-				git_config_bool(var, value);
-		return 0;
-	}
-
 	return 0;
 }
 
@@ -1667,7 +1657,6 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **deltaen
 			      const char *dir,
 			      int prepend_cmd, int fhin, int fhout, int fherr)
 {
-	static int restrict_handle_inheritance = -1;
 	STARTUPINFOEXW si;
 	PROCESS_INFORMATION pi;
 	LPPROC_THREAD_ATTRIBUTE_LIST attr_list = NULL;
@@ -1687,16 +1676,6 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **deltaen
 	/* Make sure to override previous errors, if any */
 	errno = 0;
 
-	if (restrict_handle_inheritance < 0)
-		restrict_handle_inheritance = core_restrict_inherited_handles;
-	/*
-	 * The following code to restrict which handles are inherited seems
-	 * to work properly only on Windows 7 and later, so let's disable it
-	 * on Windows Vista and 2008.
-	 */
-	if (restrict_handle_inheritance < 0)
-		restrict_handle_inheritance = GetVersion() >> 16 >= 7601;
-
 	do_unset_environment_variables();
 
 	/* Determine whether or not we are associated to a console */
@@ -1798,7 +1777,7 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **deltaen
 	wenvblk = make_environment_block(deltaenv);
 
 	memset(&pi, 0, sizeof(pi));
-	if (restrict_handle_inheritance && stdhandles_count &&
+	if (stdhandles_count &&
 	    (InitializeProcThreadAttributeList(NULL, 1, 0, &size) ||
 	     GetLastError() == ERROR_INSUFFICIENT_BUFFER) &&
 	    (attr_list = (LPPROC_THREAD_ATTRIBUTE_LIST)
@@ -1819,52 +1798,13 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **deltaen
 			     &si.StartupInfo, &pi);
 
 	/*
-	 * On Windows 2008 R2, it seems that specifying certain types of handles
-	 * (such as FILE_TYPE_CHAR or FILE_TYPE_PIPE) will always produce an
-	 * error. Rather than playing finicky and fragile games, let's just try
-	 * to detect this situation and simply try again without restricting any
-	 * handle inheritance. This is still better than failing to create
-	 * processes.
+	 * On the off-chance that something with the file handle restriction
+	 * went wrong, silently fall back to trying without it.
 	 */
-	if (!ret && restrict_handle_inheritance && stdhandles_count) {
+	if (!ret && stdhandles_count) {
 		DWORD err = GetLastError();
 		struct strbuf buf = STRBUF_INIT;
 
-		if (err != ERROR_NO_SYSTEM_RESOURCES &&
-		    /*
-		     * On Windows 7 and earlier, handles on pipes and character
-		     * devices are inherited automatically, and cannot be
-		     * specified in the thread handle list. Rather than trying
-		     * to catch each and every corner case (and running the
-		     * chance of *still* forgetting a few), let's just fall
-		     * back to creating the process without trying to limit the
-		     * handle inheritance.
-		     */
-		    !(err == ERROR_INVALID_PARAMETER &&
-		      GetVersion() >> 16 < 9200) &&
-		    !getenv("SUPPRESS_HANDLE_INHERITANCE_WARNING")) {
-			DWORD fl = 0;
-			int i;
-
-			setenv("SUPPRESS_HANDLE_INHERITANCE_WARNING", "1", 1);
-
-			for (i = 0; i < stdhandles_count; i++) {
-				HANDLE h = stdhandles[i];
-				strbuf_addf(&buf, "handle #%d: %p (type %lx, "
-					    "handle info (%d) %lx\n", i, h,
-					    GetFileType(h),
-					    GetHandleInformation(h, &fl),
-					    fl);
-			}
-			strbuf_addstr(&buf, "\nThis is a bug; please report it "
-				      "at\nhttps://github.com/git-for-windows/"
-				      "git/issues/new\n\n"
-				      "To suppress this warning, please set "
-				      "the environment variable\n\n"
-				      "\tSUPPRESS_HANDLE_INHERITANCE_WARNING=1"
-				      "\n");
-		}
-		restrict_handle_inheritance = 0;
 		flags &= ~EXTENDED_STARTUPINFO_PRESENT;
 		ret = CreateProcessW(*wcmd ? wcmd : NULL, wargs, NULL, NULL,
 				     TRUE, flags, wenvblk, dir ? wdir : NULL,
-- 
gitgitgadget

