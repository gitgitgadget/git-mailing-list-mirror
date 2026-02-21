Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FB92BEFFB
	for <git@vger.kernel.org>; Sat, 21 Feb 2026 09:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771667826; cv=pass; b=kS8NoHx2GZ0qUrL4giruew9oxQHPAsCyweIH4Tbd+4eZYtvnpfxP3KNb9FeOErJLFpcBOMNy/zwhjl0GD1QBoT3xiGgCVDmRWsDq7c8tdTw2rM+AoDwjq8HyGCyScBNp7zeWRG0xSXgwvEruticZzsrPuxfTj3VJSRgzR111OuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771667826; c=relaxed/simple;
	bh=1LQYqDw8uM78uWps7rT53YnCqQIuIh39aeiZkr9Rr/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sUtmTg5nwvC7EYp1jYcTrfUA2n4fjD/tZNvqqP7zpcLQZur1rWb2RgIBtFSyqQ4iMxXthEbmBIkzYv4VOD1uRvMJLIHkBLiKWlG9tyoQWNgJPIq21dUinDNubDRuS6mNJFl3mTTtaQdJ+Puw0HnKX+wrtogx1VMo2zOeVw+eABs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKmRVvnE; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKmRVvnE"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4362197d174so1819659f8f.3
        for <git@vger.kernel.org>; Sat, 21 Feb 2026 01:57:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771667824; cv=none;
        d=google.com; s=arc-20240605;
        b=DIsRASWTEaobz7HwUM8cvZFK6XJ1xfSRF/y8dMv5XrS8C7iwijFIy2cXc9SDg83PZu
         ikk6pRrLuMoQekYNzBf+7C63p+N2SeOegId6eWaPOBTyRPmhgTpli80KkHjuB7ykL9It
         V7c3MVFmkltokjBwb/oeyG0chOlpYhRaLyN69VOiLiziMN176GSiX9hZ7zU86zCMEdwJ
         lpADaQj+vre9rSgY4BoaEZ6nKeu3yVfqcGAUG/MRZe0rHIF/O15ymcNDJQuXId9hJW/T
         P/nYj4igtQClF9zYt7JzxAi4MfLODtIDRQuLV/sBz8YZEsK+Mo1Wgo6bBpeUKnlz5ULh
         8wBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bIxyPdxINM+eqVPeyVGs6j5eD2x+f1jQJ825cWO5lic=;
        fh=V+OzS2sKBy/dRrmFL+8BTXHNvjz6AaIb86Vf/b1pyIY=;
        b=F0L9u5qU8bz4+WQJSolgQ91Fiu3oJ1lvplH+/V0VLXPgGvx8D4DHl+3IT9XIVV/lro
         vl0rKdYxFDXzyVrnkRzevfYVTN/KcH2kmyFHdPr82cNARnBHtPHpCq8NgQXejnjpN6mO
         yuG+opiGxyPsIuYjsQyx0eVaS7+kmY7VSPaCj4mHp67uHSCNiJX8rSM0cgYN/1mTAIpA
         qmI8iySjc23PZNjzyhCaTs5Vj587GB4coPGSGug6UTrUpsBZVNm9SupWuSFblkrvLF1m
         u2dEsK+MzhV4Oc32PzNzFoGodlyGQp6GtF9iUjlAKHQnoC+TKJWIZZEK57GXeo5oIwyd
         JtEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771667824; x=1772272624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIxyPdxINM+eqVPeyVGs6j5eD2x+f1jQJ825cWO5lic=;
        b=SKmRVvnEG8j4Fm73bXwcM8XOejEowFCRFixZmini4eW7IdY6n7tuD9mNZK8GGrKRP4
         Y/65iy2dl9gzTBpIczacZJdP5OdUDtuOr61Ra4qVxcxqP83VlKmB1GaeniRSvLx1xQVs
         /XlGA2qE4oTTXsiXZw9ohRYXp1QJ9OJDcZH70y7gSZgVUgx26OvKCVpgxCJdGTk+1Ckc
         8k9PDhFBX+REL1zJGn4NqVamTVX4Vc+iEU/PYxgyiJ3wVSU5AQhyxGWrszSjsoGdlm3t
         P7dXz15Gudia/GEbCaQzCJiTQiF+CILfphZJMoSaLh387iX6b6yGyplt/jDueJNP/rFa
         6xBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771667824; x=1772272624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bIxyPdxINM+eqVPeyVGs6j5eD2x+f1jQJ825cWO5lic=;
        b=GAqjv49wlJoht2/WbIMWVigUeM+pCpjFxR/FidEXRqOxdxei35Lgz24uw24zcpMcJh
         slzrvpg1zLlSw1AuAesRTX8rRatv7ASIXpuCPPkrWmCkBpAmrRs1CLzQuBlB7kcF/aH+
         1RkM9mAcjaZLaweNIidw0+Lfw4U+D21OyUE69GVXpw9ftBUa1aGETMv6CeIHwg7eFClB
         tdQXOGC+kCz7/+Hpd3PmDttnYZTN0w9UG9WT+7BWKQbvE8reDhpGqByEPaTE/7dIyXUl
         BLt1Xleg9odFyxbCByqjCI8iphSSMB5SIyuoTLlEuxIcrxY0HYF6CftaEZ0PNAT63s3N
         Ce1A==
X-Forwarded-Encrypted: i=1; AJvYcCUX8tBxnZafY3o9uTzBs/ebesCsCFY/8SvKT/9HtwSIHvKKgjW0uhhOO6n7BnY7E9fasMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy425Qyuc4xqpSfR8418fPnYLrqYgbi2WQhi7FFgHEunCJ7p1h1
	MtHdijRVM0hu1R6N9cWEc3QLUoYK93lzpsSTLxKniWKTBd2QENkZjKe+9R0BWqEHJ1466Rli8gL
	moDiOKbqfy5oWpUUVAw2kkVFNWhoyzV2vvw==
X-Gm-Gg: AZuq6aIR9jj5j9gqoltvgA5v5Ums55Af2SJMnMkqcwXCpCLTAUhef8NmW9Go3B6tQl9
	QgHqvg7u5naBR3cGuNxO/VDQqnmRAMDSzkF3fTUt9UqtZSCtZA99zJHdBRtkHpn6SXaAjgHbcZV
	LfNY5ZUAe79qO7e6c2Euz0AegIUUszwcFclMw1Z8SPCvyvgSiF2P16RYRzswAGCGOtSnvPPIrXg
	0VdnYStTQL7pvjEZGadDYOnFpbAibtHI/XpIf3DBtHp2snx+INeR5vc8DDT+RoD5ma/wfv3SVFS
	HXvJWeg=
X-Received: by 2002:a05:6000:2913:b0:42f:b707:56e6 with SMTP id
 ffacd0b85a97d-4396f17a93emr5167357f8f.34.1771667823631; Sat, 21 Feb 2026
 01:57:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2120.git.git.1765054287938.gitgitgadget@gmail.com>
 <xmqqikcusn8p.fsf@gitster.g> <4fa413ae-f2a4-4de2-a2fb-0b1db379750b@gmail.com>
 <xmqqy0llk33y.fsf@gitster.g> <3aeb49dd-8618-42e0-b9f9-6a4fb8065793@gmail.com>
 <xmqq343sjn4x.fsf@gitster.g> <CAHTeOx8SOZmqvi0pkcheSjFpbEALmOwaUiX0tKLmNP7fqvjMXA@mail.gmail.com>
 <xmqqsebo9lv6.fsf@gitster.g> <CAHTeOx-TLwqbcdGcb2drD4vE6D3M93EPMjcAeTNR+XNTbmTVZg@mail.gmail.com>
 <xmqq7bs7ui95.fsf@gitster.g>
In-Reply-To: <xmqq7bs7ui95.fsf@gitster.g>
From: Yee Cheng Chin <ychin.git@gmail.com>
Date: Sat, 21 Feb 2026 01:56:27 -0800
X-Gm-Features: AaiRm537Ys8ErHvZDLSctQvUu9z0ZnfiLZfiqzN5eSEvSiRzEwML6yrOSHGssPs
Message-ID: <CAHTeOx9WehtwSMie53xzZUU7iK3JTrgUbVK48WM7S+LBi=jpkQ@mail.gmail.com>
Subject: Re: [PATCH] xdiff: re-diff shifted change groups when using histogram algorithm
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
	Yee Cheng Chin via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, yes, I'm still on it. Sorry for the delay. I will push an update
out this weekend.

On Fri, Feb 20, 2026 at 3:07=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Yee Cheng Chin <ychin.git@gmail.com> writes:
>
> > ...
> > {-AXB-}[+CD*XE+]*
> >
> > Because of that, I'm leaning on keeping the current code structure,
> > because it *is* indeed a cleanup step to be run after the previous
> > one. I could still refactor it into a separate function and put it
> > into the the case #1/#2 if blocks if you think that's cleaner.
> >
> > I will also add the above to the test case in v2.
>
> OK, it has been a few weeks since we had this message.  Will we see
> an update sometime soon?  No rush, but just pinging.
>
> Thanks.
>
