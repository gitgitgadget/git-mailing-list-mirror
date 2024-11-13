Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4406D17D341
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 07:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731483638; cv=none; b=KynlWCn/x21Ws6sUq7QLIcJADoGh8YplNwNeqXOv/uj4eJkNhFGcpEwG53JJQFxA7KjWJZheV9Iy9nvRLLtztpun9utuu6NnDj6kEh0dkq0zNAW6vkiW7/XT42YIgHNoR5D3sqJjIaDan6jkSiIvdB4nGlfrnHi7VleY9fpAIhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731483638; c=relaxed/simple;
	bh=BbSOJXhH+sBvITDyLo4Z5W70cEhK82K8ccR0MsSkfyc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=BaX/cr1Oma8jTOYINXGfohl7h08mv0+QPAp/Yhvmwpnp+JKWEyZlcvNFJaDaJjaLjfQVeXNr1BvNfRgoOS65Tdno2L8cWznSVv31+OMI1SJ5LCMFrrMYgfVLSQpK5ZdGFJ27vwxmDpW0cxlG9/SuCk4TCIPmuFeyhMazOFZCCrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4HN9rxQ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4HN9rxQ"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5cb615671acso4837270a12.1
        for <git@vger.kernel.org>; Tue, 12 Nov 2024 23:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731483634; x=1732088434; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o2pH/a4mdYsRnx6yDerqYMKnmm+r8rNxkY728bdtDnY=;
        b=T4HN9rxQPmsFBP+RDdhWn7N8/cKtKsK+uCFkt1kW3xXxwLPgpT1GtfhlDZqmq3cIYZ
         GB94nABdw7ebZVAzR6hgiVcM6SYCXticuPeeDxOwXqySQqSLYoaWpaoWSl3CldLqn0pP
         TEW+kSmC7hnxuK9VhZXM3j8e0//U+kvvhqlrN2zp8OQL4huiHWjUBdgCFliTpRuO7kPb
         6p6z4tAXKFGkCUiNqSd7HP1lFBorC79GX4kCg+ZNMFQhAqr30ssBoTF9nchzv0snobM1
         zRUUPPrfq51ny6sX1XPtAKtVcP+NsTAYuNxkHlxCFtklUecsbC8JthKSzf+ax2Hiy6uw
         ZjVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731483634; x=1732088434;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o2pH/a4mdYsRnx6yDerqYMKnmm+r8rNxkY728bdtDnY=;
        b=KIE5bXC9Qx+YKlUHAi1MSU/izzllx6kaov/XeFlTRWFAX6WZI4leUU5NOJO0ILro7d
         Hy2/xhp/Fy5JJTDwsPf+pf6ouTlENAI89w5Y6d40R48SxRbY1s2K0kG7uZVmpTxOT5Hu
         wZaLXr6+AZSmgR7i0z7LI2PNLEg6SjA4OSqLegQ/zHljcjKPIe+JW0V2PYNOi1GOU8/c
         pacz4hKxpVD+ljOAc39nmES6wG96pWuZ+J6MMn2/emD+COoTR+dm5UMpLF5CVtl/N6Xh
         5sTBK1zxfoxvu5eLe3thZIpSOsN2VPja0OiqpxLfNNTyErdeN5Wedy2nphHwNWQUoG/v
         czJw==
X-Gm-Message-State: AOJu0YwU/m0Fzur85FycSq6ltDx/8qdDlH5Q+N6w3zo6Zw4nN0ZdlXGL
	+IXFtu6hwyuJmh0rAHUOxBWSCJObxdWXPDsfFH/ElQTRbXd3+d4trM74m+EnWOQ7fCcR+g3VA6F
	0100v2vglgj8r70joJfi7duAENU0v1FkL
X-Google-Smtp-Source: AGHT+IFlZ6MfrM742qwkQG80U3UMU35C43XYvGmi6i14G3PiCsDJCwJHKykfpAyX0n8S17H+5buZQAI+1V5UXpsIa0k=
X-Received: by 2002:a05:6402:27c7:b0:5cb:bebb:38d8 with SMTP id
 4fb4d7f45d1cf-5cf0a3184f4mr25506604a12.14.1731483634123; Tue, 12 Nov 2024
 23:40:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?44G144GY44KS?= <ffjlabo@gmail.com>
Date: Wed, 13 Nov 2024 16:40:22 +0900
Message-ID: <CABpqQ_u4GG28L9KGX+HXiOv2AVAL7sckRBN4a99pCyeaQS+n_w@mail.gmail.com>
Subject: Trailers Containing Underscore or Dot Characters
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi everyone,
First of all, thank you for making such a tool. I am grateful to use
this tool every day.

I encountered the issue with trailers containing Underscore or Dot characters.
I don't know if this behavior is OK as a specification, or not. So I
created the post.

What did you do before the bug happened? (Steps to reproduce your issue)

I added coommit with trailers which have "_" or "." in each key.
```
git commit -m "Test" --trailer "test_hoge: fuga" --trailer "test.hoge:
fuga" --trailer "test-hoge: fuga"
```
What did you expect to happen? (Expected behavior)
I expcted that they are shown like this.
```
# git show
    Test
    test_hoge: fuga
    test.hoge: fuga
    test-hoge: fuga
```

What happened instead? (Actual behavior)

Actually, some of them are unexpected value.
```
# git show
commit 70afae811def2345bead6660e0f3183662c9f4df (HEAD -> master)
Author: Your Name <you@example.com>
Date:   Wed Nov 13 08:28:19 2024 +0300
    Test
    test_hoge: fuga:
    test.hoge: fuga:
    test-hoge: fuga
```

What's different between what you expected and what actually happened?

The one for `--trailer "test-hoge: fuga"` is finished with nothing.
But The others for ones which have "_" or "." are finished with ":".

Anything else you want to add:

I want to use such characters to add some key-value received other
service (e.g. GitHub Actions) as is.
Is there any chance that characters like _ and . will be allowed in
the trailer's key?

By the way, I tried the investigation for the current specification.
I hope this is helpful in some way.

[1] This behavior occured when executing `git interpret-trailers`.
```
# echo msg > msg
# git interpret-trailers --trailer "test_hoge: test" --trailer
"test.hoge: test" --trailer "test-hoge: test" --in-place msg
```
```
# cat msg
msg
test_hoge: test:
test.hoge: test:
test-hoge: test
```
[2] There might be the cause in the process of the persing trailers.
if they have such characters, the whole of the trailer option values
are interpreted as one token even though they have ":" if they have
such characters.

I checked the source code at
- parse_trailers_from_command_line_args
https://github.com/git/git/blob/564d0252ca632e0264ed670534a51d18a689ef5d/trailer.c#L748C1-L764C4
- -> find_separator
https://github.com/git/git/blob/564d0252ca632e0264ed670534a51d18a689ef5d/trailer.c#L614C1-L642C1

[System Info]
git version:
git version 2.43.0
cpu: aarch64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.10.11-orbstack-00280-g1304bd068592 #21 SMP Sat Sep 21
10:45:28 UTC 2024 aarch64
compiler info: gnuc: 13.2
libc info: glibc: 2.39
$SHELL (typically, interactive shell): <unset>
[Enabled Hooks]
