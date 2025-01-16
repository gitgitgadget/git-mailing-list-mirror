Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC5224A7C6
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 17:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737048661; cv=none; b=XJtyBPw6/Vps+T8tt/tf9JXKkq9GrvUrT3iMVMIUWmELEEeehQutx5GfoQ1QlOLyMXL/2/MYpVoTxw6hecPD2eI9mtq3Kn9bDoiD4zAdVHvuheuE1a17bNv/Z3SonvdIBfTAmYJz2TY9/QwNqp7dJvzXUbhImDBuHecf1cyjKGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737048661; c=relaxed/simple;
	bh=Vu7vNL6HviE5mn2K2lxnqHVgLtFuX6DKS28WsGUX7/o=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MHEc1OtE3ed6WR6NFMBITlY273FTh+eZGfrFC/z/3FiRMzN3WU4ZaGIjkluPvoUt2PlUrit+jw+LzOT+MfKWcw4Ck8LhdjKd5DmMAV4IpxZ94krcqXriwPbxFfXj5XGTJp4k6l6lr3VnL41KwvCqMWAWy0Y0uwUOcqtomUdV+48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=u4kpJi85; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BqRkMqki; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="u4kpJi85";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BqRkMqki"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2F65C11400C4;
	Thu, 16 Jan 2025 12:30:59 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 16 Jan 2025 12:30:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737048659; x=1737135059; bh=Plz3VtbVA9
	z+mlvI0Z7uIL6OIWiuGmXMum+YvDg6n/I=; b=u4kpJi85dw5PmNOkty8/k3taq4
	z9G7MX0AhsKPyIIKjlc7v8GQGRdDwZeEju8IvBDjVlNnvrgcjQwGkk3knKnZoG1S
	dByHROA2PcEDNc6eUbqUR/yvP+judrDhO4wjWtjFagH/BixbJL+l9EolsGnGhief
	gofl8tFHFYV9Ww2enbm1nXpPGN6Gzxyc3CsqdPSDMETKFOBQW9JGMJXBW5pSKTY5
	Z+f2O6Ih3+h7QEKMjjwAT+O4tPbi3qbHTyZyoPL+Uyt1a/aYE1cWGJ5YF9ZNHjUp
	i5GRFcUmMfGyy/R4PU6Hm27d1Q2PdIY4nlQ53J+wRmD8Z78SMeGnwT86Ea6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737048659; x=1737135059; bh=Plz3VtbVA9z+mlvI0Z7uIL6OIWiuGmXMum+
	YvDg6n/I=; b=BqRkMqkivMJMszIdCNjA3kBS06GHJMqxXwMOyfDI6gcjzvClV1I
	Q3WScWJt/a5UMwGlWZaIrVe70oECi2c6mq37rPqBwQ0zBnTTXRxXT/hiptkWJwTX
	2tQRe5OWvvf9qX6I2UCZoeJSP57UXFGUiVP0GDVam6YE8avY4kLD9jf4GpewDfdR
	HaO+qdSnxIvv5eerryxtuaUkrTGzoURIxGwA+mwWNMjfybMRHD+AfkclUfZMekps
	GrD34A/wH0blQ1JL8Rg+9VcSv5WWQMLTcsMJlM4Fv+ln8cDH0GcRoE135PGW9sKR
	a13jFrtl8rFUYSQeJ5cms8ua4R4EfuyKf+Q==
X-ME-Sender: <xms:U0KJZ70tvbV62creadOTb3xBJK9gszURuQmoHYdpn7ddpTZH0EygTw>
    <xme:U0KJZ6Fj1rCYM8SCohAbOWaADSyZghJVk0vfl9ZYnwHx-cmPGr-N6HhRB36N5z-ba
    xlG-pB_kPsYfLfYbw>
X-ME-Received: <xmr:U0KJZ75pl1aI4X9Rq6VdZZ5A8Di7-oa9IQeUR_hGg1fONbB5pX6tmleEy_SdbxIvFOQ0Qscyn2aSTW6HB3q4H-L1_V3fz6tAcY4k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffujg
    hffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepkefhue
    duteekgfdtueegvdfgueeiuedvlefggfefkedvffduvddvkeeuhfeifeejnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesph
    hosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:U0KJZw0mhGs-Is8XGd2tsvon4OmM45AqfmKmyNgwD4B2oxeHIpmsDw>
    <xmx:U0KJZ-GlsxcViIRc3fuBV2VlOIm0pyLq5SFscOlk_G70d5MFx07ZBQ>
    <xmx:U0KJZx9j2Ah5jyI_L9kItcVNhVbSwOGgcTgiZ3BpDcMeX4S1m3P_hA>
    <xmx:U0KJZ7mfYeLDvkDYQLDPp_69lMGU6QcTKfGI4vy-cgR0q_aTj2I3BA>
    <xmx:U0KJZzQufxeKrJLbZOQhJPBh3KOGTdgDA29abiq7cwPpzSbDfD1cb04u>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 12:30:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Re: [PATCH v3 6/6] builtin: send usage() help text to standard output
In-Reply-To: <20250116012524.1557441-7-gitster@pobox.com> (Junio C. Hamano's
	message of "Wed, 15 Jan 2025 17:25:23 -0800")
References: <20250116012524.1557441-1-gitster@pobox.com>
	<20250116012524.1557441-7-gitster@pobox.com>
Date: Thu, 16 Jan 2025 09:30:57 -0800
Message-ID: <xmqqv7uesm26.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Using the show_usage_and_exit_if_asked() helper we introduced
> earlier, fix callers of usage() that want to show the help text when
> explicitly asked by the end-user.  The help text now goes to the
> standard output stream for them.
>
> These are the bog standard "if we got only '-h', then that is a
> request for help" callers.  Their
>
> 	if (argc == 2 && !strcmp(argv[1], "-h"))
> 		usage(message);
>
> are simply replaced with
>
> 	show_usage_and_exit_if_asked(argc, argv, message);
> ...

The above is a bit of a lie.  There is one strange thing I did,
which needs to be redone.

> diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
> index bed2816c2d..9bd4b29c5b 100644
> --- a/builtin/fetch-pack.c
> +++ b/builtin/fetch-pack.c
> @@ -176,6 +176,9 @@ int cmd_fetch_pack(int argc,
>  			list_objects_filter_set_no_filter(&args.filter_options);
>  			continue;
>  		}
> +
> +		if (!strcmp(arg, "-h"))
> +			show_usage_and_exit_if_asked(2, &arg - 1, fetch_pack_usage);
>  		usage(fetch_pack_usage);
>  	}
>  	if (deepen_not.nr)

I think we should just call show_usage_and_exit_if_asked() before
entering the loop without changing anything else.
