Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C4B202F97
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 21:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736372552; cv=none; b=lugydIfUz93GCLpSl0UXy09dne4su1Cb1/xpIeJ7owjQQVE+PofRXv2kTfrF2sIAqVkeQClTFfx44lv9kBGc1rJ0+SqHSTnyCalsHAJ710NNB+vf/cAGrN2fa4rAUHinsBgHwuURfl0BSCdTZ2nTjV+70ejy1kkI3YlClBOzKaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736372552; c=relaxed/simple;
	bh=8KBgZ0gG6bM/9MvypaxzXhGAzGWS++bKAol6F8iEEzI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=rqUy/V9CuiKaLYtjyWdk3NWkEPdfQPtKEhFlCH9gGYcYCgYKjZuKZfscKnYB+OqFqnpWx6zeKgur5LycEqFog82IbW0wN106Zf7eV9Aw/AzYAapdRN1oOgg7S/2f02oIxlMSt2NnH0E3gsjAwgI/1Uz+0tRPoBYMdm4ZXX/sC8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=TASgLDWO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cZ43flVy; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="TASgLDWO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cZ43flVy"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 570132540168;
	Wed,  8 Jan 2025 16:42:29 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Wed, 08 Jan 2025 16:42:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736372549;
	 x=1736458949; bh=UKUHLTllcVMckRLmOPcA9IqiID/+P1GX6x1va/uTkWw=; b=
	TASgLDWOyq9ShUIh9XhnAUWfrsFJweFExAl55rGdT7ue+WfoFm7u7RQa5S+Unt3x
	OmdiQVU/5sQ1pkkB+JgF7obWn58Y69MELkRTV2e+/CqPMU38SxtaJcw2pxETS6yU
	MducfCgwm3ID9/jm4ruNCMNtiZ9g5J/In1cwmdodATPcn+SBA3Zs8NHDu6738sdL
	E3gLoopfDyx802Wyyn925fx0zoHF0IhZ5olxqDgs0P2bj+8v+KThJ0aELnihc1bS
	+QAhNwyWE44+vw5ytU8FqDd4vI+XMBNhSfWnppyegHPhxZjjOTIaMTJUOq2ffHl0
	oX+YO0IRJGsqxdOKKXMA8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736372549; x=
	1736458949; bh=UKUHLTllcVMckRLmOPcA9IqiID/+P1GX6x1va/uTkWw=; b=c
	Z43flVyZgxHc3We+QRH9YjLdSdx8CR3VHqrq+3bVfQZdDY4fMQVctNaJJuCmv8dy
	M2Hbv6JPrx61siHcIW++KB4rjyGmXjuvyeZFBNOEhmUUULnSV7MjZifF2fbTNgPQ
	YS5skAg6E0S64VGIwofgHZFmx+Rho8kiLHfklcbzXuXJs5AKN9X609isool5inY1
	C92rsOfS3dX1zI5fC0u7MWDU2k/pwEUlxDQ9D/gFElJn8uocSFsZxn8mjyOYmpP/
	Fy5ULUI6Z2DfGV105BZe7BWrR93VTEfp/hMVbTHcS5Cbo1zzplNb0c8CoQcnFe7H
	Md6BXRPgFmuU43m/ns4iw==
X-ME-Sender: <xms:RfF-Z8oUzpL46yh8dBBxXrjv4FSLsMKF2MQJIGkUNxTsI9rff6xhRZY>
    <xme:RfF-ZypymkZpelZ0GFLy4-bASCC1CGBzkjjvW7uD0pn8iXE-eELF2wjpz-VWQVvnD
    tF_qEXNkL8oVUVjeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggedgudehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffr
    rghtthgvrhhnpeelfeejudejfffgleduheegheeufeeffedtgfeffeevudeuleffgeektd
    elueekieenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgsh
    gsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehstghhrggtohhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:RfF-ZxOwbHT78kB2ubdu_AUIYWq8FiCV61x7IZVTwNch1C3_Oe18mA>
    <xmx:RfF-Zz5230iuuAvroDrhBR_h0BKium5GZ4bIWxbdfv___YbN_sI1Ag>
    <xmx:RfF-Z77QzMyC-9lIEIwzgom6H0xhRAuxRKA3e6zOMy77KeN9o8o0qQ>
    <xmx:RfF-ZzgxzuoOdjPCkJ5W4HwmUJVJpUEXRkyGfR4DftDGznSiK8YPJg>
    <xmx:RfF-Z7H3TYZ07uH_UlfJnr6MDuiDVNbUQllBNJRBoxeeeVIULKxUXj3Z>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F348F780068; Wed,  8 Jan 2025 16:42:28 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 08 Jan 2025 22:42:07 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "Scott Chacon" <schacon@gmail.com>
Message-Id: <52e414a5-e22f-4046-a321-ae9357ab43c3@app.fastmail.com>
In-Reply-To: <pull.1869.git.git.1736364707068.gitgitgadget@gmail.com>
References: <pull.1869.git.git.1736364707068.gitgitgadget@gmail.com>
Subject: Re: [PATCH] help: interpret help.autocorrect=1 as "immediate" rather than 0.1s
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025, at 20:31, Scott Chacon via GitGitGadget wrote:
> From: Scott Chacon <schacon@gmail.com>
>
> Many people confusingly set the "help.autocorrect" setting to 1 believ=
ing it
> to be a boolean that turns on the autocorrect feature rather than an i=
nteger
> value of deciseconds wait time. Since it's impossible for a human bein=
g to
> react this quickly, the help message stating that it's waiting for 0.1s
> before continuing becomes confusingly comical.
>
> This patch simply interprets a "1" value as the same as the "immedate"
> autocorrect setting, which makes it skip the 0.1s and simply say that =
it's

Maybe: s/This patch simply interprets a/Interpret a "1"/

From =E2=80=9Cimperative-mood=E2=80=9D section in SubmittingPatches.

Or: Interpret "1" as "immediate"

Since the sentence is getting a bit complex with =E2=80=9Cas the same as=
 the=E2=80=9D.

> running the command, which is almost certainly what everyone setting i=
t to
> that value is actually trying to do.

The section in `man git config` should get an update I think.

>
> Signed-off-by: Scott Chacon <schacon@gmail.com>
> ---
>     help: interpret help.autocorrect=3D1 as "immediate" rather than 0.=
1s
>
> Published-As:
> https://github.com/gitgitgadget/git/releases/tag/pr-git-1869%2Fschacon=
%2Fmaster-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git
> pr-git-1869/schacon/master-v1
> Pull-Request: https://github.com/git/git/pull/1869
>
>  help.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/help.c b/help.c
> index 5483ea8fd29..e6576644b99 100644
> --- a/help.c
> +++ b/help.c
> @@ -568,7 +568,7 @@ static int git_unknown_cmd_config(const char *var,
> const char *value,
>  			return config_error_nonbool(var);
>  		if (!strcmp(value, "never")) {
>  			cfg->autocorrect =3D AUTOCORRECT_NEVER;
> -		} else if (!strcmp(value, "immediate")) {
> +		} else if (!strcmp(value, "immediate") || !strcmp(value, "1")) {
>  			cfg->autocorrect =3D AUTOCORRECT_IMMEDIATELY;
>  		} else if (!strcmp(value, "prompt")) {
>  			cfg->autocorrect =3D AUTOCORRECT_PROMPT;
>
> base-commit: 14650065b76b28d3cfa9453356ac5669b19e706e
> --
> gitgitgadget
