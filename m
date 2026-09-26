Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0268535200D
	for <git@vger.kernel.org>; Sat, 26 Sep 2026 09:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790416412; cv=none; b=MeQEewgl/pREGjlk0395LDv1EK+NBAq8F7E6acfDRjYdZla4qwFzCsZHklO4CNnVkn1RMViuS93+341vI7a/TfU8z/WUShvQCJMQo5NpIHygr2yF56TZzlZeuRJxPgzMwhStAkc4Y1O5IUKOfHG9c4T1Oh90baTjLz/bZnexq64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790416412; c=relaxed/simple;
	bh=uw6gjJbcw79ol+vrAhEyVeEvxbuDlcQxlRND4+Bzyio=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ceGHIUc2jOnCjJAjCoor6ywTJkPvagZERN6A0+yNmVCzeFCpCx+D3jUapOY8Puj5Uqo+QD/t6EGW79HDgM6VM3H7zjttxjM8kv+5PSIzDj6W0PMr8UcSUr6DWut4i4Je3mj1Lym4mKHUwMGxDyoUmoIUn8ldQwLG2OUzaD6Gz04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0lvJP+r; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0lvJP+r"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ff9621c5dso3026855e9.0
        for <git@vger.kernel.org>; Sat, 26 Sep 2026 02:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790416409; x=1791021209; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jLu+N85fP+sJo17r+bUld+CN8FnaxRUGjxfs0zyr158=;
        b=O0lvJP+rYaQF//YVvsew/ZN2c3oOWivPZSvXxi1/+KvE1rFQZXhOk/AB/UCEJEsWKK
         Ml1/qcG0bVBzCg89ytdCfLF6fG7jtOKM/wx0u/VjP4iNAjNLKEGTYEfU5zNb9eKhwGsr
         l8UR15YGCRY9syOG3pzjnJJZ6minrQKQ/70GQjzGvQ0DOc1NG8a2RCggHBBDbCG3tcJy
         ZolQfaqgR7FyjJNdK65eo9Tel+HWjxy9kXwLF9XNVx7RqGfND1PV5crfXPr6w/a3tmuf
         4fwpR5rVDP1JXTpzt4HcY2DmSxgWWduCVzVhRGJyKomfLPuJ0M+Blulmca+aIUXhphRF
         1jRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790416409; x=1791021209;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jLu+N85fP+sJo17r+bUld+CN8FnaxRUGjxfs0zyr158=;
        b=cEyDMXtmo+UHhzDA1HT1Y3xytH4YtofFmQDtaaM1TO+uA9jBliUytYTrUKNGbzgsPe
         kRpZ6jtsrN9bld641K9GbGSpEYitmsnSUeTGP25N1t1W9BI13pFl4C2CIpIM4d2A3ouH
         gxlCoju9ojA2VFeFN4myvYu6/izH+nCLrPu0sYTT1GaZeYEkVkGTuuKX8943GafdiZml
         eVckwojjsQbvul2zvwTxGqP1EsRRgTwwds9qiztbSC5fRcZWcPIt9EnmHaoK226E9bFg
         karF1Pfq5XKrw8yIY3TjGYfgneUtdJrBilG4/eEeNDloon5SoQ+WFswdf3+Wp5Z8QYIH
         5jKA==
X-Gm-Message-State: AFuF++mvV5HFzY0XYE9ws5kBWBctJ2mhVAgCU1pzKnlSYL9uIx50LMWL
	bJ7KBOzfXPNPHF7f55subJ1G8NbHvOlVy7+gFUh0tuvRj6Gk+vU0uO8b
X-Gm-Gg: AYBFou1LH0ObKAz00FgFXint6mFEWTH1w3d7gGcOA4b9f0CNgmMqr52xo4qXGgv+zp6
	vSOFVFag8u/NDUmvzjV8fiqusk6iUO+1hNed1mirYLHRGnYh4ZI/y9VJ8FgkznHir8Sx8sIYwjo
	2dZJjlAmkkEHIPL7+wcwRixMNaP05Iv3vid9SYCdf/GiWt3kf7CCqcoXay/MiYRgDaEaX/zUJ/J
	NMMSwE/ETTzAtkMrFgLmcusGEnY7AFNgn0Tn2zN1rmLPoeOBRnlKXb2299Eolf3kOAJSCbI2oo5
	wWL4bC2qhCsTW9lIBYoUaKQz1KtcBg0xCTfBwFrkEer+2WjpVdjhUk8cmRA6C5oLqFigrDYY+Lv
	q6SBMuRuWbeJzhSJ5ENgYww7SCMDoFTgnwqMX+L5MnN2y4/8Fxy782YMagQdax3+euWXg6b7nt2
	RCrkVPHA58VwOs9NeFMnP053vQFl4urYTtB0AOEUjr67Y3cWq6ohknuClrpKFrng3LMmNc4Qwva
	lglIbmIS1iuxb4vyhnN38ZGMnhxPOjuVBjpM3zW9s0fLIwgerMU2w==
X-Received: by 2002:a05:600c:4fc7:b0:49d:433:c3b6 with SMTP id 5b1f17b1804b1-49fe66eefa4mr150598335e9.27.1790416408960;
        Sat, 26 Sep 2026 02:53:28 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a2acb4dsm12959145f8f.0.2026.09.26.02.53.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Sep 2026 02:53:28 -0700 (PDT)
Message-ID: <b4023f5d-efba-487e-b273-a4283c50a774@gmail.com>
Date: Sat, 26 Sep 2026 10:53:22 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/4] t: test failed "stash apply --index"
From: Phillip Wood <phillip.wood123@gmail.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Eli Barzilay <eli@barzilay.org>,
 Victoria Dye <vdye@github.com>, Junio C Hamano <gitster@pobox.com>,
 Elijah Newren <newren@gmail.com>
References: <cover.1789853192.git.ben.knoble@gmail.com>
 <cover.1790168285.git.ben.knoble@gmail.com>
 <5bd4b78cace8ba8c8887c78f739bde3513dfda28.1790168285.git.ben.knoble@gmail.com>
 <232f2bf6-04d8-4a54-b4e9-51b5ee79799f@gmail.com>
 <CALnO6CDTaunaBby+Gy4B5vxiHES3DHpybv8Eq2JPvQ1cteGzrw@mail.gmail.com>
 <a9c44afa-583e-45ad-9447-c00144141c32@gmail.com>
Content-Language: en-US
In-Reply-To: <a9c44afa-583e-45ad-9447-c00144141c32@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/09/2026 16:45, Phillip Wood wrote:
> 
> I think that sounds reasonable, we can delete the index lines from the 
> patch output with sed to make it easier to compare them.

I just opened the test file and realized it has a diff_cmp() function to 
compare diffs ignoring the index lines

Thanks

Phillip

