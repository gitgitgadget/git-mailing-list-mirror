Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB1F177991
	for <git@vger.kernel.org>; Wed, 29 May 2024 22:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717022436; cv=none; b=M794QnNk51i2RVyuJxWif0lky4ftaxqW3CAB5XMSeEDZJ95mqtPWJ8N62HDIEJkT8uksh5KFEgGPTp/m0nNGF2qkldcx2jJKveDyN87Hocrdu5cCcYql7Vkvep155WOuEkv9W6tNMBalYptTeRJSarkZhrDPPi/AWDM+TUWxD6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717022436; c=relaxed/simple;
	bh=oi36tbMXnV9BAfxS64gncg0gJ9MNqdACBA8DiCYBcnU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ZgwLxwgoTJ0f4I8c9t6eoQIcAslT/uNha8eKexpQM0CgrE/HZP5PUpBIMgdorlp3rZy4Xt0fkk28CE50cnBQ3mMY3KFmzwTUdjKpkP8VuIoksYpiOpDi+9x6paJKzKCiMmOavE9RXcWnXeLcWL8G3GYTYGU7uvRZGZv3dQo/I3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dragondata.com; spf=pass smtp.mailfrom=dragondata.com; dkim=pass (2048-bit key) header.d=dragondata.com header.i=@dragondata.com header.b=Fwf++KQv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e4ro95yO; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dragondata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dragondata.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dragondata.com header.i=@dragondata.com header.b="Fwf++KQv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e4ro95yO"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 58F061800152;
	Wed, 29 May 2024 18:40:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 29 May 2024 18:40:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dragondata.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1717022432; x=1717108832; bh=DO3zzDIg+1fTz2ntRFntHZX2Fbe21KHZ
	9lrPUHEA2RU=; b=Fwf++KQvk8rMvS8BJpC+19ZVD6EHnocvWyqt15WCynAWZDGI
	/JE0dUA++vMI5sjDGGuDNtmr6L7EfwFjtPtEJm0KvdYtQ6e+e26NJS7BhDlyhL1z
	vpXpgjuFOmekuel5FLCiijagvpFdzwEyGzZ0yZfaNozqcbpuQT+rXrUF6AGXKNo2
	sHhDlSjdgMH17FZ43xMdbFiUi8d9D6HSCYQLoWy/I/a8H9vBEikCWbT/eSaWfbBU
	zMd4rDU/2qfRX4ypgThut641N1KiT0wt+dL8xKjX1be5VlKT7TsoIFCqIosl5Gih
	XV/pdKZZvXMUnfqUPEQAndvaFR3izCXmjJaRgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717022432; x=
	1717108832; bh=DO3zzDIg+1fTz2ntRFntHZX2Fbe21KHZ9lrPUHEA2RU=; b=e
	4ro95yOIjED3qnm6Oz954SCc7x+daVATjLiJVkBt7Af+DgYayrtO2DYYwsMjiiEu
	TFiige7K0vkc2uyxUQ3RXoEwLepvQSC+sgs6EFF/AD2Oc+nj9JkYDkKi50ifzBhu
	/acKe0uFNXpCpMxG4poT4nplr1TUTa1edQ02T/ggWI+IsyqVovu4ciO5XSrRsp8n
	rzqCgofzAZWqlMCO4aJPfl4oQIF6A96+oEK3Ih/7jEA/pvsSQH1XK5BMj7UfW8L8
	MkgBQTNqqtd7c5tr/RaMVRtapHAc0wHc2mrui02zm52Q8xa77eG3y5LccH1jCou4
	vJvaEXW0Libeb5yURiHVQ==
X-ME-Sender: <xms:4K5XZuW0DK4iO0Mqcqhv8uxqsHCeSGJKGxd_f6fl4tHFKy9FsECPRA>
    <xme:4K5XZqnfACe51uWairw_jd3KAMws7zoFdwRmHkb80zzBAxcQtLBBuNp2YEJL2x31I
    PzVxXa-uyaBv_jeq2s>
X-ME-Received: <xmr:4K5XZiZpfRknYaXh1RojCBjMiH1ruWrCcPoj8H_rYY9ruojx5PF2Ehf9KC3ikFclOQiKXT0aF_m3Nm80hFXUPEvowxpRf2-SG0F04ajHNh-G>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekvddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpegtggfuhfgjffevgffkfhfvofesth
    hqmhdthhdtjeenucfhrhhomhepmfgvvhhinhcuffgrhicuoehtohgrshhthiesughrrghg
    ohhnuggrthgrrdgtohhmqeenucggtffrrghtthgvrhhnpeduteegueejfeejudetgfeife
    ehfedtgeejkedugffhheevgfellefgteettdegffenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgrshhthiesughrrghgohhnuggrthgrrd
    gtohhm
X-ME-Proxy: <xmx:4K5XZlVVya5Tc_Wpn_g6hJ99mzKOAZAApwyOvqlC9T7CB2A34-43XA>
    <xmx:4K5XZol3A-sbqBlTkq0lccEUlZnKo92eStxk98N4cl1UfA2b7cKE2Q>
    <xmx:4K5XZqeXEa9Aolw2YY1093tjKnZAKx3jRw_YPJS3akR2ZB4vQNiHXw>
    <xmx:4K5XZqEtT2vHLjJyXaZRrWDPCpK_hr3Lm4kkomP5Hv2rDNBRFNpAqQ>
    <xmx:4K5XZtyMSI0x72hMpFP5rP_RM9hS8JZgTywJXlUmOHN20aVssUxLSFy->
Feedback-ID: i862946f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 May 2024 18:40:32 -0400 (EDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: Commands using -h as an option don't work consistently
From: Kevin Day <toasty@dragondata.com>
In-Reply-To: <xmqqfru0tg1a.fsf@gitster.g>
Date: Wed, 29 May 2024 17:40:31 -0500
Cc: git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0F971F6E-6462-4E0D-880B-8FD67F42A782@dragondata.com>
References: <52819526-4C6F-418C-8B8B-A4D5C7E371EA@dragondata.com>
 <xmqqfru0tg1a.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3774.600.62)



> On May 29, 2024, at 5:22=E2=80=AFPM, Junio C Hamano =
<gitster@pobox.com> wrote:
>=20
> This is very much deliberate design.  I think in these cases we make
> an unambiguous longhand (e.g. "--heads" we see above) available, or
> you can explicitly say the remote, i.e. "git ls-remote -h origin",
> and that has been the officially accepted "solution".

Yeah, and that totally makes sense. This bit me because I was =
programmatically generating git commands that would sometimes call =
ls-remote with no options, sometimes asking only for heads, sometimes =
only for tags.... and was baffled for longer than I want to admit why it =
wasn't working consistently. I thought the usage was being shown because =
I was doing something wrong. My first thought was it was showing me the =
help message because if you ask for heads you must also use some other =
option along with it. It didn't occur to me that -h and --heads would =
behave differently.

> Let's see what improvements you bring to the table.
>=20
>> The options I see:
>>=20
>> 1) Fix -h handling and add ignores and fixes where possible to the
>> failing tests and try to not use -h as an option for anything new.
>=20
> I do not quite understand the former half, but "try not to use -h
> for new things" is a very good idea and it is pretty much what we
> have been doing.

Sorry, let me rephrase that.  1) Apply the fix I was proposing to make =
it so that the command's -h usage has precedence over showing the usage. =
Any tests that break because of that which don't have a plausible fix =
mark as "# TODO known breakage" like several other commands have because =
they aren't generating usage output correctly for one reason or another.


> We can certainly add support for "-?", but the behaviour when "-?"
> is not used (and when "-h" is used) would not have to change from
> the current behaviour, and that would still be serviceable, I
> presume?
>=20

That was proposing making -? unconditionally show usage, if a command =
uses -h give that priority over showing usage even if it's the only =
option, but leaving -h to still show usage everywhere else, and changing =
all the tests to use -? Instead of -h so the tests can unambiguously =
request the usage.

I think that covers every case then. If a command advertises -h it =
always works, it falls back to showing usage if there is no -h, and =
tests can use -? which will always show usage and we can even make =
parse-options reject anyone's attempt to use -? as an option in the =
future so this doesn't come up again in 10 years.

> We actually do not have to *add* support for "-?", as it comes with
> parse-options for free ;-)
>=20
>    $ git ls-remote -\?
>    error: unknown switch '?'
>    usage: git ls-remote ...
> ... the same "ls-remote -h" output given here ...

That *almost* works, except some tests would have to be modified because =
they don't like that error line in there, but that is super clever! It =
would be pretty trivial to make parse-options deliberately spit the =
usage out without an error though in the -? case.



