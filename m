Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EA02D9ECB
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 06:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758178164; cv=none; b=OPkWLjp+9VY/sCezEHkiDfam0XAP+JLwLZK4ulmdAwZ/8c0IOFv0jKsHAFmumljbR1kvXqqCS1RAEmq7R5aNZcTIRcMaaRY9HrMpHaS/XltzMREoD09ItX/szOwtUm5SoiZD7jI1+JHaGKnree5FRIDNRf+y9AqqQ30fhU5XysY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758178164; c=relaxed/simple;
	bh=Lex7zcdQgiyMFdQD+9h84zzU6O0ChlR6quSPKSDQ3Og=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=luLIX+w80wuK2z2/cHp0iK3pMrqYhVrImamegk4nyFk1ryD15MXoMMUpnBtRInSGBuYuyqnQRuxOvtgPaCyO+3WYeZ2xIthBQnbBpmICBUdWfg493/leDw81c+Ndid25+Zrb8s8BM/BA0cFQZzqdcnFJUEDHDgIVKevYmwqMvl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rikAQY25; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KOS7i1OR; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rikAQY25";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KOS7i1OR"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id AB6BE1D002E6;
	Thu, 18 Sep 2025 02:49:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Thu, 18 Sep 2025 02:49:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758178160; x=1758264560; bh=y5Z143kB+S
	5cr/8UimR+k/yM6ulSE16Y64oPzsoYBOs=; b=rikAQY25Rl3Xo6lUMSjeZ+uZtX
	pR6ThtaUuvnzUZk1+xjt9nDOib8K7BXyL5ntt2ieftCZL41xFgd6Dp4L9ItnzG44
	E3gurI1Foe5VoIMXc0W+7HBNW/uxPWc8Z9B0R4Xw1IEQLyJZ0KJmGaeI0HfhGTyu
	7ouhisGi6z+YWkUvvrH8vSj5anXy4XY519xapyp/hNeOlZKbQSc3haG8cENWSgXX
	MqVPjUE2VEtCaoMwtfCgpDkbXWLCyZoOeGnroiJvEWjWJ4dPRSg+5FYYA3RH4QFD
	NlYO4PdXFy8efDWcSEoNmQWdgzxdrwUeM7JlNlkmZtCUynO3whzxRFxweM4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758178160; x=1758264560; bh=y5Z143kB+S5cr/8UimR+k/yM6ulSE16Y64o
	PzsoYBOs=; b=KOS7i1ORlq4qyaEZyYTDN5LEF/GMfV6PQQNgxug+4tCTdwwZL6L
	6WYuXdxcOiwoIoYBvnFsfPHNIFWu9BKhD4I1vPzJcys8sqVG8LQmG/iputKXRQSL
	4wR/ZI8o6uhDD937gJN1tBGdyFNQGv5gfyNS5Jp3CfN66X7H+4tZljOhHyHM9dqA
	hIu+LK9vof+p1HeodoTtet2JAP4C4HHEKVsUP7e7Cie2TNPRcWcBduaN2FY/UDsR
	8htsUkMSvOaufMmeNZ/9a3ARNvkGgwnOCdeTZ4SyURWZCRfZtiTeF6YE6itF33eU
	QvN4jnQsTg4XpUoxDxHp/UltEYdPN0jFdfw==
X-ME-Sender: <xms:cKvLaJhI97-XDPGLmVyH_PIRJGeuTg0iIq9eVBRbkBFwe24H3saaeA>
    <xme:cKvLaPiiQylN-h-_TUBZZtaG3ctjYXrVoWcXUBL0vQfKdZDNedzlAeh6rAzLaSKL0
    flVN8tZ__mMPCyopg>
X-ME-Received: <xmr:cKvLaJLw7NfyLn_Kmaj9Y6JFQIEfbzYfxiOpbwXErwNRy2rPpFvZburFpm6biPrgXf6zJTFPuFlcQrEqKVpExfHTRMi91E_mNyKuSy4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegheeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhm
    rghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhkse
    hfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:cKvLaOHzmTYV5ChPwLaBfBTp3buWhqwTiXpf0AX1P4Tm-ocUe7SdgQ>
    <xmx:cKvLaNRETtiapYOWwtfnzh5g50K6jwul5CUisDswr8pNcrgpu9du0Q>
    <xmx:cKvLaKcHC649aW5xmFCdE5dQM-zf_ttoDXbDV-kc0vdSfmiqYq4YXA>
    <xmx:cKvLaMqmSSxayRPLr7WbLZ2dP3NjIYDD41tJ4Cu4LVDqKOpMKDhYyg>
    <xmx:cKvLaJyxfPqcy0gi2Ymn0q9wocRy1oVV7G1VoQCreR49KGs78Dbln9z_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 02:49:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3 4/5] builtin/config: special-case retrieving colors
 without a key
In-Reply-To: <20250918-pks-config-color-v3-4-08ea618cae26@pks.im> (Patrick
	Steinhardt's message of "Thu, 18 Sep 2025 08:14:22 +0200")
References: <20250918-pks-config-color-v3-0-08ea618cae26@pks.im>
	<20250918-pks-config-color-v3-4-08ea618cae26@pks.im>
Date: Wed, 17 Sep 2025 23:49:18 -0700
Message-ID: <xmqqikhg9rwx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Our documentation for git-config(1) has a section where it explains how
> to parse and use colors as Git would configure them. In order to get the
> ANSI color escape sequence to reset the colors to normal we recommend
> the following command:
>
>     $ git config get --type=color --default="reset" ""
>
> This command is not supposed to parse any configuration keys. Instead,
> it is expected to parse the "reset" default value and turn it into a
> proper ANSI color escape sequence.
>
> It was reported though [1] that this command doesn't work:
>
>     $ git config get --type=color --default="reset" ""
>     error: key does not contain a section:
>
> This error was introduced in 4e51389000 (builtin/config: introduce "get"
> subcommand, 2024-05-06), where we introduced the "get" subcommand to
> retrieve configuration values. The preimage of that commit used `git
> config --get-color "" "reset"` instead, which still works.
>
> This use case is really quite specific to parsing colors, as it wouldn't
> make sense to give git-config(1) a default value and an empty config key
> only to return that default value unmodified. But with `--type=color` we
> don't return the value directly; we instead parse the value into an ANSI
> escape sequence.
>
> As such, we can easily special-case this one use case:
>
>     - If the provided config key is empty;
>
>     - the user is asking for a color code and the user; and

"and the user;" -> ";" perhaps?

>
>     - the user has provided a default value,
>
> then we call `get_color()` directly. Do so to make the documented
> command work as expected.

If we are willing to handle this as a special case anyway, I wonder
if it can easily be arranged to take this as a(nother) special case.

    $ git config get --type=color --default="reset"

I.e., instead of (or in addition to) "if the config key is empty",
special case "if the config key is not given", which may be slightly
more intuitive.

But even without it, what is presented is a vast improvement enough
;-)


