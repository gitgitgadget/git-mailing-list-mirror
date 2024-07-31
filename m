Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384FE1607AF
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 06:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722406143; cv=none; b=VIi2ElZ918cM4EvTc66HxYmDE0/xySSGJ2XUsTzFo8NXwI/Ie8tR0CxyowHkM/cSvjV1ceHNd6pxpSuhDiZEVcC3AUelQJsOl4bMWzqR2ABKPkE/jvB+uVr2ETJ2rX0FO+eZ8Qe385HpGpt+mDBm/PjpASerkm1U9HTUc64gFGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722406143; c=relaxed/simple;
	bh=Bcvq760ya1v2ikEUbkU7Hu/qXmXl1xW0gQST4TNuh2c=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=A3vF981wXF566iMq2Qwu6dKQbrq5ETSpgGHVj5zSdq+GHQ7xR715dRAK4l9zmVuc47RiyrsM+NwAyhodch4dMBXYEQ4C9hUHhpFN3PEH/JJ7IFP5Bctgcv6DnfxLOMlFvDNpg4UKPchhOwnb8pBKcpxwPMfdrWjHHhlUQcU3pXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIzFMAnj; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIzFMAnj"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fdd6d81812so43565325ad.1
        for <git@vger.kernel.org>; Tue, 30 Jul 2024 23:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722406141; x=1723010941; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7gcbzjZPFVHUqrUy5yU4DLn+5Vs+sVzMg2x2AmLvB6k=;
        b=WIzFMAnjqKZ86xGdOpj4lLbsOlpfoIPZzkT90AgMZcN8Hp1/lAYZHNda817gy4GDoh
         nIi03KDzzKXSNrVHo95HsnjTESYzZL1tCziu27RPWGiwwFjS9LlVp35JrueZttxEtMxf
         IdbHBpbcWXUQRifo5j0219uLKstVoRY6X7rkbhOkSHJ7JRk0W5xzqjujK6mRmCllzwA1
         N1ytiY5kYib/EbXSregnELfekM/KMlzHSwu0d1LMSdMkCuRUuexWJIFRay/qxxOuZsia
         dHwSIH8QhubIgD1sCa0s3XbgniMI5VvRoHhX1ZT4YBCLBtZTVND3fNWPHcLAaq80QFoJ
         a2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722406141; x=1723010941;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7gcbzjZPFVHUqrUy5yU4DLn+5Vs+sVzMg2x2AmLvB6k=;
        b=YwzxXVBezljNR7ArhY0dYt8SbaQUOrtbqvPWQajjJjn9tUS2sGlNiNfSrVxFhFgk7C
         iK/+4KS2CrVA71jVzRoc4e6WZpUN5ra5LcJgbGRzJZ3G0bQoNL1lvY+TLnJ5wWOLaDVJ
         7C/82BZ2Vv4lOZQJFuzokNHF5xLMeguxnDCW+7vB4+8Xhwt8ECJOSKiNbtZHxi3OrMUH
         dP4GxoVOris3pl6KJO70tz867WeMZaoi/5UEJWUaF9Ck9rGw9xqpraP1jiR5fr+33b2c
         CYuJ7c6lF04lZMcI2WVR4JNB+j1WVMoImJwG36R2iBGAEzRYJA1AP9S3aH15wGukcMQG
         Ujig==
X-Gm-Message-State: AOJu0Yx+phZzSpW5GLqjP81dvqbssmsTZGnzkPq41SAMOrsG5ep2Sigw
	zRYT4LuSfaGLN1aUcdgYngYjk7/SOqXOwEc9X6bj3Yf8L0pKQCf0l6g9gr010Tu/egHnHY7ZzL/
	XYxhGMjIW63vtUHDYDdGYc5RRdAzw7gOe
X-Google-Smtp-Source: AGHT+IGQsYO5HsvoUvIYTIvquj0Rf1MseQvEWTEqIMaitK4QrTnyDfsUc5NRueZptSdyHWc+ca+zUMIFXD1ZOA7y4E8=
X-Received: by 2002:a17:90a:4b04:b0:2c9:754d:2cba with SMTP id
 98e67ed59e1d1-2cf7e19e149mr15652411a91.3.1722406141149; Tue, 30 Jul 2024
 23:09:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: KwonHyun Kim <kwonhyun.kim@gmail.com>
Date: Wed, 31 Jul 2024 15:08:50 +0900
Message-ID: <CADLV-7+mQ0K6_-L_Pws9yOYfQ++b4NyH5+FXwbyHuXBiOALeYA@mail.gmail.com>
Subject: Possible bug or error in document?
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello there, I have a possible bug or possible error in document.

  When I do `git add --pathspec-from=.gitadd --ignore-errors` I can
the following error

```
$ git add --pathspec-from=.gitadd --ignore-errors
fatal: pathspec 'chapter???.R' did not match any files
```

  I figured from what I read from the help, --ignore-errors means add
whatever possible(help included in the following)

--ignore-errors
           If some files could not be added because of errors indexing
them, do not abort the operation, but continue adding the others. The
command shall still exit with non-zero
           status. The configuration variable add.ignoreErrors can be
set to true to make this the default behaviour.

  So is it me possibly misunderstanding English, or it might be git
doing something wrong or document directing someone in the wrong
direction...

  I thought I might use this option(--pathsepc-from=) like using
.gitignore in the opposite way but it seems that I need to make my own
script to read line by line and do `git add`

  Thank you for reading.

KwH Kim
