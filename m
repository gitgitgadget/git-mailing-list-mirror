Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA1B7DA82
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 18:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737399504; cv=none; b=BVJsgTp/uM2ofuWy5W2KuPvaSXj4SrJGoqUcFb0xwdf926M+g/OZQiEet0JjvrsrgLrlzy9asL0d7JEA0nAJozVA23efZRXJOX3/YRDA7R/2ajoh079dnDxgccVs/7LA6g3MVIT1/n7WA4yCAqEtW0d3j58bFKutVkRDptHIgwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737399504; c=relaxed/simple;
	bh=ZnTZBOWt4afvSaPzR79sJHKmWQh9WKdEqgmkITPK2y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L3OeZ6Ds3KkrXYnO/v3P5yT0hZx1KRJbQMMVVGL6S/P0tKDGXEM5F1cXyz/eoGqVZ7WOLM+JlryZoy9Ge7r9Op4YrzbyV445M71eRGoGIv28eKxBl6mZSy5AjkmbFjXYTykzHg2q/d36GXc2MaNlp/YKStaD8/kzTMTtpQaH3UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQ460G3i; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQ460G3i"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-85ba92b3acfso2248663241.1
        for <git@vger.kernel.org>; Mon, 20 Jan 2025 10:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737399502; x=1738004302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9nTQ2lgXSJYBZ5ioBKoCjbTf2rUCJQWGCg6huwm6Ic=;
        b=BQ460G3iEr4hEPuueyisA1PD0qxG4+O/SQet6tgeTzsHCibwnq3q1wyElEyIt5Cwu9
         3VsS+spdLNic2lXpmY7gYtCJSTgWW9DLerrE7v7aWW5rCsRjYbwRC0RVCG6TiHGVqK/T
         MIRGXZ+pyBDn/crySVFtS4eUF9pY5QQi6oDNpDwBZHXCUm7uHuumP9/mQfSuZZy8dnBg
         5kHsoGrSHJM4psHvN/HmfIZKaMP+XeOBZVpTJK0rCe9BCPpro0ACsn7rp5DM9Ba94FFr
         vDwt4ZQMAZxTp6vyJo8cS/HNpylDV6tQ5ZylnnYPG6evC4fzM1XkDsYgTQDHXnIVb4pN
         BRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737399502; x=1738004302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9nTQ2lgXSJYBZ5ioBKoCjbTf2rUCJQWGCg6huwm6Ic=;
        b=Tj5RxaO1XUsIeXsgUz57+ufHvsW0MR5XvSOze9KZ0xeNfszRI61Cp+y0OOwQNBiDzr
         nYt10Wbo/lDaff2R8zQtY7bQhvQXr3PlytU8+N6zP9VcupFfAxEdYex66lAbCH5QXiLo
         D1fKtFjeT+z8tYBr3coBWMh4TPAobXFCGLrGt68UammYjy+M3nmpTkx+hYgKCrgW2QCG
         Mvx/qEg0QStKmasWXbu94/TXQfG0r0m7X8Ij9YqLluHSUhHqAnI3H6OQ5WJWqKxG4ArX
         aSbKyvKAbN66bjTI3S0w5xySnVyt94CIQAJo/RHrBHPd0g+DFCYqDGZCwqGniVxivk2O
         NfNg==
X-Gm-Message-State: AOJu0YwWmUhNjCm59VSTlOBr1maz8YeEp7sV2HdeM4ivg4euEAQqffB9
	aXmpM/LB+3PwGiwfICRCi8kMGoy4NlVI7F11JvuZtQWXbfj3LGa1RlZEIBVzNFspcW12tYiGhfY
	n2SaRnpMvoLxidS9v8XnauXz9Hw4=
X-Gm-Gg: ASbGncvGdZDVDWemoQmpCIg2hZVH+7w2MRpSjfUfSKujX52wxs6KDMPdsAGfzUJVM3S
	matBJurs4HANDoE9MJ00bCk2XwYrWZ9rFIRsGJbcsGAdrF74hoJE=
X-Google-Smtp-Source: AGHT+IHdq8Af5AsvwaU9sqlZMXrEtWrf5Gxu1A7dVMXSU4aqXMEPGO4XxQkwyUEuRiLoBmD+J4hHn/qIQhFM9cCROOM=
X-Received: by 2002:a05:6102:3049:b0:4b6:20a5:8a13 with SMTP id
 ada2fe7eead31-4b690c19fe5mr10897258137.13.1737399501844; Mon, 20 Jan 2025
 10:58:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
 <20250117104639.65608-1-usmanakinyemi202@gmail.com> <20250117104639.65608-7-usmanakinyemi202@gmail.com>
 <xmqqwmethxyq.fsf@gitster.g>
In-Reply-To: <xmqqwmethxyq.fsf@gitster.g>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Tue, 21 Jan 2025 00:28:11 +0530
X-Gm-Features: AbW1kvZ39wAIPEk5a_Itm5YVmsOXZHY6YYJKAbEblJswwReab2WyG7bBP4e19Sk
Message-ID: <CAPSxiM_9JKxu5QkxjHUFDM6cb5rSs400O72eYCiM8jHF9dr7Vw@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] version: introduce osversion.command config for
 os-version output
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, ps@pks.im, 
	johncai86@gmail.com, Johannes.Schindelin@gmx.de, me@ttaylorr.com, 
	phillip.wood@dunelm.org.uk, sunshine@sunshineco.com, rsbecker@nexbridge.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 18, 2025 at 4:03=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Usman Akinyemi <usmanakinyemi202@gmail.com> writes:
>
> > Let's introduce a new configuration option, `osversion.command`, to han=
dle
> > the string exchange between servers and clients. This option allows
> > customization of the exchanged string by leveraging the output of the
> > specified command. This customization might be especially useful on som=
e
> > quite uncommon platforms like NonStop where interesting OS information =
is
> > available from other means than uname(2).
>
> After reading the above rationale, I doubt the usefulness of this
> feature even more.
>
> Shouldn't that kind of anomalies be handled by compat/ layer to make
> their uname(2) emulated, or allow get_uname_info() to be customized
> at compile time by platform implementations, to yield more useful
> pieces of information instead?
>
> That way, we do not need to add another mechanism that lets people
> spawn an arbitrary command while Git is running, we do not need to
> worry about security implications, and we do not need to worry about
> people abusing the facility to throw totally random and useless
> garbage information at the other end to make their stats useless.
Hi Junio,

Thanks for the review.
This config option was added at Randall's request.

Randall wrote:

"Instead of an override, what about a knob that specifies the uname
command to use to build the value. Personally, I would use `uname -s
-r -v` on NonStop to get the kernel version used in the build. The
difficulty on my platform is that this is not truly useful info. The
effective build OS compatibility version is in a #define
__L_Series_RVU and __H_Series_RVU, so the knob might be needed in
git_compat_util.h or similar. This comes from the compiler arguments,
which are not yet captured."

So, the difficulty is that the compile time information might not be useful=
.

This patch is the last patch of the series and can be a stand alone also.

Thank you.

>
> I'll skip the overly wide documentation changes.
>
> > diff --git a/Documentation/config/transfer.txt b/Documentation/config/t=
ransfer.txt
> > ...
> > diff --git a/Documentation/gitprotocol-v2.txt b/Documentation/gitprotoc=
ol-v2.txt
> > ...
>
> > +test_expect_success 'test capability advertisement with osVersion.comm=
and config set' '
> > +     test_config osVersion.command "uname -srvm" &&
>
> If osversion.command configuration variable turns out to be
> acceptable addition, I do not think we want to use "uname -srvm" as
> its value for its test.  Do you know for sure how portable srvm is?
>
> If you use something like "printf ' \001a\011b\015\012c '", you do
> not even have to worry about how portable srvm is and on top, you
> can test your unprintable-redacting logic in the code.
>
> But all of that may be moot, if we take the "fewer customization at
> runtime" approach.
>
> Thanks.
