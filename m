Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E63922083
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 23:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783813054; cv=none; b=GdG4QlgOzAtM07xN1owRslOcJeHcyjVHSCamuX6UeyXhy8jLXncYMX+Ht2wrnXQtGWmauimZSjzXES87Hpoce7ENpUpSz6DiYaWKQvQaNlBSYs960hNGYOLMqn4fdj44cJ59YgCUar6g530bo+J1lyOtJ1kumtWSLaLMbVSiBTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783813054; c=relaxed/simple;
	bh=pa7TgP2tDAdnXuPeuSpnUcJSei/1ftNHk1p+6gkfXyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g/JPMvVUlVrcMw7arU41RbvuiqWM4MrK65mVDeW/OYjF7Oj+sO7ft0/t7j5aKdiw+nj91sW9GHjyEcCl+5The5Gg5eZmaYDXWw65dykrx5mwmswVLCbqlz5eTIu/UJCpmCuEGLTX8Tx8+Gxg91zNyS/+pxIheEqbCg+iYn33cl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land; spf=pass smtp.mailfrom=howdoi.land; dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b=BjePT1Mc; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howdoi.land
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b="BjePT1Mc"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <ask+git@howdoi.land>)
	id 1wihG5-009V2c-Vh; Sun, 12 Jul 2026 01:37:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=howdoi.land
	; s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=pa7TgP2tDAdnXuPeuSpnUcJSei/1ftNHk1p+6gkfXyI=; b=BjePT1McKbVzQKS64cYiktiNcK
	rxnHQjObdJFptyBwf/fdFN+gAk4ist6SUJ8hof41yAg1HN0UiqWPb3Eg6ODCWGzkUjxjPcMaOmXe7
	21RBFQfUDRINT4AyaPvNrNMYXSZWoHqtVTFlEg9Md5rxYO/QedPIHJGdVEElo29QvtOIsyOz5tSwZ
	X7bktA2+g41x2j/LY4MIzLl0C75HN5+oifDnXWgwQOzBcesQpzsfzZFpr+SS23qs1U4vRHEo/xut0
	KGF3926cpePCJBIvp6Jmpas+FE6mjyPFzhAD1B1o5xeJHwRJ9CxE6UWZxP/EWTJy8iNh1oaIx/rPe
	Dy9okPZA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <ask+git@howdoi.land>)
	id 1wihG5-00072a-HB; Sun, 12 Jul 2026 01:37:21 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1204229)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wihFu-008XJx-1K;
	Sun, 12 Jul 2026 01:37:10 +0200
Message-ID: <a8c72dcd-f8d7-47ce-a4b2-ebcd4188875e@howdoi.land>
Date: Sat, 11 Jul 2026 18:37:07 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] git-subtree: Bail out if we find output from Rust
 rewrite [and 1 more messages]
To: Junio C Hamano <gitster@pobox.com>,
 Ian Jackson <ijackson@chiark.greenend.org.uk>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20260706115816.20267-1-ijackson@chiark.greenend.org.uk>
 <20260706115816.20267-3-ijackson@chiark.greenend.org.uk>
 <9ef8cfcc-ab47-479b-9f23-71ba99e1e56b@howdoi.land>
 <20260706115816.20267-2-ijackson@chiark.greenend.org.uk>
 <f557bfcf-ffd2-4903-8015-97fff97dbe09@howdoi.land>
 <27215.27575.968985.583226@chiark.greenend.org.uk>
 <xmqqmrvx86wi.fsf@gitster.g>
Content-Language: en-US
From: Colin Stagner <ask+git@howdoi.land>
In-Reply-To: <xmqqmrvx86wi.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/11/26 18:04, Junio C Hamano wrote:

> So, is there a conclusion after reviewing this?

I think we're expecting a reroll, but this looks like the way forward.

Colin

