Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCFF19007E
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 22:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736893295; cv=none; b=m4kf3rVF2UJMI7sayUD5deY5UdJyV6eGJVlocQCB1I8VUcMZS+rODeWJZCogHF56R0VJBDCy8kyirqean7iKa3Eg3g9C+efADT9QfFj0YSEpGiqXZgNT1hKrrspfrv+GKO3NhrMJ7bvtHVMLpan6SWiQxnebqm7bGql4Ssro6zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736893295; c=relaxed/simple;
	bh=zVE7tqDUDHUcJRZpfWd51VxhQ5PCh3aZLJKonBDOvRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OhHLSHjyuD8HYXYhzybShWJyxdKHUHIbvF3mXUli3F/dKzKZqVuYfJvTMNzXBSYkWhfRe0/bSxvnj/3x7DlzH9ZN1ccy1r3vmKuwYI+EVqQ8EPzoW0dWSBzg9AEjfs/iBvymzDZBG0dP8oU/AYXxz7QVblwgAb1wLAHyF5En40c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8qRB14/; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8qRB14/"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa684b6d9c7so1056702566b.2
        for <git@vger.kernel.org>; Tue, 14 Jan 2025 14:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736893291; x=1737498091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h55MuiUZTr1nFkeWKNoM6IrM0Z1rB7cekyeGnbAORIY=;
        b=E8qRB14/SBbfCNSODLHyfJ58y9zF5n8pcNlcypI3hJACjEPl+Dv+AhNdURpMzxKSgQ
         uCGbXHaTT8IaykNVLyKE4j8sydnh+PqztGddP6LCvn53tS2Ty6xlSDox6MuQSXsm5Hxq
         TUO7dTZoqH+y0BP2yxu+sZ+E50i31ZkC2jbMJUPsAipT9sfxq/yBwGxNvpY3vQlh7EeA
         TlqTFAmWbOWYI/Na0DLE4hn6as0IKBBR+zm+J3ks6gmUjESdOLHJTt/NJ9LTEuncwJPJ
         jMkM7VdL4+p/sz3zE5OrlQNEpyF1DjhOwl0gUOlzqdzGQ/0F2VQobV65YJHT+BWcvg7c
         yPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736893291; x=1737498091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h55MuiUZTr1nFkeWKNoM6IrM0Z1rB7cekyeGnbAORIY=;
        b=uEwzeXEGiXUfGE9pBVIJJ2yWKP8kCo3MbLxtZWC8VZAzMPn2xHyFb5pSZo7rUWZ/CQ
         QyZIvvvnLhOXbzqmtwW+bxELLHo7QuSJqKFIi11YhmqaTGLn/DpieCzxvmzMih38ESGb
         6urRS3jn0jC2Y6BKAygfhx6p6cFY3evqGbBE523WhHxsJobHh8D9gHTZ6ktdrz/bOjjG
         7whGGW9Af5KH2hKUFOTzgon8r/2plcjCqk5gc6ZC3zqLKWeAHW2jt2SMKiLn2+pl+ZjA
         VEfpww6lt8T/EtZB9E5D3QrGA4mnokoCYfkKEH7KSxG5PHzfdI+hKDVIC8LeELIhWVaf
         d8oQ==
X-Gm-Message-State: AOJu0YzEsfw77nfQX97ruh/Na9TLpkWFp/bFScmIWFusyrpoDAZQuB8O
	rHY46wHOgH/eJY7h6yiJoWnabvfLiAsBcKPXDpZ7S74DBxRtb+1C5xBx8tACTX5vFo5ISChg+8x
	OZO3j0it7WcBw8g2h70AZdVc2PSJ1028blus=
X-Gm-Gg: ASbGncs3mwlMsSTzZdSk6p3BRVrupHTNWwuS9xUbNR37qGUXVgSNBIVf/Q+jq8aP1PM
	AtEvTNwOjFiEqLqUiokqRVUK8+54isMhjhRznkUCaC6IAsESfFNDvMxDrkZE/nVGPAkhntg==
X-Google-Smtp-Source: AGHT+IFVzqgscXTSAiWuzWEG3wtyPGzrQE3OoCsJZ/28vY+s5P2YAoIxJzCH4ObrAcEg3iWlV9J7ENRtg3lealcNefo=
X-Received: by 2002:a17:907:7e83:b0:aa6:9eac:4b8e with SMTP id
 a640c23a62f3a-ab2abc6de91mr3037778966b.41.1736893291384; Tue, 14 Jan 2025
 14:21:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <19461b87a5c.5a2ea74016716.8214238482389812984@zohomail.com>
In-Reply-To: <19461b87a5c.5a2ea74016716.8214238482389812984@zohomail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 14 Jan 2025 17:21:20 -0500
X-Gm-Features: AbW1kvYR-Q1YoC9qAcxDmlNsbM250lxKXz_lgUlqngrSJu0uvrRa1mJG6jPu1l0
Message-ID: <CALnO6CAzN1oeT4tMjJ1Qm4dW0xdVkVKHJ39oJTX8R8E614FH6g@mail.gmail.com>
Subject: Re: [bug] "git bisect old v3.0" takes 21 mins on Linux repo
To: Askar Safin <safinaskar@zohomail.com>
Cc: git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 5:11=E2=80=AFPM Askar Safin <safinaskar@zohomail.co=
m> wrote:
>
> Hi. This is bug report. "git bisect" is unacceptable slow on Linux repo.

That may be a bit inflammatory ;)

>
> Steps to reproduce:
>
> =3D=3D=3D
> d-user@comp:/tmp/t$ git clone git://git.kernel.org/pub/scm/linux/kernel/g=
it/stable/linux.git
> Cloning into 'linux'...
> remote: Enumerating objects: 13079335, done.
> remote: Counting objects: 100% (153/153), done.
> remote: Compressing objects: 100% (108/108), done.
> remote: Total 13079335 (delta 84), reused 70 (delta 45), pack-reused 1307=
9182
> Receiving objects: 100% (13079335/13079335), 5.18 GiB | 13.72 MiB/s, done=
.
> Resolving deltas: 100% (10454171/10454171), done.
> Updating files: 100% (87234/87234), done.
> d-user@comp:/tmp/t$ cd linux
> d-user@comp:/tmp/t/linux$ git bisect start
> status: waiting for both good and bad commits
> d-user@comp:/tmp/t/linux$ git bisect new v6.13-rc7
> status: waiting for good commit(s), bad commit known
> d-user@comp:/tmp/t/linux$ time -p git bisect old v3.0
> Bisecting: 535608 revisions left to test after this (roughly 19 steps)
> [62606c224d72a98c35d21a849f95cccf95b0a252] Merge branch 'linus' of git://=
git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
> real 1293.32
> user 1291.70
> sys 1.41
> =3D=3D=3D

FWIW:

$ time git rev-list --count v3.0...v6.13-rc7
1070175
git rev-list --count v3.0...v6.13-rc7  13,57s user 1,41s system 96%
cpu 15,466 total

That's a large number of revisions to bisect. Further,

# --force needed because my filesystem is case-insensitive :eyeroll:
$ time git checkout [--force] 62606c224d72a98c35d21a849f95cccf95b0a252
git checkout --force 62606c224d72a98c35d21a849f95cccf95b0a252  7,94s
user 18,54s system 96% cpu 27,360 total

Using pathspecs or a smaller commit range should help speed up the
start. (On a recent git, the helper is gone, so I'm not sure where the
time is spent=E2=80=94but I do notice that `git bisect start v6.13-rc7 v3.0=
`
is slow enough that I've killed it rather than wait.)

--=20
D. Ben Knoble
