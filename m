Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3C95227
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 21:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759095548; cv=none; b=fLa0PizddWtxzs+p7eKNXeDobB5xfph+s73I2hgWlFU0GpPIzgmtkOUZaH7kbjE+Ti1ugysdgarIV7HosJ4qQnEnGOnDef1PQsjUrJv2NBaZX2L4xiQU7dIcNKMrlJvDDQAF8CbPf4F4r8ksOeoUzdt1/6vXdSbt2x8zDFhP6l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759095548; c=relaxed/simple;
	bh=IyZVS1lwx5NGlMDczKoh7EfAry/Q98tNjKh5MC0gDs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R0Cajp5I4XHriC7+vTUeWgiJDnc7keKcIy1QcL2XL1PnSIWvGRoYFL5Je+nleZc1muuy29XGSvV3s0UwQEwmXx453UIgSpwPccWkbGkQZx1UUkBttEMq8qEHufqAjI0e76P/kDtMGLCYlj4uG2C3st/O5QcS9ZxhBNkywJhm82k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dyt1gEof; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dyt1gEof"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-62fc89cd68bso7347876a12.0
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 14:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759095545; x=1759700345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqYBtSyF9vZjMASgt0HpBmHGy2hl8BJB51jMq9Sx7dg=;
        b=Dyt1gEofDLIn94s2jd/5CjIJLEI3DhuQ4M6AwpmL3/VNdg0wmQ8DED109/C3jjPiO2
         sEGAi5B0yyatR3PkCJ7sMLqxAJJI/yNtulmSlpsjtJLZlIJ6N1vW7c1CFezaPhLp2MOQ
         6UdDydjrsG6Pk24aEZsxEXDGoaqalSPbzgyUZGxR3bpnKcBOvFP4dBXnSZ7xOfMHuQc4
         r52Yx6rD32g6EytE0iYwL24EEW6z2FjXhjLfGbVmPdwLrOtobA3BOhyOuhp+zRV/gEVt
         l6mPU4oabwy/Rg7HbKB8QHeO2AUL7RqgzziO1qgcVfjAf6IuszqWUI4WHww9hNH2WTbV
         FoIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759095545; x=1759700345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BqYBtSyF9vZjMASgt0HpBmHGy2hl8BJB51jMq9Sx7dg=;
        b=oM2vGZ+rR6lcB7whzdORKDlxk3z/XCqQBQTFCM61T1kne/Th3i6aPlh4UMM8X/ie0R
         bAVGPUok/X0OIsbyuiel70i/QHvHVxhGgR+BiCMy6hDw6x7zCFpyrME5kFV5wVnG0RuN
         y2609DBGgA/xDtJuNWD3CXp+5clHsYqZCUFuX07vyogkTTUKGcvw8VRO/6xDiw6Tc4a5
         X40+WSiDU/DuvZ7xSKJk31tZfX7PubaNYztpkLGWWRLbBmcpSGy866aFfaeXHciTaWVq
         UMs3NrdrGtbqg26H1kPbAzBy8Z1rdnvWIIxUjabCQOaz8fCNu6sIXiVn6NMnxRFkN0Ft
         I9UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYpxiXIKbWNCPkps+CmJJQFSLfAJqrkFytvlMvyqynZZZ1ev6kBJ//bGrlpNV8TCW9etE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpuvsdGETJP6u0uWaBUtSB975mWujVReZJUK2/34/bvbL1JMh+
	z8AMEOb36X+ZyH6KRb4N6nHCCcxRTlPYc6FLE6jKM9Mnf1uUcYpvfcD8iMZWUjkqGtrE/MbDDNW
	+gUwN1/NXOP84czcdTzMB5DmDfFwkKyw=
X-Gm-Gg: ASbGncsPIUaElpmtR/Gs45NjIMmF0XOQ2ipRUiysodVoXIkXHhEsNEyHQZ5ieubYpsy
	Inos/IcrElp/rbkuVf1LuNmnSdT/mkhKSk5/oCmO//hHwxhUjKYppWPk+eZ4V1gTol2XWsYB9dp
	kwLuKvj5xRyzp7TpSgapndbOk/qcGRq7nJaVqXHY2EUuKcX1ujlB5AmpOyxN8Anaj+sueffc9GY
	hWpuBaaii2ETNbkng3DShrUel+fJBZX2xIe+17s
X-Google-Smtp-Source: AGHT+IF1JKEvfveuzwzfqK+7Rf71lVJYAbQAGluHTQ3ZtNjx9EUPUJ08mVgFEYxS5uRs21vjcZD12ZMIpcQlGICc9+4=
X-Received: by 2002:a17:907:d26:b0:b0b:47af:1655 with SMTP id
 a640c23a62f3a-b34bab2db0amr1553635766b.15.1759095544906; Sun, 28 Sep 2025
 14:39:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1964.v2.git.1757703309.gitgitgadget@gmail.com>
 <pull.1964.v3.git.1758649472.gitgitgadget@gmail.com> <be6453d010bdc9d2b49988d6841dd7e7f9bdf1f8.1758649472.git.gitgitgadget@gmail.com>
 <xmqqqzvvk4bj.fsf@gitster.g> <2365a7b9-3d22-4406-876d-65822822655f@app.fastmail.com>
 <xmqqzfaidyil.fsf@gitster.g> <1422594f-b0a8-4a7a-bf78-940693757224@app.fastmail.com>
 <xmqq348admuo.fsf@gitster.g> <xmqqwm5lcjvy.fsf@gitster.g> <442a4f25-7d7b-4f34-9e2c-ce396277e7be@app.fastmail.com>
 <xmqqa52havek.fsf@gitster.g> <2b8193d1-f492-4cfd-b568-107d68112d9a@app.fastmail.com>
 <xmqqecrsak3h.fsf@gitster.g>
In-Reply-To: <xmqqecrsak3h.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sun, 28 Sep 2025 17:38:52 -0400
X-Gm-Features: AS18NWDCDX9n_JQnsjfVjEiT8YTMsIH4h8Bfy1kfqXApnlh1wpXqnHc3otl5tzc
Message-ID: <CALnO6CBVF6+dvhYApEQ6npz9JuDNBVGhYfzi_6D9fOGzu4JTHg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] doc: git-push: clarify "what to push"
To: Junio C Hamano <gitster@pobox.com>
Cc: Julia Evans <julia@jvns.ca>, Julia Evans <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 7:07=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Julia Evans" <julia@jvns.ca> writes:
> > My best guess from my experimentation and from reading some
> > of the commit messages/code is that the rules for how
> > `push.default=3Dsimple` works are something like:
> >
> > 1. If the remote you're pushing to is the remote that `git pull`
> >    would normally pull from if run without any arguments,
> >    then require the user to set an upstream
> >    (with the idea that the remote is somehow "special"
> >    and should be protected from accidental pushes)
>
> This is the traditional 'simple'
>
>
> > 2. Otherwise, push to the branch to with the same name
> >    without requiring an upstream to be set
>
> This is what 'triangular' feature we saw earlier in the "git log"
> output in my message you are responding to had a few commits for.
>
> > That said, the exact details of how push.default=3Dsimple works
> > (ironically) seem complicated enough that I don't think it's worth
> > documenting in detail at the beginning of the `git push` man page.
>
> Totally agreed.

Seconded: Julia and I spent quite a bit of time in Discord trying to
piece this puzzle back together [1], and while I don't think we found
_all_ the commits you listed, we found most of them. My summary was

> I think the logic is:
>
> - pushing to the same remote you pull from? Only if @{upstream} is set (?=
? and maybe something about branch name matching, i don't remember),
> - pushing somewhere else? Pushes to destination=3Dsame name

[1]: https://discord.com/channels/1042895022950994071/1412969828066787462

Getting a clear picture _somewhere_ of this default would probably be nice.

--=20
D. Ben Knoble
