Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CD119B3CB
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 12:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745845101; cv=none; b=cXwgTbu+KQ/o8NYf2IzbGlEHt7vwGpXjFDqSYT3sliXfqdFj7SNz0xOqCKb8W9Td5T7oTi58SE25Yus3Nkdg0YPi4zpH8T71OHg9SevZ6hlNo/CPCOQpe6PMt2H6HsXo5iE4VV3oh5mz9MEmak+blchZNZ1ex3/sObIhT3/Ue8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745845101; c=relaxed/simple;
	bh=rC/B+Y5rzA0vUjSL0lE+HyPCuyuQYUifyq99o0KwMB8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=F5T+lg25AWdbFJrFPb7wwn67PYmnRN0xFPOxvVBB8wqUVUC4OHeJwPeA7rqKvG4uJqCwD4pSmUip8fG1GY8h3CXRo9Qx9aeniqqDYFbyvcxUwswa26QQ3UX4rCKpLY+Gvon1S6NkWDOUQyVsVEL0fBUEBkYDnxd1zVNwuwzL+b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrAprrT+; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrAprrT+"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-736b98acaadso4460047b3a.1
        for <git@vger.kernel.org>; Mon, 28 Apr 2025 05:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745845099; x=1746449899; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cohuwf50ugn3WDIZgUIs10dxakLV7SxtWUjxIHtVEr4=;
        b=mrAprrT+sfD+nkeEb//cDB/ZGGRL9xQrYBastD3t69zPhz39MAhUJXZUeTQMMU551v
         caI06nl/qj1GexKsFl467oetuS4Y9tKKLvQudVeojg6T7INkRNMCJmUXRgP6c0XxNj4L
         dQUHiLAZBgTunzYJ9iUICQoqzYf6ocdIgq3iw4Z/skCMw50Meswc5PE8iinVblvkdpjA
         UE26ucqmhcNV3W4izFLPsxVpPFlijdzCjrWddaTzXXPG3BYy5pGVA/mI3EFE1rcDcOHG
         9QTdk00uNeQM937NMhpSqFtXAQ1YlDXQqAeRdIe+WzvGhxLwH/AjPzFQs+yR+IhLRLMh
         6RsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745845099; x=1746449899;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cohuwf50ugn3WDIZgUIs10dxakLV7SxtWUjxIHtVEr4=;
        b=PIce3o+wSrTlySnxaQn0Cq4YLYDJmnph10aoRd61nN4udq6ZHAjvg3M9jesfu5y7ou
         lIFi6/QR725eaQPKc1qj622PXj8mJJSoz07yHGghqgPzeiHrX2yY0t7HlWeElRa5WWpa
         qUjB4rMOWu6X1D9GMtTVoGdFxJXcZUIgSgHBeOe3xJ+SNX5d7RL0exfVNeS+Pziic4s3
         3hEq+kI9+VzlYT7yuZwdfQ81DQjOByhH0wHRI0bvDXyQqEX/jbjX0ZZCqhd4ymDZ2vl+
         okNY7QQupTdNvFomb/N20V80kU26V9olpy9mqh5JSn8YNQv1UZCzdxeV1K3noeneh29b
         jA2Q==
X-Forwarded-Encrypted: i=1; AJvYcCX213J/KpdczBSsir43/6NNWa3Hm4b379i9Cl0LXonfNcIydKg2jWZZe8Mv6h758PgAbnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjaaZcUcIMbzADuN1WmbSbLeDxDRARyyDADtmpSTGJ/4udSiEb
	bMhx3CThfK8+11VS49abG2u+mfuovwX5VTjJ0oRkXKlp7K4K4OEjsHXyI/oYb3yK1XIQ9TGRpMo
	DzhzMXAjxBpxe0pnt9WmBXUmuTsQ3o8qZG0c=
X-Gm-Gg: ASbGnctcb3P4kzwtUV01Ixgm9hKRM3GIfQOlNKjIB3VdNpo9aMihLnlxfTy+EaulQnE
	+Kua9/HsBzz2x0EPpz0E1vQh5jQwUhjaRs4Qww7dRhh3gqPBUZ9sIGoC/BCGMftnLctVV4nWEK7
	AtxMHiZ1KFQf78VgK//huBAnoAcpbQ3l4tMIJf9T6A
X-Google-Smtp-Source: AGHT+IFoaWZDZnBs4oJajiyRcX9NbQwbMWvSZmC05JR9ECmLGQBvyFqwALN9fOZU4UuJ9B+U9hl6j0ngrrNeUttLRZ8=
X-Received: by 2002:a05:6a00:8c4:b0:739:4a93:a5df with SMTP id
 d2e1a72fcca58-73fd75c4d62mr15589904b3a.12.1745845099233; Mon, 28 Apr 2025
 05:58:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: RQuadling@gmail.com
From: Richard Quadling <rquadling@gmail.com>
Date: Mon, 28 Apr 2025 13:58:07 +0100
X-Gm-Features: ATxdqUG_Ll01fVg2xjFGa_AVLJuQpzXYVUhn24fNi7DVaFSMhMmr528bzzYPx04
Message-ID: <CAKUjMCULZLBCG0CMiiZBRMmqz+YRXJyOL7U9_1i2tRGeq2nnHA@mail.gmail.com>
Subject: Re: [PATCH] Fix early wrapping of the command line when using git-prompt.sh
To: gitgitgadget@gmail.com
Cc: Richard Quadling <RQuadling@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

As an example:

The following is my prompt whilst in a Git Repo:

$ echo $PS1 | hexdump -C
00000000  5c 30 30 31 24 28 63 6f  64 65 3d 24 7b 3f 23 23  |\001$(code=${?##|
00000010  30 7d 3b 65 63 68 6f 20  24 7b 63 6f 64 65 3a 2b  |0};echo ${code:+|
00000020  24 28 74 70 75 74 20 73  65 74 61 66 20 39 29 5c  |$(tput setaf 9)\|
00000030  30 30 32 28 24 7b 63 6f  64 65 7d 29 5c 20 7d 29  |002(${code})\ })|
00000040  5c 30 30 31 24 28 74 70  75 74 20 73 67 72 30 29  |\001$(tput sgr0)|
00000050  5c 30 30 32 5c 30 30 31  24 28 74 70 75 74 20 73  |\002\001$(tput s|
00000060  65 74 61 66 20 36 29 5c  30 30 32 24 7b 50 53 31  |etaf 6)\002${PS1|
00000070  5f 53 48 45 4c 4c 53 5f  49 4e 3a 30 3a 24 53 48  |_SHELLS_IN:0:$SH|
00000080  4c 56 4c 7d 5c 30 30 31  24 28 74 70 75 74 20 73  |LVL}\001$(tput s|
00000090  65 74 61 66 20 31 34 29  5c 30 30 32 24 53 48 4c  |etaf 14)\002$SHL|
000000a0  56 4c 5c 30 30 31 24 28  74 70 75 74 20 73 65 74  |VL\001$(tput set|
000000b0  61 66 20 36 29 5c 30 30  32 24 7b 50 53 31 5f 53  |af 6)\002${PS1_S|
000000c0  48 45 4c 4c 53 5f 4f 55  54 3a 20 2d 24 53 48 4c  |HELLS_OUT: -$SHL|
000000d0  56 4c 7d 20 5c 30 30 31  24 28 74 70 75 74 20 73  |VL} \001$(tput s|
000000e0  67 72 30 29 5c 30 30 32  24 28 65 63 68 6f 20 2d  |gr0)\002$(echo -|
000000f0  65 20 24 7b 41 57 53 43  52 45 44 53 7d 29 5c 30  |e ${AWSCREDS})\0|
00000100  30 31 24 28 74 70 75 74  20 73 65 74 61 66 20 35  |01$(tput setaf 5|
00000110  29 5c 30 30 32 5c 44 7b  25 59 2d 25 6d 2d 25 64  |)\002\D{%Y-%m-%d|
00000120  20 25 48 3a 25 4d 3a 25  53 7d 20 5c 30 30 31 24  | %H:%M:%S} \001$|
00000130  28 74 70 75 74 20 73 67  72 30 29 5c 30 30 32 5c  |(tput sgr0)\002\|
00000140  30 30 31 24 28 74 70 75  74 20 73 65 74 61 66 20  |001$(tput setaf |
00000150  36 29 5c 30 30 32 5c 75  5c 30 30 31 24 28 74 70  |6)\002\u\001$(tp|
00000160  75 74 20 73 67 72 30 29  5c 30 30 32 5c 30 30 31  |ut sgr0)\002\001|
00000170  24 28 74 70 75 74 20 73  65 74 61 66 20 38 29 5c  |$(tput setaf 8)\|
00000180  30 30 32 40 5c 30 30 31  24 28 74 70 75 74 20 73  |002@\001$(tput s|
00000190  67 72 30 29 5c 30 30 32  5c 30 30 31 24 28 74 70  |gr0)\002\001$(tp|
000001a0  75 74 20 73 65 74 61 66  20 32 29 5c 30 30 32 5c  |ut setaf 2)\002\|
000001b0  68 5c 30 30 31 24 28 74  70 75 74 20 73 67 72 30  |h\001$(tput sgr0|
000001c0  29 5c 30 30 32 5c 30 30  31 24 28 74 70 75 74 20  |)\002\001$(tput |
000001d0  73 65 74 61 66 20 38 29  5c 30 30 32 3a 5c 30 30  |setaf 8)\002:\00|
000001e0  31 24 28 74 70 75 74 20  73 67 72 30 29 5c 30 30  |1$(tput sgr0)\00|
000001f0  32 5c 30 30 31 24 28 74  70 75 74 20 73 65 74 61  |2\001$(tput seta|
00000200  66 20 33 29 5c 30 30 32  5c 77 5c 30 30 31 24 28  |f 3)\002\w\001$(|
00000210  74 70 75 74 20 73 67 72  30 29 5c 30 30 32 5c 30  |tput sgr0)\002\0|
00000220  30 31 24 28 5b 5b 20 24  63 6f 75 6e 74 20 2d 67  |01$([[ $count -g|
00000230  74 20 31 20 5d 5d 20 26  26 20 65 63 68 6f 20 22  |t 1 ]] && echo "|
00000240  5c 30 30 32 20 5b 24 50  53 31 5f 50 41 54 48 5f  |\002 [$PS1_PATH_|
00000250  43 4f 55 4e 54 5d 5c 30  30 31 29 22 29 5c 30 30  |COUNT]\001)")\00|
00000260  32 20 28 01 1b 5b 33 32  6d 02 24 7b 5f 5f 67 69  |2 (..[32m.${__gi|
                   ^^                 ^^
00000270  74 5f 70 73 31 5f 62 72  61 6e 63 68 5f 6e 61 6d  |t_ps1_branch_nam|
00000280  65 7d 01 1b 5b 30 6d 02  20 01 1b 5b 31 3b 33 34  |e}..[0m. ..[1;34|
                ^^             ^^     ^^
00000290  6d 02 24 01 1b 5b 30 6d  02 3e 29 20 5c 5c 24 0a  |m.$..[0m.>) \\$.|
                   ^^              ^^
000002a0

With the fix

$ echo $PS1 | hexdump -C
00000000  5c 30 30 31 24 28 63 6f  64 65 3d 24 7b 3f 23 23  |\001$(code=${?##|
00000010  30 7d 3b 65 63 68 6f 20  24 7b 63 6f 64 65 3a 2b  |0};echo ${code:+|
00000020  24 28 74 70 75 74 20 73  65 74 61 66 20 39 29 5c  |$(tput setaf 9)\|
00000030  30 30 32 28 24 7b 63 6f  64 65 7d 29 5c 20 7d 29  |002(${code})\ })|
00000040  5c 30 30 31 24 28 74 70  75 74 20 73 67 72 30 29  |\001$(tput sgr0)|
00000050  5c 30 30 32 5c 30 30 31  24 28 74 70 75 74 20 73  |\002\001$(tput s|
00000060  65 74 61 66 20 36 29 5c  30 30 32 24 7b 50 53 31  |etaf 6)\002${PS1|
00000070  5f 53 48 45 4c 4c 53 5f  49 4e 3a 30 3a 24 53 48  |_SHELLS_IN:0:$SH|
00000080  4c 56 4c 7d 5c 30 30 31  24 28 74 70 75 74 20 73  |LVL}\001$(tput s|
00000090  65 74 61 66 20 31 34 29  5c 30 30 32 24 53 48 4c  |etaf 14)\002$SHL|
000000a0  56 4c 5c 30 30 31 24 28  74 70 75 74 20 73 65 74  |VL\001$(tput set|
000000b0  61 66 20 36 29 5c 30 30  32 24 7b 50 53 31 5f 53  |af 6)\002${PS1_S|
000000c0  48 45 4c 4c 53 5f 4f 55  54 3a 20 2d 24 53 48 4c  |HELLS_OUT: -$SHL|
000000d0  56 4c 7d 20 5c 30 30 31  24 28 74 70 75 74 20 73  |VL} \001$(tput s|
000000e0  67 72 30 29 5c 30 30 32  24 28 65 63 68 6f 20 2d  |gr0)\002$(echo -|
000000f0  65 20 24 7b 41 57 53 43  52 45 44 53 7d 29 5c 30  |e ${AWSCREDS})\0|
00000100  30 31 24 28 74 70 75 74  20 73 65 74 61 66 20 35  |01$(tput setaf 5|
00000110  29 5c 30 30 32 5c 44 7b  25 59 2d 25 6d 2d 25 64  |)\002\D{%Y-%m-%d|
00000120  20 25 48 3a 25 4d 3a 25  53 7d 20 5c 30 30 31 24  | %H:%M:%S} \001$|
00000130  28 74 70 75 74 20 73 67  72 30 29 5c 30 30 32 5c  |(tput sgr0)\002\|
00000140  30 30 31 24 28 74 70 75  74 20 73 65 74 61 66 20  |001$(tput setaf |
00000150  36 29 5c 30 30 32 5c 75  5c 30 30 31 24 28 74 70  |6)\002\u\001$(tp|
00000160  75 74 20 73 67 72 30 29  5c 30 30 32 5c 30 30 31  |ut sgr0)\002\001|
00000170  24 28 74 70 75 74 20 73  65 74 61 66 20 38 29 5c  |$(tput setaf 8)\|
00000180  30 30 32 40 5c 30 30 31  24 28 74 70 75 74 20 73  |002@\001$(tput s|
00000190  67 72 30 29 5c 30 30 32  5c 30 30 31 24 28 74 70  |gr0)\002\001$(tp|
000001a0  75 74 20 73 65 74 61 66  20 32 29 5c 30 30 32 5c  |ut setaf 2)\002\|
000001b0  68 5c 30 30 31 24 28 74  70 75 74 20 73 67 72 30  |h\001$(tput sgr0|
000001c0  29 5c 30 30 32 5c 30 30  31 24 28 74 70 75 74 20  |)\002\001$(tput |
000001d0  73 65 74 61 66 20 38 29  5c 30 30 32 3a 5c 30 30  |setaf 8)\002:\00|
000001e0  31 24 28 74 70 75 74 20  73 67 72 30 29 5c 30 30  |1$(tput sgr0)\00|
000001f0  32 5c 30 30 31 24 28 74  70 75 74 20 73 65 74 61  |2\001$(tput seta|
00000200  66 20 33 29 5c 30 30 32  5c 77 5c 30 30 31 24 28  |f 3)\002\w\001$(|
00000210  74 70 75 74 20 73 67 72  30 29 5c 30 30 32 5c 30  |tput sgr0)\002\0|
00000220  30 31 24 28 5b 5b 20 24  63 6f 75 6e 74 20 2d 67  |01$([[ $count -g|
00000230  74 20 31 20 5d 5d 20 26  26 20 65 63 68 6f 20 22  |t 1 ]] && echo "|
00000240  5c 30 30 32 20 5b 24 50  53 31 5f 50 41 54 48 5f  |\002 [$PS1_PATH_|
00000250  43 4f 55 4e 54 5d 5c 30  30 31 29 22 29 5c 30 30  |COUNT]\001)")\00|
00000260  32 20 28 5c 30 30 31 1b  5b 33 32 6d 5c 30 30 32  |2 (\001.[32m\002|
                                                                ^^^^     ^^^^
00000270  24 7b 5f 5f 67 69 74 5f  70 73 31 5f 62 72 61 6e  |${__git_ps1_bran|
00000280  63 68 5f 6e 61 6d 65 7d  5c 30 30 31 1b 5b 30 6d  |ch_name}\001.[0m|
                                                                     ^^^^
00000290  5c 30 30 32 20 5c 30 30  31 1b 5b 31 3b 33 34 6d  |\002 \001.[1;34m|
                                                             ^^^^ ^^^^
000002a0  5c 30 30 32 24 5c 30 30  31 1b 5b 30 6d 5c 30 30  |\002$\001.[0m\00|
                                                             ^^^^ ^^^^
000002b0  32 3e 29 20 5c 5c 24 0a                           |2>) \\$.|
000002b8
