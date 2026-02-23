Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C055221726
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 19:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771875824; cv=none; b=YfqcS7pAFABohJM/m7fqw3uq44nB//OJ2sWX2ROXM4tiHuKCvNowsbWaTLcJy6MygJOCKt8YDOWoqw8gzGMTE/inUO7w5UDaO+bl0GdTPOqnLoe9F1fTuAcMPGplbBBfoyMK+hyjoNo9ufDIgltAsGqrGJZWNzUZ84SjxCArUe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771875824; c=relaxed/simple;
	bh=UzUjEsXfixeH64WqulsbYPLUqR4NSsyJJkS4OL2XeLg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XtDqX092iCC3u3UzReiNd9aXk51yzI93g874xkR0k97mvV19dauYsAivPkFcLit0gqAHQa6THEkPbRFy7VSQdw+k/chA7uHM5R5UOoS13LEFFtarMWF0t5uJchcBXqqI65tN6cFNB++x8nhDpCUQxdyQ8VwjrakrHl6ahFn/ErU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCWygdQB; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCWygdQB"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5069df1de6fso43878791cf.3
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 11:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771875822; x=1772480622; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOPopmPoGWGWKnwfbW1TSflXsICPTQ+Lou23+I60oDc=;
        b=dCWygdQBrPfG0xQPILs5YsLR+IGzcc4HEOEWKek3g8uo3V4wRCVx2rkaXl9qh/KeJy
         nj5MQwnhaU0yUWKXTBrr1Pxs2VCCgtSObo01ovFqnJzBjWIx4SOowow5cwv3e0cBsWFT
         OE5qMq4BdN6h1P5tRtOZ9ZsNYRGiar6JEcgWc4i3sX8t4NjnFP8SPiXCCQN9q778gUup
         A0QfdXHf2MkekmdOA5CLr1ZE39Md3hR4+yupxNs7MApIBBYyf1N7WFxyjeP1a9SIGTDO
         Nzl90LqXrmEYg9sRhFdPyPKdOQ2kycRaRWSE3GocSj9lxplxwew3vK+69ZnGnNa/TUuh
         e4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771875822; x=1772480622;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TOPopmPoGWGWKnwfbW1TSflXsICPTQ+Lou23+I60oDc=;
        b=iyKiM/7PQfJdxBpGF0VND/00YHr4wd2LIluXptUVJW9Rv/ms8LE66aUoL7AFqqzOh1
         TOYUD7s2PVbeivTQhnkpN7bOD7CJjVYaSweMnxEQ1AqGD8yPBRvj/jGAk4ZOmbduUl7e
         Sb1Q4ahvjK5vO/jjiDtBawgS7qqGK64MoeztS6EaHPnjHx0A9S+lcNyk0dyVsw+fgOsp
         7CjccP4JuliZeHGlbc7GKfJ5I/I4Nv51Ez69MwqzlmAt+mwvIY2a00chPpaarpa/7uCh
         ABwBAeOp1bVIWhr7zLJ+oRLHUkvIXDe4G0M0uQftZ80WYNG/d3pDFl7cUy4UAx4vfO/l
         nZjw==
X-Gm-Message-State: AOJu0YztXt4wSBh2BfQ69wEbWh87dEKryGFJdYbVvZ+GHnmq/TXbOgsy
	cGyFVodeiR5yEG2OPKGNIb7QCkdI7cqL+AQkTBu8Cy6Iq5XbNfdeC0cSL0R8qg==
X-Gm-Gg: AZuq6aLDL/FK8+GSrBCY/4ZkmGZwJQ3aFM/6ZkNtomIFjqOyym74GdT2eudI4UHdkiV
	sVXoZDgTt7+2yF0nx2bMGK1lhPcWhPacNUsF63zctTAQIM4AWxSriJWwiD0nxG5H2MT9YbNvhsQ
	74lFZdtNi5dH155Ifl+nLnBbWt7Wf+ugDUEB/3hKhVo7xCcqKugHQvWNQ52pwvcbAxYs2mTHPMp
	6owLVWnrgh/FvslBRcx5srN+HLU6FmshV19kLu2nlL0iJFhfxKb0I2+4tHotMWZS1f0wfpcIMH7
	pFxGy/TcsVadvhZBj4BW7yiSwzLTMKIDBXLaV+PEsIEL3UkVU1Hqfh3YwR7iOuBwq0yoi7BK8xE
	eDrU9WLn6nP9Iwj/0DVVqRkV8IXx812APa8LXHvXqqem08gQpnjCyRrirh7AQrScVMwEJsyb5zO
	9eYA4Cg5tU4CX+yUCFQ+etLxPHl46QCVmkOYDmSA==
X-Received: by 2002:ac8:5844:0:b0:4ff:9688:7dca with SMTP id d75a77b69052e-5070bba1e92mr143407491cf.8.1771875821739;
        Mon, 23 Feb 2026 11:43:41 -0800 (PST)
Received: from [127.0.0.1] ([135.232.224.163])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e62fee8sm90470506d6.42.2026.02.23.11.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 11:43:41 -0800 (PST)
Message-Id: <a2a6768042239b62faff71b0bcf1cc3144f6bc7f.1771875812.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v3.git.git.1771875812.gitgitgadget@gmail.com>
References: <pull.2208.v2.git.git.1771856469.gitgitgadget@gmail.com>
	<pull.2208.v3.git.git.1771875812.gitgitgadget@gmail.com>
From: "Eslam reda ragheb via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Feb 2026 19:43:32 +0000
Subject: [PATCH v3 5/5] docs: describe repo info path keys
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
Cc: Karthik Nayak <karthik.188@gmail.com>,
    Justin Tobler <jltobler@gmail.com>,
    Ayush Chandekar <ayu.chandekar@gmail.com>,
    Siddharth Asthana <siddharthasthana31@gmail.com>,
    Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
    eslam reda <eslam.reda.div@gmail.com>,
    Eslam reda ragheb <eslam.reda.div@gmail.com>

From: Eslam reda ragheb <eslam.reda.div@gmail.com>

Document repo info category keys, path.* keys, and
--path-format behavior.

Signed-off-by: Eslam reda ragheb <eslam.reda.div@gmail.com>
---
 Documentation/git-repo.adoc | 60 ++++++++++++++++++++++++++++++++++---
 1 file changed, 56 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 7d70270dfa..6e99951343 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -8,7 +8,7 @@ git-repo - Retrieve information about the repository
 SYNOPSIS
 --------
 [synopsis]
-git repo info [--format=(keyvalue|nul) | -z] [--all | <key>...]
+git repo info [--format=(keyvalue|nul) | -z] [--path-format=(absolute|relative)] [--all | <key>...]
 git repo structure [--format=(table|keyvalue|nul) | -z]
 
 DESCRIPTION
@@ -44,6 +44,11 @@ supported:
 +
 `-z` is an alias for `--format=nul`.
 
+`--path-format=(absolute|relative)`:::
+	Controls formatting for keys in the `path` category. The default is
+	`absolute`. This option may be specified multiple times; the last one
+	specified takes effect.
+
 `structure [--format=(table|keyvalue|nul) | -z]`::
 	Retrieve statistics about the current repository structure. The
 	following kinds of information are reported:
@@ -78,9 +83,11 @@ supported:
 
 INFO KEYS
 ---------
-In order to obtain a set of values from `git repo info`, you should provide
-the keys that identify them. Here's a list of the available keys and the
-values that they return:
+In order to obtain values from `git repo info`, provide either individual keys
+or category names. A category returns all keys within that category. For
+example, `layout` returns both `layout.bare` and `layout.shallow`.
+
+Here's a list of the available keys and the values that they return:
 
 `layout.bare`::
 	`true` if this is a bare repository, otherwise `false`.
@@ -91,6 +98,51 @@ values that they return:
 `object.format`::
 	The object format (hash algorithm) used in the repository.
 
+`path.common-dir`::
+	The path to the common git directory.
+
+`path.config-file`::
+	The path to the `config` file in the git directory.
+
+`path.git-dir`::
+	The path to the git directory.
+
+`path.git-prefix`::
+	The path of the current working directory relative to the top-level
+	directory.
+
+`path.grafts-file`::
+	The path to the `info/grafts` file.
+
+`path.hooks-directory`::
+	The path to the `hooks` directory.
+
+`path.index-file`::
+	The path to the index file.
+
+`path.logs-directory`::
+	The path to the `logs` directory.
+
+`path.objects-directory`::
+	The path to the objects directory.
+
+`path.packed-refs-file`::
+	The path to the `packed-refs` file.
+
+`path.refs-directory`::
+	The path to the `refs` directory.
+
+`path.shallow-file`::
+	The path to the `shallow` file.
+
+`path.superproject-working-tree`::
+	The path to the superproject's working tree root, or an empty string
+	when the repository is not used as a submodule.
+
+`path.toplevel`::
+	The path to the top-level working tree directory, or an empty string
+	for bare repositories.
+
 `references.format`::
 	The reference storage format. The valid values are:
 +
-- 
gitgitgadget
