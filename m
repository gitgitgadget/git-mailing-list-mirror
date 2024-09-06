Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFCC1B85DA
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 20:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725654160; cv=none; b=NKBzIDQdVPQlft6yATt26Be/5s7vsXBlfSzIPxzIlBFxyMaYzw5htfCb51ih4Hu+OZNmQdn1R4amg12WSfvKmcDalFNhCHfnmPkysSOPP2k2YzgItsOkIfKcD3OGZ7OPgLmebMfcD8p/WfJ6WegmnHL7StZ42+v4GFKL2D0VmOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725654160; c=relaxed/simple;
	bh=SEOdFFyfY6DexbUZR/JkY3+V8FwzNPLRo1oRYJwM21c=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DsjB0Y4Zi4t/cxs18FO2gLHfqz/qlM0ZCoRE043Ua0sruG45ZADW6HJPGd4nDyqYojcaK8Kr/PI+QohjFN9sOXu8WjFCX8bAajSUFdYhgjNMaqYprrXSEFOVPD6w7SG3ydKtVe06tXeJ4/5cgNkk2HGuHZlMz6KUNlGcZBJ4rXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ma5e3ib2; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ma5e3ib2"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a86b64ebd8aso145918666b.1
        for <git@vger.kernel.org>; Fri, 06 Sep 2024 13:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725654157; x=1726258957; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=daoqahqLiDTIXtaSl2mMdaKU/1yU0MjRMuLR3ftCw5Y=;
        b=ma5e3ib2zSMcxWNDZFz/h0/A7OjlLWyfNJ2d1gv1bWSDfaFEWe9QxzcouIXv3BSF3P
         HhM0OQ1ZSSSZchG7Abu+qocotCg7oAaKTd5tvgSralgnZ1QDpEPzjlKnHp7O4amGyQ5T
         zEfIXg3fK6B/41HmayCb+Pz2MCfU17pNFCYqy8wdBegIs8izOAaGzWnpT8ftUC2Bap0b
         ggjniL+BDmoJkQUlVUWioNdoqMjJSnoRRaMgpXM488STlmcGj4k/yny3GMcZUHmc6RIi
         LBFX23AVUncH2unPLqJ6b1MP5+6KT7TBlH+pAPpNiwHN1kndpopIOyPie/qWPu44XHWP
         l6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725654157; x=1726258957;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=daoqahqLiDTIXtaSl2mMdaKU/1yU0MjRMuLR3ftCw5Y=;
        b=ZqnJbNy3RExw0i5zfkbq25iyyq54B4Mf2tnBtmbIRDtjot5Z8tbU6zTQTY3e6NVh2P
         U138H9EFVkFVT9vCFGIxvmRahPqaBFnugQHc8IOMxOkQ7XgWnwN6cJm0kJqm7LfeQIZg
         WtkQkKTZKXs1OUpQRQO7Foel/+ZmQDhmoC5kn6D687z0DUrEvWaeWJvSmX255gDflgDI
         a4W06+dIcCc+Ws90uX4EmAndzDMk6UF9IQlplYsrkpbS1JZvklNfjM6U4RTgt/1V5Ru5
         dzD5NGMEy0xWNcejp8g7zp3pLpXYDE/0vdVOPxPjvjlhoCrCgXzNUGWSL5UkUA5SP8uO
         InNA==
X-Gm-Message-State: AOJu0YyRT42Bju1MtqfMn8CXlzvCKWDZfng8kJ4BZC/lNbg7/xw5Ozkq
	AKIpm87fW+fX/t7AEica7agV5RNoIq+AwNNrYdDbEm2eoWrXVYK0PBSJ9w==
X-Google-Smtp-Source: AGHT+IG6PxdKAf0mVLXQnAOA/ynHwdfVkr3QfdoLHI2XezlgFIz6uCtCXjpQLiKlRcj5QeuXAJDZQg==
X-Received: by 2002:a05:6402:448c:b0:5c3:ccac:2b3a with SMTP id 4fb4d7f45d1cf-5c3dc7b7fc9mr3297862a12.25.1725654155986;
        Fri, 06 Sep 2024 13:22:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d0ee8a264sm55109766b.100.2024.09.06.13.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 13:22:35 -0700 (PDT)
Message-Id: <pull.1781.v2.git.1725654155162.gitgitgadget@gmail.com>
In-Reply-To: <pull.1781.git.1725559154387.gitgitgadget@gmail.com>
References: <pull.1781.git.1725559154387.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Sep 2024 20:22:35 +0000
Subject: [PATCH v2] advice: recommend GIT_ADVICE=0 for tools
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
Cc: gitster@pobox.com,
    Johannes.Schindelin@gmx.de,
    ps@pks.im,
    james@jamesliu.io,
    Jeff King <peff@peff.net>,
    Gabor Gombas <gombasgg@gmail.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The GIT_ADVICE environment variable was added implicitly in b79deeb5544
(advice: add --no-advice global option, 2024-05-03) but was not
documented. Add documentation to show that it is an option for tools
that want to disable these messages. Make note that while the
--no-advice option exists, older Git versions will fail to parse that
option. The environment variable presents a way to change the behavior
of Git versions that understand it without disrupting older versions.

Co-authored-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
    advice: recommend GIT_ADVICE=0 for tools
    
    I'm finally getting around to this doc update that I promised [1] a few
    weeks ago.
    
    [1]
    https://lore.kernel.org/git/e90949ed-8065-4498-9ddb-3d5c6afa7b35@gmail.com/
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1781%2Fderrickstolee%2Fadvice-docs-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1781/derrickstolee/advice-docs-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1781

Range-diff vs v1:

 1:  52f6450bbf8 ! 1:  aacc8c06017 advice: recommend GIT_ADVICE=0 for tools
     @@ Commit message
          option. The environment variable presents a way to change the behavior
          of Git versions that understand it without disrupting older versions.
      
     +    Co-authored-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
       ## Documentation/config/advice.txt ##
     -@@
     - advice.*::
     +@@ Documentation/config/advice.txt: advice.*::
       	These variables control various optional help messages designed to
     --	aid new users.  When left unconfigured, Git will give the message
     --	alongside instructions on how to squelch it.  You can tell Git
     + 	aid new users.  When left unconfigured, Git will give the message
     + 	alongside instructions on how to squelch it.  You can tell Git
      -	that you do not need the help message by setting these to `false`:
     -+	aid new users. These are output to `stderr` by default as they are
     -+	intended to help human readers. Tools that execute Git as a subprocess
     -+	can disable these messages by setting `GIT_ACVICE=0` in the environment.
     ++	that you have understood the issue and no longer need a specific
     ++	help message by setting the corresponding variable to `false`.
      ++
     -+When left unconfigured, Git will give the message alongside instructions on how
     -+to squelch it.  You can tell Git that you do not need the help message by
     -+setting these to `false`:
     ++As they are intended to help human users, these messages are output to
     ++the standard error. When tools that run Git as a subprocess find them
     ++disruptive, they can set `GIT_ADVICE=0` in the environment to squelch
     ++all advice messages.
       +
       --
       	addEmbeddedRepo::


 Documentation/config/advice.txt |  8 +++++++-
 Documentation/git.txt           | 11 +++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index 0ba89898207..257db589181 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -2,7 +2,13 @@ advice.*::
 	These variables control various optional help messages designed to
 	aid new users.  When left unconfigured, Git will give the message
 	alongside instructions on how to squelch it.  You can tell Git
-	that you do not need the help message by setting these to `false`:
+	that you have understood the issue and no longer need a specific
+	help message by setting the corresponding variable to `false`.
++
+As they are intended to help human users, these messages are output to
+the standard error. When tools that run Git as a subprocess find them
+disruptive, they can set `GIT_ADVICE=0` in the environment to squelch
+all advice messages.
 +
 --
 	addEmbeddedRepo::
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 4489e2297a3..d15a8697625 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -1027,6 +1027,17 @@ standard output.
 	adequate and support for it is likely to be removed in the
 	foreseeable future (along with the variable).
 
+`GIT_ADVICE`::
+	If set to `0`, then disable all advice messages. These messages are
+	intended to provide hints to human users that may help them get out of
+	problematic situations or take advantage of new features. Users can
+	disable individual messages using the `advice.*` config keys. These
+	messages may be disruptive to tools that execute Git processes, so this
+	variable is available to disable the messages. (The `--no-advice`
+	global option is also available, but old Git versions may fail when
+	this option is not understood. The environment variable will be ignored
+	by Git versions that do not understand it.)
+
 Discussion[[Discussion]]
 ------------------------
 

base-commit: 2e7b89e038c0c888acf61f1b4ee5a43d4dd5e94c
-- 
gitgitgadget
