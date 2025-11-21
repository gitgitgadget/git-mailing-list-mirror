Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0BD2BE7DF
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 21:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763761953; cv=none; b=kpE7RCF5H/RA5MTyL0IPwuH9Aa+BOWZWzf1m3yLrjpPlpgBGGJgSqlD09YxRMF5+8NtrcwDv6QXf3WNn9sNfz9Fq36CpcmHQ3eohANXY9z2RCenUu3Y48kHM8tpV5BZ7N2wgF5rz2iduEwU8PV3WXNU0SQaLv5dQY8yIEZhabGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763761953; c=relaxed/simple;
	bh=oHvhHqaNjvmm8XkVrrhxFiTa1KIeSNAlR/XOLlIDTd0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=lnMjKrLuHIwj4dFtsssSQBBAszHuPfraOR2r4LjKHdTZ24eLwy3/gWWywgI1hRNL6h7Qy/H7+gD0j5Yeg+KlA4rUNNGuH9WrvWU1kFOLfc2XEP8o0VfJRCcP1e60nD3IBAZRmLFsL+UM6RLwuXBB/tG7kvUdWyuiQAsXYoJ2CTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jdkN5CQJ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdkN5CQJ"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7b89c1ce9easo2853424b3a.2
        for <git@vger.kernel.org>; Fri, 21 Nov 2025 13:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763761950; x=1764366750; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oHvhHqaNjvmm8XkVrrhxFiTa1KIeSNAlR/XOLlIDTd0=;
        b=jdkN5CQJBgilbistLHscWnbcwgqpXDCp3BQjpp27Sezujd0QogzjHAcFuxUe6JwkOW
         UYwj+sfWofRr0SqmpGAZQtUAHAp55JQYFLjB2SRMKfFog8EN1faSBGQA/JM/dLsfs/gX
         XdgQWjxrMAxrW8/2EBIpm+pKhXOe+b+O1B0CXGK9UqVR8oUNAnb+rmPI0/J1P3c00yqu
         jkTFdKt4ziiNh0vrN9ivAeij4rvhScU+lQX+dU5uW9n/PtYbnuyQ8AgNVcrSbwJrJppg
         1YZdX3o1EHJLIZhaVWYz74uJLgpizRAJTiJFjXHhPXhukbUCqP0/q2i8mJPB8FGsJ4fg
         y7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763761950; x=1764366750;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oHvhHqaNjvmm8XkVrrhxFiTa1KIeSNAlR/XOLlIDTd0=;
        b=gc1QfyunShVqQXhRVIRM1RrmN9mNQu5CfIEJsYQvRWDnEa/ID8G9zBWcHpqoIl9xwI
         NDuajPMp7yujhXXxhc44X7xF3H32xpkbLS3WE2OnU+pgTyr4a9TKcY2GfiQF1F4FT8qR
         hBUWGCggqf618/MtSuyPKzBVLQ3YOazTJDXWx5y0o4/+TIxrFiMtW+kK6mMBfswQyemh
         uCx6cav6dcHwFNWpyIFrzxt57midOkUs1z0dBzZmdwyCkjT2YgXmK1j3YH8ThOogYPD0
         bg6sZ5FjshG3jMZxXx4YGPBoZI6JSkiogRHYvKzO7V1Kkl11VvyzrC2inxLm8y2P2KL9
         hqQg==
X-Forwarded-Encrypted: i=1; AJvYcCXGETK+xa2u1ZEfgHV2WGC3mGo2xrVWqV7uPd6I4YV4d+yKjLNvAypNGkDCKgndRRO6Igs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8CZltm/PRVhlz57OG6FI4jyl0m8AaD3NEv0Ewbdj5KzQLlgn2
	nN1nqz65cULCV4pXv+0lhU74LPo/I/+yowhg5xrwN6Tp4w4hrP5a87IA
X-Gm-Gg: ASbGncuZwwtnMXqcbknVJSNqyI7mf+CxHj3oaTscwraxEatnRBWSfUaYhjJnmTASiB2
	REsNzYX1E6BgFH2JJ07V3z410vv8eUuKSCFCRFfoCKm9k7o4OmOvNjNg3fmO2T7XNIJ+a7lhT5G
	ULzCb+E3rt3SWHrigxkVmFAFyKwr+tAAOnc2JujMY9NBJSmzOSV6ESCAr4G3pnSev8y7OXhp5xZ
	9ghBPa4RPhMIMOHbVD4pb2QQ9eSMiqGavM7dzSaiTG6SXQyXoFEEMVjxmzPfdGN4uJYT53tT5Bk
	1K7LdaqblOrH8C2lchCyvWPCOCdoBmS0fcUi/WRvEy/T+f62rjg58fEZcHDJg0RET9MbnQc87Zw
	8tIuSMzt0blgh1WumghmF6RRQWcVs2dZJZCGgZ14sLnyHRNeZ9N0dNBtjBX5yOEIA9/Xi54QRcL
	nkp/oFTBX/28Z1MFj41W9X3yNQ1NUbL+Pcv0qC5GqG
X-Google-Smtp-Source: AGHT+IEBGpvgvbDo2q74C5R0jLdLXW0H1Ge0I7dsJlCbQhlW67HlYDhFxMywlTS2Vnfpc0YB1y/G5Q==
X-Received: by 2002:a05:7022:4425:b0:11a:e426:911a with SMTP id a92af1059eb24-11c9d718ebbmr1325287c88.15.1763761950119;
        Fri, 21 Nov 2025 13:52:30 -0800 (PST)
Received: from smtpclient.apple ([177.103.85.82])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e3e945sm27983077c88.6.2025.11.21.13.52.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Nov 2025 13:52:29 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.200.81.1.6\))
Subject: Re: Feature request: git cp
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <CAL4-wQra+7HOJ6_qNy+4_tvz7=KApW7yb7BNE6B86JnowschXg@mail.gmail.com>
Date: Fri, 21 Nov 2025 18:52:15 -0300
Cc: rsbecker@nexbridge.com,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <6D0DEC5C-0912-4D48-A108-3E0D1B2017D7@gmail.com>
References: <CAL4-wQrgD3nnW2BfNf6e9d7tDANE60dYBRRP_0FW3Z-LvQrZmg@mail.gmail.com>
 <6F4B3935-7F2F-43C9-8E5E-12E2FB3331BD@gmail.com>
 <010b01dc5a7b$4790ee30$d6b2ca90$@nexbridge.com>
 <CAL4-wQra+7HOJ6_qNy+4_tvz7=KApW7yb7BNE6B86JnowschXg@mail.gmail.com>
To: Martin Guy <martinwguy@gmail.com>
X-Mailer: Apple Mail (2.3864.200.81.1.6)


> My only regret with git is that it's line-based instead of word-based
> as that would see a change from < limit to <= limit as one symbol
> change, allowing semantic analysis of program changes but
> if it's all retrospective anyway, the line-based change analysis
> could gain a word-based mode.

Again, since Git is based on snapshots instead of deltas, actually
it doesn't really matter. Git doesn't store diffs (deltas), they
are only computed when using `git diff`, `git show` and `git log`.
If you want the diff based on words instead of lines, you can use
the flag --word-diff in those three commands.

And, again, since Git is based on snapshots, if one wants a more
semantic diff, they can use the snapshots of two commits and them
generate the diff the way they want. One example of that (and one
that I use a lot) is git-latexdiff [1].

[1] https://gitlab.com/git-latexdiff/git-latexdiff

