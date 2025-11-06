Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2D72C21D6
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 17:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762451178; cv=none; b=pS1A7oXebAg9/pH2iQHcYbjTEzY3bkyNBAUcPPTILI1KUMsiX+dWBrhC2OieOujWoIfUqi4ChfslMEAx4vIlUWWjU5qnzVhH04OU0SGt571gmEyLAwtjayebrs5VETyVghgUhpu+b+GRnSUO2fc0O4yW3HB1t47JH+72XxvisRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762451178; c=relaxed/simple;
	bh=m54vFqF4o2Cw/SIjzZUvVowHlIgKz2clNbfREzJFZuw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TaNBKpuFmdxi2mEo5+c6VOXzuGLHDlEeG13zZ6g4B6f1wjLSgBYN8lC/Vu1dWHUmUv4gSi6rR1YIgbPkU3PPkfOKkVichgugEfpQchjTOvcZxLlqIltdbKINYE64Y3A1ZK4zVOJMco3VvffMN+DwvG1M8K14mKZtpOsQ8rXy/F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dxd/ywhe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gNc05YLW; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dxd/ywhe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gNc05YLW"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5D27014001F3;
	Thu,  6 Nov 2025 12:46:14 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 06 Nov 2025 12:46:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762451174; x=1762537574; bh=SM7hOZKSn5
	AOgyTKMiwzDiCvQlb/KS7WWtLBTFtX6xs=; b=dxd/ywhe1GDLSt5huqUHG8004+
	+C0pGxkDiMMm7No/lRoFa7xLd5VihAdRieX6Vepg7ZASWMrGUXNgJ79U4IqOqDAB
	6Tfm7TThMnoaj8fGX/sQX63sL5UKJakXrY63lLe+YP5tnbigZSlLknd8Rk6jz8nZ
	4QIQ7H+c8Ohz5XSQHass6ipyH/9WMrfTkFn3RYV5JYhpPyY6jDJ0b4RxwqtMizxk
	l1WF/LR4R6aE57SnECxZemezo2Yzc6gSgC4/t3CX/nO/GyfZo4GmNgSxhHjb8rZL
	Jwrea+65sILBaPV/yRK57wvkS1dbUOBQQWN1D8nLyI5y/hm8IQkdvwK81j5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762451174; x=1762537574; bh=SM7hOZKSn5AOgyTKMiwzDiCvQlb/KS7WWtL
	BTFtX6xs=; b=gNc05YLWhA+gM8MYkS4+k8ZfBObzOJUPXfDu6Bqac6ZyOZZt2F7
	57hiCYAMPon2tYiSD0Nk0J6vUJ/kn2rFmfPP9P3DzsqpeLHkKHhhvkdpaV6FYChJ
	3enlQ0dbAxFeIE7REZyGTrP9INZsM/FkU3hZyjsUTE6aSXs6X/v/UjBfuaWqNbke
	grq3FCeATf4Az1XWBqwlHJMuaOYnVi+CQAEq6B+0HuAPRd3P1G/rslEt7HiX8f7x
	cPKvpYuhqTVNHxM3t5F8AcHCM8IpBV/ZIcjTLo/+IMipRqyt+sw1g8L/IQuO+ZHC
	BlOsrSOokVV5HEvi+lbJli1DRzFnNs9S22w==
X-ME-Sender: <xms:5t4MaVUhrYYKbqH5FrLbp14vR_HpVETLHkpPhrcsylCK83RBY8lMTA>
    <xme:5t4Macd1Mm9GYkRSswZG4BXfw9RXDin8umXLaJbexTYPXrdwN6Nj4ipUxyq6Myehf
    GYMsZvGH6v7q2Kmw5-YldFAcr1zIvo_Jsa6wpJQjg-py8c7DWI_lQ>
X-ME-Received: <xmr:5t4MaZuC03b4wYn3oSq4QDsavsp9CWD4yzf1LU6fq3VX_0jlgSe9MorVePRT6KQ2uQ0GjMqXS9RlhnLrutyZlvdOTn-EYDx5AOvX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeejgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepqhhjvghsshgrieeivdesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghh
    rhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhhsmh
    grnhdrrghkihhnhigvmhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:5t4MaT8I6_VaTW2nXbYWXcsHIa7HBC2O54WsetHYKoZjuSPu98vniA>
    <xmx:5t4Mac3ZpE8Kq2D2IPqW5khKG2W3iF2MzsS3Ic3yLRCTybkM-ZgheQ>
    <xmx:5t4MaQBE15c7Pi4Urgpq6JkqeHTcHuUFR6TGSO52xxISoM8cDZP09w>
    <xmx:5t4MaQc8-RO_EMOHoV55UJQH4THgHzC_TemBrCOwr1bEsVZ8dFwDGQ>
    <xmx:5t4MaTOPb9Re-ZQAqVMrF942QaE6T28ZymXNO7pIsP3uAY4GwKm9K5kf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Nov 2025 12:46:13 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Queen Ediri Jessa <qjessa662@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  usman.akinyemi@gmail.com
Subject: Re: [PATCH v4] doc: clarify server behavior for invalid 'want'
 lines in HTTP protocol
In-Reply-To: <20251105143849.1192-1-qjessa662@gmail.com> (Queen Ediri Jessa's
	message of "Wed, 5 Nov 2025 15:38:49 +0100")
References: <20251105143849.1192-1-qjessa662@gmail.com>
Date: Thu, 06 Nov 2025 09:46:12 -0800
Message-ID: <xmqqikfnhx5n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Queen Ediri Jessa <qjessa662@gmail.com> writes:

> Update the documentation to clearly describe how the server responds when a
> client sends an invalid or malformed `want` line during the HTTP protocol
> exchange. The server includes the offending object name in its error message.
>
> Signed-off-by: Queen Ediri Jessa <qjessa662@gmail.com>
> ---
> Changes since v3:
> - Removed extra explanatory lines per reviewer feedback.
>
>  Documentation/gitprotocol-http.adoc | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Thanks, will queue.
