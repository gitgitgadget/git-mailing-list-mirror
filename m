Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B782F7EE2
	for <git@vger.kernel.org>; Sun,  7 Jun 2026 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780849074; cv=none; b=UhBTGMvWvWaZEquwhfum6HNiiR3MwLfG+0cyK7GITR31zBOEFHFETTs5YT5fqAJIlh1Ya4qiBxWAAJijibB4pkpkC7Xcod7McPdGoZ5tmVCvL3VoEyxu7xrKChlihQma07UbOpxcHTx6AMR9MqxUcRhv5MbNI83e07DuBCpomzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780849074; c=relaxed/simple;
	bh=/eVGQ5BgWXR8Rs4Xkbz1nKMo+3RwDPDrt1VqawqwxNM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HlWvCV1YxdIMfVYGLwMT2ezFuhEFSnInDy2A9mjr4ABsl+Yjplp0EDomtLYrIq/psQEf4871ZKRugCygkIoc7ozVV1rzPTjbDNFsD2ZMB6Oudr7LhwcPt5DVQE2+8iQ0ROwuv2ERnSlMAaDFan5KTekZC0LmJhJpYLbHhqj7Zvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=NwMB5ckM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ov2L1Eyc; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="NwMB5ckM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ov2L1Eyc"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 0DE21EC00C4;
	Sun,  7 Jun 2026 12:17:50 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sun, 07 Jun 2026 12:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780849070;
	 x=1780935470; bh=tXicm7Xpaa1iTulFV2utmtmN82+YeLx0pt/XTJqybaw=; b=
	NwMB5ckMLzLG7pBhBPS4E0/CUObma2giaUYCX/EyxLMDoxmS/e8aCb3aTzi+8ZsN
	nei9XsFO4yUA1zJzLtybud0/5SX7scChtd8C52guKlH9AIuEnhbuMtRNjXZbxGSg
	ENag+62l4J0hEvu9Vns+u+wONJtUk1947wlZibAsGt3wo6EXmpljRcXTc7YGvx1T
	n89uqRsehmxPgKwh8teALUUeQMwyMRn7sqLi69r8GLEvG7XBQIEH2OZ+qILttiQc
	JBPEXVGM7U6Nieo/MFLsDpA5eSa2l+yRole6iU/AQH/jvqL1oMbyLnAR5XS73C1W
	9V22Y2kLG9ASjIX/2Ojhyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780849070; x=
	1780935470; bh=tXicm7Xpaa1iTulFV2utmtmN82+YeLx0pt/XTJqybaw=; b=O
	v2L1Eyc96v/cEesXLZscgkTTUU48zDQlSWCc4Y3GaWY8+DCWT3cq5A9A60g1fX+1
	6NS4cp+g/7Qa3l2Tq8OlEgXWme4883zM17xn0rwA3U1LTNmngjVrxsC6oZ8zdyP4
	Th8ce3yuFQHM+SneuzsE6DTo2daULBEBWxAe7tdcze86nrAgtsT1fP2zTnHKa+VP
	ThuN/3nCx/VwqSkr5IoDhCDciUrr57ztiH6vxvOo4PhWZAzUTC7atBJyW31cQntR
	xUt2g2Sh3/qFimdWt276Hd2DrnG1lZ4CosQaBfVD5GwgE8ibIgmsccgixrWxr2DS
	HX0AiPG5g2uVPosOvJaIg==
X-ME-Sender: <xms:rZklao9fPLwkX-2iUQRllboGyC8WIYdeeJWBlShHu2HTfqCqyDDGJ6A>
    <xme:rZklarj98VhqWyn3G5homU2RcusaMAGOjgtG1O-6OLoswLu9VzG7xe1uzLjc_886E
    Mbsb6dR4xgtM0gxGNQDusOqReIMYV-itkHZ6JTxRKmx0o8U7UWWsQ>
X-ME-Proxy-Cause: dmFkZTEJcgLEwIhgTFjib+0YI54131O0I9VbvoY5mFbiHbz0KkbRGbwBVqkO0yY1SPlm/c
    MPChxnguVvy3jsDBuv8U92tpCC1Jkf6QpjylkmP895jcCCzulxrjcn+bUVoL6FMdw+1cOV
    h/xxJj0otC7bDktUoV7BR5hPQn7ZprhpjH0WKnMzbbaeTo3eWhPQjhWz0+NjnaqgYEvGbF
    vJyXrYN9ZX6R+YAxh4fSqFt/7/sOAeXUcjF+vunDqAqvEGeATSVcIJRT61NiI3Zdg3omkJ
    qdu9O2LLh2tnRppM1TfkfQLhYDrFEuQjRRSuIKY9zXlkk8/noJ5LOgq5+ZTTE1pWZb65Ni
    nTGQuKuXjiHFodh+RKTFddTiU8XMMLrncfGJeZpEj8EYlaNbGQdWm6dT+uayADzKDuCC/N
    9OVcaHoOtPVrdU7VxpjraM/p3AcSG9W93hw91BYja0g1ezDbL/C6U+gp3AHk7sjRz8tWPo
    TEJv5shEmmCONkDnHqZ5uB2kxunngvasxcc7yF0bFKA9rV0Wl53TvZO+nat8hIeDd2aFXO
    hlGq3Mq3lLuXaYd/k4niFt/FFNp2lneZenDfN5/BnC9KfPUMLZ36+GxU0/Z2yaUDerBAzr
    mMd1WoV7bdyoZ6wG4OZN247hNbu7WcqyGR6WDiEnXc9VMN286amSDYj5zd8Q
X-ME-Proxy: <xmx:rZklangjF7OJGFijrropsVskXqugFMPxwqZDFOy4qhY-aKM2-meETg>
    <xmx:rZklalgU-VKkE_h0It_aKSm_yo8nGjs5-95sEB1xo9ySo69oXpxG3Q>
    <xmx:rZklanJ2imJg1vl_bng5WXCdmw_AxT-Vex8NN9zP4dQKzi6dj-fllw>
    <xmx:rZklakE0c2x_NFgCtDedrlDaY1V12hr6htO8qw3f-itMTycWbG5vnw>
    <xmx:rpklas--Xd8q5bmh9JdLejem4Sgy69ThTNhJrlxa_lT6tUwEuSDQSfnV>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D579030201A3; Sun,  7 Jun 2026 12:17:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ABzAPUHUW1Mc
Date: Sun, 07 Jun 2026 18:17:29 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Tamir Duberstein" <tamird@gmail.com>
Cc: git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Patrick Steinhardt" <ps@pks.im>, "Junio C Hamano" <gitster@pobox.com>
Message-Id: <e42fac49-5037-4eac-b4c8-58bc62857ee2@app.fastmail.com>
In-Reply-To: 
 <CAJ-ks9nXybntsa5FCJVWSQ2u+hzxaMdrfCdL3D+vmzjO4e21kQ@mail.gmail.com>
References: <20260607-ls-files-pathspec-lstat-v1-1-8cf40b730146@gmail.com>
 <8f3bab63-3b37-4492-a39e-95e610a15a07@app.fastmail.com>
 <CAJ-ks9nXybntsa5FCJVWSQ2u+hzxaMdrfCdL3D+vmzjO4e21kQ@mail.gmail.com>
Subject: Re: [PATCH] ls-files: filter pathspec before lstat
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 7, 2026, at 18:07, Tamir Duberstein wrote:
> On Sun, Jun 7, 2026 at 12:02=E2=80=AFPM Kristoffer Haugsbakk
> <kristofferhaugsbakk@fastmail.com> wrote:
>>[snip]
>>
>> I have done the same thing in our company repo, crediting <LLM> for
>> authoring or co-authoring or helping with a specific thing. Using a
>> =E2=80=9Cpeople=E2=80=9D trailer. But the intent was just to show how=
 some LLM was
>> involved. So I think I am going to switch to the following trailer for
>> our company repo.
>>
>>     LLM: Yes
>
> This all sounds reasonable to me. The kernel has started asking for
> this trailer
> (https://github.com/torvalds/linux/commit/78d979db6cef557c171d6059cbce=
06c3db89c7ee)
> and I saw precedent in Git as recently as last month
> (https://github.com/git/git/commit/7a094d68a27e321a99c8ab6b700909e5039=
04bd9)
> so I erred on the side of caution.
>
> I am also OK with this trailer being dropped or replaced on apply.

The most important thing to be aware of is =E2=80=9CUse of Artificial
Intelligence (AI)=E2=80=9D in `Documentation/SubmittingPatches`. :)

Thanks
