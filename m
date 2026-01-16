Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D0F33B6E1
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 17:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768583397; cv=none; b=ZbX09eLTIDR+tcdr72xdrGXbf0xMhe2BjwEFeubVJb4HtmfovqRkiBrklQxQK5AXkSAfpbpZaI1vv3g2mnWMQ0MHwrqC8rHQMNE9R7lFjGUZO0dD2+VVHZ0d/HMefouB3RYxFWjEZF1koo1eiTfYNnc3Jbb2REJITgdTYO1lbRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768583397; c=relaxed/simple;
	bh=ibPgFwN61bWZ478VwEPLgEwCq6bGxt9qsLDQHQ0SGRg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k/6rV51fLSWJL9B5pKIGJ1lrUp6Ee6NYtkmKeQqXiiQTjNGDvils1aXOxdCodgnXTo5eH6yQo4vGszVVsZdSSZaR99PTfFgGfuflSpVZaRruDxrQmiXm1aPQ0gofWWqed6z6L+CIxkeb4kD1fot2HqGkdHpQz7U239K1zKPdWiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=c1kSW2C/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G3xNEz4+; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="c1kSW2C/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G3xNEz4+"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id A97861D00178;
	Fri, 16 Jan 2026 12:09:55 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 16 Jan 2026 12:09:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1768583395;
	 x=1768669795; bh=o65hNptA3f8VhIJgASesqCuWftO+su55ty3hp2TEQLA=; b=
	c1kSW2C/th8RxCtYyXiXMq1IMaAmgJ1vZyi1yLEzMIDItZtx+DtPcHgDHyVQQLWM
	TssSJ0/fzj/+Kf+k1Db7HZXAQ2K1vSI73dLgzYvjkNDuLl4FSkkpZhoFopGJJB80
	ivsSU3LtfqhznbPyehoBK/NTLVIW6ZVkfZ0NlB/HJY2gusAIpJHpbMiMS8VF84kH
	hHTLDO7RgHetDkrDeQai4d6+fyElfB2CNPf3KhG6ilMW06M9NlT3lJlQ3HRL7ew/
	/aV4AIWqbpDmiOURvE16K7pCKD5eT87Wnu9oNOwed6MHovxUm66/r3+MOENSyAQz
	IFJ5Ysc5VyagpB3dyzr7dA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768583395; x=
	1768669795; bh=o65hNptA3f8VhIJgASesqCuWftO+su55ty3hp2TEQLA=; b=G
	3xNEz4+dJFMbkmcUM4EooQAhocccyZXYNbjOX8+uNF/VDht4vrLOlBrtP4+Ss/nG
	gFn/qWJUEoStBcddtvXpRwzp50zgUUFbP1lRUix5Nvef9oS3m1gP20s7IdD3qIxJ
	z11Sz9TMvGJd4BRUvVgPL6XRrVrDjo12LwT/WcRvM9KG3z6pMwNaL2QFcssxYeJu
	028SJu+yKxDL/f6aiZYSac0DNlpTNvCnTQ0q2mrSH2eCicM6/xEo1CiTEjig2Dbk
	8wd0DeYelmk+IoPZK6a7R7aqdBwgW5I8ItVRqicSIlmEE/RzUKN1Vv5Psk7f4ZJI
	7GTzuZaVonmwe+1x7ltZw==
X-ME-Sender: <xms:43BqafQlu8E-m1zEe4dbku35V-UOhjPMJzvOzoq_xpQYPAE76_I_NQ>
    <xme:43BqaYNYiuejBVidJpjHnBRieU8_LlF8eBpuNsEts2w-xZAMIXKd9LKwwMEozj9Hf
    2WMVb3RgtrTdcasyu7X_f0tJQ5dtrhWDGVrzmy10bknYkevp_3MPw>
X-ME-Received: <xmr:43BqaSNqr0h1jb1wbbbYucPHpKIx6kfQJmTpcxw72BpPWDKNj1z00m4BABexgllAG9HcajOiY-dqcDe2EkUrGYoVGYk6TVVy4Te50Tc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdelhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuve
    elgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepohhskhgr
    rhhrrhholedtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:43BqaYsmGqfs1fyfRT71ykfPTdkwTD3I7mBj0xHm0q4P8Fhtfwp5kw>
    <xmx:43BqacXGSCE8Vnab_uK8lMpILsXI9fxO3oiL4D5k0yKzY5Sj6_KamA>
    <xmx:43BqaQshv6xU6PxwvzetN-BraWWzAWcVUr2BrjKu-J_dEO-158Lj0Q>
    <xmx:43BqaYX9B7OUNRuhU4ZG75tqNFAWmhbDd1saWmjVuzxrxty1BQ3srg>
    <xmx:43BqaYOkh9wawiN6t2mfyDDqr_JMBqwRs3x8y1vOx8WPlq4Y10BtQyCS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jan 2026 12:09:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Oskar =?utf-8?Q?Jask=C3=B3lski?= <oskarrro90@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: README update proposition
In-Reply-To: <CAFp-0Pz_BdZwA4Pn=jUxvYu1prj0F85q+3GWSW-G6LF=cSHn8A@mail.gmail.com>
	("Oskar =?utf-8?Q?Jask=C3=B3lski=22's?= message of "Fri, 16 Jan 2026
 12:22:39 +0100")
References: <CAFp-0Pz_BdZwA4Pn=jUxvYu1prj0F85q+3GWSW-G6LF=cSHn8A@mail.gmail.com>
Date: Fri, 16 Jan 2026 09:09:53 -0800
Message-ID: <xmqq7btha3ha.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Oskar Jaskólski <oskarrro90@gmail.com> writes:

> @@ -16,15 +16,20 @@ standard Git installation.
>  You need to have the following dependencies installed before you begin:
>  
>  - Git
> -- Tcl
> -- Tk
> -- wish
> -- Gitk (needed for browsing history)
> +- wish (Tcl/Tk runtime required to run the Git GUI)
> +- Gitk (optional, needed for browsing history)

Hiding the mention of Tcl/Tk may be a small regression for users
depending on what distribution is on.  On Debian based systems,
"wish" is merely a virtual package and the package to install is
"tk", for example.

Is Gitk truly "optional"?  When running git-gui there are a few menu
items that invoke gitk.  Does the rest of the document inform users
well enough to avoid touching these features?  I'd think that we
would rather want the README talk about giving a fairly complete
installation without such limitation.

The parenthesized explanation on "wish" is a good addition, though,
and we may want to keep it even if we were to drop everything else
in this patch.

> -Most of Git GUI is written in Tcl, so there is no compilation involved. Still,
> -some things do need to be done (mostly some substitutions), so you do need to
> -"build" it.
> +Git GUI is implemented in Tcl/Tk and is executed as a script via the `wish`
> +runtime. If `wish` is available in your PATH, no separate Tcl or Tk installation
> +is required.

If this were in the end-user instruction, being clear and concise
like the updated text is a very good thing, BUT because this is in
the building-and-installing section, I doubt this is a good change.

The build procedure (in git-gui/Makefile), would try to run "tclsh"
which is often found in the Tcl package, when it needs to use po2msg
on a system without msgfmt, which are all part of the install/build
procedure.  Again, if somebody already built git-gui for you, I
agree that all you need to have is "wish" and "gitk", but that is
not the target audience of this section, is it?
