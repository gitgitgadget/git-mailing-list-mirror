Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2B0382397
	for <git@vger.kernel.org>; Sun,  2 Aug 2026 22:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785709449; cv=none; b=XJiYQLgjVUD+SCNP+etPwUzqqA5PgnlMwlttzwLO7SvXYPJJ/1O/moyixkpJbUeb0iU70rOufmMJ2poH+uKkGu6wAxN1coVMY9oAN8MBYXZXyfI+0dpJZknGsdkph5ez6Ie7kHjmNzriDASnVOSjJ09qmkuydzkJgLt9zRyRGuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785709449; c=relaxed/simple;
	bh=pngLfPyM1IRXr0iQHODz7BEKw0AsUXV2RpqOhf2LgTM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B9PaH1eOx5dUCUqoqRHprOH2sMDfLYq0SqpHuNFurVnCyXaAxcp9RwGdraNUmDUyadjmrW78n2WXShIza2eHxjVupgp3a+7UHzJwYrEhVpAUBpcvxdK8u0E+0T1OSLDQpu+Qw3Rj+krxhVJb202jcmkyNtx238cQ0cE7dwss/OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GPsKP1+N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xcww6dSW; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GPsKP1+N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xcww6dSW"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C738E7A007C;
	Sun,  2 Aug 2026 18:24:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Sun, 02 Aug 2026 18:24:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785709445; x=1785795845; bh=pngLfPyM1I
	RXr0iQHODz7BEKw0AsUXV2RpqOhf2LgTM=; b=GPsKP1+Nz8OIjhl7VcSa455fOW
	4OURFBB499EGLyoTZAf9PHOalOneE9Z2w7XsJi1O+a1Cy/Yc8mNDgj5Z5UE1GEPK
	78Q/7ytkH0xHXaTu2N/3Zgt93T3xtVEUjSUlS0e8LUnHlTj91yS5B54t3onZ+oz8
	RiWVdtGUNThfKizEpi7VxmjktziSavfc4E8ABWzEEVZd2jTAoAihPdQcTr+51tdQ
	LGxsGgrFpcMgvMEDg0B5mJfQf2l54bUfyt5mGkGO6jKtojhKPbi1YQpSCyjkn7l8
	v1oWrP8k9fb1U06dc5TUd1mWTdKJ56GEpqYrtCXuEuIZqYtuWJGWoBIR5q5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785709445; x=1785795845; bh=pngLfPyM1IRXr0iQHODz7BEKw0AsUXV2Rpq
	Ohf2LgTM=; b=Xcww6dSWJ4TnNf+4L27YRV4Qc40tjJyCDdCzsI5VFl77Q6cWV39
	8txEpIIfbue0pDut6dylR15zPLkA32cKzSve0JiO3X5+4ny1NzO6RN3md8mEQ5XA
	tH78q2QTpQ5onYYh/7OVEfG1l4YwxJ0iGCJ43X5IpTwOz1S575IPhdQQIH8SzR+8
	DcC0UIdargAmuAmJ6ZpKLoI0ZZpGKwg535xq7L2kX9sofGwgKvPWGMGKuLSe2LGl
	zdbVG9/Pne+PrBAR4PekYwt0qO1z1Jf6EFYcHJXffP+pVvqwA1yHPU13Gnwnkl6l
	vPoPnb2fsjl36d518/0QAy6mqqV25GTBhCw==
X-ME-Sender: <xms:hcNvahB3q4qvuLEnEaOEPfKNg93B0d3-v2qEs-vNXdym3NYr-97NrQ>
    <xme:hcNvajNTK7JzNpEDsib6EXZJRjknzfDdXiTlXJ9P3vu4B96U7jeuYoQ7brZhEQGjA
    bCPWucGa2GW93EnMHb8g-zCXxR94_xeSb_SVivGuFw01OVGzALd1w>
X-ME-Received: <xmr:hcNvamaZ-f6ewi0GiY-wkT1gMHHUq1sieMTobYEzoQtsDb7qM9s1jrZaDRHnkdeMu7DY62RAN9ZFjCc-mNfWTLnf1gDwjNegZQ>
X-ME-Proxy-Cause: dmFkZTFb/EDG4MrwAOp8cQ/d+q8NPNzJJCdWJ6bOoMQFKdzVNb/IbRl8iPl6ht8j9gDddW
    caWbsQf4L77NHXjBKkuewXZZLaksSK6fE0cAdcFduHYJssgmQfoydjOWJZFIaolCT6CTmo
    DwoDF68TTBsLMgsMGGwbqyS5C3XHizQsLoSZR7Uvhm/V0zhTq4QMcCO1UXatUqxHEuAO6/
    d36QVIu9YcF19HlHZkN7Zxuqivrj5IO+/wJ8LRrFG69oZFyQugCcgfOsNQd+8Fi4hxL10P
    YkA+/8MIuUk86wRwxWAWecj+RSpBzMb8E1vzY3umDFNa4aMsHv/5LXEa42wWPyvTTlZYiI
    78Usfsf8nH6u3KBzWUp/aRnInlWhbJUz4uesH65/JQUeyRaIgBj+ooP45BwXXy3gPWGyeY
    fFnVo5ulR2ZQ96I8eIek3UNODo6bvDrCBs961fn3Yz8dUnMRZmbsELnpHYBlbsA88OVLGl
    Vwr0DvLLOrNcCSMHU/1zxb8FK/cKnxOzGrvhjaqnxiuW81sfmxcHSoYaGfu+sbOCxHpPfx
    8Ne6GHlrlTbHpitvHptdt/3VCejc9htjc/3WXVQrYCeJBqTpDAzE4wU3K24BMsZektTXh1
    SL5ox9mg3C+Z08jwk2/xUfblWtFr7oP9hNLq3nU26B9zXXV8Y4YwRo48Gvnw
X-ME-Proxy: <xmx:hcNvaitkDZLWrCAROhr-dtJLeUkPvbkwy-WkgtFdyzDjUBZ8Sho59Q>
    <xmx:hcNvaoMXzD9v_n5lhGB9MQTRDiH2lzxYuCCPv2U50_VXQ9XdThDLog>
    <xmx:hcNvap7T-VxHHzr6dUqTGT8BYqVkxtEzC31S23RBBwxYc8ghuCpHjQ>
    <xmx:hcNvauSELzLg895RArgeymDFSXc1t_Ms8_zlj2vXTqkCsfgvSZsdJQ>
    <xmx:hcNvagxTFtLqgsl3IzZkWbYFShqft8CAR7Mgujv7su97YaFwtANJrW4N>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Aug 2026 18:24:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Pablo Sabater <pabloosabaterr@gmail.com>,  git@vger.kernel.org,
  chandrapratap3519@gmail.com,  karthik.188@gmail.com
Subject: Re: [PATCH GSoC v2 4/6] fetch-object-info: parse type from server
 response
In-Reply-To: <20260802163806.GA21296@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 2 Aug 2026 12:38:06 -0400")
References: <20260731-objecttype-support-v2-0-af577461ed57@gmail.com>
	<20260731-objecttype-support-v2-4-af577461ed57@gmail.com>
	<xmqq7bmaa0sw.fsf@gitster.g> <xmqqzez67yg1.fsf@gitster.g>
	<DKDYGQRTSF2W.25OU81K306HJN@gmail.com>
	<20260801231437.GA2097059@coredump.intra.peff.net>
	<20260801232941.GA2097163@coredump.intra.peff.net>
	<xmqqpl015lfl.fsf@gitster.g> <DKEGM4BYZ4UW.UVJ1H8IGVF0Q@gmail.com>
	<xmqqcxw04hjm.fsf@gitster.g>
	<20260802163806.GA21296@coredump.intra.peff.net>
Date: Sun, 02 Aug 2026 15:24:03 -0700
Message-ID: <xmqq33ww40vw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> So for unknown objects, I think a separate bit is less awkward.

OK.

> For signaling "the server refused to tell us this item" we could use
> sentinel types like OBJ_NONE. But I don't think that extends to other
> fields (e.g., there is no useful sentinel value for "size").

True, unless we abuse things like ((size_t)-1), which I think I saw
somewhere in recently posted patches.
