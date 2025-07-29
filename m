Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EB829D0D
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 00:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753748757; cv=none; b=HQvxtPEIggNTbiU+rsJrYB0eN1yVoeNl3rXgbaBvSTKJkSFhk7Bez2k8k7n5ntMYS7WYircaNkPzJXAUm662QKWylR0Q/Qso9G9YoieRgZYHDHKOGIddPTJMqKUUUZ8PJgCRcpDrKVJvQ8hrZPx0EEcIdqTrZDQyel7BeRHBnXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753748757; c=relaxed/simple;
	bh=FquRD2OgeoC9g9glrJUZwCzituTjCrj/YE7joh1ftaM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Cc:Date:
	 Message-Id:References:To; b=j7Rwgfo0myjoIxCOHT22mONQIe49UCSTyMUsAyErD4w8q7t2gOrPm91SRFl5/OHIamlAXYx4GKAnDC5BFTLM+BiZXGh04YMeZmJtKXh0iqEZp/Tzp+GE4+/SCG4dsyq6ZZtxraAnsUDJPE5+7ukjIvAF+DV9wTxJO/hlfOf4LlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duUpyVc9; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duUpyVc9"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71a379cecd5so703427b3.1
        for <git@vger.kernel.org>; Mon, 28 Jul 2025 17:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753748755; x=1754353555; darn=vger.kernel.org;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+AGpCEbZW6kQkaXOVH3GtpYbYwWqbsroXsUilkqUqY=;
        b=duUpyVc9HCyXwfke4pw0AREIC80FmRGMpyqpEld+kNYirmSwm0LV7Fxp87ee5Jc/UV
         DzhEqql050WkYPkWEmjK3v/huCO40AesoBWVWWde2UaZM1K34Umk1ZCokNx3ECt603Yf
         NgLJTCwibtkisEQdwa4XQzHsFvjMppKycfBMYn5ILN8aN2521xYBbcTG1mwZjo5RMcHb
         FzOVKLQfDiDWALOu0BsOhdMQRSrxgqYSTAgWAWRbjrC0XAudeQzpxSI6DlGKbxuOP0Lg
         qwHYdGafTVbhOOvi1cgT+IvetU2gu05dXcliB0bTLL0RJf5me3cZlIUBE8unLPE/90UI
         wLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753748755; x=1754353555;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F+AGpCEbZW6kQkaXOVH3GtpYbYwWqbsroXsUilkqUqY=;
        b=YXpXet6up2K3pCMlBASkbi1ORPD2kY/xzVPBpR+yRyYTVyMoxqAScWB/pd5GVm2d7h
         dPSxMYmpL1rK/Q6SN+AEnzSOuMqCnL7k/JJZsKUdbBM5L+d/VFMeNhpEgDcDYTUhECL7
         6uoBdI62QD/6+jopdvjiPWGHpaaPr8ZKlJDb0tgf7suQhO31Cq5KSFwvFvr6S782spXC
         YaEIDVLC2w/qA47DEPxVuor66ySuRwheWgNzfJ3NReoi/VbS0vh9Y4PMtBR3UamNGg5m
         6SIIiQnVK+moA/tt5p1Cvawv70sydM2u6mgEFQJRVxzUnvBRu12l6TQab1HzAeKiGgW5
         mFkA==
X-Forwarded-Encrypted: i=1; AJvYcCUTsqu1Wr4VLgmYCTt5PWaO1atb1hJE7PBOW9PyHfeHnedXbWPUnfmeDs8w5AdrggClAoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYTY4qEzMfiioIV5aULCtieCZmJ9KayssSl3c2NFaFIpmHB8Ve
	t2LZG1IKDGnD/Jux9uAjIcIwNXcvZX3ZqXIDxArUukxICgubAX1A6IIt
X-Gm-Gg: ASbGnctorDBvTegAjNfU8N5Mvfxv7aKnzUSyl3+WOjSAXZGOMmvEem8KbzFsFLnDNJk
	1OfVqD24DOEeWK4MObtiWEo1W26T6rp7e2rA8fjVE4wjdgLJfnngPrLD+uW0N+mdbvS8PrNJe/l
	Com5XynvTQ8kYzjhxbhEEdsYmzH38OoxCOl+cbmSzjOPmQ4JFSa+3muYXBvO0KoRM/gnPmqd774
	ceE7gwOLRyTZ5j8RICxl360y8+G766LXMDI12cQeIhi7F0PM2UI4tpVWQapFXlFGo1V2pYyPopr
	L2ZEWdWHgsVu9+b1BpXIQZLUaZF+kNcG2XK0U707QIa4dtdbkov39dOzilomNgTD18wQJ2OP/fz
	Ecwe6abQOENosX02Q/6n6DcbsaVtHi6TeeGXjAFZRa7o/bnGypDA=
X-Google-Smtp-Source: AGHT+IFYyYzV8OyhDyeWg1hPj7aehptx5ljlzlEQcgBAucnS4sr7p4BI3uplDVox+xGwRTxUtisyyQ==
X-Received: by 2002:a05:690c:3501:b0:70e:7706:824e with SMTP id 00721157ae682-719e328b1aamr159306517b3.6.1753748754705;
        Mon, 28 Jul 2025 17:25:54 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:59fa:4cd3:495a:22ea])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719f23b23e6sm15309807b3.65.2025.07.28.17.25.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 17:25:54 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 4/8] builtin/reflog: implement subcommand to write new entries
From: Ben Knoble <ben.knoble@gmail.com>
In-Reply-To: <6414dbfd-6f34-48d1-aa3f-3fe7998f80af@app.fastmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
 Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>,
 Junio C Hamano <gitster@pobox.com>,
 =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
 Toon Claes <toon@iotcl.com>
Date: Mon, 28 Jul 2025 20:25:43 -0400
Message-Id: <6E84D571-CC02-45E6-9E58-DD918B45998E@gmail.com>
References: <6414dbfd-6f34-48d1-aa3f-3fe7998f80af@app.fastmail.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: iPhone Mail (21F90)


> Le 28 juil. 2025 =C3=A0 11:37, Kristoffer Haugsbakk <kristofferhaugsbakk@f=
astmail.com> a =C3=A9crit :
>=20
> =EF=BB=BFOn Fri, Jul 25, 2025, at 08:58, Patrick Steinhardt wrote:
>> While we provide a couple of subcommands in git-reflog(1) to remove
>> reflog entries, we don't provide any to write new entries. Obviously
>> this is not an operation that really would be needed for many use cases
>> out there, or otherwise people would have complained that such a command
>> does not exist yet.
>=20
> This command will allow you to write a simpler unique marker (without
> having to make a marker-ref for a ref) that can be used to find back to
> a specific point.
>=20
> I=E2=80=99ve had some use for that.  I used git-update-ref(1) for that bec=
ause
> of `-m` (as well as plumbing-for-scripting).
>=20
>> diff --git a/Documentation/git-reflog.adoc
>> b/Documentation/git-reflog.adoc
>> index c3801b82fb6..c8389810273 100644
>> --- a/Documentation/git-reflog.adoc
>> +++ b/Documentation/git-reflog.adoc
>> @@ -12,6 +12,7 @@ SYNOPSIS
>> git reflog [show] [<log-options>] [<ref>]
>> git reflog list
>> git reflog exists <ref>
>> +git reflog write <ref> <old-oid> <new-oid> <message>
>> git reflog delete [--rewrite] [--updateref]
>>   [--dry-run | -n] [--verbose] <ref>@{<specifier>}...
>> git reflog drop [--all [--single-worktree] | <refs>...]
>> @@ -47,6 +48,12 @@ The "exists" subcommand checks whether a ref has a
>> reflog.  It exits
>> with zero status if the reflog exists, and non-zero status if it does
>> not.
>> +The "write" subcommand writes a single entry to the reflog of a given
>> +reference. This new entry is appended to the reflog and will thus become=

>> +the most recent entry. Both the old and new object IDs must not be
>> +abbreviated and must point to existing objects. The reflog message gets
>> +normalized.
>> +
>=20
> You have to give the full refname to this subcommand.  `git reflog write
> ... branch <msg>` will update the reflog for the one-level ref `branch`.
> But I=E2=80=99m used to using git-reflog(1) with a name like `branch` and i=
t
> using `refs/heads/branch` if it exists.  At least that=E2=80=99s how the d=
efault
> `git reflog show` behaves.
>=20
> Which means that
>=20
>   git reflog write ... refs/heads/branch <msg>
>   git reflog branch
>=20
> Will show that written reflog.
>=20
> Whereas this
>=20
>   git reflog write ... branch <msg>
>   git reflog branch
>=20
> Will show one entry since `branch` is the one-level ref `branch`, not
> `refs/heads/branch`.  Now it looks like `write` truncated the reflog and
> wrote a new reflog message (if you mistakenly think that `branch` is a
> branch).

This quirk of update-ref bit me the first few times I used it, too. I think i=
t=E2=80=99s at least documented there though.

>=20
> It isn=E2=80=99t clear to me how the current doc guides me in the correct
> direction here.
>=20
> I tried `git reflog drop`[1] and it can deal with a branch like
> `branch`.  It doesn=E2=80=99t need to be told `refs/heads/branch`.

(Partly responding to comments about what to do with this) I think consisten=
cy would be best, and since =E2=80=9Cgit reflog branch=E2=80=9D is not abnor=
mal we should continue to allow that.=20

>=20
>> The "delete" subcommand deletes single entries from the reflog, but
>> not the reflog itself. Its argument must be an _exact_ entry (e.g. "`git
>> reflog delete master@{2}`"). This subcommand is also typically not used
