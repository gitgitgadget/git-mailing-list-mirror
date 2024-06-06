Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6181C71B4C
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 20:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717704755; cv=none; b=PwPOWxaqYMV1USLo9TFwfVZHA5d6uUW2Am9Xw+Uu+V0CCgxmfvINnuCROlHGxMrYv/GvEeu6LWMVF93ug7XMOJkzpsVHcaGE3mxEmFMsbRpptJuqoiR/EzHhPpwgnmsWvzqKx/wrGJdLQI9H+cW3IHH7AQOlb4HxsSLhjOD0m7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717704755; c=relaxed/simple;
	bh=IzzbclxxHsj+IMolf1oUXHMV+xs/PdeCZSJgTaRMD3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ck+emYd2FqC9INlJ6ykkwbsG5Iy60bi6uFbPGmZ7+2A4jIkgxoeaC8iOU/8pj9yWojHUtvq6zHNJPeRd3Hm7867I3iDoNrv7xHMHn73DxVTGdjIwWeM+kCbRcZ6whalL4qSrYF1qsqugDh+lofP9s9BCOzm40jASldS4mHdh87U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=kfJq6ini; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SzO+rGaL; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="kfJq6ini";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SzO+rGaL"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 5D9EA18000C3;
	Thu,  6 Jun 2024 16:12:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 06 Jun 2024 16:12:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1717704752;
	 x=1717791152; bh=KLZtCtIDSS+umkHfWdJRrEZ5cRFoumNYjuExAiuccjI=; b=
	kfJq6inidBs/oXEdzBX2DCIHrfv/jaepvi0A1XWPIuZeRPoOdDDXW2Ekb7Q7m5va
	VvSsqDTe0RtVoPnRg1icrgKCMQ7bi3S5AynRLC237X/QimjdQ+Y0lFoj28+YTyj7
	ptnnTc1psFKLeSVJmWXvKvs3IzaM/TiSfBJ/TwfhBeWRm6xM/rgmasABgWaAZY7J
	nQsvT2vWEP5ye13YQ/d5EaJcuVbGjZ5tGQZCnxW6JraEhPlSSFD2Sf8UjKxFe+WV
	tc/y73F2gkaLxVhQxxRLHj451rDvUZd2GRCsDMy4rOXKU6QNHZPVdwYJa3SC/72l
	w9r2GSDdF+UH1EFP+m7vQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717704752; x=
	1717791152; bh=KLZtCtIDSS+umkHfWdJRrEZ5cRFoumNYjuExAiuccjI=; b=S
	zO+rGaLrpkpdVI41tTiVLT/2tYpyOJF9pKbDoW0hZU8S8CE1HrpHHVpxF8Ka+9fr
	AeMSwPLmHm+4pT1+wFMeCLR8S2IFI8eE8RHcKRj60v/af5dyxeqX5/xR9FKb3Sf8
	6C/5xPiheOzq2DkbqOYbjB8P79z6p/p6o0LwU0S06tcQrFLRfffJFP3h9esSBEEb
	v+9bHjXTo9REUy+XlD7i7i+Dca9tCk+oRnnWq6T4/m1Z93HZsGxqMfuQdSZtl7EA
	a2Us/XRXXFxdNK0KJbaE+qa+rkcXfvPEHfvaDzSnQfAijyLufoNzq7Kumafa5olp
	sLCRILaZ8v3+QtVKxA8WA==
X-ME-Sender: <xms:LxhiZiycDTtLFsLzHd_Lvi6sctuupm0m8BC2YJ0gYicdFCfaSSqzww>
    <xme:LxhiZuQioceYr17EYw8v-2erpXA5DoTjgxspehTcSBbfUZF5Xwm46RBjLk8D9Af-K
    loHmAR6e6g>
X-ME-Received: <xmr:LxhiZkULhZ5GElCA2c-URsMUnKVdfrRXlvFX9Ot_r-aRqw_8pu1wqUZ1gk6fx79Lxyp4A2pLIUMsnIbI9_KbMPc8WFMK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepkfffgggfuffvvehfhfgjtgfgse
    htjeertddtfeejnecuhfhrohhmpefhrhgvugcunfhonhhguceofhhrvggupghlohhnghes
    fhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepteekledugfduheejffduie
    eugeelteeigeeujeegteegfffhvedvieeuhefhteeinecuffhomhgrihhnpehgohhoghhl
    vghsohhurhgtvgdrtghomhdpihhnthgvrhhnrghlqdhfshdqlhgrhihouhhtrdhmugenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfrhgvuggp
    lhhonhhgsehfrghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:LxhiZog2RYU9oUkinHI8j6fWCWOnDN5tgj-4rXO5Irb0wK0hyEw5GA>
    <xmx:LxhiZkAsGl8AVpw_ewzKVyKcz00KnlnbBd-jgOenBMXesYqmFcEgvA>
    <xmx:LxhiZpLzzM1SM2QcLqNBA7kjf9_wzLh4i3woDvR3r8pPVAr8wJvFWA>
    <xmx:LxhiZrByTlw39mD4LccnQoqYTqkU0PokiutGsl7F-Dz2opAyNcEkXw>
    <xmx:LxhiZn-nudfDOEf0iXK1Xxo2-8cAs-L8piOB1NqWmWe1eHjyGpG_-UWm>
Feedback-ID: i08fc41ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 16:12:31 -0400 (EDT)
Message-ID: <5469592f-69eb-b1da-1218-abeae88f7303@fastmail.fm>
Date: Thu, 6 Jun 2024 13:12:31 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: git fetch --prune fails with "fatal: bad object"
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, rsbecker@nexbridge.com,
 git@vger.kernel.org
References: <16919-1717194882-875013@sneakemail.com>
 <xmqqplt1d0k0.fsf@gitster.g> <000501dab3b3$51779400$f466bc00$@nexbridge.com>
 <xmqqo78kbqwo.fsf@gitster.g>
 <20240604104437.GD1781455@coredump.intra.peff.net>
 <876fbb07-210e-128e-5289-57ab01761750@fastmail.fm>
 <20240605084718.GD2345232@coredump.intra.peff.net>
 <c2a02982-40a9-6629-05c2-c8de3335f35b@fastmail.fm>
 <20240606011453.GA623737@coredump.intra.peff.net>
Content-Language: en-US
From: Fred Long <fred_long@fastmail.fm>
In-Reply-To: <20240606011453.GA623737@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/5/2024 6:14 PM, Jeff King wrote:
>
> Certainly this warning is ominous:
>
>    https://gerrit.googlesource.com/git-repo/+/refs/tags/v2.45/docs/internal-fs-layout.md#project-objects
>
> -Peff
Yeah, I saw that, and I think I know what's causing the problem. First I 
create a bare mirror of AOSP with "repo init --mirror" and "repo sync", 
then for all my different source trees I use "repo init --reference" to 
share objects with the mirror using alternates files. Running "repo 
sync" on the bare mirror works fine. The problem occurs when I run "repo 
sync" in one of my source trees. Commits and refs have been deleted from 
the mirror, but the refs are not deleted from the repos that point to 
the mirror. So it all makes sense now. Still, I wish there were a simple 
command I could run to remove the dangling refs.


