Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C5136DA03
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 16:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785083694; cv=none; b=a1KEehhjEsivpsQUm9eNRA776RRtX1BdRAUiZ8dLxDS0+LVBRjTrZha+QdtXF4JuYbpMVCVdiCX3POr+TvOsH1/38s19obBC0vziNVuLRO6Pksca/63ZFGr2ThQXhF34wccah8HPP0EdcyVndnaxGstKmbWA34liBIZaK94vv2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785083694; c=relaxed/simple;
	bh=3LMPqVfRJAwAUgs6+eEEkfshZPCTLsU4ktJQJC+oaBw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dcw/cOhnxcl4bUrv0Scu88heCREExGb+owiLpbXKSAQ/jHlDvpHp/2ITTNyxMQMX0gYI5zuxJtsTOXa8I/NMSNogb9rd1b8gpfYO51Ftdp3VJo72TECdrESucjk9rRl4Dr9nLEzDm4q6DNQObP8KPOXtQ4qZIYF9PI936LKNShg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=O3VMl0cY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pfG1h6LN; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="O3VMl0cY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pfG1h6LN"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id AB8B5EC0072;
	Sun, 26 Jul 2026 12:34:52 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sun, 26 Jul 2026 12:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785083692; x=1785170092; bh=e0fFdTXPuG
	/vdmLEYLwe2k/E5+xpSfHjP1E7nbrjAV4=; b=O3VMl0cYuOO/E6gB4Tx9QZELoF
	YhZeBFkFzDGb+2rx66ISo1SIhCb/KrK08PLH/Fe1d+AyeFWzibLZ9L+JOdILHt6T
	95LEicf+paymtIBf6VZpIj5mXk+kW9INWDHfTGrcCF9ggjT0wS1JrGQsSCqIwOT5
	VZ0CDA2wZWEWGaKEiQ5wYxEzHgJ0S9rrFmcsV80+E1WTgxynk867XE3fMUskwEeV
	CseTtDl/sDaKBGEr0YiTrw15bu0LmBVnSJ/p3wDOtyW9YJ9Km93xPtUf6Bf2roM2
	va8hF3sxiA3vrfBU1twMj0v1wm0FsLXXR5XaDGIqn3afPJ5YxBhC3AWVk4tA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785083692; x=1785170092; bh=e0fFdTXPuG/vdmLEYLwe2k/E5+xpSfHjP1E
	7nbrjAV4=; b=pfG1h6LNaAquCi8JIfd4zC2KlOdFbpCKgZYx09vpfsxWAk8hUw4
	vSPmNTiJMjlGDqfTw1WzaCyyKgCdnfkgWb6c3QkixnqgG8xYkDqLG/KuMo4sBzCI
	P9DekQJ5JKWfpB/Qfi4NWZ63PUCVTebA+88thzlrcyQXWS6HZQ6R1jgUvQenKlqO
	x4yHDtUovueVYXAIbeCPfvqHDxoGLCS+nuzPMI/+FbjnmZ6q8oiNJVLI09Y5fS4F
	psmys9qREvR25VIV2EdwrKzC9H/RmPwBzertF6LdmQ1fYFZ+tG4ASDoPnWoYtbZK
	ZJURoqr23MimfdGQqHqXBk4lviIZmmKKSVQ==
X-ME-Sender: <xms:LDdmatRSqAt5xfONakbMR7pUe1rrJV_m_V7HkJfzMUwmp9MpdQvHQw>
    <xme:LDdmaqf99ltOARwQzkzhGw1wdUDPxEXuigIYbMTAz2hwvcu7iaEtgngi9sSzMXna8
    u9kCmoKuuFbxFsJSXrte7hqRNRcb5tF-iUb5jhakEKcFBAtmGjQ>
X-ME-Received: <xmr:LDdmaspkxQByOxklk__Nj0J8yX8UpOhp3mSljn2OOb1tz674FPzrvzyz32_LiP0oyLJy7CAxthoO5cgy-paENsQv87GHxm8nug>
X-ME-Proxy-Cause: dmFkZTFQaOAdhCYDFVKWKLUO19H++sgZYyzmhE8vOeT36FuBXxiQcp27EDsQwSroJnl4XP
    RtBOgqG7tciSWcu+2caF4C4Hkfnqt1qPkK3vpsg5e+GNsMCsTCFvtvng5eQzjN6eDLnYNP
    HV2DfcUqfalU2PS9xUqk9kGGeIyEPgRaChr0UgXIJaKDiCbgsGOLVUQtDhYFMyZLD38iJL
    ztx8xCuUXBGOftLDink91YA/c3YUx1N6+gCOP+sCnDVbCKBVhqqRyq1b4qOqW7rVw0K0Li
    R6L9GxhtLew+YKtGRmJiu1zjqmC7P+SFhOBz/2WXL57zNp9nGxc1C+eTMojKE2pIfedmsm
    yhoIk6alnzZGssX+KeTkBEXB0u6DnCHkI0CYgW/1CmjWyUHE1b4tHWIx7P2GMZgerpR6FT
    Jd+2uStxBq0w3wq8Lj5ZznANQpS04DH7nq04FO3MhSI0iqC2udko/Z2k0a0XxKfYO31UFF
    z8Qp5Q/UEwJu7Fgx6bD9KviCc9HcPK3cHp13nJhp8cqdHN2YNvxjbcE16cd+oveZVph9Eq
    WnotYLl8na4C0om8dCGZAeZQ8ogGmKYcB9M24RXylTipIWuseawjn6NNRYjFwOmp13XFMb
    GdwqBCaolXcJbKVjyEg+kQdBM3pei6Pd43RFZazGrPGfL7wUq5uWckBunAuw
X-ME-Proxy: <xmx:LDdmar_VvqYPycgrwhw5cHI6liSBhwgHbbLdG2pVm1mwqhBayKwscw>
    <xmx:LDdmaodr1IcMev-pqGukt0cGDOnx02J89qHxia4piX2qwfMO1xHsmQ>
    <xmx:LDdmalIxsW_M0u9gYJ0PPtZWaLX34cUHeZxdjqJXXt_SC0DB_dDpYQ>
    <xmx:LDdmaogiYmIBBkuKL5clHI8S1wKDVJ-X1PyYcF_hU3lkBaEPD9H9PQ>
    <xmx:LDdmaqJj7al8duodkwmGdAkv2QeY423BqBKcnZrQTVmyDrPV7cf_T01t>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Jul 2026 12:34:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  tnyman@openai.com,  Taylor Blau <me@ttaylorr.com>,
  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/2] bump static-analysis ci image version
In-Reply-To: <20260726083254.GA3528497@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 26 Jul 2026 04:32:54 -0400")
References: <20260726083254.GA3528497@coredump.intra.peff.net>
Date: Sun, 26 Jul 2026 09:34:50 -0700
Message-ID: <xmqqo6ftvhed.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> This is another way to fix the slow coccinelle run discussed in:
>
>   https://lore.kernel.org/git/20260724091152.27794-2-tnyman@openai.com/
>
> by using a newer version of coccinelle.
>
> We tweaked the code there to avoid the problem, so this isn't urgent.
> But it is worth doing to avoid running into the same problem again (and
> because in general I think it makes sense to run newer versions of our
> dev tools than older ones).
>
> The second patch is the interesting one. The first is a necessary
> clean-up (+cc Elijah as the relevant author there).

Both are interesting.  Thanks for doing this (with relevant
archaeology as usual).
