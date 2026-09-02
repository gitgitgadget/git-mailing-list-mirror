Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479D549DB91
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 13:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788355290; cv=none; b=rVY2IPaAD2PLivbFEnU4WiXXbB+O/BZhobD4d58PC4ZvbJ/OnyWc8YQ7qCvAf9vGuaRnywCZ6wtTPdQlnwNsACas15EmT5orFyzw0ipJuTWK5ImIvHeHfyRM6uPNfS47qekSuznwaOmxBQHzKPXCNu+Te0G+LyJ77jKRFWc9h+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788355290; c=relaxed/simple;
	bh=8i4QuUupyhEaU0H/1RkkB0C9DCC7huziI8Dw/S1jpM4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=olnYfJWFIgobZfoo4Ez4znHJWlJNAaGZLbvFsDInhZy9xHUeNoXQY+i5eaOYBOvMCVt9JJY4l2W2SUj5lhmamlPy5R8xEi3yCNmqFFJQGG4OP603nYqQ9QI22Vg9x/vr+T2CvypsRYDSSA4H65hjp1GDVQRe8qhT7k47JtuQuVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=UhwlPHL+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e8MjDekp; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="UhwlPHL+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e8MjDekp"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E86DE1400045;
	Wed,  2 Sep 2026 09:21:27 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Wed, 02 Sep 2026 09:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788355287;
	 x=1788441687; bh=8i4QuUupyhEaU0H/1RkkB0C9DCC7huziI8Dw/S1jpM4=; b=
	UhwlPHL+kQNREuXTnx+68sXTgMjEGnlzyBNZQ5lMlvAWU2g0pbnTgsaA35ICnJx2
	8o6ZCA6ktSM3MkWgyVcz0T+NV++1ghmLTf8b2ARTWO/b6mRA92aHA2mZipiDIDCi
	FJm89lgeTc0GoeNwdDK3JL9lByl4ZxFjCJKgJFuVxdBuDsb56Ngisn2pIMkRgQXx
	yX913lHR5NeigHlnjbEPT5YG33gbjrZnh8m88Gjg5+bVGcXSNLx7fMeg/Tt5KOlB
	W1/b1W8KYLwlWxPokbUdhq+WUuBnBky94GHwpqTv7DuiEEAuCcV5rvo1yBQ7ySp6
	oQeCJytgSu3NgaFiFH9FdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788355287; x=
	1788441687; bh=8i4QuUupyhEaU0H/1RkkB0C9DCC7huziI8Dw/S1jpM4=; b=e
	8MjDekpdUOXpL+aQL2UdTpR4wkNr3N1aYRMeQc6XiMgWRb4b/Bo0o3UD5i0/OVEQ
	OA684RYTaSzrjn/bA92thA3xwV6b9nLvxCKyOoGS1clKw/DTrp58r2tDWNKPJXLf
	0yl/2+Af6qRRjQFQkFBVCdZNt+WNVYn6xAfDGM+ip6Y0EKZhDeoWnJuzg7O+vszO
	+1eC/j0gsHAWc0kFQ/C22cUf9KqMzyOWxzkbVwCSvtnjoHQutc5J9pEbMiy4pzZU
	VjdeOK7poaIJSuQux2v1QbmfTOfKGNEyn/N5CqnSER4rVMFENGHQXIxGZPpRl29F
	UAEpr2jlDgF5tEZw1ZOSw==
X-ME-Sender: <xms:1SKYal646Vo1St4Tpi6yDNgv7WJ2dx6Ps9DxwA8GkLnKI-LnlG8EMhI>
    <xme:1SKYatvHXgdpfqE-ojvYH1LrZ3WU73imFuPl_CcAf7DABR7n0c01hw2U-QzQ1jY82
    0aNQOOi3Bsp_XrPas6xJS8aur1K3v8pIJPHRhD9toF11OlplyhQFjg>
X-ME-Proxy-Cause: dmFkZTEFcHUWk/PGPtkVlY3YtcwnwzC63paJYqW5ExZFC18qNV+nMeGUwcRYwV9NXVGmcc
    l6k2R8HfDcwec57qv4rJVTqeZYKGwy2yxPbh6mQVL6eIILg5vfZKwKPO3dWuvebHP6wjtd
    G025XFs09vhal2QkYiWphp2YSRoizMlWiaNJpyQiLCC2RpCULjzUQpim3vs8+wtXZT25qS
    bLYrT/9ryAAXk2cEMqhxvij55+qp9pPflF01TfokigdyPsDEuiCVZH6ijGKRca2Z3kbYxY
    EtOFLSHsfeNWfdXGIV2dKOKS1kpJJCQwJf2puWVA9SdPCeSEnMix7TV91HmEGJUQq9cuBZ
    +Wn1HRBIjF+b3+NEptFErypdEU8NTsAJJpozOACKamG6GWhBPSNUsmE5hW5OCf6MrFfUVz
    NQsBqoEeQGqymsMsURQNMGqsjjBW9/2BlpVkW79yJrbtd0bynDHW0ntzDG01C3NbuqkUhd
    SZXsYFbkECWpEsWdkSUU0IW9STrgMMlPrfED8zXU69Sxwynt7GTLdggvadmF+L050THbTI
    kxPI0/gCYjPkKYlw7GmSqKJE9MawUxR4Z88Ht/ZiJItYquAOBB98v1kaZgvkqo1lJxlGXm
    6UnshyFecrhQYv6PKv24JHKB3PXyTHKApWt9u3rZh+19EWPp7MFOncoTvS7w
X-ME-Proxy: <xmx:1iKYakVK2BGcjFUAjNcu4ADvbiyoVeTBoP89tFBQkvqiirxabdiejA>
    <xmx:1iKYagUhOCJalnA8sCTks9HU4r6qV3xhUHUxDHqveyw94uq56ATqZg>
    <xmx:1iKYarcIjjAwVwaD_cP7lpyff-DeKWwqYY53RDNlX8jWsK0nG6A7lg>
    <xmx:1iKYahWhkw2Ct1D9im4AxpQXwEilpptv5Mn9tvrWf-AP8Q4B2mTOwQ>
    <xmx:1yKYauNUI0kMmoIlPVS1T3XQAn4b055KOtXvBobxFcMka2opm_v8RulL>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id C856522C007D; Wed,  2 Sep 2026 09:21:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AM15om2Krxhk
Date: Wed, 02 Sep 2026 15:20:55 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>
Cc: git@vger.kernel.org, "Julia Evans" <julia@jvns.ca>
Message-Id: <00afa5ab-0e37-4afb-8eec-d45e46dbd7a9@app.fastmail.com>
In-Reply-To: <apUrC_ROf9lyiuAm@pks.im>
References: <CV_doc_datamodel_advertize.bea@msgid.xyz>
 <V2_CV_doc_datamodel_advertize.c20@msgid.xyz> <apUrC_ROf9lyiuAm@pks.im>
Subject: Re: [PATCH v2 0/4] doc: advertize gitdatamodel(1)
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Aug 31, 2026, at 09:19, Patrick Steinhardt wrote:
> On Sun, Aug 23, 2026 at 01:32:45PM +0200,
> kristofferhaugsbakk@fastmail.com wrote:
>>[snip]
>
> Thanks, I'm happy with this version.

Thanks for your reviews.
