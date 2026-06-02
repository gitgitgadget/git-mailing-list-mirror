Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5EB175A8A
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 14:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411589; cv=none; b=DoHie1k4TrR7AWWdtiSiUkjItxpnk+BCEWaz0oPTJHo1Emlzbv/1AnFUCrLkUojwaHFQZkWhFqxeZPtQpWZcalYgL48RVzeyjAJrfQ+0a9otEeLbqptmu+z6hVmyrAy9/BeKcWUiPyaIgccW2J/Fp1veSfRbwI5Y5KnZBMUMU+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411589; c=relaxed/simple;
	bh=aL+VrGdmgcE1P+JF0LhWj/Nmx6XGlnha82/vZCtcdSM=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=J+HB/UWnYQvCe43d07WOuljKSF/InadQxquQSki4JIF6EdHAkvqLPUTtE8iMfZGhTbpFDnyiOuBz2bIS4Sn/d495YU8dvAsUQ6Kbre527iuAzo6wjfMQeBfsyZczcU+lwkMzlpyVQstrQnucf7m+M0TDOZmdi7onoVf0L97VVsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=HXqwmYrr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ku1oKfV6; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="HXqwmYrr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ku1oKfV6"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 787A77A018E;
	Tue,  2 Jun 2026 10:46:27 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Tue, 02 Jun 2026 10:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780411587;
	 x=1780497987; bh=E7MPuTEYZI1XsVdi7eCs62198oc599EPj+bf3gcmhkY=; b=
	HXqwmYrrhe/YrNahVqd7AxJlHKad5DQnwGzMM+I+4aJq/jW44vHUIrxN7b/5jRvI
	RPosFUGJdmjBd3ksE4SUIpHLoC8bWzk7nH5qBcpT9yOPySSvUw8VC4XmOGp4f8KL
	UwwIsSJzRwI6kSoPIF933z8SNPczJmTJOTaCSo3U1C8JxgvIlAtumX18kQKWcAql
	koLEsZAkN760x/YBd/Y4Ic6wy8DwfbsRpFPysgFxmuPTrUKCW8vt/FaAA6Cjw0YC
	oIRNrxkE3Xthei3U7/N0QhGc/5HAJYpTHxLKBe6Zff+ocaViUFNflXX6ZBTNjkBu
	lC6VK5hDuji2g9LKDXY5cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1780411587; x=1780497987; bh=E
	7MPuTEYZI1XsVdi7eCs62198oc599EPj+bf3gcmhkY=; b=ku1oKfV6YBp1/s6vF
	ApusxLFObKd839wvW2T4NodLeuooAi3vsQkZFsnKup2PWohn+nCoO5ZP+AZ9BOgx
	Ydgmfn7rchpZQRJgctX28PHOcNMHZwN7sZJuVQBX1dYF3xTcpfVv+DPWM3qWN1T9
	MVomZG6uDymfO4xV2AEA00LINUsRgqS/yaYCEzxx6sKfG3tR9qKaGmOj609s7+Vx
	oNEzqR8iGwIB5tabKpTB3CKplSyEev3ogEhOTDmY5QcJNky9w3MwvC3lL9lAoYUH
	3CWhyiHvud0SmrTzWBoj6v2cmZEgrWnxj5BZfGxq5Ay9c8IBMKusXQZYY95VtidG
	QSKCQ==
X-ME-Sender: <xms:w-weagnsqMymAimTRKLU2Eur8xM5jxstPJyPv_XRRZjJy6qLQmPaG_Q>
    <xme:w-weaqpp1ynxAVhV92NPDPfh3tL9wMJoQFni260jWZT4qZjzw_slg_zR9rs7TQRIQ
    FYvzuBEpsmaYu6gZ0LGOrFeQ8kzKSlkqJQwDIRG4DC61xdcE4--CA>
X-ME-Proxy-Cause: dmFkZTEEMyfJ/TokG4TslS5WViyqBWiJLxNjoAkyElXdwtyl2H1ou+YXd8aWfCXFnTJawL
    Tln2MAJSFg/+87yXQu5ibvHqyJIUpWE8lmxkrkuTUtRgdRX34+4OAoroYM6lsejq/+SB1R
    VX+e+Y3mYJnSi4LSRh//IEI5+YPxslZe3qb2SI8gY92OXzky9to38sakGxjB9WR6fW/u8k
    lDhCIBnyLTOJt1O6K00+11fmL8t2IV2YuZPIO7P6MXQgyhfugzd7UKTYOoSKpRbZxQfu0x
    zh/4llf86kS6P259IYazPpatRAreLEl3OpdW/TQDdQeedU4PgQTfXobLV3PgfV0MUwNJa2
    0QpSFguJ5MNb+XNVgzJOjtYJYSM+Kw1wgQuQMjX+VJ05pxhED4SeCr0dE2B/XNCQKblq70
    x0cXd4CT9d4aZBOKXgpVrugHNOfu5G+mkKwfZ2AckgIn3+rd16Vmyz1ZGat6kwd5TO/1pZ
    6QSeOVP+7gDJpaBfx3iKpBQwmtrkHtD4RjFQWIkG41t/3ehXaRdlORcZs72th9mMLG/GCp
    Gg+N1cM4UydO7IgmK2BKDWT50Y+m7Bt1GUC6sjk5MYOEB5E0GTkTumVLTqF46Nf2lL0sLN
    mzP4aKE46Yq5B6owX8n3i58ykbiVB5UXsF5WHOGOGD1aTOM71rTk6kEXTsYA
X-ME-Proxy: <xmx:w-weanRnGpg7wGwL1aVtprlVhbTGCLSPjKul2Xu-oTq64I3l6kMqoA>
    <xmx:w-weamuN-prfto4G9FTyfZ43n3emzav_ImXialeqn7FkW5c5S-Oqzw>
    <xmx:w-weakbWJio5tVwTRbN0o9AQg6OYooc1nMoWBZQDeRvc5iUyTyKl_g>
    <xmx:w-weajsLLLGQenn_vi2oPzxTs8BEyUBYHJS3wVHoG515gE_3Y6ZufQ>
    <xmx:w-weauboNE3RExOgaDfMc65KsOjCi_gg8JxTwa6_bOmFdIjnRUCMXzE->
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2824E3020097; Tue,  2 Jun 2026 10:46:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AVgREVly4glJ
Date: Tue, 02 Jun 2026 16:46:05 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Message-Id: <c64bb761-a412-4ec5-a1b5-30f0893a3d1f@app.fastmail.com>
In-Reply-To: <20260602090808.87837-2-gitster@pobox.com>
References: <20260602090808.87837-1-gitster@pobox.com>
 <20260602090808.87837-2-gitster@pobox.com>
Subject: Re: [PATCH 1/2] SubmittingPatches: separate typofixes section
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jun 2, 2026, at 11:08, Junio C Hamano wrote:
> The existing text said something about tests (with [[tests]] to make
> it easier to refer to it from elsewhere) and then flowed into a
> different topic of typofixes, but it was unclear where the latter
> started.  Add a similar [[typofies]] marker to the document.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

Imperative mood?
