Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2376BC00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 13:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243191AbiHHN16 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 09:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243158AbiHHN1z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 09:27:55 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E7F9FE5
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 06:27:53 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 186-20020a1c02c3000000b003a34ac64bdfso5161097wmc.1
        for <git@vger.kernel.org>; Mon, 08 Aug 2022 06:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=tk099UvRKNEVcBOVTHd3KhiJ4Kzhm+f3HVLIs4IyNQ0=;
        b=GajXdQ2+ZjLVD4JxWCpy5vjoi+xbKr0hyJhtfOqzwjwfiis6FC/VjCacIBNp4qUos6
         /EL+TB1HdjExe3/RFqZ06G6D39DRjfpjffZYHHqyOtAD2mSQbA6Qqfm11Xn+A/pFJhIj
         5HDdCa403AOIJXICn4u9d5th+PRpqBE4bul3q5vLB/9Rmjj71OM1mGUmz21ROB6rTiRA
         ctjveKiTd/DcrUdp3wSpl/0E6NQfiQ3KBkwri4j8VSQ8iJ0zlcQX36WJcyUceYQbIw2P
         kYod93SCSTli9Ij0CSDsnmKNHG6oP9lz9CUGag05insWhSQWaNKu0x0+ui3sXwhYizVo
         QmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=tk099UvRKNEVcBOVTHd3KhiJ4Kzhm+f3HVLIs4IyNQ0=;
        b=dS70nFl/B59T5YaYk/fs6CESyVGuzxbeo/ITLRZ7Dlasm8t0MUmQi/RmteuEt2LKN6
         wrHeu01FiyaWXhlP8zuRWA83aEdS1KenKH62z2EOUpwddSC2r6qHYTLzh6cj3pb6gRqP
         aKZ5nJI8hcjeSlgdqo4d9lh/aeTCZiyEbSKZVTdlIXiT2lETWiSvxHTIDfa8b/uNG7Ld
         bPKDemlM43KuXUuZF6Lej/UBLqxi/a3oVV8Eve9516XIm1a9ZjdBT5jEjvKMYptQXUGp
         gIdkje087u4Eg7PnvMxAtFWvxdhfIXBxA2kUaTXs4fdi8JjgaD34P4Ow7NhD8CUEATF0
         p81Q==
X-Gm-Message-State: ACgBeo2XG6l5z0vj8FwGr1CIcLj9i3IMIjMsqMog9yhOSrKq9khA3AZE
        hnIAwsa3e9vJ4WiYZdl4BfXD2w/vUGc=
X-Google-Smtp-Source: AA6agR79eGRCwR42VVENJZNOfNRcyo8MIW1vjSwoQyaCNV9GbnCIa/Q/FmNNaa2bK7E/0A7UhEqk5Q==
X-Received: by 2002:a05:600c:4fd5:b0:3a3:4664:6d55 with SMTP id o21-20020a05600c4fd500b003a346646d55mr17999638wmq.73.1659965271723;
        Mon, 08 Aug 2022 06:27:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h19-20020a05600c351300b003a501ad8648sm14447177wmq.40.2022.08.08.06.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 06:27:51 -0700 (PDT)
Message-Id: <pull.1286.v2.git.1659965270.gitgitgadget@gmail.com>
In-Reply-To: <pull.1286.git.1657700238.gitgitgadget@gmail.com>
References: <pull.1286.git.1657700238.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 08 Aug 2022 13:27:45 +0000
Subject: [PATCH v2 0/5] Some improvements to safe.directory on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Due to the semantics being substantially different from Unix, the
safe.directory feature presents its own set of problems on Windows. One
particular issue would have prevented it from working in GitHub Actions'
build agents, which we definitely rely on in the Git project itself. This
was addressed via the fifth patch, which had made it (in a slightly
different form) already into Git for Windows v2.35.2, and they are ready to
be applied to core Git, too.

The FAT32 patch came in later, and was released as part of Git for Windows
v2.37.0, so I also have confidence that it is stable and ready to be
integrated into core Git, too.

Changes since v1:

 * Restructured the patch series.
 * Instead of an environment variable to turn on debugging, we now always
   show the platform-dependent information together with the error message
   about the dubious ownership (iff it is shown, that is), based on an idea
   by Junio.
 * Rebased onto gc/bare-repo-discovery to avoid a merge conflict.

Johannes Schindelin (5):
  setup: fix some formatting
  Prepare for more detailed "dubious ownership" messages
  mingw: provide details about unsafe directories' ownership
  mingw: be more informative when ownership check fails on FAT32
  mingw: handle a file owned by the Administrators group correctly

 compat/mingw.c    | 59 ++++++++++++++++++++++++++++++++++++++++++++++-
 compat/mingw.h    |  2 +-
 git-compat-util.h |  5 +++-
 setup.c           | 30 ++++++++++++++----------
 4 files changed, 81 insertions(+), 15 deletions(-)


base-commit: 776f184893d2861a729aa4b91d69931036e03e4b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1286%2Fdscho%2Fsafe.directory-and-windows-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1286/dscho/safe.directory-and-windows-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1286

Range-diff vs v1:

 -:  ----------- > 1:  301d94f18f5 setup: fix some formatting
 -:  ----------- > 2:  8cc45e4922a Prepare for more detailed "dubious ownership" messages
 1:  3480381b8b9 ! 3:  63494818105 Allow debugging unsafe directories' ownership
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    Allow debugging unsafe directories' ownership
     +    mingw: provide details about unsafe directories' ownership
      
          When Git refuses to use an existing repository because it is owned by
          someone else than the current user, it can be a bit tricky on Windows to
          figure out what is going on.
      
     -    Let's help with that by offering some more information via the
     -    environment variable `GIT_TEST_DEBUG_UNSAFE_DIRECTORIES`.
     +    Let's help with that by providing more detailed information.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     - ## Documentation/config/safe.txt ##
     -@@ Documentation/config/safe.txt: which id the original user has.
     - If that is not what you would prefer and want git to only trust
     - repositories that are owned by root instead, then you can remove
     - the `SUDO_UID` variable from root's environment before invoking git.
     -++
     -+Due to the permission model on Windows where ACLs are used instead of
     -+Unix' simpler permission model, it can be a bit tricky to figure out why
     -+a directory is considered unsafe. To help with this, Git will provide
     -+more detailed information when the environment variable
     -+`GIT_TEST_DEBUG_UNSAFE_DIRECTORIES` is set to `true`.
     -
       ## compat/mingw.c ##
      @@
       #include "../git-compat-util.h"
     @@ compat/mingw.c
       #include <conio.h>
       #include <wchar.h>
       #include "../strbuf.h"
     -@@ compat/mingw.c: int is_path_owned_by_current_sid(const char *path)
     +@@ compat/mingw.c: int is_path_owned_by_current_sid(const char *path, struct strbuf *report)
       		    IsValidSid(current_user_sid) &&
       		    EqualSid(sid, current_user_sid))
       			result = 1;
     -+		else if (git_env_bool("GIT_TEST_DEBUG_UNSAFE_DIRECTORIES", 0)) {
     ++		else if (report) {
      +			LPSTR str1, str2, to_free1 = NULL, to_free2 = NULL;
      +
      +			if (ConvertSidToStringSidA(sid, &str1))
     @@ compat/mingw.c: int is_path_owned_by_current_sid(const char *path)
      +				to_free2 = str2;
      +			else
      +				str2 = "(inconvertible)";
     -+			warning("'%s' is owned by:\n\t'%s'\nbut the current user is:\n\t'%s'", path, str1, str2);
     ++			strbuf_addf(report,
     ++				    "'%s' is owned by:\n"
     ++				    "\t'%s'\nbut the current user is:\n"
     ++				    "\t'%s'\n", path, str1, str2);
      +			LocalFree(to_free1);
      +			LocalFree(to_free2);
      +		}
       	}
       
       	/*
     -
     - ## setup.c ##
     -@@ setup.c: const char *setup_git_directory_gently(int *nongit_ok)
     - 	case GIT_DIR_INVALID_OWNERSHIP:
     - 		if (!nongit_ok) {
     - 			struct strbuf quoted = STRBUF_INIT;
     -+			struct strbuf hint = STRBUF_INIT;
     -+
     -+#ifdef __MINGW32__
     -+			if (!git_env_bool("GIT_TEST_DEBUG_UNSAFE_DIRECTORIES", 0))
     -+				strbuf_addstr(&hint,
     -+					      _("\n\nSet the environment variable "
     -+						"GIT_TEST_DEBUG_UNSAFE_DIRECTORIES=true "
     -+						"and run\n"
     -+						"again for more information."));
     -+#endif
     - 
     - 			sq_quote_buf_pretty(&quoted, dir.buf);
     - 			die(_("detected dubious ownership in repository at '%s'\n"
     - 			      "To add an exception for this directory, call:\n"
     - 			      "\n"
     --			      "\tgit config --global --add safe.directory %s"),
     --			    dir.buf, quoted.buf);
     -+			      "\tgit config --global --add safe.directory %s%s"),
     -+			    dir.buf, quoted.buf, hint.buf);
     - 		}
     - 		*nongit_ok = 1;
     - 		break;
 3:  dae03f1b204 ! 4:  7aaa6248dfe mingw: be more informative when ownership check fails on FAT32
     @@ Commit message
          any ownership information anyway, and the `GetNamedSecurityInfoW()` call
          pretends that everything is owned "by the world".
      
     -    Let's special-case that scenario and tell the user what's going on, at
     -    least when they set `GIT_TEST_DEBUG_UNSAFE_DIRECTORIES`.
     +    Let's special-case that scenario and tell the user what's going on.
      
          This addresses https://github.com/git-for-windows/git/issues/3886
      
     @@ compat/mingw.c: static PSID get_current_user_sid(void)
      +	return 0;
      +}
      +
     - int is_path_owned_by_current_sid(const char *path)
     + int is_path_owned_by_current_sid(const char *path, struct strbuf *report)
       {
       	WCHAR wpath[MAX_PATH];
     -@@ compat/mingw.c: int is_path_owned_by_current_sid(const char *path)
     - 			 * okay, too.
     - 			 */
     +@@ compat/mingw.c: int is_path_owned_by_current_sid(const char *path, struct strbuf *report)
     + 		    IsValidSid(current_user_sid) &&
     + 		    EqualSid(sid, current_user_sid))
       			result = 1;
     --		else if (git_env_bool("GIT_TEST_DEBUG_UNSAFE_DIRECTORIES", 0)) {
     -+		else if (IsWellKnownSid(sid, WinWorldSid) &&
     -+			 git_env_bool("GIT_TEST_DEBUG_UNSAFE_DIRECTORIES", 0) &&
     +-		else if (report) {
     ++		else if (report &&
     ++			 IsWellKnownSid(sid, WinWorldSid) &&
      +			 !acls_supported(path)) {
      +			/*
      +			 * On FAT32 volumes, ownership is not actually recorded.
      +			 */
     -+			warning("'%s' is on a file system that does not record ownership", path);
     -+		} else if (git_env_bool("GIT_TEST_DEBUG_UNSAFE_DIRECTORIES", 0)) {
     ++			strbuf_addf(report, "'%s' is on a file system that does"
     ++				    "not record ownership\n", path);
     ++		} else if (report) {
       			LPSTR str1, str2, to_free1 = NULL, to_free2 = NULL;
       
       			if (ConvertSidToStringSidA(sid, &str1))
 2:  be06d711a13 ! 5:  fbfaff2ec21 mingw: handle a file owned by the Administrators group correctly
     @@ Commit message
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## compat/mingw.c ##
     -@@ compat/mingw.c: int is_path_owned_by_current_sid(const char *path)
     +@@ compat/mingw.c: int is_path_owned_by_current_sid(const char *path, struct strbuf *report)
       	else if (sid && IsValidSid(sid)) {
       		/* Now, verify that the SID matches the current user's */
       		static PSID current_user_sid;
     @@ compat/mingw.c: int is_path_owned_by_current_sid(const char *path)
       
       		if (!current_user_sid)
       			current_user_sid = get_current_user_sid();
     -@@ compat/mingw.c: int is_path_owned_by_current_sid(const char *path)
     +@@ compat/mingw.c: int is_path_owned_by_current_sid(const char *path, struct strbuf *report)
       		    IsValidSid(current_user_sid) &&
       		    EqualSid(sid, current_user_sid))
       			result = 1;
     @@ compat/mingw.c: int is_path_owned_by_current_sid(const char *path)
      +			 * okay, too.
      +			 */
      +			result = 1;
     - 		else if (git_env_bool("GIT_TEST_DEBUG_UNSAFE_DIRECTORIES", 0)) {
     - 			LPSTR str1, str2, to_free1 = NULL, to_free2 = NULL;
     - 
     + 		else if (report &&
     + 			 IsWellKnownSid(sid, WinWorldSid) &&
     + 			 !acls_supported(path)) {

-- 
gitgitgadget
