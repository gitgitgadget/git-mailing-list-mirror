Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEEB43B6C9
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 14:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786544832; cv=none; b=PLX1t5wA4SSfcvRo2QDzC+KmDDTokhkxywMiudp/6dFM9LDrpzmHvxvJ6lJkAGoif355AW9oDxGW5sSwLgVFzwNdRmMrQbLx7R1s4ITeqcm9lluKiRw6ONnMqANqJseTVTXr/sdhzjGO8Tptc9fT1uMdlK2LCesc3Ok8s3zX6lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786544832; c=relaxed/simple;
	bh=+Xh3rvf+lDL1cO+iunGXzI0OMm8X7e3WD8I0V9qCBSg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iit8CEXsSqUCvZ8Da9ia9ZUZDldeWiuXWt5w7/ONv802Sh8wUpzoJ/5Owkf6co1uBlyCys/h6GIZuBhoN7y1HoODVOiaLCk1+KlCjIQOt4PH50wUUUeQR5e4V3h6zbf847O4i5GGZPeKnOEPn7uHAzmkqK3mKoV83Gm7T8oF3Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=koXuRVQI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kepi21qW; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="koXuRVQI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kepi21qW"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 8D874EC0238;
	Wed, 12 Aug 2026 10:27:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Wed, 12 Aug 2026 10:27:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786544829; x=1786631229; bh=dGUTNIh2EZ
	Bbago1mJG4Ty9VEizeXiFPppMlQKUulqU=; b=koXuRVQIOWKSYH4n+u2DcnaZe/
	DQ9vHZxHYQ6pVuABoZmdOMG0udoR1Szo3qfI75mnK8pf2lSUk8Il/uabiMgnPxkD
	xBJuNyFJQQOwwhJ1j2a7xUsxzA6mbfi2cnmm4NGviEOhj3l+rVBkKSWxDQ5009I1
	Bdo7cRABh68T88DYEuc6rAT98iFqZeTnp5EL0liybTCsQRqSzly2/GDSxqW9ZN05
	NQWbbE8PkSBRqEym7+Ozn3QyaBeTQDG+HhC8VkU/I4gXAA+XesrAszuQitjLLlR8
	oFkccxyD6ku248NaYQfqF2TmUp3R8puyQb2Xu8TCOW+8o1douvtD+hYP+msw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786544829; x=1786631229; bh=dGUTNIh2EZBbago1mJG4Ty9VEizeXiFPppM
	lQKUulqU=; b=Kepi21qWHER3v2wLK5ssmuo0dj16Nlab/M1oTzg3tzL68DBuF0f
	I0Rux51+HT8Mzz//0bHVhakBFgSfA9ehMbkF1dyA1FiNQjpCPG1kM55PesKS3UAB
	X0M93PVdWa0Nfrq4KXYQ51hKbHT5qMS5xO/J5ENCvVBELVWMJFDrYWMlYDshG8WV
	LPBIHaD/vrDxy3uVWwoCmXNY9BxEZdw8BfS+pckZfZRImiBm8ukLazDlhjNq4KPM
	XVulXQohasJ8S9mvftMGtYReqmQe1wLwT5sAVWHxOmSPI9hDPsJk1+fNxGy9Nl6r
	FcpAdafBUvK4SlNPfcIS+FsccDPpYRgIu4g==
X-ME-Sender: <xms:vYJ8aiNx6lip0Cf7Wi1hmecsI8o4_f2rKJFD0khABfOX0BKeJ6_YXg>
    <xme:vYJ8an9e6oaNcBNenxfOC4B7wZTV5e0IB5yIUT3Sx95VK-JrehiGzeBF2I9yMw8aY
    x47iXuPQAWIVzIfWo1JCbjPaNu_lEzG3VekGpixZyzgWhpYyx2T>
X-ME-Received: <xmr:vYJ8auRjrq_w6wLXl3OFlTdbNKc_uchgIj5mKphSwSJ-DQyMxa-2NnSjAIASIzmZD5rDCeZkr94FCLjhWKqGcDnSbIJhxoY_rg>
X-ME-Proxy-Cause: dmFkZTEpLWOc0eeddQowTMuB/lrHNv8ouGTF43rpcxugPEA0utjQ3ZrG8bt9KkO2ZcLMsp
    3gOD+ebZBtWPjXo/tWEUUeuLnztDWjAr0Mb6cL4Tqcidx5njMha+ScPJmqRi3vyDSdGIlK
    Uj7JuwaFrGL3Xd4XcMKORnQwX3LUs/OF98ljdtiWhyyMHfpl3z1V0NLRTz35rYukLh/WFw
    9Saw2fEjgUeoCvPE3Vx7khPM8DdfCqLsDQOoL/gH+HPm+NaegWKKxBGeuYDD9l+fheydpV
    moTcSFn7nMrrEk8FHIqYba5/2A/8ZTN27vd0GCvmBfX8YPRqYHx8utIqJpWptKfw7yyMVy
    piSdbu3b5K85mwrEY0XBfQb7k0CuFcgSAh/gham6H8/THwwLnjJHMuXCOGjNc75jBqjuvD
    tjoTL2dapO9cqx5tlR7vjQ3hmyXCgZkRDJNtW8bxljKJ3zTVWY1A9Ru0dTPNEgXPJ+gooZ
    e257Yz0azQAfDmkOn9iSvu1DPQU74b2uCYnFqjJX2jhE5MygMj280bAX6qKOLwcvL5mT/w
    hr1hKjFd4Ah5agSVi3ewORR9lQt9yzi6nk1aG/Ryd/LCQ6T6WS/ELF5ECkNEJJIP0eWWqN
    kQamTEg2xWA/5Ie75oMDjZASk7YODQksHjSTnHT58T4Rcq/FXHTVeNRU4QGA
X-ME-Proxy: <xmx:vYJ8ahluTyJuPNCUAPghTOTqtc9bJLIBbEbURKXVR313sfr3kQU3dQ>
    <xmx:vYJ8amSMCdMqOP-MU7N0nmDMvusDgO3piNhYbwuOLCQUzWG_rmJzWA>
    <xmx:vYJ8anPs-OHDMyTmc_3HojQDJm_gn5fPAKdCy9DBJ89uNf7xX36vig>
    <xmx:vYJ8anUSWxd6Vii_nVaIgfkzy_Kg8iTOmFi6YAzowCP20lhTWfRz2Q>
    <xmx:vYJ8arpoZie9xm1nRAIPt50HFwKDkpL0mm7f0MOHMFnrUpW-kb8XBha8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 10:27:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 12/12] mingw: allow `git.exe` to be used instead of the
 "Git wrapper"
In-Reply-To: <bacfe6f4-706e-670c-3466-ccb4d7caeffb@gmx.de> (Johannes
	Schindelin's message of "Wed, 12 Aug 2026 09:51:21 +0200 (CEST)")
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
	<f822133191c9cca40477fb1bdd5d1416c9fe66c1.1785939999.git.gitgitgadget@gmail.com>
	<xmqq33wrkvmu.fsf@gitster.g>
	<bacfe6f4-706e-670c-3466-ccb4d7caeffb@gmx.de>
Date: Wed, 12 Aug 2026 07:27:07 -0700
Message-ID: <xmqqcxvnza6c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Checking tmp[0] is a sign that we do not consider MSYSTEM set to an
>> empty string a sane state and ENSURE_MSYSTEM_IS_SET is about
>> correcting it, right?
>
> "sane state" is quite the strong wording for such a minor issue.

Well I didn't know how important that variable is, and didn't expect
or wish to offend you by use of that word.  Perhaps "sane"->"usual"
would have been better?  Sorry about uninformed choice of phrasing.

>> Can $(MSYSTEM) be an empty string or undefined at the build time,
>> making ENSURE_MSYSTEM_IS_SET set to "" (two double-quotes)?
>
> Sure it can. Just like `PATH` or `HOME` can be empty, or invalid. But the
> person building the project has to go out of their way to make it so,
> therefore I don't want to spend any more brain cells on that highly
> unlikely scenario.

Again, I didn't know how unlikely it was, so I judged it based on
the existing practice (quoted) below.

> Ciao,
> Johannes
>
>> Which would mean we are exporting MSYSTEM defined to be an empty string
>> as well with this setenv.
>> 
>> It seems ifeq($(uname_S),MINGW) side protects against this situation
>> by placing the cflags definition
>> 	
>> +		COMPAT_CFLAGS += -DDETECT_MSYS_TTY \
>> +			-DENSURE_MSYSTEM_IS_SET="\"$(MSYSTEM)\"" \
>> 
>> inside "ifneq (,$(MSYSTEM))..endif".  That way, ENSURE_MSYSTEM_IS_SET
>> is not defined to "" (two double-quotes), so #ifdef ENSURE_MSYSTEM_IS_SET
>> would not kick in.
>> 
>> 
