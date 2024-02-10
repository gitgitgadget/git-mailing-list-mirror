Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B986C525B
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 07:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707551377; cv=none; b=GM7nBIOrqZcuD7hNixI19pHxrSxtKJ4ziFoST9vgf+QHhyEwYJNsaJRsosnkq+36IgnM5XfewpixL+/4sYCNeBdKRFnbeiPTUaxX0QvTpHjqk+gxX+ZfBqUmS9/Qp7vsb/AbqBk3tdac036ky/30Cdohpx5eASZyVTP51Peoe8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707551377; c=relaxed/simple;
	bh=kwW5c2ST8rZ3ihNiHwmfXGA9G8hTiLvpDT4gLf7LKOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kY32tx+IvJxAV20l2KikjVZbSptanQo1QlnKC1jGiZbfM1/UCbQ0TqJi0JSlP513dLkXxX79DW2j+IDUn4KRniTq06iqJJJd4MfV11UFZpHvk9Zpp2lrvtfrsQry7hMsV7lXCAbDJ87SL0MsQDXDgGqCwzobHTmLFhsHpisHqKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lz/c9DOl; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lz/c9DOl"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-21922481a2fso1128529fac.0
        for <git@vger.kernel.org>; Fri, 09 Feb 2024 23:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707551374; x=1708156174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijCi1j04LTNv/4I4ivbkzrW+GdMNuxQ6nlp3HVhJuSc=;
        b=Lz/c9DOlhRtxus/7suGxCH8UbdHPukgp+l079lefA0SZ42GNUzlnkUvrbS/G4ZMjzf
         JIATn98eKyPo/89OAUbteDIDOKSkPN2Q0+vzSGPEAXAXXz4AjSsfpRUQpLty0Qri8UEb
         CFXXh0166+QHTOSp9OT0ac9R5vpVYi0CAGNlC84qC6DUJtJS9ViKIfQavgoc0B/TAN5c
         clADd3ymBN58Ljevr2Yv+0YsiCFo4wPV4w+6WeUhA6UiHPPZDH1NNgVg6iYeSQ4gIcfq
         Nxw0i5uBL6lvgBKplaf3wdiTV5wOHeD2N5s2z2IdH/1hlIhDwSjpmDb7sqGanYuf/xmy
         V6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707551374; x=1708156174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ijCi1j04LTNv/4I4ivbkzrW+GdMNuxQ6nlp3HVhJuSc=;
        b=qjqNE1MupL42nq0YJIaeaeNFG8gC0oheNvM5UPuEPpoiFjaKKZtSevq9/5DW636W7U
         UnkM36D1fuOKLKljcpWQgsvmAQB5E6pWOU+YXW5J1IaPMAe1opSzHuqLkyFIVbWkGwu7
         MZu0e0DKIW+bTX+861kIB1XY5d7MTG/2WxVmDHOgq9aC581ohUoZG+Gt6OgIKkut9/6P
         sldfiKbjf8bQh/t0e+9HJBOlS/23aYy1xkZmpUJsyrFscFKVfIkMHmxRZxDXmmgDG0K4
         +NLHecP5BVzfzBZa93oy1PLMwkPLZ4yBRaLANud9Ff7JZYGaIEk7a4BBrtWpo2yI8eIE
         pJSg==
X-Gm-Message-State: AOJu0YyWQ8tH3XGOyKoz14HFBESP6rlyqhNjsfDHtIrvdwYiR73Z9SXp
	D/NPFQa15sCxfMkEoGbkAEIPYujh4btSrpHqpTh7u8rwaN2xueUsmQSPZ4TmTO8=
X-Google-Smtp-Source: AGHT+IGGiMx1XUto25jBgP/oWZOd6myWezi9mhjngSj3B/MIne5XCJaS8IbLLo8y1jov8O2EqoEkXA==
X-Received: by 2002:a05:6870:2114:b0:219:48a9:2d08 with SMTP id f20-20020a056870211400b0021948a92d08mr1396119oae.12.1707551373761;
        Fri, 09 Feb 2024 23:49:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW+Xl7O6zJ7LR1mlmH8f3mu59A2AuCZWIRk6xiQxHzHJImNhAQJ4kv9Wd4rTQA7GSFMgr17nFdOK5/1TVY2zWjaqRF+BCjYHzczYlHkSxgmNtNVRM17zHFUi098KIH0AxxNK+mub6zihXMTgeR4IpF7RHkZRdU8SXlQgD8y6ePv
Received: from localhost.localdomain (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id v19-20020a056870955300b00219fd9e3194sm310028oal.7.2024.02.09.23.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 23:49:32 -0800 (PST)
From: Brian Lyles <brianmlyles@gmail.com>
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>,
	newren@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com
Subject: [PATCH v2 2/8] docs: clean up `--empty` formatting in git-rebase(1) and git-am(1)
Date: Sat, 10 Feb 2024 01:43:50 -0600
Message-ID: <20240210074859.552497-3-brianmlyles@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119060721.3734775-2-brianmlyles@gmail.com>
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both of these pages document very similar `--empty` options, but with
different styles. The exact behavior of these `--empty` options differs
somewhat, but consistent styling in the docs is still beneficial. This
commit aims to make them more consistent.

Break the possible values for `--empty` into separate sections for
readability. Alphabetical order is chosen for consistency.

In a future commit, we'll be documenting a new `--empty` option for
git-cherry-pick(1), making the consistency even more relevant.

Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
---

Changes since v1:
- Options are now listed in alphabetical order per Phillip's
  recommendation.


 Documentation/git-am.txt     | 20 +++++++++++++-------
 Documentation/git-rebase.txt | 25 ++++++++++++++++---------
 2 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index e080458d6c..f852e0ba79 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -66,13 +66,19 @@ OPTIONS
 --quoted-cr=<action>::
 	This flag will be passed down to 'git mailinfo' (see linkgit:git-mailinfo[1]).

---empty=(stop|drop|keep)::
-	By default, or when the option is set to 'stop', the command
-	errors out on an input e-mail message lacking a patch
-	and stops in the middle of the current am session. When this
-	option is set to 'drop', skip such an e-mail message instead.
-	When this option is set to 'keep', create an empty commit,
-	recording the contents of the e-mail message as its log.
+--empty=(drop|keep|stop)::
+	How to handle an e-mail message lacking a patch:
++
+--
+`drop`;;
+	The e-mail message will be skipped.
+`keep`;;
+	An empty commit will be created, with the contents of the e-mail
+	message as its log.
+`stop`;;
+	The command will fail, stopping in the middle of the current `am`
+	session. This is the default behavior.
+--

 -m::
 --message-id::
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 9d7397b696..68cdebd2aa 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -289,17 +289,24 @@ See also INCOMPATIBLE OPTIONS below.
 +
 See also INCOMPATIBLE OPTIONS below.

---empty=(drop|keep|ask)::
+--empty=(ask|drop|keep)::
 	How to handle commits that are not empty to start and are not
 	clean cherry-picks of any upstream commit, but which become
 	empty after rebasing (because they contain a subset of already
-	upstream changes).  With drop (the default), commits that
-	become empty are dropped.  With keep, such commits are kept.
-	With ask, the rebase will halt when an empty commit is applied
-	allowing you to choose whether to drop it, edit files more, or just
-	commit the empty changes.
-	When the `-i`/`--interactive` option is used, the default becomes ask.
-	Otherwise, when the `--exec` option is used, the default becomes keep.
+	upstream changes):
++
+--
+`ask`;;
+	The rebase will halt when the commit is applied, allowing you to
+	choose whether to drop it, edit files more, or just commit the empty
+	changes. This option is implied when `-i`/`--interactive` is
+	specified.
+`drop`;;
+	The commit will be dropped. This is the default behavior.
+`keep`;;
+	The commit will be kept. This option is implied when `--exec` is
+	specified unless `-i`/`--interactive` is also specified.
+--
 +
 Note that commits which start empty are kept (unless `--no-keep-empty`
 is specified), and commits which are clean cherry-picks (as determined
@@ -698,7 +705,7 @@ be dropped automatically with `--no-keep-empty`).
 Similar to the apply backend, by default the merge backend drops
 commits that become empty unless `-i`/`--interactive` is specified (in
 which case it stops and asks the user what to do).  The merge backend
-also has an `--empty=(drop|keep|ask)` option for changing the behavior
+also has an `--empty=(ask|drop|keep)` option for changing the behavior
 of handling commits that become empty.

 Directory rename detection
-- 
2.43.0

