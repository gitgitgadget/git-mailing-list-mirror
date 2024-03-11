Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40945732B
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 19:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710184649; cv=none; b=GU9Q1BaI2wlBjp4NJawRU6BiF7jPJCdqkBtcoxCmWF8xDLumPlgVR+FCO3n15Vln/S0/mcHGnpz6s6R1j5Qh0MWXUmN3S6dXiK5ZQ3RjslKbOqfm7HNuHPM3hI/lhXeD6GVisdd7sjqcLWkPVz+cWpf0sjbS/wMEHlba7Q6jyDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710184649; c=relaxed/simple;
	bh=O/XlhN1T7uo9ADyrkIUy1H498ZEIFrg4zfhmMWPO9V0=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=T/rlaMOBG1KZz1uPJFzkDXeiZioPRUqgRTeRx6tl1v3qatoDkqwzmibj3jyt9WjYbIZkq2GBT9vEp1dy/ohPuM0/Ewknyyo3Re+u3XlUUTNAG11c+2uN4yMTV9kKuSjS/tADLZos9ZqTg2YQ/+IOnPA6DLKrU6aqUNCIwgSIC98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 42BJHAVr1238332
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 19:17:11 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Ralph Seichter'" <github@seichter.de>,
        "'Dragan Simic'" <dsimic@manjaro.org>
Cc: "'Junio C Hamano'" <gitster@pobox.com>,
        "'Ralph Seichter via GitGitGadget'" <gitgitgadget@gmail.com>,
        <git@vger.kernel.org>
References: <pull.1681.git.1709532018372.gitgitgadget@gmail.com> <pull.1681.v2.git.1709824540636.gitgitgadget@gmail.com> <xmqqy1apudvv.fsf@gitster.g> <5eff951e815e2fdab3834c4aa4160ed8@manjaro.org> <ba6d65ca-8ae2-4d93-a5a5-e0b60768c302@seichter.de> <265e5b2d352c34dfe0625904b3356000@manjaro.org> <277b3187-f793-4782-aa18-50bc15febe9a@seichter.de>
In-Reply-To: <277b3187-f793-4782-aa18-50bc15febe9a@seichter.de>
Subject: RE: [PATCH v2] config: add --comment option to add a comment
Date: Mon, 11 Mar 2024 15:17:05 -0400
Organization: Nexbridge Inc.
Message-ID: <0b9a01da73e8$b7cd8f80$2768ae80$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQFlUIbffV0Kx6ugRLQuqCoXSigUjAIBeUnZAda4N5oBcGPiHAGhABIFAYNf9/gBy8wZUrHLaSXw

On Monday, March 11, 2024 2:57 PM, Ralph Seichter wrote:
>Subject: Re: [PATCH v2] config: add --comment option to add a comment
>
>* Dragan Simic:
>
> > I mean, perhaps the whole thing with the tab characters may not be  =
> the right example, but I just wanted to point out that the
>more  > major an open-source project is, the more discussion is often  =
> required.
>
>Oh, I have no qualms discussing things, but over the last 40+ years, =
nothing good has ever come from debating the pros and cons of
>tabs and spaces. At least that's my personal experience.

My take would be that all whitespace is ignored, but if you want a tab =
or other character in a value, be explicit about it:

	variable =3D "value\ts" # comment

where all whitespace and comments are dropped from the parse to be =
functionally equivalent to

variable=3Dvalue(TAB)s

when processing. Implicit quoting arbitrary whitespace can be =
interpreted in an ambiguous way. That's basically what the C parser =
does.

--Randall


