Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E087301490
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 23:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755127225; cv=none; b=aqmnP2KVCl4nE8CtwP05XtZBw/r0rbqlEtRM+o5AK5Dx7XrYMIn6bhjMknFJdZkDB+6UhjtiaNryHsx4oNpPWAPjHfxElxsiAouaj/7vUI2DZW5lk5WAlRCKGJvtmVY1IczpSfBXZZvxNtYH3x2tT/OP+0+W7seEg2VEJDZN/g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755127225; c=relaxed/simple;
	bh=holjnUqzKW1w44wz57P7oWqyX4ohKYmyyyJgaBBeA8Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UINS+dhqsnnP04JxkFspP/3W8najV76bAidfkffGm2885D4nQ7qzLlrGIi/V5itk0cGT66RBjwrlpnuKH8CRWwW6iJNeaXiAB7iLslfJ6Ba6U4SPqTBxvIhO8lIjBD6po6wmYPeDQjC6RAoP3CyQ3AtgzxKA0eLqVDrPsqX3Kws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtGuEKW8; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtGuEKW8"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45a1b0d0bc0so2111615e9.3
        for <git@vger.kernel.org>; Wed, 13 Aug 2025 16:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755127221; x=1755732021; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkBb9+m2uF+tN0tse2ITtw4y2bImSEnbBkaR9TI8BiY=;
        b=PtGuEKW8AtIl0xt6EoHYqVt/3D7vbBSFAMDrOlLbYRJqbUey7u1itKMg3dp3cY4WVf
         P1PkZKIQjccPXJNfxLuI5mqYx0Z2vqVSaEYkuPu0Eq4bAhfCxUvg3x2hpg2z/Wspt3r+
         tVay5TWAKcSPpJXYx16tg2wY+WGIBI16r3u93T7qdsNsYdVYdnN8Xa7kHHlXOVwdq0NN
         l3PDQ3wDgR6AY0bMDmYsFaXzVRav9ghZwK8QrDm9YO6L+lzrscXwKQLposDwsN7Sv98i
         IyNfjwKbK6r9DjG9QEuud2bpyd0Co9Hv/QqIRlGhh0g6VBUa/EJbkU026bsi+69Duwvp
         P8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755127221; x=1755732021;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kkBb9+m2uF+tN0tse2ITtw4y2bImSEnbBkaR9TI8BiY=;
        b=l9w1RdrvcVNRxvbuH7d0vp2DSw68/pjvC0MOVcVpZtOPsbJ/jj4nWNYHsSC6eiGxev
         MvzY1pgHy6on6r6fD4f0uH8ZwS9uv1DiOJSTTSQi2P5GruvjxIwqvFODALvALaAO6+mZ
         E9ey6hLJUyJWBnPijnpl8S/dyKME13F1INySSqbthpTxYpAEJXzO9tT3U7NiSnSOc2Sr
         OCejSz5KVcMz/UyxY85VMWxrZfgGtbTvAN9FTk8G4UP2Q9vd9yTAncszvwnNeMjYuytT
         9L95BXkOZrBaO98vGIjl0Cg21pJXAmcxEKQtOR8MFAZL4AoCO/1v9lwS4r69VJDJB+Ew
         1N4Q==
X-Gm-Message-State: AOJu0Yy9Qg/V1vYsP2uZPKFrCfBwhrz4LLPjONR609qVgaOGYLWev49S
	WWM9BQVCD1MW3pZfkQIQ78+ElVR+glgQnrpCnnIH876uFpN3fptu5SqzUmG0Ig==
X-Gm-Gg: ASbGncunjFVbINmFO7GgPa9mQ3cELi4YnX0luu11eUi/pasOLrB+WsUaf5hwQo22k6O
	EAeJXvdQzX5Ks51Cb0J+ilnsvtVruTJaTHr03jMMKlUVVPC5PW5zCfE5hqEjcXqtbgOMTJR1EbC
	bLQkO++sNTonOCyDjcsMlx78HjQ1BnPzVnyGJFQ8u9LWAAe+WUQPCilkzE082lVqoSgzqwBltmv
	7s6TGDgQP/5oGDCYDCebxfDvxbNSkrZbJMzG/DgRO+XSVoAmpgkZP3kDWBuV2vvu2wf0C9dqLpX
	n3abroQRhwGl3BjVrFwdQdu9RbQ0LR/h01xZ8A9bDs/HSpoiJQPuTBbSFtsDn5sLKiwfTl3klD9
	ioNKaYUk0KYdxtYL8FdiPU9RESVuKpNzo8g==
X-Google-Smtp-Source: AGHT+IG7E94pP8wAw5PEYrR5IUuFKpc39Mw3OHZiy6O3BhdOb1WvmwKxw15TcIikHh/fLtKbFnLE0g==
X-Received: by 2002:a05:600c:1ca4:b0:459:d4b5:623a with SMTP id 5b1f17b1804b1-45a1b60f58emr3959055e9.9.1755127220915;
        Wed, 13 Aug 2025 16:20:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1a541c3bsm17435515e9.29.2025.08.13.16.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 16:20:20 -0700 (PDT)
Message-Id: <d041d09589b51734a8cc257f80cdaf210c6676e7.1755127218.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1952.v2.git.1755127218.gitgitgadget@gmail.com>
References: <pull.1952.git.1755029249.gitgitgadget@gmail.com>
	<pull.1952.v2.git.1755127218.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 13 Aug 2025 23:20:15 +0000
Subject: [PATCH v2 1/4] doc: git-add: start man page with an example
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
Cc: Chris Torek <chris.torek@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

- Replace the intro paragraph of the `git-add` man page with an
  example to try to clarify it for new users. The goal here is use less
  jargon but communicate essentially the same information.
- Give an example of how to add only part of the changes to the file
- Remove the snapshot-based explanation of the index and replace it with
  a diff-based explanation because I don't feel that it's useful in this
  context to emphasize  that git uses a snapshot-based model: the main
  way most git users interact with the index is through `git diff` or
  `git status`, which is a completely diff-based view of the index.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-add.adoc | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
index b7a735824d6c..949b016e6fa2 100644
--- a/Documentation/git-add.adoc
+++ b/Documentation/git-add.adoc
@@ -3,7 +3,7 @@ git-add(1)
 
 NAME
 ----
-git-add - Add file contents to the index
+git-add - Add new or changed files to the index
 
 SYNOPSIS
 --------
@@ -16,18 +16,20 @@ git add [--verbose | -v] [--dry-run | -n] [--force | -f] [--interactive | -i] [-
 
 DESCRIPTION
 -----------
-This command updates the index using the current content found in
-the working tree, to prepare the content staged for the next commit.
-It typically adds the current content of existing paths as a whole,
-but with some options it can also be used to add content with
-only part of the changes made to the working tree files applied, or
-remove paths that do not exist in the working tree anymore.
-
-The "index" holds a snapshot of the content of the working tree, and it
-is this snapshot that is taken as the contents of the next commit.  Thus
-after making any changes to the working tree, and before running
-the commit command, you must use the `add` command to add any new or
-modified files to the index.
+Add new or changed files to the index to prepare for a commit. The
+"index" (also known as "staging area") is where Git stores the changes
+that will be in the next commit.
+
+By default, `git commit` only commits changes that you've added to the
+index. For example, if you've edited `file.c` and want to commit your
+changes, you can run:
+
+   git add file.c
+   git commit
+
+You can also add only part of your changes to a file with `git add -p`.
+Please see linkgit:git-commit[1] for alternative ways to add content to
+a commit.
 
 This command can be performed multiple times before a commit.  It only
 adds the content of the specified file(s) at the time the add command is
@@ -44,10 +46,6 @@ directory recursion or filename globbing performed by Git (quote your
 globs before the shell) will be silently ignored.  The `git add` command can
 be used to add ignored files with the `-f` (force) option.
 
-Please see linkgit:git-commit[1] for alternative ways to add content to a
-commit.
-
-
 OPTIONS
 -------
 `<pathspec>...`::
-- 
gitgitgadget

