Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F192627EC
	for <git@vger.kernel.org>; Sun, 14 Sep 2025 19:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757876791; cv=none; b=p48DhGM4gt5NF8rJmcsIzjKosDJ77vX2IqlzVJtR29hTsBl0TBNiUFKUvOAhn5iL0Iu9Lr1hl9/PQEn7+bG3fc65XCP1T7F3J/fp50sjpkyLnIlwvszDNG0nvTLhwhJTSxyVOtUdPueCodplzDbYwtUYelS5ubccFEik7LnF2AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757876791; c=relaxed/simple;
	bh=KBsOSDsEnW9rzk9f9FPS9KoPOYTQz9tfEZACa8Mjqu4=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=hxG9DNoblUgYd3+OCg0aGih16ltOGcJsNUw0f7fkGuFd8pjoJshLMB+e3jW4XhEVUJ07FMFN1y41g5jcG8/menkOzggcFhEu9AszYiTIxlAYXTLiYb6JLeARvkohPHUPk+RdptYy/aT9GFbmP2FpLgTyNC7GWnzHuofld8rJaPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJBtRoCI; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJBtRoCI"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-ea3dbcc5525so1516904276.2
        for <git@vger.kernel.org>; Sun, 14 Sep 2025 12:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757876787; x=1758481587; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8i03zelantGZbooC+rovCvBPOm2ARj7Gbk8YTNoEblY=;
        b=LJBtRoCI5Oe/nR8BEXFzpJFy1NB9lihrwRmTCo5iDCB2zG9/uol5YF78OU36AY/9Ix
         /szqbXh4MTF0cfhdijIjkF6hVasEsSbQAySumSMD+znA34q2FEHbT0c8BCA4UWshA61B
         qer91Sh53/7uCe4EFpX2mmsz1SGwLh9NQ2L8qHmRv/rw4Mp60k/7BxB/DO7Bv6zaQ9ln
         grF8zT20r9PbsCdGA3rnZjJiwudZSz73uB0TQ/GHTxAs7TE/aAubAByEM/zeGyCA4Uzr
         jYYzLIWCiyYjicbJnannRZb8Yjp04ucVaUElOcGkK63o0Y41IvtJsYgLgICubkqFAZ7n
         VOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757876787; x=1758481587;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8i03zelantGZbooC+rovCvBPOm2ARj7Gbk8YTNoEblY=;
        b=XVQM0YEbKWuskczZBQrchJl5wf4u9JWMLZtTEQ8lVmgDY7d/V9Z0fN11FUpwUXbDCW
         gW/RDi5LdZhrjG9b9YxcG1axWXNPxQCBsDqs86L/JkhW8Ylss2D6xO7KmnsnEzBaL45f
         mOlbEFzovQh+GQk2LsHw9wEQ+eNU8l0/X4UybK+wwXRqeyF5t/I2Xn8Rmc4SklhmFgJB
         2hm0l03ORyVZtHO+6bijqgjPc9VZoppmj5GLmI53T+l9BPLMdGgbTls7J1vIRgFAAE3n
         NuZQ2k3mtnWdrrBGP6g7OGWQN4CDRsE2MQ6O3jmIEJUXCJN1S4FJIflxnWHs/2hSP+oM
         VnTA==
X-Forwarded-Encrypted: i=1; AJvYcCXN1USUUocEILh5fSWe4XdYGEt6BN6vc46YxJt4LsjYhb+lNeTPyKLgpO/ufYskUma2P+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIVrgnHj1AbJDBO53tS31loXdRlJYcEhb/8Apt99TuRCkDQ/DH
	/m36hap5Emz1BVp0LAN9hTaH0M8awroQ1Ihriu085Dm8L/nHCF4Ax4Y6MgepdE4E
X-Gm-Gg: ASbGncubTs2cFtXRB8PAMFkPyJOd6NLXeJR6t1WHqer/J0TpNDCOTjzJSrPRJ0cNiR4
	EJDtDybK+LjXK79QZ+vbbKnTLdb0usc1vRnR+GC8KWnSy3xTEFPy7GklxByldKZCCj8Vc4SruXW
	vkvvim5YBQd1uo7Z8RZ+63S3yr28/Q81l9PF9l/19TV/wQ01j3+/DarmYquLyABJJZag9gZT6p8
	pyfzHbKRZejGzK/oKTwv36wHUJGunFeKrk9BM20Rx2wafH71ybZOydKOeWLR1AUGYKSHvBeqV39
	9/l4qxPVNsH1zlqIX0fqV7WlXISLRx3nnZhU/+9yg0RqTwJnkDZih4wV0ONLXBUIGTGot+QCQMq
	r3OWMsUNm6M4j4l++7mGEVsHeLRP4SvOs7R5nev2Lhk6QDAL/EUmVOFw2E+uSF/I87cxmhIpgpM
	coD7cb2OVjWcXGHcIbJNgIEbJp4Q==
X-Google-Smtp-Source: AGHT+IGHvLrzJs3+nFk7wTOiZKhnoQkmQyZIPd7a0r3Z/TaxWaNT3OHwZI6joPewVSq+olAoR0HrEQ==
X-Received: by 2002:a05:6902:120c:b0:ea3:f937:a52a with SMTP id 3f1490d57ef6-ea3f937a96dmr4148453276.24.1757876787493;
        Sun, 14 Sep 2025 12:06:27 -0700 (PDT)
Received: from smtpclient.apple (99-144-70-174.lightspeed.chrlnc.sbcglobal.net. [99.144.70.174])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-ea3fe8b1b01sm1198842276.4.2025.09.14.12.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Sep 2025 12:06:26 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/3] checkout: provide hint when failing due to another worktree
Date: Sun, 14 Sep 2025 15:06:15 -0400
Message-Id: <1A8DE1F7-6C83-4ACA-A9D4-D686787EA9BE@gmail.com>
References: <6B2DF1C9-8745-4733-8082-9C37BEF12150@gmail.com>
Cc: Gabriel Scherer <gabriel.scherer@inria.fr>, git@vger.kernel.org,
 Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
In-Reply-To: <6B2DF1C9-8745-4733-8082-9C37BEF12150@gmail.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: iPhone Mail (21F90)


> Le 14 sept. 2025 =C3=A0 15:03, Ben Knoble <ben.knoble@gmail.com> a =C3=A9c=
rit :
>=20
> =EF=BB=BF
>> Le 13 sept. 2025 =C3=A0 16:56, Kristoffer Haugsbakk <kristofferhaugsbakk@=
fastmail.com> a =C3=A9crit :
>>=20
>> =EF=BB=BFUnrelated: I found it confusing that my `co =3D checkout` alias d=
id not
>> work with this fresh-off-the-press Advice:[1]
>>=20
>> ```
>> $ ./git co master
>> fatal: 'master' is already used by worktree at '<path>'
>> $ ./git checkout master
>> fatal: 'master' is already used by worktree at '<patch>'
>> hint: Use --detach to avoid this restriction,
>> hint: or --ignore-other-worktrees to ignore it.
>> hint: Disable this message with "git config set advice.branchUsedInOtherW=
orktree false"
>> ```
>>=20
>> But it did for this older Advice (which is in my installed git(1)):
>>=20
>> ```
>> $ ./git co -b .. @
>> fatal: '..' is not a valid branch name
>> hint: See `man git check-ref-format`
>> hint: Disable this message with "git config set advice.refSyntax false"
>> ```
>>=20
>> It=E2=80=99s because aliases are run as a subprocess from the `git` in `P=
ATH`:
>>=20
>> ```
>> strvec_push(&cmd.args, "git");
>> ```
>>=20
>> [1]: Chain of events:
>>=20
>> 1. Try to trigger the Advice in this series
>> 2. ... but it doesn=E2=80=99t
>> 3. Is the code wrong?
>> 4. Wait, I=E2=80=99m using my alias (which I always use; I don=E2=80=99t t=
hink about it)
>> 5. I test with `git checkout`: it works
>> 6. ... so aliases don=E2=80=99t work with Advice?
>> 7. Test an existing Advice that I know about
>> 8. ... but it does work with aliases
>> 9.=E2=80=9315. ...
>>=20
>> It was part of the process.  I didn=E2=80=99t *decide* to get hung up on i=
t. ;)
>=20
> Using bin-wrappers/git should set things up correctly, I think?

Ok, just saw the other patch series and see how this could not work. Thanks.=
=20=
