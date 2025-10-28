Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789F3283C9D
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 16:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761670017; cv=none; b=uCAX2bjaBQG8FPCEscUc3pQtbW15PfdKE6Qwszv0byKgbO958nn/9mE2BRB4lTcv0YIFa33/D+HMF338ShV12+ndECr3fkMRnqwkgoOt+ZrU92MGCjjGxqpXxDjB2qBaPBGf1lky5buj2L9tETdn84HOWy8F0eQdfuTAjzSM1wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761670017; c=relaxed/simple;
	bh=dzsUyyunXQgqYKNFLxb0P2f8YSuPdIfb85AcvJqYkKM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J4JyaplVgbZGN2w4WPHUXiyWdXmp9pi/91hpAw2wnclurC5KBsdYlCxpuFzwT6y1RKsO4B/Lt4aHqfNC5mCFpHDdxUYZJYJAUg8HJeskUT3I54ic1zY5wOKHz4c01ZvcRqKdkZB5/pgzuEldhoKB172/fgX5MB8A9TwJWp9XdxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Gopr4aM4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oDHNZTj8; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Gopr4aM4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oDHNZTj8"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8CE087A0045;
	Tue, 28 Oct 2025 12:46:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 28 Oct 2025 12:46:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761670014; x=1761756414; bh=6piebOF4AT
	AutsdSQNrHQJzGHjA3pNDhx8bedQp3WA4=; b=Gopr4aM4Yh6Y2y863sfSaqy70j
	CQkjpHG2HGbk3006KVuIYt+dOqQaHkxjr6Keeud5L5VaJISov3pLXL1K+IIIb95W
	124IheLtLrWeJq/QctR4GEnfzzGjnmjsnjtFqTGw213ROPb3CVx32eUQsrDGtNXu
	VFBBNgR+RmHfWP9TCiC2u8CJeCnIf//gPqUTzyiFa0gwd4G39l69Vy1Hmimrl/oX
	046PRq+LpRVBjYqBnf/pr9JB/1GkKcmhVEB24mysmy2crkx7tgIPsS57qeYw7yC0
	zDADO79lt/M6SoydYm/oInBnpzk1ktq0qjShLXM6OuFG2DxnoOgE/sCgRKBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761670014; x=1761756414; bh=6piebOF4ATAutsdSQNrHQJzGHjA3pNDhx8b
	edQp3WA4=; b=oDHNZTj8PRjOCbVzKxPPmYeKR2ETTLkF+icbKOBb+mHQIhWM/xE
	lgE5unSvROGGq8FF/xsYYfV465ZrNKm4rgeAGJAB4NSeEZqDz3NnziJErXcLTMbM
	yQ6i3nV6iOSaDycCpi1IofvkEyHWv8Mnqjj5OmyoFSItKNr2ErCL186Bcee1ksce
	8Zf0gTH9Eeq7TpS9SGYKdC048CYyrevz4aDqXJkLOOA+Yi2riZMn76VMuxRb9NUm
	3kIAHsRDZpghdasMEvD+fe4GeK+YqL68RJWDarq2VNf7ixfrGPkQXV2trQuWa8L6
	FHzlFyvmFFP7DykOM7ibdLEctm375FKCVCw==
X-ME-Sender: <xms:fvMAaRP8PB17EudfS3eu8fFgYfYLlBIvtlL1KRdHk0tZEZp1YdtjOA>
    <xme:fvMAaWhGqEsNdLMH6I2z9c6_ygGP4PDSQJ_XDNrRK_W6ikHRfo7WtvPiabnKG1TPs
    glmDSwcOLlywBSTueI_u6pr-7dsWXIAz-hM5qUTZkpOoM1sFH41>
X-ME-Received: <xmr:fvMAaT4_5QRE38Mp_Tt4r5OywVuqDoCJUmnzWLIIAvj6pff_dyqDPsV_2UgwYyyCN_-a5pSqII9IW4pnMqsEpnC_bXYGa_EP1GD9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedufeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehsrghn
    uggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehjoh
    hhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopegthhhr
    ihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:fvMAad1WIiusv3-3_Zu8puLiSfCZNUDgQuzWTTyLK4gFzz27IOXUyw>
    <xmx:fvMAaeu55XL43r0QpxHyokzCnc2tHvc9NugLgf8Jkf8JYjZ5H9p2CA>
    <xmx:fvMAaT4BH5G2HvuMjzEnfX02FJZwe2TWmTU-8qCGAOgIdAzppgD7SQ>
    <xmx:fvMAaac3gFcNhZts4MJhv8z6dvKak3kux19R5cCJFGnim_21Ha_IqA>
    <xmx:fvMAaacS45Wj-Mp8DyBnLDIeMFGQmxVMwYrT4EjhzKm2Ovnc3o25vMfK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Oct 2025 12:46:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Elijah Newren
 <newren@gmail.com>,  Jeff King <peff@peff.net>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 4/5] fast-import: mark strings for translation
In-Reply-To: <20251028081232.3068147-5-christian.couder@gmail.com> (Christian
	Couder's message of "Tue, 28 Oct 2025 09:12:31 +0100")
References: <20251028081232.3068147-1-christian.couder@gmail.com>
	<20251028081232.3068147-5-christian.couder@gmail.com>
Date: Tue, 28 Oct 2025 09:46:52 -0700
Message-ID: <xmqqzf9bc6tf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> Some error or warning messages in "builtin/fast-import.c" are marked
> for translation, but many are not.
>
> To be more consistent and provide a better experience to people using a
> translated version, let's mark all the remaining error or warning
> messages for translation.
>
> While at it, let's make the following small changes:
>
>   - replace "GIT" or "git" in a few error messages to just "Git",
>   - replace "Expected from command, got %s" to "Expected 'from'
>     command, got '%s'", which makes it clearer that "from" is a command
>     and should not be translated,
>   - adjust the indentation of some arguments of the error functions.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  builtin/fast-import.c | 270 +++++++++++++++++++++---------------------
>  1 file changed, 135 insertions(+), 135 deletions(-)

Same comments as previous.
> ...
> @@ -3774,7 +3774,7 @@ int cmd_fast_import(int argc,
>  		else if (starts_with(command_buf.buf, "option "))
>  			/* ignore non-git options*/;
>  		else
> -			die("Unsupported command: %s", command_buf.buf);
> +			die(_("Unsupported command: %s"), command_buf.buf);
>  
>  		if (checkpoint_requested)
>  			checkpoint();
> @@ -3785,7 +3785,7 @@ int cmd_fast_import(int argc,
>  		parse_argv();
>  
>  	if (require_explicit_termination && feof(stdin))
> -		die("stream ends early");
> +		die(_("stream ends early"));
>  
>  	end_packfile();
