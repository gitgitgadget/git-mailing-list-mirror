Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443CB47207A
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 11:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788349555; cv=none; b=PlGk9FUZA9vucSSSr8nTWzfjrZqCB+r4kPsSYzn7qZyFbGtFQP4OjsREwRKi4HGpWWxcHDVbwFaoPhd6c1ujzK/rxd0pyBpwuuxoDrHIUXtTYOgm2cAte3WBq2XeOlCiUEj0BhqgJ8xfMFP/MpdsYGODxHsxe3I3U7WFNUhaPFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788349555; c=relaxed/simple;
	bh=JjWBH/m9+64X1XcOHwYAdqd5+l1X4PvydaBoULbnhd8=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=n2vMHPPjaqvZY8iHRT6AxRHJ/haQS4giEpZ41+hsY1+5bTmIcs53QHaVjWPeGF1lSehgyaqu7wGQ6l0NPSZMIHA+EGT4IVibF++IsJcylmku5uQFRIGQ8LQhhZ1/c7480+zSuBJHfti2Qo2XGKPQNYeZc6/y9E3GSuRNAPtJBk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7q2vwOl; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7q2vwOl"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-85dbc24d398so13957687b3.2
        for <git@vger.kernel.org>; Wed, 02 Sep 2026 04:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788349550; x=1788954350; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SRX3QpNppt1kTHwI56v8zUjVH5yXOyALToA3KRRQGPY=;
        b=I7q2vwOlBNWNs7DQoQMcwDExJVluT8PweyUsMwcQHBtXlBiMsFmhlPlP+I0M/xGP2O
         a6dFSvfEGLwg93kXEbNZBHZh1VfvTEo0wRNi8owT+OOxqubwBbf8VXPnhLWtENF7W+Ip
         oSo7B9iC/iPPLWTe1gzZJhg2QM8rFxDrkrapC1gBYgHVIyTImW5l0qJCTxNOC0kNIIHE
         P3tautCsuxktFyZTD3dmnP5laJqWLvmdQppVVxr+Q1KpqMYTfkGnj3DxIW1LHpm60K2Z
         aX3rjeET9nylbBx7vo3uIgvSvDBXiQya9w0YD1y+l1KzmAbE1J89o7J+hFsjPDMEtgp3
         4a+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788349550; x=1788954350;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SRX3QpNppt1kTHwI56v8zUjVH5yXOyALToA3KRRQGPY=;
        b=lSnfLDx7ruCF3/AOS8Dm+uuN/Ep43kE6Ru7LQc6Q+/LPboB8Zl49KMWxiFly1Z1qOb
         DOkoFqH5CyE/Mc0AYIROrIO4JPiFj+TkRXRFbZtnxzTAEahrSflcKnz1DyNiWhtuPwG/
         mx1/LMQSew2/kcGIIW3evFMOf6vgi4P616jQOoDqTQ65O4eA0d11ErVJfca0/rdlw9SA
         leQtKPgAnctRQNiJS7osxLOL593/7d9jBDRSDwhB7vj3F63CK/vZTO3Zd2eBkM3k1Gtt
         Tzwn7gdiMNJAEfE/pHIS9o/M9dvjbVJUUdAFwX/lVGUV1VLDKaaLeshVHIcXiY1WuwnE
         XaiA==
X-Gm-Message-State: AFuF++ktjHyFlY3m1D+nxVy3WN8L28+N+ascImOO6ia8Md4JLpVuwmds
	AQ3dkjNyS61ASTtzGv8QTsY8NC9FSmqaNfcOojGX/bPq/FbEFKb4eDBh
X-Gm-Gg: AYBFou1zoasB/OHw7IH21IfOz0EAzGJhiEFB1LA1VPiVMB+2gQp5sY2RElhGnV0W7M6
	1EMQZahpjP7Mu8+TVJfiA2GtujvDijz7463ZHmgBVv+ni5cw6kO8S++GHCt5Dmh0bT49Zdy4zJ/
	2iMb4cTE62xrbbgLFrVn0ZdI5xqU35hxSgQ2fpZr2BQCfTI9ZyLDGmkoW5Oham5jwYz+hANfaMo
	p9P4fK6HXYLcyZDlftLy1pqdpzGt6AP1Xm5QQ2MrMHDf6ddO1hYnb10Ej8xkHvJJyDnl+0lj2En
	7MQ5FyEi9UQIkq6A9mzHw4Qu/woK4Z80S13I0iIaMK2etgRjgRHJdGQjW9LDGw76mC7+vRi22At
	E+HuPy46js6C77hU7Sq0vpuJPmZ3C1cQ0jvoCjd7MhU7KlxaG82DEcIXNWtw91giBTKY2UYqGRK
	DqLrz4IMbt0jWzM7M9OcSAtDhLn6UEJL20Xe8Qzj4rHXdg74kyUddYk8Hr0LQdO3256tXpA0o6e
	pj9ZC2YGWNDRe5WFl0kCFuiPhCe+OStN+0uDpLFzh080dU7Aj/UWBsECok8wnraPv6lZotW79zg
	JMSyUi4OsPjKdV8TbGx86HvHWgg0Ax33lyQyKg==
X-Received: by 2002:a05:690c:30a:b0:858:def3:3422 with SMTP id 00721157ae682-86c53989a23mr23096107b3.27.1788349549728;
        Wed, 02 Sep 2026 04:45:49 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9092:700:69ae:7306:49a4:34f0])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-86c129b2ee1sm14823407b3.20.2026.09.02.04.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 04:45:49 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v6 3/3] core: convert build-time USE_NSEC into runtime core.useNanosec
Date: Wed, 2 Sep 2026 07:45:38 -0400
Message-Id: <B02189AD-DEC3-4117-8505-AAFA56494822@gmail.com>
References: <20260902072646.GB70165@coredump.intra.peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Patrick Steinhardt <ps@pks.im>, Todd Zullinger <tmz@pobox.com>,
 Olamide Caleb Bello <belkid98@gmail.com>, Yuchen Tian <cat@malon.dev>
In-Reply-To: <20260902072646.GB70165@coredump.intra.peff.net>
To: Jeff King <peff@peff.net>
X-Mailer: iPhone Mail (23D8133)


> Le 2 sept. 2026 =C3=A0 03:26, Jeff King <peff@peff.net> a =C3=A9crit :
>=20
> =EF=BB=BFOn Tue, Sep 01, 2026 at 08:36:22AM -0400, D. Ben Knoble wrote:
>=20
>>> This hunk made me wonder if we even need to do any build-time magic here=

>>> at all. If your platform doesn't support nanosecond stat entries, then
>>> you're probably not going to ask for core.usenanosec in the first place.=

>>> But if you do, I think the code still works; we fake the entries as "0",=

>>> so they'd always yield a racy tie, just as if core.usenanosec was
>>> disabled.
>>=20
>> At first I thought you meant we fake the cfg->use_nanosec as 0; it
>> took me a moment to realize you mean that we fake the index entries as
>> 0ns. (That is what you mean, right?)
>=20
> Yeah, sorry to be unclear. I meant that we still have this code:
>=20
>  #ifdef NO_NSEC
>  #define ST_CTIME_NSEC(st) 0
>  #define ST_MTIME_NSEC(st) 0
>=20
> So we are free to pretend that stat nsecs exist and compare them.
>=20
>> In that case, yes, I suppose it would work. Might be confusing in a
>> debugger to see use_nanosec set and checked, though?
>=20
> Maybe. Looking at the list of NO_NSEC flags in config.mak.uname, I
> suspect it's a pretty small population in the first place.
>=20
>> Hm, yeah. I haven't thought too hard either about the interactions
>> where you toggle core.usenanosec on and off, but giving it an initial
>> think they seem fine. Unlike this hypothetical case, when it's off we
>> don't look at the ns fields, so I don't think we end up with any false
>> negatives.
>>=20
>> And in this hypothetical, by restricting the option parsing we avoid
>> reading the ns values on unsupported platforms, I think?
>=20
> I'd have to double check, but I thought that even without USE_NSEC (and
> thus even with your new core.usenanosec off) we still read and store the
> nanosecond values in the index, as long as the platform supports it (and
> if not, then we use those "0" fallback values).
>=20
> So they are always there in the index. I guess the same odd sequence
> applies even today. If you:
>=20
>  1. Build with NO_NSEC and get "fake" 0 values in your index.
>=20
>  2. Re-build without NO_NSEC, and also enable USE_NSEC. Now we get
>     _real_ values when we stat(), and compare them to the fake values
>     in the index.
>=20
> Now the index values appear up to 1-second older than they actually are.
> Which could maybe yield a racy miss of an update? Probably not for
> stat-freshness (where we want an exact match), but maybe for some index
> vs entry racy-git comparison. I didn't think that hard about it, because
> at some point this sequence is just kind of insane.
>=20
>> The build-time conditional _does_ mean that if your distro (e.g.)
>> provides a NO_NSEC build, you can't access the core.usenanosec feature
>> without compiling yourself, even if your platform supports it. But I
>> haven't thought too hard either about what it looks like to get rid of
>> NO_NSEC entirely, and I'm not totally sure if that's a good idea.
>=20
> You couldn't access it even if core.usenanosec is supported in the
> build, because your fake nsec values would all be "0" and it's
> effectively a noop. ;)
>=20
> My suggestion wasn't really about supporting more cases, but just about
> making the code simpler by having one less #ifdef. But like I said
> earlier, we can't get rid of the NO_NSEC knob entirely, so it's probably
> not worth worrying about the one #ifdef either way.
>=20
> -Peff

Right on. Always good to find myself nodding along with your explanations :)=
