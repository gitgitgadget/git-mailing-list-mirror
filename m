Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933BD4D8DA
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 01:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731288873; cv=none; b=iCrrTfa4TnfDAKWtYO+7BhFG3wHVEZ/xfKWaiRZAD3odd7UeLw2T3XMT+fm3+V/+vuEUZAnW93ga6uwyasijk9PRvhDfUVEyTS9VRfyxMIg4hCqAkBLI1Y4TV/4wJMnd74VLWEigEV2v17aEw7Sm48D5Gw+gndQ9WG4vppEnfTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731288873; c=relaxed/simple;
	bh=n/QbKzugM7GZnu9/8u9PoMwkuxAlMBeOeEPKrxsg54s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tKCT+uK6XkSM5i4hgQP8Bfz8gv7IbZ4cZIXPLx4tcJSloJM1F8POyH0AkQnmvMYBjbk/Kq6NuocFfOh41KNN/QdcNbKF4r45VKXQ+WeeBLRB3oAcBgywxyPjTP5NsYe6lrO/HJ6Jf3/lcW98L8eapGUE5Yg03aQ9WdNayWHloKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WxmS5HGA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FaGj9Ro2; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WxmS5HGA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FaGj9Ro2"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 71E32114017B;
	Sun, 10 Nov 2024 20:34:29 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Sun, 10 Nov 2024 20:34:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1731288869; x=1731375269; bh=OBNcvwrXQ3
	h4iKZXDQaQr2fB9agN7KDJRviXH91G31w=; b=WxmS5HGAhZrDXcJsNrPWhFNrgw
	/+UCkmmWYUyUqGMDzs4elwjXNEVnWNcNuyY6yCHUYVvjOCXxIPrrJb0B3rfx8Yrp
	uR0K44I0xiKfTFFSpleH6XAm4HNUabKZvq5xmjLbFix0CFB7sINPpp94tEYPBChK
	kDSBKvj0x9Aw4T4LuH3HKylY9qf6lcQfAq2nhrnzdN8h0k0CsXXlt73lwUlTOg4c
	QomuojZ+RjSRcntgIyAUJysy4owJyRlHU2Hp4sGpHCOjoSGRVmoRj5FtQA9ARvup
	leiihyzKYYd9+lb9zhmjwHf3qk7lsw5nMSg9RyIDo2U9aTVF23EsrbHRaxMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731288869; x=1731375269; bh=OBNcvwrXQ3h4iKZXDQaQr2fB9agN7KDJRvi
	XH91G31w=; b=FaGj9Ro26ihctbImao7axz3/vqkVUQqwIqRBh9iCBNX5cyLiJZj
	2x76koiDhxpB0LG2ozGKi/KgBTlv/dDhnilmnqm2bxkbYJpcytioCbU6Ly4j0lHU
	0+dGyoAsujfTei/pBvhDScuIQtduQ0/hDop45XI4E3tWPHOwghbZlf2PZSI9xqlH
	bNs9LJ+fwnn7rbr0ENUpYkJL9ntmSET8BhmEGo2hFw3ay6LsUK8J58EjOo/0xF94
	Uzh1giaiZkfoR5mb49sH11Ov51Qu3NtUflinGHx8WidDzAl+a/ZCMK00H0sSUWr3
	cbDmgTW9mSkstULgeoA+3bCRGFEqPI74eAw==
X-ME-Sender: <xms:JV8xZ_JUUNMnwtrCWKugwctBs4DAJoLOhGmGDzErY6o5ZuZL60JFqg>
    <xme:JV8xZzKzk5ij7ADuCWNLbFFOe5Rsn8GdTyc_WasA3ai_YgC0tmtLzPMYj6P7bQJgO
    nr4k1Ob666f1D054g>
X-ME-Received: <xmr:JV8xZ3uQWi9w1jGHYXu5EmP2R1I_g4qrz6qY5wiRvqeD_PoUiMGT1VhPefZKP34zsTpJ7k2-GA3dHAXc-0FS7_x-lxkojwqMRAKM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddugdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifoh
    hougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohh
    grnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:JV8xZ4ZypacMOwdYok9kL9PYeKqSdT-vjVFmFQirmnPrQJcdM2k81w>
    <xmx:JV8xZ2brIQp6naqn0xCqdv9dpMYXNEX8J_ZLPtMrb6W_nxgKBsUTfw>
    <xmx:JV8xZ8B63cAVFuu7b4SVq-whcRFSz4f5_W1xqtqbxHTQgtYPgqYdsg>
    <xmx:JV8xZ0ZVMzb43b7ITDQ_8-azzDFvQoxdPbOqTAU2FUXjW1uWLeD3dQ>
    <xmx:JV8xZ9w8n9roVM8BmFQcq8Y-c9Vp4vD8AfFX4irsEASAhg7AcPDDJw28>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 Nov 2024 20:34:28 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/3] Build improvements for clar
In-Reply-To: <890b423c-9756-4e1b-a6d0-3990f1091f5b@gmail.com> (Phillip Wood's
	message of "Sun, 10 Nov 2024 14:30:59 +0000")
References: <20241108-pks-clar-build-improvements-v1-0-25c1fe65ce37@pks.im>
	<890b423c-9756-4e1b-a6d0-3990f1091f5b@gmail.com>
Date: Mon, 11 Nov 2024 10:34:27 +0900
Message-ID: <xmqqiksuk0yk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> I've been using the CMake build in Visual Studio the last couple of days
> as my hard drive with linux on it died. I ended up with a slightly
> different fix using "sh -c" rather than putting the awk script inside
> a shell script. See the diff below. I don't have a strong preference
> either way but it would be nice to fix the line wrapping and add
> VERBATIM so that paths containing special characters are quoted correctly

Thanks for comments.

I've committed the same sin number of times, but a scriptlet written
in a third language as a string literal in a shell script is
somewhat awkward to maintain, so I may have slight preference for
your variant.  Either way, we are now letting the shell, and not
CMake, to spawn "awk", so if that was the reason why the file needs
to be changed (i.e. CMake perhaps failed to or found a wrong awk),
either of your two approaches would solve that by delegating the
task to the shell.




>
> Best Wishes
>
> Phillip
>
> ---- >8 ----
>
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> index f0a1a75382a..b8a37b3870d 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -989,11 +989,21 @@ parse_makefile_for_scripts(clar_test_SUITES "CLAR_TEST_SUITES" "")
>  list(TRANSFORM clar_test_SUITES PREPEND "${CMAKE_SOURCE_DIR}/t/unit-tests/")
>  list(TRANSFORM clar_test_SUITES APPEND ".c")
>  add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h"
> -        COMMAND ${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-decls.sh "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h" ${clar_test_SUITES}
> -        DEPENDS ${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-decls.sh ${clar_test_SUITES})
> +        COMMAND ${SH_EXE}
> +                "${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-decls.sh"
> +                "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h"
> +                ${clar_test_SUITES}
> +        DEPENDS "${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-decls.sh"
> +                ${clar_test_SUITES}
> +        VERBATIM)
>  add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite"
> -        COMMAND awk -f "${CMAKE_SOURCE_DIR}/t/unit-tests/clar-generate.awk" "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h" > "${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite"
> -        DEPENDS "${CMAKE_SOURCE_DIR}/t/unit-tests/clar-generate.awk" "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h")
> +        COMMAND ${SH_EXE} "-c" [[awk -f "$1" "$2" >"$3"]] awk
> +                "${CMAKE_SOURCE_DIR}/t/unit-tests/clar-generate.awk"
> +                "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h"
> +                "${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite"
> +        DEPENDS "${CMAKE_SOURCE_DIR}/t/unit-tests/clar-generate.awk"
> +                "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h"
> +        VERBATIM)
>    add_library(unit-tests-lib ${clar_test_SUITES}
>          "${CMAKE_SOURCE_DIR}/t/unit-tests/clar/clar.c"
