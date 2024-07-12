Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879F613DDDB
	for <git@vger.kernel.org>; Fri, 12 Jul 2024 08:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720774727; cv=none; b=RkVezZaFJsTArGfx2ETFfeotfHo00MF7cNNVKzYRyyt5n0F7tC7PoHpOZY7EKUb8UBR1jsTfcuEr7Yz+EkU4n0gQjN48LBuj2fcBFpDTDZexDJcVlegxBO3Gvca+G0XMZ0CLA3pcJbRhklHFNHvbuAa6W7d38g29z65/amvTDk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720774727; c=relaxed/simple;
	bh=2pmBPN1tTf5VWVPlBN046giGKGru1XvGICrk5VnywN0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=sXZloEOvQpL13yeudFv/a3TW7xEnGLrJVDaQaJTK546GxkvEXxDU5cUsByNSywbz1WUkyM3v+ZlT1m5YpKS3JgzfNgRR2OGhbwVRd9AsTzIEzol82YNgyjdWPB+CpCud9Bt/3+fouJddXk6NT/xMxmKIe7T3/TBt4UVfyG0N8CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=bEiZCD+b; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="bEiZCD+b"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1720774722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FrZwUMfgiP94I4T29xyolO8aRX7lYci/stDwjsopE5k=;
	b=bEiZCD+b64uzSTUeZUhXggexNtYwAht8KUHWuRPR6d3g4EUpDJcJn0md7iROSCs9EBuPsm
	WtLhY5q0tWr6vB9cNkzKg8PsoNcUFxCGx8R1wYaZLpUqMHXyrsWrkiPa0H80cO6GJah+VJ
	xaRoI/8swFkoRwtKzr4x6Hkm9D5He4jOEczJsCCGosmc8qd+KKCEtejgt3X4BM/bEuXZNF
	MXpXYYkKaYsDYk6eLrLdjrIduYfidiouveZRezR98tBcfP+NRVe9Ql0Ws+bh2f20k5Xi8k
	RkPyXFAZeRPniMs8QuQtsMKN+2KS7gpNa5VeriO2tKSdIuu3tMwMyRxvejKBog==
Date: Fri, 12 Jul 2024 10:58:42 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, Jeff
 King <peff@peff.net>, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 4/4] add-patch: render hunks through the pager
In-Reply-To: <5effca4d-536c-4e51-a024-5f1e90583176@gmail.com>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
 <5effca4d-536c-4e51-a024-5f1e90583176@gmail.com>
Message-ID: <3776d430faaee9b68d488cb11252d6ed@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-07-12 03:00, Rubén Justo wrote:
> @@ -1391,7 +1393,7 @@ N_("j - leave this hunk undecided, see next
> undecided hunk\n"
>     "/ - search for a hunk matching the given regex\n"
>     "s - split the current hunk into smaller hunks\n"
>     "e - manually edit the current hunk\n"
> -   "p - print the current hunk\n"
> +   "p - print the current hunk, 'P' to use the pager\n"
>     "? - print help\n");

I'm fine with this compact form, even though it diverges from
the "one command per help line" rule.
