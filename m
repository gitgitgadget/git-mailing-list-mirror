Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9841C77B61
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 19:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjDJTqK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 15:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDJTqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 15:46:09 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0D11BD9
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 12:46:06 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id w21so5304064wra.4
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 12:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681155965;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7d9FsvV6oRM8kPya+unxlrbbM+Mrju44AkjR078AdU=;
        b=h4Ow202Git7O+dmw/P8kagjyupKgTdcnFdZwOiUk3Mu79h3kcfWLQzrHYBDkSGxK8x
         ivPq6XPbhXSiDREvMCXZt4Qavpr/1ZVqPPfItc+RdfBFOArPhGdY4UhjjxQZuOvGOFW3
         vrfeHpdvBXHCK12Yq1B7e7eBXjk61dhMT85shAGKmiYcwmwPTxMKqa8W4vs+n/oNRXBX
         MlPl/ADboA3Nf3xeV/g7FHcjS4fQ0qmMhuKx/M8oWg00K7j6rPNFvsN2BXlG865LTBzI
         TCgahtfsEmx2+HZPp9ozgCXOphdjQ3AHi6o/E25cOtq3ozm/Zex0L0BW4ZlMnR2fm23o
         WUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681155965;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B7d9FsvV6oRM8kPya+unxlrbbM+Mrju44AkjR078AdU=;
        b=fS5ZDz4uYqQRoV1zM2PFlOHSaOzjqylxvzWtKJs2sNs5xBqhPnnqa5nM+iLtu9QWnY
         fNcxEYIVeBO8Sgdy2GM+SvLyWs7Ls0QjDzoz6paeBI5z+SSvBVkAvnIGpi32HUu/wmY1
         tcaaQbsOGnBNYUDdMisgF7oG4K2yd57HMq/sgvSzAFARQD/jelTCDStDp8q6H/woUdD1
         vD4nEj1ZkGh8HRkVUKcUfYISi7ItCbuoZaOW4mUMHYoATu/6Kfk1tmZqlD1+EXZIQkBQ
         8Mc0hb2qSYLADpjoY9ARhZFAhqxemu4lhH7lO5KqLpOgL8Fn3LDRYCuaxsLwjZh1u2Xs
         EYxQ==
X-Gm-Message-State: AAQBX9dIaekN9u9qP8I6zbLujYBXDj7FIl4JdIwhZnYJSO/usKdYU4iD
        t4EYmEjcz9wLQdZiJ/zW5f+PG4kE/w4=
X-Google-Smtp-Source: AKy350aEf8EWVzIf8jlNyJtVY2XTeDhd7cZ6+a4NyoAfvDpDGETnQbhHiwj/6xJt3j/h5TGsFH0d2Q==
X-Received: by 2002:a5d:6b8e:0:b0:2ef:b4a5:69c with SMTP id n14-20020a5d6b8e000000b002efb4a5069cmr6781333wrx.11.1681155965066;
        Mon, 10 Apr 2023 12:46:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x18-20020adfec12000000b002f2b8cb5d9csm628769wrn.28.2023.04.10.12.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 12:46:04 -0700 (PDT)
Message-Id: <pull.1503.v2.git.1681155963011.gitgitgadget@gmail.com>
In-Reply-To: <pull.1503.git.1679678090412.gitgitgadget@gmail.com>
References: <pull.1503.git.1679678090412.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Apr 2023 19:46:02 +0000
Subject: [PATCH v2] fsmonitor: handle differences between Windows named pipe
 functions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric DeCosta <edecosta@mathworks.com>,
        Eric DeCosta <edecosta@mathworks.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric DeCosta <edecosta@mathworks.com>

The two functions involved with creating and checking for the existance of
the local fsmonitor named pipe, CratedNamedPipeW and WaitNamedPipeW appear
to handle names with leading slashes or backslashes a bit differently.

If a repo resolves to a remote file system with the UNC path of
//some-server/some-dir/some-repo, CreateNamedPipeW accepts this name and
creates this named pipe: \\.\pipe\some-server\some-dir\some-repo

However, when the same UNC path is passed to WaitNamedPipeW, it fails with
ERROR_FILE_NOT_FOUND.

Skipping the leading slash for UNC paths works for both CreateNamedPipeW and
WaitNamedPipeW. Resulting in a named pipe with the same name as above that
WaitNamedPipeW is able to correctly find.

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
    fsmonitor: handle differences between Windows named pipe functions
    
    The two functions involved with creating and checking for the existance
    of the local fsmonitor named pipe, CratedNamedPipeW and WaitNamedPipeW
    appear to handle names with leading slashes or backslashes a bit
    differently.
    
    If a repo resolves to a remote file system with the UNC path of
    //some-server/some-dir/some-repo, CreateNamedPipeW accepts this name and
    creates this named pipe: .\pipe\some-server\some-dir\some-repo
    
    However, when the same UNC path is passed to WaitNamedPipeW, it fails
    with ERROR_FILE_NOT_FOUND.
    
    Skipping the leading slash for UNC paths works for both CreateNamedPipeW
    and WaitNamedPipeW. Resulting in a named pipe with the same name as
    above that WaitNamedPipeW is able to correctly find.
    
    v1 differs from v0:
    
     * Abandon hashing repo path in favor of simpler solution where the
       leading slash is simply dropped for UNC paths

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1503%2Fedecosta-mw%2Ffsmonitor_windows-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1503/edecosta-mw/fsmonitor_windows-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1503

Range-diff vs v1:

 1:  c5307928cd7 ! 1:  b41f9bd2e96 fsmonitor: handle differences between Windows named pipe functions
     @@ Metadata
       ## Commit message ##
          fsmonitor: handle differences between Windows named pipe functions
      
     -    CreateNamedPipeW is perfectly happy accepting pipe names with seemingly
     -    embedded escape charcters (e.g. \b), WaitNamedPipeW is not and incorrectly
     -    returns ERROR_FILE_NOT_FOUND when clearly a named pipe, succesfully created
     -    with CreateNamedPipeW, exists.
     +    The two functions involved with creating and checking for the existance of
     +    the local fsmonitor named pipe, CratedNamedPipeW and WaitNamedPipeW appear
     +    to handle names with leading slashes or backslashes a bit differently.
      
     -    For example, this network path is problemmatic:
     -    \\batfs-sb29-cifs\vmgr\sbs29\my_git_repo
     +    If a repo resolves to a remote file system with the UNC path of
     +    //some-server/some-dir/some-repo, CreateNamedPipeW accepts this name and
     +    creates this named pipe: \\.\pipe\some-server\some-dir\some-repo
      
     -    In order to work around this issue, rather than using the path to the
     -    worktree directly as the name of the pipe, instead use the hash of the
     -    worktree path.
     +    However, when the same UNC path is passed to WaitNamedPipeW, it fails with
     +    ERROR_FILE_NOT_FOUND.
     +
     +    Skipping the leading slash for UNC paths works for both CreateNamedPipeW and
     +    WaitNamedPipeW. Resulting in a named pipe with the same name as above that
     +    WaitNamedPipeW is able to correctly find.
      
          Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
      
       ## compat/simple-ipc/ipc-win32.c ##
     -@@
     - #include "cache.h"
     -+#include "hex.h"
     - #include "simple-ipc.h"
     - #include "strbuf.h"
     - #include "pkt-line.h"
      @@
       static int initialize_pipe_name(const char *path, wchar_t *wpath, size_t alloc)
       {
       	int off = 0;
     --	struct strbuf realpath = STRBUF_INIT;
     --
     --	if (!strbuf_realpath(&realpath, path, 0))
     --		return -1;
     -+	int ret = 0;
     -+	git_SHA_CTX sha1ctx;
     -+	struct strbuf real_path = STRBUF_INIT;
     -+	struct strbuf pipe_name = STRBUF_INIT;
     -+	unsigned char hash[GIT_MAX_RAWSZ];
     ++	int real_off = 0;
     + 	struct strbuf realpath = STRBUF_INIT;
       
     --	off = swprintf(wpath, alloc, L"\\\\.\\pipe\\");
     --	if (xutftowcs(wpath + off, realpath.buf, alloc - off) < 0)
     -+	if (!strbuf_realpath(&real_path, path, 0))
     + 	if (!strbuf_realpath(&realpath, path, 0))
       		return -1;
       
     --	/* Handle drive prefix */
     --	if (wpath[off] && wpath[off + 1] == L':') {
     --		wpath[off + 1] = L'_';
     --		off += 2;
     --	}
     -+	git_SHA1_Init(&sha1ctx);
     -+	git_SHA1_Update(&sha1ctx, real_path.buf, real_path.len);
     -+	git_SHA1_Final(hash, &sha1ctx);
     -+	strbuf_release(&real_path);
     - 
     --	for (; wpath[off]; off++)
     --		if (wpath[off] == L'/')
     --			wpath[off] = L'\\';
     -+	strbuf_addf(&pipe_name, "git-fsmonitor-%s", hash_to_hex(hash));
     -+	off = swprintf(wpath, alloc, L"\\\\.\\pipe\\");
     -+	if (xutftowcs(wpath + off, pipe_name.buf, alloc - off) < 0)
     -+		ret = -1;
     - 
     --	strbuf_release(&realpath);
     --	return 0;
     -+	strbuf_release(&pipe_name);
     -+	return ret;
     - }
     ++	/* UNC Path, skip leading slash */
     ++	if (realpath.buf[0] == '/' && realpath.buf[1] == '/')
     ++		real_off = 1;
     ++
     + 	off = swprintf(wpath, alloc, L"\\\\.\\pipe\\");
     +-	if (xutftowcs(wpath + off, realpath.buf, alloc - off) < 0)
     ++	if (xutftowcs(wpath + off, realpath.buf + real_off, alloc - off) < 0)
     + 		return -1;
       
     - static enum ipc_active_state get_active_state(wchar_t *pipe_path)
     + 	/* Handle drive prefix */


 compat/simple-ipc/ipc-win32.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/compat/simple-ipc/ipc-win32.c b/compat/simple-ipc/ipc-win32.c
index 997f6144344..632b12e1ab5 100644
--- a/compat/simple-ipc/ipc-win32.c
+++ b/compat/simple-ipc/ipc-win32.c
@@ -19,13 +19,18 @@
 static int initialize_pipe_name(const char *path, wchar_t *wpath, size_t alloc)
 {
 	int off = 0;
+	int real_off = 0;
 	struct strbuf realpath = STRBUF_INIT;
 
 	if (!strbuf_realpath(&realpath, path, 0))
 		return -1;
 
+	/* UNC Path, skip leading slash */
+	if (realpath.buf[0] == '/' && realpath.buf[1] == '/')
+		real_off = 1;
+
 	off = swprintf(wpath, alloc, L"\\\\.\\pipe\\");
-	if (xutftowcs(wpath + off, realpath.buf, alloc - off) < 0)
+	if (xutftowcs(wpath + off, realpath.buf + real_off, alloc - off) < 0)
 		return -1;
 
 	/* Handle drive prefix */

base-commit: f285f68a132109c234d93490671c00218066ace9
-- 
gitgitgadget
