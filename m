Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.33.87.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794155652;
	b=LMOetkGg5bb+83XpJZ8Cjugt0SioSM62xwAOKN1MSRc7YMxZnwauaz8SGhBqX+nBE4YW
	 uTm5UhlhdCLFILbIthCvuJ++Jqbl0laBz3OOMkFa5PFc67IpxxpgK8ffIHiJEdJwnWY2z
	 kJIHkkOLRoIQpqexT+WHkxgfGAV1qq5bSrjlIjrWQtkpCtd2VhEhNnr7HYcp2S7Op216C
	 hANbnPC7bvuVkX4+2tQFv8zrOT4bxK/KZDK0KYrfNxMj2srUAS/ABGrIhey0nGXlaQjSy
	 Z2yFfzY5vBUyhVqMw0lg8pFEZTO30JS0T0EkuYj2mdHMoA+7HpRnjqupXkNz2dQkZlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794155652;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=dpnxa+1GNp6B5MZxFzb6MMBxcU/sKbVNu+MuFD9rF2k=;
	b=gcZxd/Pp/m7YJpKV2o6NuxgNwVQSVXN+2sBn/PX9CYb7rHpbeBrvp7i8+0xBHFKoudiV
	 5l1umCfCr2HnuQDU/0tAsddMp1Ksc4mlY8jW9wdsAx2MPhoqj7I7M9F95QtVxmjRhbMhC
	 NFUI5dECSKiquOUgUqhdNmVxWSYurvA5a4r1yu4YtNk64sgOrKiJuJgTTCBxB9VSkyaCx
	 rK0bqfKhneVzYvICow86gyNNKoiakVYwh2sh+VCccoBRED/KfQzSFW7i8ug+hl2BYClNI
	 T85I/2IP3erksDV5TemNgje5VJVOctWnpZfk/ed6yYUOLwTIa7NTXJzZ1rc+Nw8X5JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kdbg.org;
	spf=pass smtp.mailfrom=kdbg.org;
	arc=none smtp.remote-ip=213.33.87.17
Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2A6606A31C
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 16:34:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB2A6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.102] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4jMz570TTmzRnlL;
	Sun,  8 Nov 2026 17:34:02 +0100 (CET)
Message-ID: <c8688e1a-17b6-4d0b-ba9a-fc1e0fa8938b@kdbg.org>
Date: Sun, 8 Nov 2026 17:34:02 +0100
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] t: add "test-tool genbytes" to avoid slow tr(1) on
 macOS
Content-Language: en-US
To: Kristofer Karlsson <krka@spotify.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
 Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2301.git.1794063565.gitgitgadget@gmail.com>
 <4c02ada9b85028f26f7e7bcc62e2ac12443da9c5.1794063565.git.gitgitgadget@gmail.com>
 <50b6c35f-e9c3-47ef-8fca-aebd2620623a@kdbg.org>
 <CAL71e4NFyAShDZPW9JRB7Bpg3aLY5mY4wdn5m_ZYoLQjHZw_jA@mail.gmail.com>
 <6992b7e9-8721-4e1f-9c00-9fd0e0704e80@kdbg.org>
 <CAL71e4NKsTZNoLFOuSPfiJPf7oS57S01MpM5V+UOr+bgMGjOkQ@mail.gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <CAL71e4NKsTZNoLFOuSPfiJPf7oS57S01MpM5V+UOr+bgMGjOkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 08.11.26 um 13:24 schrieb Kristofer Karlsson:
> -       test-tool genzeros 2147483649 | tr "\000" "1" >expect &&
> +       printf 000000000%02147483640d 0 >expect &&
> 
> I tried this out and it works on Linux but fails on macOS[1].  What
> happens is that printf only outputs the nine literal zeros
> ("000000000") there, and silently ignores the very large padding.

Fair enough.

> [1] https://github.com/gitgitgadget/git/actions/runs/42475956442/job/128717309586

-- Hannes

