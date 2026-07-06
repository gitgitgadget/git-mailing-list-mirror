Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D323ACA65
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 17:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783359519; cv=none; b=DdFQ9fEfVSq3c9hLr5boWv9MLg5uqpIJSXSe0EdygnJ5xkjjXBEkwHbSoaKUR/M+uZRiaScZmeEh4tHkUcRWScsn7dw9LEkZtQm7IFlX33N9OCK3VNjvlyHhkrrhmaGWrD6EtDabLvXbuQo+o1ZI8abpoYG6TkEAaPKWYXD45OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783359519; c=relaxed/simple;
	bh=oXeVhgrjutcLgNWOV4m1LPB1eoWkLygagwXcaUU6S7o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Axp96KrH19rh82lT0mbTG5Te1G8SNeUa93e44HjqBkPogeJM3vF06HC2B83FMX4AFiUGqwqGxu8awsL87d6pqa8Bx2DxEfASKS8VB6gXCyvELS9rXNTyOGd2QBtSsDNis/JHM8oDyFHsedxBqWDIQtNBOaKLXEnZMMDRSnbEqLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L7ii3+vt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k4r5UOn2; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L7ii3+vt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k4r5UOn2"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 502A11D000E3;
	Mon,  6 Jul 2026 13:38:37 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 06 Jul 2026 13:38:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783359517; x=1783445917; bh=hexCa0LR/y
	8/ezhVsIiTjFkKPPcrLFRHOLT2CuFNGsc=; b=L7ii3+vtwzoN9c8fncRrewX000
	Eog7eYX3k8lMOZYWQeQSzpAyWn/qdBMyLsgEwGK09RbuaiJ1lAqH9v5E100+cLQU
	LWImLgBszJCHK8gcB5oa4VQlcAlj6caTKRJx6WktlP20zyQL6x0Zvixir6PvPyEI
	EYAM3eKrI4QRQgSlYlq4+b3bwZ5g8XRWODNArYSa/BAm7mWMQDjFWgmDqQeLZpGL
	GOl6HiN5/1nPn0pvlWLoMBMowSRCeWFiCXOcYmxr/UFNaTkQh/CAVN9HqbOFDqa9
	BJasYd4X1rpRr+IDpdQx0uwPADCDN90LHy3XewMmrU306KOZSWqfmfPVh06w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783359517; x=1783445917; bh=hexCa0LR/y8/ezhVsIiTjFkKPPcrLFRHOLT
	2CuFNGsc=; b=k4r5UOn2oyDvR9HuHefdxllgTHkC7ia+963JaQno01JdsPvEEc4
	nD1y0NVRpx4WBm2VMSELEtkJOwuj73AYmfKcmoUUtnGtO240QSujM4r9acfE1+Fv
	yqkZBy3JbueV1YTiM/SJ7AzTJW3loqKdAcmCi4oDI7ft8dII9vC9j+hAo3s5f0bC
	gcc8ef/0vBD18QT/SJfylE1/jlLp7pBYIxD0yg8fISs4b/sPSeDHn6Z1l3RsSc/t
	tXqB2m3tHDxIumhn6qPqISlQ0gxuBER9bz9ZRTP1kZh91qXHBywXl5kP8EOJES0f
	Fn6W5dKCKNczMPg76WBRlO0El8gguQBJTzw==
X-ME-Sender: <xms:HehLar280o0oF5Yk10VOnYhwNUWAKOFx1Nd0NuWbDrpj0RCo6glm9w>
    <xme:HehLapIl8SqS00Nz3GUTMXLXntBstmBejS927ioMvwhOxKZW3HR14rlzcmzUH1YKG
    hrXTY01TrwzGkoZcvYB-59H6A8Iz9HBQhanfy65XPAoIOp10-gHkw>
X-ME-Received: <xmr:HehLaiHpksIB13NxyyCvDoApGqa1NgpaAE0Qs75LPwzkOmTvRhekNop7KR7xmik5ialp3fCX6qy_6cBB7jQsVQjurYAkFMz0yBQZjCs>
X-ME-Proxy-Cause: dmFkZTGK+AKLHWwVlb4o8AhLdSdXx8IaBAiAJyoJtk+UEn8rMArQjFCEwXAlPGWQ81rgnu
    bHCdlIIihGxgveQ1mxV6GduMfKCAGmEofcUSc9ftU2CQu5AvYD00nJ42KvAQjHaL7YFzB6
    Miw/7whYn5hVt9LmUjN6kSg9RuCf+ycvDrvIph433Vb6GJsDWedV2nBCDcELwtbCwtcumh
    6kRRrZlkEdVrppOaIvMeRz6bdT4Mu9GS8RQ21jBxR230JdBGRqM7LDE6iD+l60JGAbrir6
    CG49yQ7v9ayZRRBjlTgb4qsT8gZwBKjj45ufOhxeCwPv7z4Zr/nivZ8r0V75nxUavYEYFM
    K1eGt7q5HgrYAykkZlhxdbdAfleHUHhIOh5sQV1Fgnv0eCLBxkdXzshQbC9UrvJjSpnDJO
    IeCiVQeIdJhnDKUnVKWm467Q+VjW3+GNgoMpgaKoqfyX5A5M/0EcD1OqINWZcRaxjRlj4A
    naNccOxcVYieF19DO/B6Irshargk25ombRnYBgCL+OUipWqPsE/6o7KEx+kbmsp14LRcT8
    pXw+08dZou4IhFbIxuCER1MUKh5uvplWZWtZ9Ucr6IPk3YAOQdkIS2GyUHZ3BIpDO1k/zI
    WeL8Flf7RRIgRdXnzP0hovKRHVKwlZZFdQE4gVAl+O08aWwgHi4ffTmXPNHQ
X-ME-Proxy: <xmx:HehLatUGVtNVBpkxFcJHM7lMC_kCLFPmJ73m-f2noUnHvvtKhdd2iQ>
    <xmx:HehLaizVXnCa5nqOIyZ4QKujxFcqlXmPQ8xCgrEkeOec8FIE-t_uDw>
    <xmx:HehLaqRJLplDNV_yy5D-BPRnx2Zq6mEXrU-9B4nMHDEar1WW14PUVA>
    <xmx:HehLamgD0mxObQVo9gUiWYWRM1OrlQbTcsmHACEEX9QlIg21ao7VQA>
    <xmx:HehLakicB_NZ1UWWDXDujYyzG7HNe6UA9DT8Fj3sSkOwTJBApvNbSQJh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 13:38:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org,  cirnovskyv@gmail.com,  szeder.dev@gmail.com,
  Christian Couder <christian.couder@gmail.com>,  Ayush Chandekar
 <ayu.chandekar@gmail.com>,  Olamide Caleb Bello <belkid98@gmail.com>
Subject: Re: [PATCH v7 4/9] environment: move pager_program into
 repo_config_values
In-Reply-To: <20260706142530.3681520-5-cat@malon.dev> (Tian Yuchen's message
	of "Mon, 6 Jul 2026 22:25:25 +0800")
References: <20260701180813.776173-1-cat@malon.dev>
	<20260706142530.3681520-1-cat@malon.dev>
	<20260706142530.3681520-5-cat@malon.dev>
Date: Mon, 06 Jul 2026 10:38:35 -0700
Message-ID: <xmqqpl10auhw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

>  	if (data.value)
> -		pager_program = data.value;
> +		repo_config_values(r)->pager_program = data.value;
>  	return data.want;
>  }

May not be a new problem, but does the old value or pager_program
leak here, if callers call this function more than once (or
pager_program gets assigned elsewhere)?
