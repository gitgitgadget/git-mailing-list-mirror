Return-Path: <SRS0=Fd5/=4D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC6AC71150
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 21:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C3C2086A
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 21:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0MgnJpT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgBOVhM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Feb 2020 16:37:12 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37187 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbgBOVgz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Feb 2020 16:36:55 -0500
Received: by mail-wm1-f67.google.com with SMTP id a6so14555151wme.2
        for <git@vger.kernel.org>; Sat, 15 Feb 2020 13:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/5TWiNBQa+LnBDeU6aNAaUqHhevtYCCIHRn9vC2FzeA=;
        b=i0MgnJpT0THFHdTj6RTC9/65na23tIiISTWq2wtwF4bWPyiLxV4QZ399RyBVGxDT7B
         jvfqJuikGsg7rXq27TIF29xHWzc6cvUhtItfh67CXqJaNsYXT/drhaX1zBX3D45YVOo0
         DfZetgZ1BludZLij8/O6yYLLL/rfyjygGU8a9BOQKs8Rwq22f5lMnHhOOqQzrfQHhTew
         G0HDfgcsE5fZUjVp1uw4lBHMTR/HsTl276hAlX35d+2JbuCSldjG64glRsh925kJwdID
         fdM37WKieZ/s7pLe0TIxiCLmCmkrEeIV5qTOjHYvm7qt15XvYZHTbac3EeeGCZC+8lGC
         m29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/5TWiNBQa+LnBDeU6aNAaUqHhevtYCCIHRn9vC2FzeA=;
        b=agMpGO29u/Xxqp3mu1D0N2C5i92CKYSu6Fu3Le6vpSa4X985WLfmCqwNZpU66+tX2l
         UgXAe+pC6WaluG/zbnubtCoU/Uo+V+VdZlSz/4fbi0IpcJ6stC0oZFfpVhCtbt9D8aHS
         m1Le7UWjRQUUa7phGWtcQa2SzHpmnr9zY5mQ8QVFYyzx/gyvVIMtW72brcbR+hszSJ06
         oL9WjfdUau35LD23tH/sQ+RZ1biefrWjK0DKoN53/nxQ8FSwAxCsILLUlh6kq8ez0r0V
         nhCkfSNugj1KrkAhM/fStOb9xHQ3gYVROQhH4hJ9xKSZDjv+4F2KlVVNcUe8h8WRmKYx
         IxQQ==
X-Gm-Message-State: APjAAAWnur6CKzhLb+Ta9Ve4E6qBgB7rSBBf/dsteNqevq+GbuyJW73o
        Xz40X6oshsFj5PGBDaxmJl+m7f9P
X-Google-Smtp-Source: APXvYqwlT4gEkUR80SgEAPsMTcuSIwR8+PusrQjU1M3I6XRy1DZ9qQ0nQE6/mQqECbOi/BdZXXntEg==
X-Received: by 2002:a1c:9d08:: with SMTP id g8mr11768849wme.141.1581802611544;
        Sat, 15 Feb 2020 13:36:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p12sm12081269wrx.10.2020.02.15.13.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2020 13:36:51 -0800 (PST)
Message-Id: <11e96b9a5fab2fe18a9f97d66358febdd810d99c.1581802602.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
References: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
        <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 15 Feb 2020 21:36:32 +0000
Subject: [PATCH v5 11/20] git-rebase.txt: add more details about behavioral
 differences of backends
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt | 85 +++++++++++++++++++++++++++++++++---
 1 file changed, 80 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index e1c6f918013..6e2569cd8a7 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -416,7 +416,7 @@ with `--keep-base` in order to drop those commits from your branch.
 
 --ignore-whitespace::
 --whitespace=<option>::
-	These flag are passed to the 'git apply' program
+	These flags are passed to the 'git apply' program
 	(see linkgit:git-apply[1]) that applies the patch.
 +
 See also INCOMPATIBLE OPTIONS below.
@@ -563,8 +563,8 @@ The following options:
 
  * --committer-date-is-author-date
  * --ignore-date
- * --whitespace
  * --ignore-whitespace
+ * --whitespace
  * -C
 
 are incompatible with the following options:
@@ -615,9 +615,84 @@ handling commits that become empty.
 Directory rename detection
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Directory rename heuristics are enabled in the merge and interactive
-backends.  Due to the lack of accurate tree information, directory
-rename detection is disabled in the am backend.
+Due to the lack of accurate tree information (arising from
+constructing fake ancestors with the limited information available in
+patches), directory rename detection is disabled in the am backend.
+Disabled directory rename detection means that if one side of history
+renames a directory and the other adds new files to the old directory,
+then the new files will be left behind in the old directory without
+any warning at the time of rebasing that you may want to move these
+files into the new directory.
+
+Directory rename detection works with the merge and interactive
+backends to provide you warnings in such cases.
+
+Context
+~~~~~~~
+
+The am backend works by creating a sequence of patches (by calling
+`format-patch` internally), and then applying the patches in sequence
+(calling `am` internally).  Patches are composed of multiple hunks,
+each with line numbers, a context region, and the actual changes.  The
+line numbers have to be taken with some fuzz, since the other side
+will likely have inserted or deleted lines earlier in the file.  The
+context region is meant to help find how to adjust the line numbers in
+order to apply the changes to the right lines.  However, if multiple
+areas of the code have the same surrounding lines of context, the
+wrong one can be picked.  There are real-world cases where this has
+caused commits to be reapplied incorrectly with no conflicts reported.
+Setting diff.context to a larger value may prevent such types of
+problems, but increases the chance of spurious conflicts (since it
+will require more lines of matching context to apply).
+
+The interactive backend works with a full copy of each relevant file,
+insulating it from these types of problems.
+
+Labelling of conflicts markers
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+When there are content conflicts, the merge machinery tries to
+annotate each side's conflict markers with the commits where the
+content came from.  Since the am backend drops the original
+information about the rebased commits and their parents (and instead
+generates new fake commits based off limited information in the
+generated patches), those commits cannot be identified; instead it has
+to fall back to a commit summary.  Also, when merge.conflictStyle is
+set to diff3, the am backend will use "constructed merge base" to
+label the content from the merge base, and thus provide no information
+about the merge base commit whatsoever.
+
+The interactive backend works with the full commits on both sides of
+history and thus has no such limitations.
+
+Hooks
+~~~~~
+
+The am backend has not traditionally called the post-commit hook,
+while the merge/interactive backend has.  However, this was by
+accident of implementation rather than by design.  Both backends
+should have the same behavior, though it is not clear which one is
+correct.
+
+Miscellaneous differences
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+There are a few more behavioral differences that most folks would
+probably consider inconsequential but which are mentioned for
+completeness:
+
+* Reflog: The two backends will use different wording when describing
+  the changes made in the reflog, though both will make use of the
+  word "rebase".
+
+* Progress, informational, and error messages: The two backends
+  provide slightly different progress and informational messages.
+  Also, the am backend writes error messages (such as "Your files
+  would be overwritten...") to stdout, while the interactive backend
+  writes them to stderr.
+
+* State directories: The two backends keep their state in different
+  directories under .git/
 
 include::merge-strategies.txt[]
 
-- 
gitgitgadget

