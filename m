Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDFB1C2BD
	for <git@vger.kernel.org>; Sat,  5 Oct 2024 03:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728099052; cv=none; b=lmlqLKCELkscaVlo4fjUjfctFWFlXgICx1WerB6x0DAvxtBLr0YbXkCgM+sYMGrRx6iOVIBZ9Ap7ZpOWASgw1sXuALaTfCkM4hdbEi3h8rxLUEk93/wHYJRpjUJMclbWU8tmU8aGfDKJkn6YdTLbC77A4IBaGAIJSDOfuFpQicQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728099052; c=relaxed/simple;
	bh=4ufd+lnF/x/gbVvxt6igaQdaCfeXszeiZxur2NDEL3w=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=P4dJgf+X1lFvPJYNHCvRLw92aonmgxeADsKb75cVyIK7awhBw0LH9Zg2gTyvSZ1MzV0JeLMO4e85OlROHeES7bwAlR908GIiuN4X3q5rhCte7DqWpXT37QZjiszBgPtHD/+Ogz09lClyU8Lo4uOibf7EOgAO9OFxUK7f2Z73z+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8ZrrtVm; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8ZrrtVm"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c5bca6603aso3313481a12.1
        for <git@vger.kernel.org>; Fri, 04 Oct 2024 20:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728099047; x=1728703847; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e356y39zVXRBnY/Z3w2k2oq9FSHT+mnTZxHfqON7Uzk=;
        b=P8ZrrtVmq94nF0J86KYNDjtEhV3RYyThYdM7POllMUJPSBgMQ4aMnI3c3SWA3qIskg
         qRyIjAPz51boaEQvHBVBJC8oRQCaeUqLFK3eUoGncaTfwnZmf+5RIxZ3o0Kpuz2RxcrF
         SKdjRoUA/NHG2QGvPdkPUrtbB1ASaivqQ/VmAC2Kfji1cihbVUel92NEk5j+L1Z7rwWt
         TjyH3pjdQQNzdijyx8jlpWKXCzrCEXFNKiF0mx4pugbo1P/nj2yx+jiA33Qom0zpX34A
         6wM48yGUaAktsewcp9gnmSoB0rNgzSx2Pb+Dl1j6nF3dpOc1txiRrbNllPnRYlxhcmmv
         n6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728099047; x=1728703847;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e356y39zVXRBnY/Z3w2k2oq9FSHT+mnTZxHfqON7Uzk=;
        b=rUENGL+XVsN3Hdim9ZkNpJv6JCb8nArGj1PejmrQzwsazed65rWgjJ3d/xMjjUbheY
         S6IuaOo9p9M04g0MleiYJ6Aw4k404n0x28gAqHWqA0VniiPIrrHfbtl7TOTRJU2i5Vnw
         txBYn2p17chYrfcU7AbjrIWxAF3LICJ843Fi+jlazPEzHYY+jn6uZj0QcOuHJGFXp+qo
         fy2GwnnnCRQgrdmcTgYjW9mmeOLQfLro6R89eaPidjMCjLV8ru4+cLLE/jGUVNzgm4ik
         kA01tp1hwU/5KyuvArS0MHaFPfhTOSclP982yEaitySICHH0XR26kCo5UX9IEOb1bQNc
         Tc8w==
X-Gm-Message-State: AOJu0YxtfkwK1cno49vLQ49biK53eC2ertaQiTuuwDFpKjstgA4a6HF8
	F6VOzevgiPhU7VY+XfkbwYmqADUoj0gzGBsw5jXeESeggb3GeXlxBrNhHA==
X-Google-Smtp-Source: AGHT+IEP57R18hpAOwHnwpnDjRH6W2ehC49QBWPGS/lX3CIaEWdae8QaF+b/78/sGkUbhP74fzBXZg==
X-Received: by 2002:a05:6402:510b:b0:5c2:5c36:f838 with SMTP id 4fb4d7f45d1cf-5c8d2e2ca0dmr3310964a12.16.1728099047175;
        Fri, 04 Oct 2024 20:30:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05eb34csm551409a12.59.2024.10.04.20.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 20:30:46 -0700 (PDT)
Message-Id: <5d33a375f41132b8b378885d00e934b9f20a0854.1728099043.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1788.v3.git.git.1728099043.gitgitgadget@gmail.com>
References: <pull.1788.v2.git.git.1727718030.gitgitgadget@gmail.com>
	<pull.1788.v3.git.git.1728099043.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 05 Oct 2024 03:30:43 +0000
Subject: [PATCH v3 3/3] archive: remove the_repository global variable
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
Cc: shejialuo <shejialuo@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

Replace the_repository with the repository argument that gets passed
down through the builtin function.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 builtin/archive.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/archive.c b/builtin/archive.c
index dc926d1a3df..13ea7308c8b 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -2,7 +2,6 @@
  * Copyright (c) 2006 Franck Bui-Huu
  * Copyright (c) 2006 Rene Scharfe
  */
-#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "archive.h"
 #include "gettext.h"
@@ -79,7 +78,7 @@ static int run_remote_archiver(int argc, const char **argv,
 int cmd_archive(int argc,
 		const char **argv,
 		const char *prefix,
-		struct repository *repo UNUSED)
+		struct repository *repo)
 {
 	const char *exec = "git-upload-archive";
 	char *output = NULL;
@@ -110,7 +109,7 @@ int cmd_archive(int argc,
 
 	setvbuf(stderr, NULL, _IOLBF, BUFSIZ);
 
-	ret = write_archive(argc, argv, prefix, the_repository, output, 0);
+	ret = write_archive(argc, argv, prefix, repo, output, 0);
 
 out:
 	free(output);
-- 
gitgitgadget
