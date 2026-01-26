Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652B22D979F
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 21:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769462752; cv=none; b=XHLqHq+bFxdWm69MrtRzxlFyqNeiPkxUVzUlC3kkX/7YV59URYN1ccBEjtilWlQNsRjx/BV0CzNTtq1HUwmdWGLRk2Q9N63UUM9qnKsg8SYZMt25xnpG8v/aezbtMExnezaQhW7xCPAPqbZXBAYh3PZB3z9bFaTHHU0PqpiX3zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769462752; c=relaxed/simple;
	bh=4oCQV383JqWryli1a3Zkmdcx8T7b2nsXwkxFRoqd5fg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=eHO1nKi77J+zRP3TcjkOhrhhNzScdwL28mRgAf+6M0tbFcvs5SpQtfjhU5PVSk7bxfCdEX4na5t11E+e6QBoNCFtwRZpih+DAz8pOzh49/CZvdVWqQ8ghur96c7x5ZFiti6lxw80gKhJK2QNgP+IVKYb0iTqbCfckg1adwYwoAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNxbyI34; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNxbyI34"
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-12332910300so855436c88.0
        for <git@vger.kernel.org>; Mon, 26 Jan 2026 13:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769462750; x=1770067550; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZUatlVYQmchdq678m6RZr2UIaBwwzA1V2bH78z3eD8=;
        b=fNxbyI34LX77XexPNLTHj3S6+B23wRQ8/8kQ2Kc2atrxX34rsiCXT59SQUpdy+YJp+
         rVo9H8/vEr+f0acHIMI3n/mucBFOVE+gBK4g69UZ2glc3dBgiG4iMnUqBKwGr9d4XP8T
         RfKZxXvdb8hRY0az0od65Ef7Irjotomdh31nWCnGSKwALE4+/Yge7GV+G4NX5KuClz0M
         WD4HDNy2M3BkDz874MOQ2QxChL+/ZDc1Fc8E44tbiARK4caupp4X3YlJa83Depx9wfYc
         NzaKzYLb6yqDH+R7CruKqHRKFqMKnnJT6aR6vbcVtMBjip0q/nkXc7FPLjTpPFiFu74U
         sBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769462750; x=1770067550;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xZUatlVYQmchdq678m6RZr2UIaBwwzA1V2bH78z3eD8=;
        b=acRf4r86octkNK8F63+sW5KIqFRAcG4hTzy2RdF+kq39ReW8qzlK6MemVjd1g2pTII
         Udd+Botj4dvDStNeIyp9uCoeFYI4n9LL5CqyYZNFHjFTeuJxAdqPD4JuQDbzFOj1cf/p
         lJ+g/f7/CI5mf+QZ3IvzAlQHn95R+7jskPF0Thw7bvlxO9/Cw3wKsLifY5SsfitG/F83
         06IHX08YKQHoyzmka9slnG6CbfgQKfyVroodTuU9anTzx7a+OWF6j2oAoyqM9WrruxTT
         tCF2BAEhvB9j7C6Oxy6DCvZ+c2vCyWHPBAqMMIGa3sAy6NIIUGsdC/J06AIBnLyoQDCa
         J4jw==
X-Gm-Message-State: AOJu0YwvU8d79Ez8uqLgL3bGuqNB8xyURZB2RDtHQQRenWNvLmaYqGXV
	xKJz48BOb/NKPnV4UM9IzkP1asAyPX19Fdy4dAMv192vGK1/PypZrEpFK9z3u7cB
X-Gm-Gg: AZuq6aJL9y2aQdNsr8EUcJM25cFW8VZwbJb/r1/qoZ/17xZrF1PjdOkWvpC21h0fDTr
	sUJSMCfyBYa2uvWjAtmGL+iA4l55ZfxVptXtAI93I8vcmRxwoL4X9I2IDMHgRFJ8TSwMM62+8kj
	jb/3tEGD+ER1kNB/vcyB/em6G7/W8kDUx6PNtCGb2fqHmMaDrSgIfcaSIc3K9vWG/Fe7L0Kfyv/
	rhrkJgeFlnDj5i+6yfsI6qGd1F75/7GADX9LCA0FpBVFxXVGRQmXHbmj38zWuGZ994DQCGVK9jI
	waE1tzqiFdPkhvX8YNWoeElpIHCE5oBh+eeyXFscHtwpSp8YiMFXaFhx23mGfhwdtBwvXGBsYh0
	U6Jp/6259i+AbxIn24lYbrT0NFspyHX7ZljiMXYTjIzeuXAWbYLrb/kyjMiUWDYYNudDIyw6K6z
	/VNJLDQsQV2uwA
X-Received: by 2002:a05:7022:6885:b0:11b:ca88:c503 with SMTP id a92af1059eb24-1248ebec16bmr2921612c88.3.1769462749837;
        Mon, 26 Jan 2026 13:25:49 -0800 (PST)
Received: from [127.0.0.1] ([68.220.59.208])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d9a4698sm19618739c88.16.2026.01.26.13.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 13:25:49 -0800 (PST)
Message-Id: <3a5b642d05b9fcafb684631a0026959bfc362d2b.1769462744.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2036.v2.git.1769462744.gitgitgadget@gmail.com>
References: <pull.2036.git.1769202903.gitgitgadget@gmail.com>
	<pull.2036.v2.git.1769462744.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Jan 2026 21:25:42 +0000
Subject: [PATCH v2 2/4] doc: finalize git-clone documentation conversion to
 synopsis style
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Use backticks where appropriate for command-line options

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-clone.adoc | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-clone.adoc b/Documentation/git-clone.adoc
index 57cdfb7620..7a0e147384 100644
--- a/Documentation/git-clone.adoc
+++ b/Documentation/git-clone.adoc
@@ -152,7 +152,7 @@ objects from the source repository into a pack in the cloned repository.
 	unknown ones, is server-specific.
 	When multiple `--server-option=<option>` are given, they are all
 	sent to the other side in the order listed on the command line.
-	When no ++--server-option=++__<option>__ is given from the command
+	When no `--server-option=<option>` is given from the command
 	line, the values of configuration variable `remote.<name>.serverOption`
 	are used instead.
 
@@ -206,14 +206,14 @@ objects from the source repository into a pack in the cloned repository.
 	that all these refs are overwritten by a `git remote update` in the
 	target repository.
 
-`-o` _<name>_::
-`--origin` _<name>_::
+`-o <name>`::
+`--origin <name>`::
 	Instead of using the remote name `origin` to keep track of the upstream
 	repository, use _<name>_.  Overrides `clone.defaultRemoteName` from the
 	config.
 
-`-b` _<name>_::
-`--branch` _<name>_::
+`-b <name>`::
+`--branch <name>`::
 	Instead of pointing the newly created `HEAD` to the branch pointed
 	to by the cloned repository's `HEAD`, point to _<name>_ branch
 	instead. In a non-bare repository, this is the branch that will
@@ -230,8 +230,8 @@ objects from the source repository into a pack in the cloned repository.
 	name.
 	This option is incompatible with `--branch` and `--mirror`.
 
-`-u` _<upload-pack>_::
-`--upload-pack` _<upload-pack>_::
+`-u <upload-pack>`::
+`--upload-pack <upload-pack>`::
 	When given, and the repository to clone from is accessed
 	via ssh, this specifies a non-default path for the command
 	run on the other end.
@@ -240,8 +240,8 @@ objects from the source repository into a pack in the cloned repository.
 	Specify the directory from which templates will be used;
 	(See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)
 
-`-c` `<key>=<value>`::
-`--config` `<key>=<value>`::
+`-c <key>=<value>`::
+`--config <key>=<value>`::
 	Set a configuration variable in the newly-created repository;
 	this takes effect immediately after the repository is
 	initialized, but before the remote history is fetched or any
@@ -339,8 +339,8 @@ Specify the given ref storage format for the repository. The valid values are:
 +
 include::ref-storage-format.adoc[]
 
-`-j` _<n>_::
-`--jobs` _<n>_::
+`-j <n>`::
+`--jobs <n>`::
 	The number of submodules fetched at the same time.
 	Defaults to the `submodule.fetchJobs` option.
 
-- 
gitgitgadget

