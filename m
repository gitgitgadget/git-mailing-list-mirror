Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F822184E
	for <git@vger.kernel.org>; Thu, 17 Apr 2025 22:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744930615; cv=none; b=OhR4stJH9BsREffoTlk62USUGurgPEBixC4+lAcPRYwT7i6GNVKkKKj7eGu2rpq/0uIfCwOQNOwMLx1tp7pf8Q8IsJSSlmUEF76TsVQBDeLKUEWdTHnUyqeK8OHACejrGihcgC//MpUU2Dca6q3bjLpnCDsDHbtjiGJLWTS0e8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744930615; c=relaxed/simple;
	bh=uCJr3SRMjm8JjP1PyAzHYnW66MGzpgLfvteqpQk7860=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=K2CjNf5uOtJZudhVzztYGQwhGXTfbjY+zqtLXTiSAzwL2KnTc7U+61/Lkw2b8YHejBTaxvJxw+PmhAUDEHU2rz/OZX83rZJY/5v8JyZi7+KttFWsEsVvgVhY//ZKUFBJTjbBt4rvb0XIVuk/H7Td8H68g3bNXHDEQAMV2jBUH/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQfzuZW1; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQfzuZW1"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3913d129c1aso922073f8f.0
        for <git@vger.kernel.org>; Thu, 17 Apr 2025 15:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744930609; x=1745535409; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uM+9yYKIDdyjvQ6mrBRDxMilakxbfELeAOK3uTya8OU=;
        b=WQfzuZW10rc1U8NYcyTSF5JrXH16k0wD4xY/CGWGecc6JfY0hHDIGI8CxgzdgU/YWb
         +xqX+m1NwzhYzudYRmBAGV6O2xE2rTMXx+hDHc5vcG+HrVNflWWSKdUmgD5Ec7YzJZnV
         xYB5taNsIrbWU/Y8fSYjkzlI1PgVRh8JQ2Xw47tZ2ZxPgYmD07shqTHP4Xu/3XNRPfZ7
         q439vA1QrUqWsCblW3DYFVXsTwnGxxXa3Wfs34LkwfWE1T03BJN1PsPxCBUd5drzA513
         LOdnAne+nFnYjvQEl3SqdR11FTXMF4WrIHUxtp8bC2eQJJxM4s/23AqpFWt4hTYRQAVl
         Cp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744930609; x=1745535409;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uM+9yYKIDdyjvQ6mrBRDxMilakxbfELeAOK3uTya8OU=;
        b=oBS4EfE1JMJndsMG3g876XipYsAY/ZifHOLbd53rPBmfLI0/yJGT9Y8cPSQqaRBigr
         nKA5lwXgxzPvWhnGxPJSbVIRnphCAMixheVHsTRdRVLVgOoU55Q7xBWcXI4JE8LwPY6Q
         V8S85q98zBJJhacnAmATwOX0w42TbizN1XOfq8GE3YXHj2dm7NebtUVSaEjW+HG6ZL98
         p10AGDJ9d/SyfmF1lAWXOVAG/EU9w82POMDklBfvB5o2ZXK464X1be12IRYc4OL5xJ9m
         C6EPg5a7N0+iTil41tzVI+BjV0++xQeA6SOeRaTgbL/iII/8OTCdxeG+ELUn8Hy8y64e
         fTBQ==
X-Gm-Message-State: AOJu0YwWfuv+NRvazb9cdA10g48T5RCtVm2NyQiWmSxKulFzIc6RckXV
	zc5DSNdGuoQkPADa3MKVNLzdcw13vxol75sFIzc4MjKqBlLee/7JNE4E5/BTvCM6TTvpuksCPi2
	MpQAA0hXD0YqnGAXX0pfc7o+2+dL86Yt5D5s=
X-Gm-Gg: ASbGncuIja34xSZPFquUAaQgay+TV/aGEhqrGMm1uP1sbbEJwYJk/E9/MHd9hMjCN3a
	+Uo9I5dYkQUYTnzgIFR44iH9Wyqcodo1o3uUFFRjDCSteQ9BcxtjFCcNSYeVuNDTYBYRjn9J77Y
	aRv/IB0lQEsTd/s4abZZtUpg==
X-Google-Smtp-Source: AGHT+IF7vMyBhRs1FY3asx//lgka3uYWmgZuqttwii+kRAI2+N3l7erOzC5av0W6qVnXREvuSO/xDlCARdGr49+Zf20=
X-Received: by 2002:a5d:64a7:0:b0:390:dec3:2780 with SMTP id
 ffacd0b85a97d-39efbdc665amr294694f8f.24.1744930609092; Thu, 17 Apr 2025
 15:56:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Keith Thompson <Keith.S.Thompson@gmail.com>
Date: Thu, 17 Apr 2025 15:56:37 -0700
X-Gm-Features: ATxdqUHyxvGwvP3OWMnhZu5AGTR1IW4n2zNhLNt9rOIPiT5E4-9x1CCD4Q3zLHA
Message-ID: <CAAHpriMkqapiJuUGimn-i8SqcZmvmc=Wpk6oUr844uAkCYgMxA@mail.gmail.com>
Subject: Bug report: Minor glitch in "git help" error message
To: git@vger.kernel.org
Cc: Keith Thompson <Keith.S.Thompson@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
git help nosuchcommand

What did you expect to happen? (Expected behavior)
An error message: "No manual entry for git-nosuchcommand"

What happened instead? (Actual behavior)
An error message: "No manual entry for gitnosuchcommand"

What's different between what you expected and what actually happened?
The hyphen.

If "nosuchcommand" were a git command, the man page would be
readable by typing "man git-nosuchcommand".  The error message
should reflect that.  (The error message is actually produced
by the "man" command.)

Anything else you want to add:
Proposed patch (works on my system):

```
commit 148f2e07a7dbdbe72fa0bd4340b76cba12a19a24 (HEAD -> fix-help-bug)
Author: Keith Thompson <Keith.S.Thompson@gmail.com>
Date:   2025-04-17 15:35:44 -0700

    Fix "git help" message for nonexistent subcommand

diff --git builtin/help.c builtin/help.c
index c257079ceb..792549864f 100644
--- builtin/help.c
+++ builtin/help.c
@@ -450,7 +450,7 @@ static const char *cmd_to_page(const char *git_cmd)
  else if (!strcmp("scalar", git_cmd))
  return xstrdup(git_cmd);
  else
- return xstrfmt("git%s", git_cmd);
+ return xstrfmt("git-%s", git_cmd);
 }

 static void setup_man_path(void)
```

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.49.0
cpu: x86_64
built from commit: 683c54c999c301c2cd6f715c411407c413b1d84e
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
libcurl: 8.5.0
OpenSSL: OpenSSL 3.0.13 30 Jan 2024
zlib: 1.3
uname: Linux 6.11.0-24-generic #24~24.04.1-Ubuntu SMP PREEMPT_DYNAMIC
Tue Mar 25 20:14:34 UTC 2 x86_64
compiler info: gnuc: 13.3
libc info: glibc: 2.39
$SHELL (typically, interactive shell): /o/bin/bash


[Enabled Hooks]
