Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20ABF39479F
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 22:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787610675; cv=none; b=BSWILaDgSwUEmmK3+pddfG+FtM6mw0+eE2qDxf1OP+pJyWLHMQpfelpuApN+K+0HQ3R8d5Pf835+6O8DhNyuZQL7w3JvYE7xH+O8FnyUnWnt2UzMKQSKK9AfqWQIYIwwn35ee9QPbUKgg7E/LW09QVDy+WXjwYOSIH1GsQrXhoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787610675; c=relaxed/simple;
	bh=F1eL9DIubhBs31I00JYzfzDYDG3xWgkxJKoZqCytlYc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KYzZup5xq9qbiJ5tMnYnC2jR1X6vEB8UF7x0ChSlZzwtaL8ntYCuXMTJKywV6W888YJ5+p35e/oUny7E1ToBrMJ4DIP1EA9XHggx/no+0u2WardQzaAqVWIti15FAx31Dh7VwJ6E7S/zLGybM4/1nxvMNgyHwyt55Z558xTPiSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RtZyNJTr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i7LO/eOb; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RtZyNJTr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i7LO/eOb"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2230214000F2;
	Mon, 24 Aug 2026 18:31:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 24 Aug 2026 18:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787610672; x=1787697072; bh=zAD1c4cIP1
	fAS8yEpNxxY6VPU3+kG4qOTinDraZP6YA=; b=RtZyNJTrsX+7fuzJc6TQWWAMtD
	TDNTRA4yh1c/KUAeTQUZmUDLYzf6TQnKm38s0yqt6EOCc3gTQ8ffojxfpq58Ek4E
	Ypxl/E7SAFUVPjFQn00UWFpFARRfSEoZ6qdyFEQ3BzrnqHdslOlhVpE1DYGD5z0X
	tJluxbnBWJdwt79PQd03+fCGtDPQ626naOCiGcVbjSqBcAqt6eTJNK221iDdxjLF
	gfK5tRJvlONqtNkqf70OMb+duwPB6ts0AUbNiMazcZzaGbZ0duwapW7NiJmBN2qt
	b2crunFPsbvEcBQyAb6gMY1gRhLHZvak+FSye/w+JvXCoEOzwuvjhVKFNsDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787610672; x=1787697072; bh=zAD1c4cIP1fAS8yEpNxxY6VPU3+kG4qOTin
	DraZP6YA=; b=i7LO/eObEfGibuUvb5711gj0Jyj57SAPkNcpVaDGTBNevCrXYd0
	kI8FK38Yx5Ux5fLp+3Okx29age1GOG1sdFU7oziwam7WWcJYnAzt4D80Uzz3Ty3c
	6I9VcVAsm4Ytrh9Mamef+G8DzW7Ug9pfS5EiagsyS2Zp7EBkibC+TORl0AeY54/t
	Egk7Ny/r7ulQ4cGYX5Ui/DT+2L28upW+0Phu5GGEfTJ/CB2/1ngW/CJ2GuIM0k5G
	8vRRrXsq2HARSUf635NPf9UHyWigEEJLJhX28sdSwKmoaDqsy+F4xEJIgPAlJ6r0
	NLhkE6i+t77hGlGNjWSaNQ5yWRHoyK/0OfQ==
X-ME-Sender: <xms:MMaManVH6vpWVwJ2wMWTs2nsiI-cZs9GNe2g089miNs_yC5km6d4Zg>
    <xme:MMaMamlL_gq1exle2G00cXhvJ-mt2atkWAXXjDi9EqKO3A8hAglSmutemfOcoTRsg
    _bBHdQ3iRl_ve_PARw0MoweM9qGR1KtQsF7030swvFWBLLHXwmcOA>
X-ME-Received: <xmr:MMaMaoZ_vCbCegJVP87HJkZ3mLAwWl7RDIs_dp1e_O4ZeaXnWuH8BYsVDyvPqnaCj6jMXW_utMgAnXWUI-gwTR7RuUBgFo8jhA>
X-ME-Proxy-Cause: dmFkZTEpp5yyj5rRDEqHDYkVbQpQ0VJmaaY9PzREmGp+pM8fNO8Vf4oY7JyKZzBhktIY3t
    R0N2flUGEXly+FRgWl/3nxfWEM3A05OAlRR5iKVq0onF6hxTWM/PNfkzIzo6yTSP6f6VBz
    dnk3M56Moj6Qen5AmA4tWwHuIS+jR24Xg5BDbhMCpiqPwUqD8XqcFZo5IwpYCeXLB1Pe05
    uu81C6FbxbV61RYyjIb+UbKHuj39jBpmtbrbwZbg1ArwbZhYmBOFByZuPJvzBU949/EGKM
    hMffi/z80pdVO06DaHs8wqO+Qy4inbec07kNcSD8S51OvC+uY5C+nhTelXsGliI1Utd0pQ
    SLITTBGuJIwgHBGtML9XW8veUJIv8aJ47rNFRGI8V36QTM4RCyguKKXSdpu4jqRN1Bnu3Q
    KbmqG1hzioinNVBcdCUNFasXxyz30IA2Pkrqnia+m/V+oKgvRntdw1wUJeaTHZHoJY35EC
    qkKPrkFRkeFov7iCmUdMIxP+IpBPU0YIWavp4fF/9YNn8vZZhDrXP1r9RUghem9dgh/euc
    5E26o0cV4C/HKtM4EzTJMrnSv2VBKyC9h/MPM+cTNqw47wRDvvKsruro/MQIiND2iqDex3
    N0IRMhW7yofIFQ6jLKvAt/3mhFmP5NPPqbNSpeClw9m9ercHFtqoID1LI6DQ
X-ME-Proxy: <xmx:MMaMahO-fHWcBxMTb3gzWsiDUeiE7B-3ZB0pbI__sl5rkStBERFZ4w>
    <xmx:MMaMatY1p3mOm8_wOL1aHcMm0tmNJeZ9ilkUhMG5gsj97OKX_u2cog>
    <xmx:MMaMav19borvUjicLgJuouDrVqoM_jESPyjqGKKzkDBFMyIMeHH2nw>
    <xmx:MMaMajcGZEnUTFDjbeRJDYCmL5cN8lNyECtFSutc_doDlgrb4htP3g>
    <xmx:MMaMavAu3qcLd8XyrZ7TFihcYAM-ste8b1kbB_yuVxI1PF1kFDEPdJ8p>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 18:31:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH 3/3] format-patch: learn --[no-]range-diff-notes
In-Reply-To: <format-patch_learn_--range-diff-notes.c5a@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Mon, 24 Aug 2026
	22:35:44 +0200")
References: <CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz>
	<format-patch_learn_--range-diff-notes.c5a@msgid.xyz>
Date: Mon, 24 Aug 2026 15:31:10 -0700
Message-ID: <xmqqjypfp2vl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> diff --git a/Documentation/git-format-patch.adoc b/Documentation/git-format-patch.adoc
> index 191f64b77d1..e0ba435dfcf 100644
> --- a/Documentation/git-format-patch.adoc
> +++ b/Documentation/git-format-patch.adoc
> @@ -378,6 +378,23 @@ case is to show comparison with an older iteration of the same
>  topic and the tool should find more correspondence between the two
>  sets of patches.
>  
> +`--range-diff-notes[=<ref>]`::
> +`--no-range-diff-notes`::
> +	Used with `--range-diff`, tweak what notes to display in the
> +	range diff. For example, you can use `--no-range-diff-notes` to
> +	turn off all notes in the range diff. The default behavior is
> +	to display the same notes in the range diff as on the patches
> +	(see `--notes`).
> ++
> +You may want to turn off this notes override after it has been
> +activated. Use this sequence to do that:
> ++
> +----
> +--no-range-diff-notes --range-diff-notes
> +----
> ++
> +Now the range diff is back to displaying the same notes as the patches.
> +

Hmph, this is a bit too complex for me.  When I say

    $ git format-patch --no-notes --range-diff-notes ...

I would expect that individual patches would not get notes, but the
range-diff will include them in the comparison.  But if
--range-diff-notes just falls back to default (i.e., inherit what
patches use), would I see the notes used in the range-diff?

