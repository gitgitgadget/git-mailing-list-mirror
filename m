Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055C325FA2C
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 23:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753487625; cv=none; b=qHi1iDngg+lO4mmJ5tQDdQmrkWjBBScKl/COMWjLreD1PAaJb6qKzYJFZop8MaWCUppDCY6f+Jadad3iLnyhtG+aRWUbSuCOgGZc1zmYWjoAIOfN2CUBWsJmIy6WpD89IeMZ6PWEzMLHpAU3wRVNj3dsQvRIJqmWD6kFyQWXy9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753487625; c=relaxed/simple;
	bh=ysiTcIwg7oXPIYv5sDMhddD8TXzmSKV5OBcB3iqszKA=;
	h=Content-Type:From:Mime-Version:Subject:Message-Id:Date:Cc:To; b=kOmUUmDfiJz4LfdDA/sAl7ozYnfLAsixby60YZSty/zVXfB6B6EOEX8Kh9f7nanP5mSHkZ/idP+omYofTLLTdbiaqN+AUK2y5D2J1Fd9bt8e91VRo2Gah/x1OlQrKeCATlVHmdECR1Fd1yJMp3TlDy9lFZR5eq8/ybR3OhzjBqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKEzpLqT; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKEzpLqT"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71967cd1072so26854077b3.3
        for <git@vger.kernel.org>; Fri, 25 Jul 2025 16:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753487623; x=1754092423; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ysiTcIwg7oXPIYv5sDMhddD8TXzmSKV5OBcB3iqszKA=;
        b=mKEzpLqTfXOrxL2kRcQMT8gi5aKGPJcauWKazasr+nj5mR1ARfYULyUJT/AoOWV6Ck
         V7DtOoJkMOMxwozFtj3w71ibmZ5niAgJH1Xp40tWm7U1YjZ22+W9bHACWn0xG2q32tNC
         9Tvc/RjWJ90tx4oRJiYOxGz1StRQ2m9s/Pu+P45lmnLcPUtGR1Qapd+Z67AxM9TiH2N3
         D7YR9Q8/toun+QcZ67ycEhvVjusoOprMXNz9OqYnbROeEL3rVeg+tY/NY2IO7SSoPZWo
         44UR+EisDMdtr6xjTesPfjpilI8FVCtgZi6ZdN6DDbUH0BqzLSlc4l6AFhKhMyKPKE3V
         YM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753487623; x=1754092423;
        h=to:cc:date:message-id:subject:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ysiTcIwg7oXPIYv5sDMhddD8TXzmSKV5OBcB3iqszKA=;
        b=p7Egfj/vOmllPXwH7HFT3KKI2H/7tQbBHoDnbUqjYmq7QVyPGzFMhMiAYWD2R1ZIun
         nXQNaSnl3vIjenHUn8FO814gvL9+CToV1VnX0LP/NQZ75qlxy0bB7PL9arijT+qz+yci
         y5DJ2FNxggsTevPcBbPK3jPzt3sB5VNvPvdwM+PxPPFVgL7woIN2itdwNibtrGfAWASA
         obWoEORw2RsiLQV5BS+59vIIV5/dy134F1cCMxoH9iynwpqPHT1cjF4YWGhs0Z4J9YS8
         DQZL6faswIx7r0tb1sSxAZ1jH4+Xw99CVdsU98Dnpv358/EGMhPu9kXBPaNtaQmUZTaz
         QJKg==
X-Forwarded-Encrypted: i=1; AJvYcCVDDauE+ZU2VXL37oOm+k2j8Pi7N1cVFdEyhefPrzUXYRqm1ZzKuEVL7TeSzsrUKcEzMU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG6YmtMEVbCuHZsVld0FihJ7Fa+xcRWfKZp4UmfiGlPPcIVqoW
	0rpSKIsJlDK1S9ZTbnqgXmtMih+qmNdnS/Cl7gocTGMQ7ESXYsctIgOO
X-Gm-Gg: ASbGncsvbnMi8Eh6+w/ucUPLYkVHAXX3QZd8/MXL4A/eekEC+VOFgVQS24Cd7SX2jFb
	1QhXNqJhiea6BMAV2dTnYS9BBGGI7BFCp3rvWCJOsBkBlhsja7Ds6PQrdkNAQSzb1xYN1rKvSp/
	45vgRQF821qFs0hKEbCxS1dve9YEERSacsF39R7fmwQksn9l7/lALCIRILFUkzdPU+NxEgDlwAp
	GI+swDzg2kUl4K9m9VOFk2+fHJlIU9Y/U6QgEcXex2ud51tnZYybh3eyjAl49lz+4GuK6YrVZVO
	a91+0O/LKKcmgB7ihU/2zo10ghb5g6jONfj1eszxEWw6tTc616ABoK0GWFD3xQKMj1WTuOt6GWb
	WrpiJfCciJSH1LEkxfCiX1zZftnSixjek3xlN4sv358AXW0gJ0vAs3yWVv2J+5ZHQR6JhKjz5Yh
	5jab8DeWj+ofpvyRg=
X-Google-Smtp-Source: AGHT+IG0MRno/A3olKkb4UCt58OUJlOuyrTv/EYDGGNXTVwhdkSVa19rh8iwzjuEreHQPRInAZ3DAQ==
X-Received: by 2002:a05:690c:490a:b0:719:79cc:5632 with SMTP id 00721157ae682-719e349632fmr48507607b3.41.1753487622879;
        Fri, 25 Jul 2025 16:53:42 -0700 (PDT)
Received: from smtpclient.apple (99-144-70-174.lightspeed.chrlnc.sbcglobal.net. [99.144.70.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719f23fd843sm2062387b3.88.2025.07.25.16.53.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 16:53:42 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 0/7] RFC: Accelerate xdiff and begin its rustification
Message-Id: <35287949-FD3E-4A5B-BC8E-A2389A077133@gmail.com>
Date: Fri, 25 Jul 2025 19:53:31 -0400
Cc: "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
 Eli Schwartz <eschwartz@gentoo.org>,
 Phillip Wood <phillip.wood123@gmail.com>,
 Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
 Ezekiel Newren <ezekielnewren@gmail.com>,
 Edward Thomson <ethomson@edwardthomson.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Taylor Blau <me@ttaylorr.com>, Christian Brabandt <cb@256bit.org>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: iPhone Mail (21F90)

=EF=BB=BF
> Le 22 juil. 2025 =C3=A0 08:25, Patrick Steinhardt <ps@pks.im> a =C3=A9crit=
 :
>=20
> =EF=BB=BFOn Sat, Jul 19, 2025 at 02:48:39AM +0200, Haelwenn (lanodan) Monn=
ier wrote:
>> [2025-07-18 17:25:01-0400] Eli Schwartz:
>>> On 7/18/25 9:34 AM, Phillip Wood wrote:
>>>> Hi Ezekiel
>>>> Thanks for working on this
>>>> On 17/07/2025 21:32, Ezekiel Newren via GitGitGadget wrote:
>>>>> So...
>>>>> This obviously raises the question of whether we are ready to accept a=

>>>>> hard
>>>>> dependency on Rust. Previous discussions on the mailing list and at Gi=
t
>>>>> Merge 2024 have not answered that question. If not now, will we be
>>>>> willing
>>>>> to accept such a hard dependency later? And what route do we want to
>>>>> take to
>>>>> get there?
>>>> As far as git goes I think introducing a hard dependency on rust is
>>>> fine. It is widely supported, the only issue I'm aware of is the lack o=
f
>>>> support on NonStop and I don't think it is reasonable for such a
>>>> minority platform to hold the rest of the project to ransom. There is a=

>>>> question about the other users of the xdiff code though. libgit2 carrie=
s
>>>> a copy as do other projects like neovim. I've cc'd the libgit2
>>>> maintainer and posted a link to this thread in neovim github [1]
>>> A hard dependency on rust for Gentoo amd64 would potentially require
>>> building https://github.com/thepowersgang/mrustc followed by building 13=

>>> and counting versions of rustc in order to get to the latest version.
>>> What is the minimum supported version in this series, by the way?
>>> bin packages for rust do exist but not everyone wants to use non-distro
>>> provided binaries, sometimes for auditability reasons.
>>> For Gentoo HPPA, Alpha, m68k it will simply mean the removal (or end of
>>> life and staying forever on 2.50, perhaps) of Git. There is no rust
>>> compiler there.
>>> Even s390 support for rust is limited to a precompiled version not
>>> everyone is willing to use.
>> Also in other distro concerns, if it trickles down to libgit2,
>> extra care should be taken to avoid creating circular dependencies
>> due to cargo depending on libgit2 (via git2 crate).
>> For example with making sure it can reasonably be built via meson's
>> Rust support rather than through cargo.
>=20
> I think it's unlikely that this eventually trickles down into libgit2.
> The bundled versions of xdiff have already diverged for a long time, and
> unfortunately libgit2 is mostly in maintenance mode nowadays. So I guess
> that this change here just means that things will diverge even further
> in the future, which is probably okay-ish. After all, the whole xdiff
> library didn't really evolve in a fast pace over the last years.
>=20
> That being said, there is an xdiff fork located at [1] that libgit2
> maintains nowadays. So if the Rust dependency ever became a problem for
> any of the downstream users I think we could simply redirect them to
> that fork and make it the canonical upstream for C-only xdiff.

/cc Christian: if Vim absolutely demands a C-only xdiff, this may be a good p=
lace to get it long-term.

My preference would be for Vim to be able to get the benefits of Rusty xdiff=
 or other speed up/safety benefits without extreme porting efforts (translat=
ing Rust patches back to C?), so perhaps a build mode that allowed me to sup=
ply my own xdiff lib would be ok as a start.

I=E2=80=99d be willing to lend a hand to help Vim support Rusty xdiff direct=
ly, too.

>=20
> Patrick
>=20
> [1]: https://github.com/libgit2/xdiff
