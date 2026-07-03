Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5533101A0
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 12:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783080178; cv=none; b=fc2tIcAtrwsu8FhUBPlh8sXPdBaGXcdAgew8JtogswvlOtYrs41LyXOIaTy5Ul2qEpC5VLvhmbirdDzBI6MVIzhV2mo+8n5VoL2buh4HDUA+M/fxfrn38YIKoJ/Or6NuTc7MAJ/8LPXou5p9pGZPLZ9cO5p8EYHp4inxa6sEcP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783080178; c=relaxed/simple;
	bh=/4SnDKk1zwevd506OjTNSt6wlo9vaDpaJSzHBT1wQqo=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=kcbRk6wX4JLFFP4sz42xSQ4kJGABfgQhz9eQ3yWFVoP40Xehl0Ell+TQT7ttCBW9JJ6vqGWdyaBbY923Q7eTDUapKvU+ARlyU3QehnRdDgfdRW/LAMU38JGQf32JjhZ2DmeIjiTbhhkB5x+tpcvfJO72i4On0ytiM1X6G+K72GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHVWmatu; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHVWmatu"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-664ee752958so698502d50.1
        for <git@vger.kernel.org>; Fri, 03 Jul 2026 05:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783080176; x=1783684976; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+E9RNF7Pc9QfTU8d0OnHHye407DLYwVhtXEmIwfPFiQ=;
        b=LHVWmatuukNV+oNeMRi9J5nCMEDC5sOERFwSlJFD0UnW3z6jhnjz+IO3Xsz9xBdgax
         z4MIi9wDaeWwiVe/TcpXElVVE25yN9G6Soy/jZBY4Xn/z51jvYZ2R5/69L5dUq30qlO8
         GrSdos0spavgjxRqzmdQxRWO013qy7CSgYKtaeZ+DD2ILbt/en0jreWP3JF//kSIhhhF
         4MiLS1cPRBHDkUCdAl8e/TttV0va56TjI286OGBfH2ydMuc+eX6+Sh/U+K6jl64FivJM
         AknsdUB34OXxZELDJdNAIVCDYDrprI6PKx4FMZektDSLll9JeLmbQms/WgHIRGBQxACu
         /nkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783080176; x=1783684976;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+E9RNF7Pc9QfTU8d0OnHHye407DLYwVhtXEmIwfPFiQ=;
        b=VPWQ27u8B7BHjLTo36inXbzMTx7iG/VaMGLOkvNJuBMj8xu5wEgsAyWta4kGHj2eAk
         z0wDQn/x1mnC79LZu9gUsb9xlW3MZ3VUxi0TCCtelD8BEZyHpu4iUqjUhLyzE3suke+D
         l8PS4oGCKzD1AnK70C/fQnCTF4AC5v60yDBgfNGmjBGwpeWT1qppJXZ8PSeycIxchxqr
         7JQitCohAFp7F/4aFBuCIeG+YVQkdCjcGtxNDDqawRD+9KVBSdJiT64mMowKYMuTYI/i
         a1xZ6B4/zj84l9CqGMLVTKYOqI5qHGKf+Gsldjf+fse9vMfnxn2DnOsYss5OqEv3uDvD
         iirA==
X-Forwarded-Encrypted: i=1; AHgh+Rr+WcLA6G3e7lvBeDph8dxYrwCr3ywK3nHO/rei4iNUCOcfB1MVsgByGeBCY8+NGsOLGcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmBT6b66y4lYP3MokTjo71Vwos3PfHcCsBJ36tamzVerNqsS1S
	7MK4FflxIedFJDx8tT/zNIuJcR2kcO/SJMZ3s0UEe6E5+cZUwdL8Vkfkvpfh0J/L
X-Gm-Gg: AfdE7clLIAjbt8exp/21xwFwEzEYxHEDHIJ7auM9zfXUxTlPAjndatkvZ99zDAY7RnJ
	HGCQ1iwpNWs7DUa+0QK/rcfY8YqAw/RFeV0hEjrQZvOEvuUbrTUPz0Xji6urIBD8jTHC6sgM1JW
	cgctUJA5SffUUzMYZslB4O6yXI0E8ceBCtU8RG+3XfEuqLmRHxwrPvdxqZcSUN6SGvHuufM+tRP
	HEOjW4dxRIpfgiUbldO1LJ6SIahIYQjnsOxOidaAYaRYdcdiAGEtXnGh2Lr834BTBejumoRM06x
	JJdUAiuUrPa6CaPIz3HwfAd2Cky6BsKNDQnQmUx99Q7uR6DXU5VUk3akCEUbXWg1/skf9eXP4gK
	WUlM+UlvTOSypN8MVnblpncmbs2xIKoj8M/kTA0LkQrYotmuihB1kob3Yl/HuF87xpzVH0J7DvZ
	vZTW1eXfxKGna0MC5gbv9aoSZrJnSIlCohSHgcxX35yos69kaM1CkKi3GfA0CasG9WFZXqHUIt2
	aXrjMvRVx5VgSnMbWuwhhXDnsVGzNNvv8b8LeO+Pczo5C6Swym5zDvhaqquvQ4Z2UUUtaQ1Wcmu
	bA==
X-Received: by 2002:a05:690e:d59:b0:664:b1c2:88f with SMTP id 956f58d0204a3-665219659bdmr9138655d50.1.1783080176120;
        Fri, 03 Jul 2026 05:02:56 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90fb:c300:8d7d:a0ea:80ba:35bc])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6664053777esm708498d50.8.2026.07.03.05.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 05:02:55 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: lipo availability [was: [PATCH v2] Makefile: link osxkeychain & support universal Rust]
Date: Fri, 3 Jul 2026 08:02:44 -0400
Message-Id: <539E5E6E-ADEB-415B-B126-18FC0BDABC99@gmail.com>
References: <akZQmDYe9MtTdGM2@pks.im>
Cc: Shardul Natu via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Shnatu <snatu@google.com>, Koji Nakamaru <koji.nakamaru@gree.net>
In-Reply-To: <akZQmDYe9MtTdGM2@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: iPhone Mail (23D8133)


> Le 2 juil. 2026 =C3=A0 07:57, Patrick Steinhardt <ps@pks.im> a =C3=A9crit :=

>=20
> =EF=BB=BFOn Wed, Jul 01, 2026 at 10:01:43PM +0000, Shardul Natu via GitGit=
Gadget wrote:
>> From: Shnatu <snatu@google.com>
>>=20
>> Also, introduce native support for macOS Universal Binaries
>> (multi-architecture builds) in the Git build system by allowing
>> the user to specify a list of target triples in the RUST_TARGETS
>> environment variable.
>=20
>>  3. On macOS, if multiple targets are specified, we use lipo to
>>     combine them into a single Universal static library at
>>     target/release/libgitcore.a.
>>=20
>=20
>> diff --git a/Makefile b/Makefile
>> index 1f3f099f5c..8d49ecc897 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -3019,11 +3030,33 @@ scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS)
>> $(LIB_FILE): $(LIB_OBJS)
>>    $(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
>>=20
>> +ifndef NO_RUST
>> +ifeq ($(RUST_TARGETS),)
>> $(RUST_LIB): Cargo.toml $(RUST_SOURCES) $(LIB_FILE)
>>    $(QUIET_CARGO)cargo build $(CARGO_ARGS)
>> +else
>> +ifneq ($(words $(RUST_TARGETS)),1)
>> +ifneq ($(uname_S),Darwin)
>> +$(error Building universal Rust libraries requires macOS (lipo is not av=
ailable on $(uname_S)))
>> +endif
>> +endif
>> +
>> +RUST_MEMBER_LIBS =3D $(foreach target,$(RUST_TARGETS),target/$(target)/$=
(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME))
>> +$(RUST_MEMBER_LIBS): target/%/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME): Car=
go.toml $(RUST_SOURCES) $(LIB_FILE)
>>=20
>> +    $(QUIET_CARGO)cargo build $(CARGO_ARGS) --target $*
>> +
>> +$(RUST_LIB): $(RUST_MEMBER_LIBS)
>> +    $(QUIET_GEN)\
>> +    if [ $(words $(RUST_TARGETS)) -gt 1 ]; then \
>> +        lipo -create $^ -output $@; \
>=20
> Can we assume lipo to be generally available on macOS?

=46rom my digging, universal binaries to support the PowerPC transition to I=
ntel have been available since Xcode 2.1 from 2005 (whose release notes, if t=
hey ever existed, have been impossible for me to find). Of course for modern=
 (Universal Binary 2) formats, you will need newer Xcode: the format was ann=
ounced in 2020, so I suspect Xcode 12 is a minimum but not necessarily suffi=
cient version. I have not been able to find a release note specific to UB2, t=
hough in 12.2 there is mention of both universal binaries and the arm archit=
ecture. Apple=E2=80=99s announcement [1] supports the argument for v12.

[1]: https://www.apple.com/au/newsroom/2020/06/apple-announces-mac-transitio=
n-to-apple-silicon/=
