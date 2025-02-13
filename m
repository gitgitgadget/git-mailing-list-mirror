Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ACF266B55
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 21:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739480857; cv=none; b=Yp96pWoQMfEhDg7uCY87MEtkvn3Sc9fSjndf72RCl867qZ5hAWLgPIT7NAsWU6lhRRYcTjXUHDstoSoeRzBws4ZHhvM2cfcjFcYK/p7BPxjHJjgRcgB2ZqM6gAafptEqOQ2IKYLM8D5XKx1aglqSyM6+X8RVHMvHRovED41WOrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739480857; c=relaxed/simple;
	bh=RNy1Fs0n7l9MyI2JOX/2FVZ+sWMpLnbS9OxFnTffEH0=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=hQhNJy0K8SCQWzmxWK1mlpPtFmk8gCheIDq7wLyEm9R3q5gRJR7FceQRwvgjcVukytWmGgn74QMiBDKqdh11q4mxplya8tfecizjM23wwSVOem9DCyHeVT7ufZbzSYiO8cOv9978VXhJShOaV/l7muG0YiS+eFhe74+VKvvtWG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amRPjBQR; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amRPjBQR"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-471a25753a4so11494241cf.0
        for <git@vger.kernel.org>; Thu, 13 Feb 2025 13:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739480854; x=1740085654; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ND0AolxWZDcg8jkrKiLBL857CaR1eEl91UWit5U1Q6U=;
        b=amRPjBQRp4NNz7LYOKyMhBjZHUUjpRirm1gRTLMzHznTVOgcEJxTbhGyqKRBF4csjl
         ZbKlRcPLcRHmmv59bRcTmP4qBXC2KeHLVT8H7676CxuGXcXPtBpx3ncGQftFWsmMDojn
         Qcmwol5R3Cp0pafc+HBYmq91ioaCidy7XH+IYeICccXPTwNTmH1S+m2YLm8AvpG5/8NR
         ysKTB60hnG4HMEfcfOKa01Ii3RlgF06GfO7pp5zB46sC5AjziTys82pWmiRl3m/4HG3P
         W69ZbUDcCPCr7UQDPgiJHylfA4ma5DXWcKSKUlgdDR1zwI/g6IGSg41t7mVHimgRt8Sl
         u/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739480854; x=1740085654;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ND0AolxWZDcg8jkrKiLBL857CaR1eEl91UWit5U1Q6U=;
        b=ipso6p3CL7DvdvFzA7HT38VmSOlV5dehowRq2X++xGk/rMP8jW03eIlGIUNr9yh43E
         HZ3izhAU9aYQ3x2+m96lzEwKznVWsUN+leZVD4ohXnvamyXjsGxmo34GDZCLgtgjFkD8
         yUxxcEqg0DrNs5xXP+2axlrJmKwNVwD2MV0wV3G87Xyt7vHNhzUIGTIsINELZmQlwy4E
         yqxALU16vhkrAsq9+X3caYaGvzJml1rpbR9v6I6uV0IiMe1XMgjLltYMYOzDybdvtcOl
         9PRBhFBbx6iNctEbFSB3Pj21R+tE0HD27vixdJb4gnInbcS1F9Hz8V7vTYF1PXpMCSYw
         CqPw==
X-Forwarded-Encrypted: i=1; AJvYcCWjHLHUokkhAwlmVdvyfGjB/wa9hDtlIsb4+WPi2Q46St0hfYJibZQqkI9xi3AOXgvouK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO78UXUCrH3GGd5xcCkygyxXGHvj2Uha3iPdxoCtRX7oFmODsR
	DMlsXmhrWMfQMbZgWtSmcErkAkq3EUHqdyfCCdzg3xm6vr3Dvy+DOK017Q==
X-Gm-Gg: ASbGncvt2pAYTj7wwVpCfbagm8+vYg8OGzlVrou+EAstMNqht/6WHKKI1TbBFTegQjo
	y+CYHaGXu+TKThId+YhlU6/BMbkWw4bTY95WETTzvdwvslI+n3/oSw+Xo1SWsW65GuZfUyFfCtW
	BmC/jmHp5qWtpH2T0OvXpwF0g/AHhnJar+D4XNUWbsoqJ351NS132jxhPClyrUUtVJzPFpZlA9B
	I9MDvXZM2nKavRJMvanolawf0NaYashmmo0tt3/rATQdmZJ+q6EBJ252NKIa2KrN7Z0ooJabA2F
	kTP41xj0GhESzEBnqlM748crR3wBxwUfEF1ZOXaTjA==
X-Google-Smtp-Source: AGHT+IHO8frk+M2UDY45cNPnDIk8ILlIWfsK4lWxiju8GrKRUhjF6zXeGkFk4FPQeGM3pR3WvqK9/Q==
X-Received: by 2002:a05:6214:495:b0:6d8:916b:1caa with SMTP id 6a1803df08f44-6e46f898fd5mr160901266d6.27.1739480854474;
        Thu, 13 Feb 2025 13:07:34 -0800 (PST)
Received: from smtpclient.apple ([2601:5c1:8380:760:9da3:a1b1:61fb:9b52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d7a3d2esm13695776d6.55.2025.02.13.13.07.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 13:07:34 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] revision: fix missing null for freed memory
Date: Thu, 13 Feb 2025 16:07:23 -0500
Message-Id: <40281952-B43E-493C-A092-63768C708C8A@gmail.com>
References: <20250211212909.GA3113114@coredump.intra.peff.net>
Cc: Patrick Steinhardt <ps@pks.im>, Emily M Klassen <forivall@gmail.com>,
 git@vger.kernel.org
In-Reply-To: <20250211212909.GA3113114@coredump.intra.peff.net>
To: Jeff King <peff@peff.net>
X-Mailer: iPhone Mail (21F90)


>=20
> Le 11 f=C3=A9vr. 2025 =C3=A0 16:29, Jeff King <peff@peff.net> a =C3=A9crit=
 :
>=20
> =EF=BB=BFOn Tue, Feb 11, 2025 at 03:22:28PM -0500, D. Ben Knoble wrote:
>=20
>> 2.{30,35}.0 fails to recognize --no-graph, so I checked "git log --grep n=
o-graph
>> origin/master" with "git describe --contains" and decided that 2.36.0 was=
 first
>> release recognizing --no-graph, but it didn't build for me (possibly an i=
ssue on
>> my end). I got 2.37.0 built, and it was "good," so that's where I started=
.
>>=20
>> Here's my "bisect run" script.
>>=20
>>    #! /bin/sh -x
>>    make || exit 125
>>    # segfault has exit >128
>>    ./bin-wrappers/git --no-pager log -2 --graph --no-graph --patch
>> --cc || exit 1
>=20
> I don't think this is quite enough. The problem is a use-after-free, so
> the behavior is undefined. Depending on whether that heap block is
> reused, it might work just fine, or output garbage data, or segfault.
>=20
> I'd have _thought_ it would usually just segfault, but it almost always
> just output garbage for me. Building with:
>=20
>  make SANITIZE=3Daddress,undefined
>=20
> is a good way to get reliable results for this kind of memory error.
> Doing that shows that v2.37.0 is actually bad. And bisecting shows that
> it has been broken since 087c745833 (log: add a --no-graph option,
> 2022-02-11), which is not too surprising.

Ah, fun, that=E2=80=99s more like what I was expecting. And thanks for the a=
dvice!

>=20
>> The --cc is important, since this repro logs from where the bisect is! Wi=
thout
>> it, if the head commits are both merges (likely), the repro will accident=
ally
>> mark the commit as good when looking further for a commit with a patch wi=
ll
>> fail. Omitting -2 might work, too, but that makes "git log" take longer.
>=20
> I've also run into non-determinism when bisecting like this, because my
> test command depends on the value of HEAD. The best solution here is to
> just feed a stable tip to git-log. I bisected on:
>=20
>  git log --graph --no-graph --patch origin >/dev/null
>=20
> (I didn't need "-2" because good commits failed with "unrecognized
> argument" and bad ones were killed by ASan immediately ;) ).
>=20
> -Peff
