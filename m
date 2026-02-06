Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBCD3382FF
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 04:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770351153; cv=none; b=dHvQTlfDJuzoYDujnzK+hlr228DWRLJuL/5ozXmxljDpx6Io0at7cqlA/3EvJC40Wv0JLMtv6pOUak1APy2sFpO/AbbgLPSs6LJTsXVMEyrE7suhJNwJyptw8Yltn+rl1TMF0bb2d5U2iknl5cwL13TLOb/ojRFUcKzl6PWueoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770351153; c=relaxed/simple;
	bh=MlHYplbmuCIJ42Zi2drDlSeskmI+bYuUgM819ARjtZo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=It8xpMDazGynQSj/z96eD5I0DSFZ1wyjdMN36hfQt2UNwsqV0RJ7dPLXEii08JYQLKGB5QgnbvgiZjAM0XjjyG2lq2iYQaTon7z4RoKl+e61Cco3lb7sVyWXXpK5hAHR813+anjdWT1pg4klrApddLLPX67iytsHyv4EPmVfB24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/C3HsqS; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/C3HsqS"
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2b82c605dbdso3437039eec.0
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 20:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770351152; x=1770955952; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zBH/k4p9UP/z7S00zx9DKYaAOYP/FuI70S5KFVcs1Ms=;
        b=l/C3HsqSyHDhjlwu2ionDt2al7QhuI836U8GBJ+3cB+U5N6ePnKaK8rYwf4TnD879v
         I6wGkM6ZotU72lmEh75MHgfnNXCMZdFR3sHMfSxLqGQ8z6wX8IOV+67G5fV17T1sVfc2
         qtffihPE6bsQMGe1Kojl/szq/7026d58Ms1FseaP19gmbPh2I6vdyQholhZ8Q99CwmiC
         HAycBouSYjeKFX7n1Ina9jid+ZyEKGwXwUE21GK0xUQNOc7cCJ2ov/DHKFhRLxIo8P9c
         T/UgebchIUCtPG69my7lyn3s412bF0hSap5S1evmDZFhNE6n8oNWaWTOP19isLSrYbTr
         CDYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770351152; x=1770955952;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zBH/k4p9UP/z7S00zx9DKYaAOYP/FuI70S5KFVcs1Ms=;
        b=v0PBb4nNcNFJPttZz09QMS4IbyAdK7GleKEqUZ3wWS0TKmDWs/atso85v08qCMQJMA
         c13K+dhcCukcx3b2B2fAiCkhM36vLyQv6387NoRBudSSrqrq3Nwtgw7d0SVFqZGWGkDZ
         GNyjEgrPX5v5z8nKdTQmXpO8Fpmy0VB/uGvBWgjgJgKMVnsevbXUZbnGd0kis9mShu84
         QpPLkc6cm7eZoDZDndDElBRFp9IYHXP1ahHbXIPENI2cBGllWbtya5ceIbSdUjYORvf0
         arvo/a+FspDiM7DT5UKQPg2FQWJwSjCcf9z+QmQtC0Thd40LuZZq4WwOWf6gPTsAei8H
         uMtQ==
X-Gm-Message-State: AOJu0Yx+22evIcPMxhzx3sTqJaUadsn8F1HJcisYoVAA7tfw8aV6cNkl
	xMSWmY+sYXnCZBiCJCpJwBDDyQZm691TkeV+rSyzuKOMRjuYdpuZ2PBmO9/VjUSh
X-Gm-Gg: AZuq6aJ0anpWaNMHUPrfmfaAeLyFfCCwwev/2qcBynsy5S+W66YsMkBxtbFPpGeyYy+
	D9e30sybwfObrB2S5DRaAuKd76d0wKvUFdL84aQPMuvRTJVEnAoag3a3VE1Epvdhb8vcIxk8JoX
	8RQCWr9LovoL5vEP8c/xltl5ercDjrRXKkhVveGfAKydyTo20OxRkllYT0ePrCZaVCcPNcCOxjJ
	02WDVrNsbKPj1KAJfqhF48ntf9n6i772OQoqF8gnoyfdJ8EusLrrmJVVJIBBIJBmexlLRo92HZD
	MqeIyxsaByaQ8mRncC7QNw0ki4R2GgRTh06BIhMzUTjhrKU0RK7as5V4vKyqx1zaEljmTcSm7kA
	ahx8mR+Lbh5HGO6l09qF5Ev/yKmAh/d7M53XLjEc6aOmaWHrmUy4pseeqx04VlnLTA55/3cpH41
	5Aehoro8Yv0pg=
X-Received: by 2002:a05:7300:1355:b0:2b7:f415:53da with SMTP id 5a478bee46e88-2b856a455d6mr614782eec.39.1770351151749;
        Thu, 05 Feb 2026 20:12:31 -0800 (PST)
Received: from [127.0.0.1] ([52.225.25.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b855af6452sm1017773eec.9.2026.02.05.20.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 20:12:31 -0800 (PST)
Message-Id: <41aefe81472b3c0ca4fecf06efc83e2ed1eff046.1770351146.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2036.v4.git.1770351146.gitgitgadget@gmail.com>
References: <pull.2036.v3.git.1770138215.gitgitgadget@gmail.com>
	<pull.2036.v4.git.1770351146.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Feb 2026 04:12:24 +0000
Subject: [PATCH v4 2/4] doc: finalize git-clone documentation conversion to
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

Reviewed-by: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
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

