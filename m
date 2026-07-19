Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782BE1519B4
	for <git@vger.kernel.org>; Sun, 19 Jul 2026 19:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784488925; cv=none; b=BkxiPcYX5KPKn//qLbEzeGeDOkkLJ/EPt0hFVdI8J8A3OcBnAsyjsapojW37aCYppeUiCGSQKvo2hBkffoDyoJ1CXo32Gmv+Rh+4pr8gFZkU93zI95Q7RlC03Pm5yX8KADyLDevZgVUAgac3w0ik1LPwQtyx5dMyP1BSN+g18SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784488925; c=relaxed/simple;
	bh=+GI4yZCBp3zgiKJXASJK1fs/SCboeR91BfGyRMewRAc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RWVVrix2tbushskhI1u2D0udxDFt1g1sBx+IuT5BlMzWrXPpXe7mD41gUQ8RIjQn9TFDQrSH3W3DK/ljnyHXoCTp57YZL5CRPWGW1lSu6Rp1ITi79z51TSSU+fsBKnQIUxqdWmnIiFmlFLvLs/qyWfXAW6wMN6o/9ehOlgE/ag4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LXMFu0Wj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qSyFhPl4; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LXMFu0Wj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qSyFhPl4"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 856FB14000E5;
	Sun, 19 Jul 2026 15:22:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sun, 19 Jul 2026 15:22:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784488923; x=1784575323; bh=/TojWiPINJ
	qTGXZleXBJX7Rjp6dh8lUlHJbX0A67KfA=; b=LXMFu0WjC3iOQyaIj2Hcjoaljb
	7W9Bwq0wPWlA1X5ZhVEFi6T7W1zQ6ZJxRv2VRtC46b0fDMMbps94Zfohv6zHeYnR
	GyhWBxOtmdqot5LGg9iGa2j6WWKkIhgQ8weVypunCzZXate9skiOIca7B67k7UiR
	2pHUVP/bzFS9YLoIhhmpxEMz7KV7EinPz+6FOr5DeuiClk4R59DvYprBHhGgcgfw
	FFdZB5hJl95y/FIR4kM5d9TLvRUkDZeHz1GCKIoWlltkDpdM9FiYwJE61ULjEm8r
	vzbhwhyD9ptt+anxv87tQ+JLYNXzb5GaQUVLNy6SVdwskWT9ZSmRvA9jBFLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784488923; x=1784575323; bh=/TojWiPINJqTGXZleXBJX7Rjp6dh8lUlHJb
	X0A67KfA=; b=qSyFhPl4ImroMRXgBbHngz5q28yQOXDaINQu+UXLBW085jQmvsO
	MEjs/VRyK1uz6Y7AjU6P/Kq5XId1y9FFHg0kCjOeNPrep2G7da/kL9RqdU389G7O
	jO6xvaogbujf0qoJUgjmo01/9AzjRbpO/Ekl+SsctA2SKTLG7MP5whieej0Mm+SE
	wV4kW0rl2KeMjbuUnfKsp/BtcdFCorwkheE8iuaSVvLAPjVKsNTFJWwXN+YMAa2X
	f5536kMBEBSOSRmqUsox7STRJ+xezuNkvsh01XUx7hUDNvcgePa2mAtWrezUEpJD
	U0RzB5dmD9WhFSR+9TLKyx9V6kmLswYqx7Q==
X-ME-Sender: <xms:2yNdaqQupmTnyTI5sl7119iczGwUXGMUIro9oAdYvr8YZbh0amlkaA>
    <xme:2yNdaiA4p15mHCU7HeLwcH2FPReJWBgeAb_Onqwj7DrGT6KR-1fAPLlw5MDUkV-Vv
    L4mB6lOSI92r5jGjJYGa1tnQFvj0sSXm2_s1HzlLvMUhmftAdovqUM>
X-ME-Received: <xmr:2yNdaqGBY_LZ99ZAcaHNZQJf03vKhjTen0eC2gacFw-Wg5StsB4qgGMc5xG3YZ3LFY8xlLuxsYRJCMHueSbomMumNVOOfAhFZg>
X-ME-Proxy-Cause: dmFkZTEi6+Bd+HkWlaF0xgm8pkUgnLVoavvQnHdt94pLIL8B4JY6NkU7lcskQ2JYOyU9VL
    4RQSRarv1YNWwJYsI+ckcQr7jiwmXxgBIZ2rG4BWA0wQTgT2S0TdlAtJO3w54drwo/rXu/
    S31CF4X9FfOwrQqOAiy1EF/FqxUIWt8M+eHx1eqA3oNLG6KggjzOoCKPgfkWSxQEz1ug00
    fGdumi/XsT9Pz3NFM6IseOxRIy2TiIxc/wnuuegRirQPnLtNB7XCZi7cN8PfkpPyBCAKdV
    mj473mkXEYTyi/PUBHF7cVkHTC08CjMyW4c4mBvgmXVS4X9BX4kfEvIG0F2wuuMZq2SShh
    +HRM+WvzbwgVsh3Y5Dayowzr72iyvVxUB6eGY9knCCKrRjyqHshQ/KVpGsoT6AEmph6X7W
    2shuBUvJRC7Wcq/bygRl+UL6MjRvz0g5jK//jPYuI1zRS4/Bp2hhbcUlV4YLc95J9bwUD5
    qC9Z6D3nMEpiRIqOuZVZhtGbpSZkcztLDGIl0FE5v1eauOmoK1URQWiWqM2EC9G30W6wsh
    q7tMr3Fh8UcTECM5YA+54249whqJpbYqQDAaKg/VY6iVD146RLgSfLB+/0euPYnvxxNHXH
    yStHraODfoZkooGhAGnhKTCPclh/Y2UV8xgaRVRmJHgQNZqLJHHFh2AnsXTw
X-ME-Proxy: <xmx:2yNdasBF8Efxri1zgMYqjbITfusQRWqTGsyB6dQ4j9cKpkqpIKbA0w>
    <xmx:2yNdaiUHrZTB5RepiV6JEPq4iVCSfwjqTgZB-kdn2sfFqUFRSTWKFA>
    <xmx:2yNdaoqogMB8bfeJCU9iwHdP5ENN8bzCSKEt5AxlNRTlMBXQvBg73Q>
    <xmx:2yNdamQaRg3XDjxqFRVPvbh0Cc8CKoutBRi7SL4VomX_0R_Oy8pPfA>
    <xmx:2yNdansl4u57cFv_WMbCJVFcE6UC3egS1431L22xJe7lVS7TLby4pXTh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Jul 2026 15:22:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Johannes Sixt <j6t@kdbg.org>,
  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v19 5/7] branch: add --delete-merged <branch>
In-Reply-To: <CAHwyqnXdaPeO12+p=_+_ttrknV0-VqTMnH-suS66yZ4stsBKnQ@mail.gmail.com>
	(Harald Nordgren's message of "Sun, 19 Jul 2026 17:30:11 +0200")
References: <pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com>
	<pull.2285.v19.git.git.1784053493.gitgitgadget@gmail.com>
	<a6caa5b397da8ea24eb97e6aa6dc92b437e456ef.1784053493.git.gitgitgadget@gmail.com>
	<xmqqtspvptqc.fsf@gitster.g>
	<CAHwyqnXdaPeO12+p=_+_ttrknV0-VqTMnH-suS66yZ4stsBKnQ@mail.gmail.com>
Date: Sun, 19 Jul 2026 12:22:00 -0700
Message-ID: <xmqqik6an5t3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

> I think I can fix this with
>
> ```
>     -+  if (strset_contains(data->deletable, ref->name))
>     ++  if (strset_contains(data->deletable, ref->name) ||
>     ++      strset_contains(data->spared, ref->name))
> ```
>
> I used your example to write a test about it as well.
>
>
> Harald

I do not claim that the single example I gave covers all the issues
that arise from failing to analyze the dependency graph, or from
attempting to solve the problem sequentially, which makes the
solution depend on the order in which branches are visited.

I have a suspicion that it may be unavoidable to employ a multi-pass
approach that iteratively identifies all branches transitively
needed by any surviving branch, though that is merely a hunch,
unsupported by any proof.

Thanks.
