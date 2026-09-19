Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6EB379EE4
	for <git@vger.kernel.org>; Sat, 19 Sep 2026 12:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789820422; cv=pass; b=UWZZX5K7pfoglb+K+T6GYQptyCuqgu0FZqy9xv5dxyBXFnHOUVE7UpRpv2SfdhjwM5qTdEN9bBGIjB1Al7sUOCegDLY69Z4vL58ColbMj6G1SevL1zuSlMU/xz0yG183j6z6focsZj+B+ytFR9Tp0bO12ecK3lNnaYBbJPEU1+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789820422; c=relaxed/simple;
	bh=0ctvl4/IXnbS6LiOjN0v1amDg3l2ULm+9l0LzZ7T90s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=kAoCnKfks9j3pjYkQJHVveDgJE0vGlqW5u+qYyfj9u8UsU/tfvnV3sVxqtlU3tPBVB4OJDARaTRy8ncAgRkAN9LTjeJOh2hDUDisZs/zPLbh4u0lgBVf+YKSAxZkTfISHUmlTPcsXHK7tMI6FL5yj9m1xZEDPIg0spHJkC7guck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q/A+Eoyw; arc=pass smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/A+Eoyw"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-9107051ba26so11127426d6.1
        for <git@vger.kernel.org>; Sat, 19 Sep 2026 05:20:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789820420; cv=none;
        d=google.com; s=arc-20260327;
        b=qgmKIIaBE4HXjDOyfdkCb5AYQJWG6KuNqLtXY94kpLbzUbwaVYToKHHI20tMlExeIt
         r8VVQLsMiN1fJKEJdZPjLjQ/lwQIn22n6REgloVFrv11GgiWbG6hKtH+dkagT+Ixn5wL
         Hy3ZzUnCr3u/W6z60RHiJyQmHclcP0ax+08ShVzMxcNNoCSs20kI0MAQjLbl3MUAHiMg
         NKpMXdmmfaPe/K28/osj83igYOtGCBJIvWUwC0mr46RdZWrXzjJajz2xJsCSbC9L7W2W
         3kVVyPwrvC4UnpeefAlrZUhX+dbsufoB8l2OYhP9haMIAVreq/FICmOe2oxOuzeM5PRf
         2ddg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=AiWAg8INKvoaKuZyI5LYoPGVS8sx1BE9z+AsBG5wsr4=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=ZLYZJZhfpckBKgiglW7hQ+nep697eaTex0z1cILcqg4AMkHDNhkjNVp5ApXmb+Rhis
         3Lk05NpDIQ4VS0zaT9hTPn8q6GNuPirCq2PvRbPiIR8rkB5MRSR7ycYnpFJeK2EGyqMY
         86Y6JRDdhflKzT3hMqVskMNLdC3rj9HoS60V13fU+G94y+2/2eeObIqJT6J0R1qsV/4o
         SUp2cxnI8GDRsyGP75aO2du1CSKJ+gql0/AY+l0ta3fdt1mkJ9fQLynE1iDB+SGxsbEc
         GyLlbK/cUxLccmB1o2YzxZSS71MjGPWz1nyJYOy3Qr6HcIWhhbz5dlx/gRnlAaDhR2G0
         7uBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789820420; x=1790425220; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AiWAg8INKvoaKuZyI5LYoPGVS8sx1BE9z+AsBG5wsr4=;
        b=q/A+EoywBOJruZ9oB8QRyyLtGUGZuCbW7OZepikiu21tlEUtSFKvf7oyHxmkQVMkmx
         mM4SLkedYAAFHij6e01qnjq7s1Qp85+Kcea7hw4xf2xZAdLXD6iAKmfNlTcf04BUCZiy
         2qWes2N8q4NsZKh92fCbadFdHbmFtpwB1ASALTTH6yqgz51jLTeQ1J6FQ6OhbLULzcCr
         yCshS0nXzeRmVr1ZVfWNxWwoeuPpHwogBsAbqcMbkTSIZoVIEvp/V0MHqXhvAisVsZKt
         kMlpPi97NGTo//482YHmE5jBjUJM+oRI+9MGIfq48GZhfZIQF74RpN0erolCozS44a4D
         OBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789820420; x=1790425220;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AiWAg8INKvoaKuZyI5LYoPGVS8sx1BE9z+AsBG5wsr4=;
        b=A+Ii1Q6sypcYFYvpD3lAE+Qv0zsH064NelsQNoP4IpKYS1ii063RB0WS3hQ0SDOxdo
         fwenK6SphlT4H2gX/i7/i2ZyFt/PibV3F4xoYsLbrxNafdPWhlNeyGbJz9cPntb8TIxd
         uTWbrMduFz7kPaYIhtJfoUQMDGLEXYgmYB0pft8rOXiebhAnOpQPzrxlsdiBb8J8xlfW
         OubRVSDpMJvtoXSzt7NzZTpnz2L8/O4OwyV36LUMG7tiWXyW/NqhUMz2+h0cHuFmh4Db
         L3RvLFpXe21k8pYxUEcLX99juM7ezo3mBytlaK2xONlLVfAxBnnEk6PdeAzTaSfp3AUr
         iMyw==
X-Gm-Message-State: AFuF++ntWYzR9yxDB7F5pDHTMYMnzsYFTcBT+FdrueRH2nkz6MguuwWL
	tqldtUQCZNfyqaiDuVUyiYdGmLdBpUmLYsZXJDjb3EdfYpHZXMljNZsvfbHxfUYlKAoZQnI9g6/
	k84AYrUq/HKUNHKP9IXWOyESiHAdJrz1JkBcz1Rk=
X-Gm-Gg: AYBFou3hGUPtaOMYeQYsPdqBJ7VPo0JjwggBg0tg0C4bsd4eTCCfwrqUmQeb8GvVZYy
	Q8ldMYo473ugWmhec7V1JbaLvJV/Od+lntkc9qaqVsXaiXAdOetpEXHRDzQ/1IbyQ3QngffU9ZF
	9ZPMf6JEuir8jg3nP3HVH2QWNXkzS2ZjvyEi+Ei4HamlZOMXgOvXOLpLhI0WPuo6+MZ2G4Vgk1x
	g8NfBbBOWrfDg/WVWSPccebOfaKnYXh/k9HpD5vLMGjW+mOAYlpoMQlIHqvlaDLWG95mz+wpL/G
	P3AMQHbw5y/+3vZLGZq0EDqbXRdPvJz82+WkvC+L3pljs10fE8Iq5rAnXUKcaCwMCAnQGj4WRNh
	NNYZpsAVQ8cvGFT81lajwg5rJ
X-Received: by 2002:a05:6214:4006:b0:912:5135:2a86 with SMTP id
 6a1803df08f44-9129c787f1dmr14571336d6.15.1789820419969; Sat, 19 Sep 2026
 05:20:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Francisco Boni <boboniboni@gmail.com>
Date: Sat, 19 Sep 2026 09:19:40 -0300
X-Gm-Features: AcwNN1WYgxrGf8tKYJmqZhW_8U2xl7D0yS2NtQK5FrENDRLENv8IHg2HDLbvr_k
Message-ID: <CAKNeS+mFS_VCs_tQeFb8jBx70FwQLW0LtuqhSk4xSdbWdqDR=g@mail.gmail.com>
Subject: pager: consider revisiting automatic LESS=FRX with custom core.pager
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I ran into a surprising interaction between Git's pager environment
handling and a custom pager, and I think the longstanding automatic
`LESS=FRX` behavior may be worth revisiting.

My setup is roughly:

```
[core]
    pager = delta
```

with delta eventually invoking `less`.

In my shell I had:

```
export PAGER="less"
```

but deliberately did not set `LESS`.

I also configured delta's pager explicitly as:

```
less --RAW-CONTROL-CHARS --quit-if-one-screen --quit-on-intr --ignore-case
```

What surprised me was that:

```
git diff <commit1> <commit2>
```

caused the downstream `less` process to behave as though `-X` /
`--no-init` had been specified: it did not use the alternate screen,
and in my terminal Page Up / Page Down also stopped behaving normally.

The `less` argv itself looked as expected and did not contain `-X`.

Eventually I tracked this down to Git setting:

```
LESS=FRX
```

when `LESS` is absent from the environment.

The particularly revealing test was:

```
LESS="" git diff <commit1> <commit2>
```

With that single change, the same delta -> less chain used the
alternate screen normally and Page Up / Page Down worked again.

I understand that Git's default `LESS=FRX` behavior is old,
documented, and presumably exists to provide useful defaults when Git
directly invokes `less`.

What seems questionable to me is that it is also applied when
`core.pager` is an arbitrary custom command.

In this case the effective chain is:

```
git -> delta -> less
```

Git is not invoking `less` itself, but the `LESS=FRX` value injected
by Git is inherited by delta and then by the `less` process launched
by delta.
As a result, Git ends up silently configuring an implementation detail
of a pager wrapper. A user who explicitly configures:

```
core.pager = delta
```

would not necessarily expect Git to alter environment variables
specific to another pager that delta may or may not use internally.

There is also an unintuitive distinction between:

```
unset LESS
```

and:

```
LESS=""
```

The former causes Git to inject `FRX`, while the latter causes Git to
leave the pager environment alone.

I realize simply removing the default could have substantial
compatibility consequences given how longstanding this behavior is.
But perhaps it would be worth considering whether the automatic `LESS`
default should:

* apply only to Git's own default pager path;
* be suppressible explicitly through configuration; or
* otherwise avoid affecting arbitrary custom `core.pager` commands.

For my own setup, explicitly setting:

```
export LESS="--RAW-CONTROL-CHARS --quit-if-one-screen --quit-on-intr
--ignore-case"
```

solves the issue cleanly, because Git then leaves `LESS` untouched.

So this is not primarily a request for a workaround; rather, I wanted
to raise the broader behavior because the interaction with pager
wrappers is quite surprising and difficult to diagnose.

Thanks,
Francisco Boni
