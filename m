Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E0F15574E
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 14:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395544; cv=none; b=uZfFvZ9lT03BQt0+1WOggqcYS1StBH7HaSZfkxLIUFbLpLLEXWKS6GkGc2kzyD7CsDl0avmRDNSUhfUsRVQf7DKdEHiwTGt6mABZx2AD4unhrRr+QbBS2qdNbeTKmxdFIahOSZdKiyLcvMnZzNLsLN1kt1V82dcxIQ0JyuOz/+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395544; c=relaxed/simple;
	bh=MVb2tdqchBbRosQ5o4C6L7LD3nhWvB+yskaNUqHrmGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uhu4ydXK1npbfEpIcLzPZxVEp98rZRoBamtO/PH4qu1Iedvp5OgZhO2Dp651U/IpnsPb3wkoAcA4h1gs1sjfVnfbyig/vgIitQRaN7+AuLVDweJsjkv6wA7U5/Qh2WnFB2ytCaO55VD4xeod42PWgjkt42nLrjIwKvRU6/h/M4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kfv+1hm+; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kfv+1hm+"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-85e1b1f08a5so11258339f.2
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 07:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742395542; x=1743000342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVb2tdqchBbRosQ5o4C6L7LD3nhWvB+yskaNUqHrmGE=;
        b=Kfv+1hm+1J3LJEjWSGzxRC3KCdxbGRDGaZKABJcSvDydyW2wwptS79emSUTOX8hYJa
         LOPP8rRz+pHMc604XPXB3+f6i7bzrnSO5tOgvYWqDrtRP7G7rdTyWE/qCGbYFCtBOmKc
         zoGiDd42Rj3eY1thh0thgY6GL3ELGM1TBnNTFngjLjbsfu3YPX+rSJ0SAfCLmajH7COu
         JdcX1b9AuZYzRWiYIarlHl8a4boxJlgrIX9qT6fR1y5Q2p3Hj1iHRIR8yhvObDiotIOo
         DD/BVT7ehzwhRFfALyLdDF+GA7hoMQ4veRlRd2L3PW+cA5VzzF0BQ7RUCdXxZe25lmb1
         DUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742395542; x=1743000342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MVb2tdqchBbRosQ5o4C6L7LD3nhWvB+yskaNUqHrmGE=;
        b=epjikEEvmrPPsemVGU19muBemN6tByb5/yzrAK7H7VsOyvb3qwxesqj0i/t1rM8GdB
         pmrpSan84AkuURyPAaQ3AMpDbzql7RUTQQyDSBzHF4DW9d9spUPGZB/+SDO11niAcycB
         woWLm+B5fonGCtHc6HHtEbgEkx4YsHjYb210eTwrBYober/HDBeZj7AaH2uHh7Fa16Bq
         0wwuqS7PTASPIQP7+lobu4tUW9eayALhSSxcX9+KbSRMcTw54+cZeS3JzNVntIzleD6Y
         t29dWUKxPHBvhI78A5/dXRRWIG9PY5b0ZUWcXz0nzpnGGE3L/L/GNjP9suvPPDpfyzgY
         oyzA==
X-Gm-Message-State: AOJu0YxZN/t0tSAIUJSNv5+ogNEuKw2+ed0yCb75MmNVeTVp/hMKhbct
	Ly/wVUyEU8FTYNWCSH5QBC80U0+uLLjGoLd2pCp+1jPzG/aTkBcKQyLZFKGucuvUHyqis1a+h8q
	k/7/Qqjk82f1f4V7RA1bcYYWU55U=
X-Gm-Gg: ASbGnctBrsXk4Qd+quRX/CK2UbMXDSsRbHy+1v5fs4jpgvP9MyJmKpqQYaHwNNBsehu
	uCoMj1go+HTM53Zbv9Rb2gwb5KDFG8eksb8eceoi3whjVhKiJpxvHr7COzPISrDj/H9+3KqY4XN
	ZYItOMp3cGhdsVbp6FE8BeWy+FbRkb
X-Google-Smtp-Source: AGHT+IE+XNiKqtaNr4HBFyOJRyOF0Mfj/oiyjQLcpa/eFDJE4CXxstCIjanaklOJMePaazl06bRb5bmuumtGvvKHyp4=
X-Received: by 2002:a05:6602:3819:b0:85b:3885:1595 with SMTP id
 ca18e2360f4ac-85e1378bb9bmr363075539f.3.1742395542417; Wed, 19 Mar 2025
 07:45:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7EC98E2F-144D-4974-94F6-FC24B443651D@norbauer.com>
In-Reply-To: <7EC98E2F-144D-4974-94F6-FC24B443651D@norbauer.com>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 19 Mar 2025 07:45:30 -0700
X-Gm-Features: AQ5f1Jrw0XTyvDG25s7Kw8uW1vz68UUQxbYCyIvEMQgMXNTD6O2uAe2SxnJlafY
Message-ID: <CABPp-BGTrEfGqX=o3W5rfqZiRdEuAzdKJuT8W0J=6kSY9ME4LQ@mail.gmail.com>
Subject: Re: bug: git shows hints that should be suppressed
To: alan@norbauer.com
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 2:59=E2=80=AFAM <alan@norbauer.com> wrote:
>
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
> `GIT_CONFIG_GLOBAL=3D/dev/null GIT_CONFIG_SYSTEM=3D/dev/null GIT_CONFIG_N=
OSYSTEM=3D0 GIT_ADVICE=3D0 git clone --quiet /Volumes/sourcecode/npm-packag=
es/packages/repository-tools/node_modules/.cache/@altano/repository-tools/2=
078b9db1d71a4f4a5422e25a7016c75/git.bundle .`
>
> What did you expect to happen? (Expected behavior)
> I would expect the clone to happen without any hints because I provided b=
oth `GIT_ADVICE=3D0` _and_ `--quiet` to the command. Both should suppress t=
he hint.
>
> What happened instead? (Actual behavior)
> I received the "hint: Using 'master' as the name for the initial branch. =
This default branch name" on stderr, which caused my tests to fail (I am us=
ing git programmatically in a test).
>
> What's different between what you expected and what actually happened?
> The hint on stderr was displayed.
>
> Anything else you want to add:
> This behavior is NOT observed on git v2.44.0 and is observed on git v2.48=
.1. So the bug started occurring somewhere in between those versions. I can=
 find the exact version the bug was introduced manually with some effort if=
 that would be helpful.

Bisects to 199f44cb2ead (builtin/clone: allow remote helpers to detect
repo, 2024-02-27); cc'ing its author.
