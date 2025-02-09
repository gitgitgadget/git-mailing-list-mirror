Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA0128EC
	for <git@vger.kernel.org>; Sun,  9 Feb 2025 02:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739068401; cv=none; b=imtmqQg0LYDTiwz2Odbg3I6aigoY9tbtDM7A1YvH1ZO9msoxbt31WnMUjkbBlSMoA0r1JjmlUerJrSjqD9EupGzSQerSzhCyh0t1REOcorwzEFdG9P1EovuFBHpAuoLoMqwnwQWgD87fq3TBzVbPm+FWQoFawiBVOxperslAolg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739068401; c=relaxed/simple;
	bh=cVhtUhzDatm5MLfD9bUsXhuueI88lM4MYKDun0HSglM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=p1Vqo9PX+Eoak+BfZNc9FL+HAt46f9liYxSRVSCwPPHsolFfGfnAUIlkKvLax7XUQOndYBaZMbJmGK0AteZ0U6NqeZyrZfbdXl6+LdGUSTrlz6sToVBK2bm55JdRehCBtMcIgmgldcBrB2HdgEJXum64NGULoGSPgA3fZqQqZuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k29dvcAN; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k29dvcAN"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aaec111762bso802844366b.2
        for <git@vger.kernel.org>; Sat, 08 Feb 2025 18:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739068398; x=1739673198; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8BDl1tM9VcKNET9DgIQoWEf3YGfWvVeFE8h20Ygko8=;
        b=k29dvcAN0vd0/odN/EHnVz/0OUtb6bx9RENTN0MfDzYo2SDlllRofcsnspMrT6sGEE
         DTh8PgcvdqqDOaj5IvvQU30lxhcWkCnBYEG31x8i47ddwbgQXvHwop6gsTSHWIiVHKvb
         yvQGMgTKtULaeof6ylGd0A1gEteE5wUxrrcbYg2SlNg3nehnDs0lTw0ny5REJ0Ypa2eO
         qx6yXAJ6QwieTl8COhW5x9d7yafoUxl7c5xv6aW2webgF5aLC6vAhXnfU8ogdMWmt5+K
         wqlwqxMe/XqNTenrQYwrSPlRoedcci/dOD1sW4PLLlaAOCryMxOoA8juuXQTtFCsu0w6
         N8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739068398; x=1739673198;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A8BDl1tM9VcKNET9DgIQoWEf3YGfWvVeFE8h20Ygko8=;
        b=gRAH4sXL46qZ6fQgSESGy2E9qhzqq/XKj3YdUuGvNcpvfiZWXjBO1z4Cvvakr9ilbE
         tWAODEqtWdDsS8y+pIaGfgKoz7smwtBN5/HwmKG4XqdOIk+m/PK/In4aqCx8uaJearpX
         LYnmA8hC6mVkva7EwXq1z2rYEWmAGl/nnPE5NgD/wS4C57Uj072E7ToWVmh1LgCLqT/D
         xaO05O9XwzhPr/5uFMwfeSsSv83D8bd+tt+CU0T46+NzRvgcDdtwAzNxnshAob7ysqlx
         /seyRtcwQlxRm/499CHUM3HeTzUATisE22Zyw/qYgQFQI2KtgUvg9Z2QhUMWg3ygVQ1/
         PxYg==
X-Forwarded-Encrypted: i=1; AJvYcCWThXqfpMnLF5Xo9tA7AfrCwBjrV4rDTCOLPaZ8dDbeVuALVzyW9CfkHheHi7N6ljXQbQo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4S1lIHjfrsIcaDrub6T4xiGvvB/pswbOMtSbeHay6v2fsW1Pf
	0CUtP+Z2w3u71KkMAPR5q62kKDceLAqI3ow209ZkRAsWMtduXSF2+s9A15VhGMPMP25CSV2VcNs
	wv3O578fB9HcbO+mIX3wB8BaCp18tqXH3
X-Gm-Gg: ASbGnctyg+dJjXnwiGKpxcqWw79gH4mRy2XoQ/YtdasYbwvOBNe2wEAdaLAAzRQCpjR
	4tyFhklLIzmnZ2CedEMOF3HH0ZWpQzCqbw45MsrUGzkyI6gv26efFtC9zaWd8Lhlkk11g+i/IHk
	cj+cIJXLXPz9YFh1yZ96Ox/Wd+qns=
X-Google-Smtp-Source: AGHT+IEhQo7JODl+8dsn/bLA3KJzbqVKzEyVmtMRdI2GPr1ac0EvnIWFYvpPt3rsDrr/MNKXIE5HNCHgUuxai4W24pw=
X-Received: by 2002:a17:906:694e:b0:ab7:a8b3:b015 with SMTP id
 a640c23a62f3a-ab7a8b3b0f5mr276011266b.49.1739068397455; Sat, 08 Feb 2025
 18:33:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206134006.GC30202@raven.inka.de> <20250206200418.GD30202@raven.inka.de>
 <CAPx1Gvc2piLT=p+dvzcJPTMDQAAjQfz__O4KiRWs-fOMg8dpTw@mail.gmail.com>
 <20250207104510.GE30202@raven.inka.de> <CAPx1GvcyaZqYK+SvgtfsajqtkMty1jOcVAtwfmam-LpOjyd0jw@mail.gmail.com>
 <CABPp-BFnx2m75jsa3_kTPet97HY+xwb_6JmPiKM5+OARPy=mGA@mail.gmail.com>
 <20250207203248.GG30202@raven.inka.de> <CABPp-BFGUa_DRBe1WLVfCOKh53+F15KxW_c_OZAMwZCxuAQCiw@mail.gmail.com>
 <ba65ce17-8768-4d60-aec6-badd12930b81@gmail.com> <CABPp-BGwZ029Y8Kfr2kkGiUDZ613kxS81JXzk36V85=77KcYfA@mail.gmail.com>
 <20250208232651.GJ30202@raven.inka.de>
In-Reply-To: <20250208232651.GJ30202@raven.inka.de>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 8 Feb 2025 21:33:05 -0500
X-Gm-Features: AWEUYZmCK_sXHtJ5QdbT56IMYc3rcEqBlaZPnYO3dY9e7jurjEozwc16L7kDRik
Message-ID: <CALnO6CCUYSM69V4CRiFV=EvQLCC7LCdzuY2gqryj_G_nAWqj-w@mail.gmail.com>
Subject: Re: renormalize histroy with smudge/clean-filter
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 8, 2025 at 6:28=E2=80=AFPM Josef Wolf <jw@raven.inka.de> wrote:
>
> Hi Elijah,
>
> On Sat, Feb 08, 2025 at 01:43:05PM -0800, Elijah Newren wrote:
>
> > Ooh, nice catch.  If folks had an appropriate .gitattributes file in
> > place in older versions of history, they probably wouldn't have gotten
> > into the mess.
>
> Well, you can't assume that paople get it right from the very start. An
> important use case of git is fixing errors made in the past, right?
>
> In my case, I had no choice. I HAD to commit those propritary data files
> as-is, because I had no clue how they are structured and how those hashes=
 are
> calculated. As time passed, I learned what I need to do to smudge+clean t=
hose
> files. But at that time a whole bunch of commits were already done.
>
> On this roadtrip, I had to modify those .gitattributes files in various w=
ays.
>
> The only variant of those .gitattributes file which will work properly is=
 the
> newest one. And this is also the variant wich will work for all the olter
> commits.
>
> So no, I don't see why using any of the older variants of this .gitattrib=
utes
> would make any sense.
>

The original question said

> Why on earth would one want a changing filter setting during a rebase?
> Can anybody outline a use-case for changing filter during operaion? [sic]

But I'll answer this one=E2=80=94general operations on older history can't =
use
a newer gitattributes declaration without explicit instruction because
they'd have to know from which future to pull. Remember Git can
branch, so (even assuming we had a fast way to calculate this, which
AIUI we don't) from a single commit there can be multiple valid future
commits with different gitattributes.

For the starting point of an operation that eventually invokes other
operations, where the start clearly uses one gitattributes, it _might_
be reasonable to assume that would propagate down to the other
operations.

But when subsequent operations logically operate on older history, it
also seems reasonable (and unsurprising) to "do what the repository
intended at that specific commit." Git assumes the latter and provides
a way for you to indicate the former. Perhaps it's worth an explainer
somewhere?

--=20
D. Ben Knoble
