Received: from web23.osl1.nordkapp.net (web23.osl1.nordkapp.net [185.114.57.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F07A29E0F8
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 08:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.114.57.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764144371; cv=none; b=uR6rZ7nlC57Suwotg1/u63wFKkl2/BErQt7Mpvm12cBKt31qwJM/2THH//XNmOBFwHHivSJRnPR3XukyfykYAtKz7aGhuQxI1kiZKm/Vh/enRkoDwhbz24gLC4OgXA08IJaGIwi5gCWq1natROrPq/7j8jB7d8Vvvcny/n2vdkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764144371; c=relaxed/simple;
	bh=MBLMcTxAcg/saO0a6qP5MAwvn23uLMi7ErEU9tmiEgc=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=lQlkBXwYAehJrRSktzq/IhSzj7owIpFUZ8lEURda7R8L5M9gsvpddF+xLM/FrQdSNt9cdH40FBQqRWm4ASg/4wl4VW6+7Va//xNXaiPUxL/dLXkY7+NZmhGcGNRC690LrpgO/Pz7ZPV6cpMZ2fPwcWF/vRo8euILl814qMDJ2y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=softwolves.pp.se; spf=pass smtp.mailfrom=softwolves.pp.se; dkim=pass (2048-bit key) header.d=softwolves.pp.se header.i=@softwolves.pp.se header.b=MEZhWkLz; arc=none smtp.client-ip=185.114.57.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=softwolves.pp.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=softwolves.pp.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=softwolves.pp.se header.i=@softwolves.pp.se header.b="MEZhWkLz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=softwolves.pp.se; s=x; h=Content-Transfer-Encoding:Content-Type:Message-ID:
	Subject:To:From:Date:MIME-Version:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gnCPhVJeaf8d+TyhCUH+cqEBut94ieJICWUZYPIFLBU=; b=MEZhWkLzecX9RRsJtLlYCPsYoF
	3UxALC0PrcDfN+fx6sTLm8ahIWfImP3Z2b6SO73Z+aYrkE+gIuRSORLfiHIHqwZH2mOqv38/aUSSb
	RDHgn0Xq6cxTq6iwUvhIkVoVZrhHsH15W736UhL4LK2EQrcjda5q/xNNaoBlr1f+ZVJj/U0RuZrhS
	xDsFkLckymsZaI8InVIv5LyRnRtw2acKAaaEJo6of6po1FhV7hN4GFpWmWMAHcQ2dPTG/vT6hjvgf
	fas/KY3Rtf2VynXX/r1hWXkXyIYObOddOSnSA420M8OWHhlD0BDMB4QmDNWaJMUwwC64k/TyKxQSo
	gu6eMf1g==;
Received: from mail01.osl1.nordkapp.net ([185.114.57.50]:39606 helo=mail.nordhost.no)
	by web23.osl1.nordkapp.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <peter@softwolves.pp.se>)
	id 1vOAI7-0000000EZFU-2nzk
	for git@vger.kernel.org;
	Wed, 26 Nov 2025 08:50:19 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 26 Nov 2025 08:50:15 +0100
From: Peter Krefting <peter@softwolves.pp.se>
To: git@vger.kernel.org
Subject: How to localize "git push"?
Message-ID: <f2cb6da7c17e8de829c3e4cb066684e2@softwolves.pp.se>
X-Sender: peter@softwolves.pp.se
Organization: /universe/earth/europe/norway/oslo
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-Authenticated-Id: peter@softwolves.pp.se

Hi!

Re: https://fosstodon.org/@McPringle/115611195011002487

The message shown when running "git push" without any changes queued is 
always shown in English, whereas the corresponding message in "git pull" 
is properly localized.

I looked at the sources, and the string "Everything up-to-date\n" is 
included in both builtin/send-pack.c and transport.c, with both 
instances annotated with a comment "stable plumbing output; do not 
modify or localize".

How do we fix that? Having the message show in English from "git push" 
is confusing. What is the corresponding plumbing command that needs to 
have it machine-readable, so that we can fork that to fix "git push"?

-- 
\\// Peter - http://www.softwolves.pp.se/
