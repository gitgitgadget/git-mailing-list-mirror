Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00801273F9
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 00:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738800293; cv=none; b=N4Hc3LdMows1ak0EwCfC5X/OAPVoP2qjnazocqTKZtvIETKGZXoiWijGzb16bA2fBCDZAkBGF9t9ypr8X0r+WJCI7fJWmZqFDaN4f+qw6AUlbtyElGiXZOq4oW5puuKseaf1bJkVxRtrEuUWphNvNRUtMB5PawEcgB9gAo/nAPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738800293; c=relaxed/simple;
	bh=kNOop7nlycCd1YMBjBKzhMbmrRi8iERGauFNlbTOYM8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kV+YQ5uVUNcsP0FwzdURVuOOYyx+eBa3gKgt6m8Ve6pobUxGVsGq6x5qaArx5aVn38cgz1x0BkvyVr9DMCW+eEV1EVyNOhz2NDYDASXL2hSWtyjg1ZfmmGUlA3Eg9+pZqyM6ESUqlftKWmkWsho5qmP7NhYqMSf9Is684amP/6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ud9Snzd4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wvztHsv4; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ud9Snzd4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wvztHsv4"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D6E0B2540150;
	Wed,  5 Feb 2025 19:04:49 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Wed, 05 Feb 2025 19:04:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738800289; x=1738886689; bh=d9Bwa3jZJv
	CnS2K5apGHouDRnHFkI7VGwaUW1/S0yaA=; b=Ud9Snzd443HZAQaBb4Gm9E3ohZ
	Kh5ho2OdCzra2IF0KgUNiTWr91+LXYfPmDmgSytkEyr20yuUOQvdE2rmfHWjE0Hu
	RfU+X5LoL4rdlNhCoHTMKPY7AaAQ2nZYJpA36YDRRWSmDi1TAY0HWy+bls/3dsrS
	sb63CL38HhkxinRwARXXDZ95hRJVwjbpx16JQuO0QNBltzSK/cEgueJb70dQ1l5a
	Lx9swWHV2NLHaxm286WR6olAuVgSRCaapzY0ie5GrH/Kqst6prn0BHHQcQRENUvy
	Klck4l9Hwr0di8eaNdf6ODfBvb59WhEN/+DbOr7XBsBJPhbOARoOBJxh731w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738800289; x=1738886689; bh=d9Bwa3jZJvCnS2K5apGHouDRnHFkI7VGwaU
	W1/S0yaA=; b=wvztHsv4rm2R5gTsCU6fvsYYm9uo8KDPPQtQgRbWLVkdtlQmMEO
	Hzxar9AcapjC7WGnnZ5LtVKwYRB2ZDa6ypk3K+ZcVOGmu4LI7hUOcY9Ahu1chQTJ
	9eJbJ0c9S+N4M+68g/IFCBJNqbLwKbi3dN1RCU0OjglyZItatg68V+GJe/vhFas5
	QGwDOKKEjeV4brNCbuBwos1l4qHMclVEnkPh/rDLLsff7Yf3otoqowqDPdQMUkuM
	f29cOchRG4ffZjB1L4vff95jbJa3yKGbFIlccbiMnSxqPQlHmxLYeaYiBrk0sBOs
	m0KvCtvRCgH/YaUyNd6Nox75yIvL4vOBRMQ==
X-ME-Sender: <xms:ofyjZ-krBWN4I85obSURM_TVhdpjrpKR_om50sSnr7lBsuuHkG2XxA>
    <xme:ofyjZ10kaZ9WOFj35mrQVLqlJ3diRmtlKfQ2XEhIqLAhfOH3FjiZ7alSayjWvLbZ0
    d_Xzk7awLQA_HYpVw>
X-ME-Received: <xmr:ofyjZ8phjHn-4KDE5Ze4qbr_0UEE-pGO8h0HuBiLkGRK43FZdylc26nq6oGD2AhA-RmYBW_8_EJK39_Aol9ihL9OFIKLg3tak-OC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehjiehtsehkuggsgh
    drohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ofyjZymLvHc3oDs9KceQsFn20KeuSNdltj5VhGzHfZ26I-LWW6WkaQ>
    <xmx:ofyjZ83aXXQboEsQ-fRGK8XCDZ1bIoK3OplIJgR3KXetOP7LU8NgcA>
    <xmx:ofyjZ5vzbNpisv4CKg2OcTBIhQrBZkdkrFX8YwWwuDmOuhFnrYxY4A>
    <xmx:ofyjZ4WMwlJ-HDcKz_lpxkKAgwL94L7lai9HC5lJAPdno-Gi83sXuA>
    <xmx:ofyjZw9kt34bIdi_Vm_mgS3i0t-dyurOXlV3NQmvE9frzwQeX2avLEDB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Feb 2025 19:04:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Justin Tobler <jltobler@gmail.com>,  Johannes Sixt
 <j6t@kdbg.org>
Subject: Re: What's cooking in git.git (Feb 2025, #01; Tue, 4)
In-Reply-To: <xmqq7c64nn4o.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	05 Feb 2025 12:37:59 -0800")
References: <xmqqldulrvly.fsf@gitster.g> <Z6MNRVrhw3Nxz6Iw@pks.im>
	<xmqq7c64nn4o.fsf@gitster.g>
Date: Wed, 05 Feb 2025 16:04:47 -0800
Message-ID: <xmqqseoskkf4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> One topic that I miss in the cover letter is [1]. You probably forgot to
>> pick it up :)
>>
>> [1]: <20250125-b4-pks-reftable-win32-in-use-errors-v1-1-356dbc783b4f@pks.im>
>
> OK, I was wondering if we are going to rethink after seeing some
> comments but with blessing by j6t [*], I guess this is fine.
>
> [*]: <37c14379-68e4-4c52-a08d-b78c7797ef26@kdbg.org>

Wait.  This works by futzing with unlink() call that is imported via
<git-compat-util.h> which you got rid of in a separate topic, and
given the overall theme of sans-compat-util topic, I do not think
you want to include <compat/mingw.h> either directly or indirectly
(via <git-compat-util.h> as we used to), either.

So where would that leave us...?
