Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEF92E4998
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 18:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751480892; cv=none; b=jYc3siGj7tQOvF7H+QRQcbk9u8JXP6nI3nkDzPVfShTRmW2Fwd+CdgZfliBm2y2nMylnEIwpXwyd+TCmxpWlB7SH5tLBE9SCSIycP88vSKoq6+r4z1qWBQF6D0N1f2np21AQhXvP7VhaAQjYGWMDeZxwV48LQmuaQnnUzvTZYBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751480892; c=relaxed/simple;
	bh=P78KQqVOEnkCh+bSPJsdaursKEFF7N9P04Db1uo+fMU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LhBWGThEw+6dcp21q1JBzKZmoVlUYDMHI//AasDfsbZPOoeIjsIOGaVWJUBY6YK8XnIkLQz2/quteSd1Obe17PTaVFAs3whjIpasP6Y0O8vmzRawiu7CzkbO9FHjiLIvn+JJv2Oys2aL49ol36fT4yee/nZ00mFo2RgPGgDvnhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkUFg5ZY; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkUFg5ZY"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7490cb9a892so5088727b3a.0
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 11:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751480890; x=1752085690; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tby0GuA+rjwCFWLF2jyg7+NF3tfPqyhRVg0rF6a4EbE=;
        b=KkUFg5ZY58opTO6aSQ2DcGeFB4AbY0kedDtLF15c8CkmOMuvA2yFBQnvlQjz7izznq
         l1zq9zG/6alDbsbJmye8y6Zty34MGeU8hXR5zry/JbGte4umEnK3bDQvPu+g6PXTwl+J
         LcZyfKC1zlEc/AfNPtkt61MD9PwE+CNdzkSPagtT6Tch6cZGaCx5NZcbjDFkQjymCOfW
         5CZxGvi//3PKIZaIrE5APGumLuZN+3TvnW0OFmZpK/oftK8P/qw/NFK2taT+qqqU+Y4I
         EaKI0WIrPka8RcLC1xqpzomL40ou1TEWOn5IyKvKtg5iNSvHpsJNJjrVr8YL3jFs750j
         AO3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751480890; x=1752085690;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Tby0GuA+rjwCFWLF2jyg7+NF3tfPqyhRVg0rF6a4EbE=;
        b=FwstCK0svt5lVrB3d2leOTyIRoDvgh02K2Jvq4hKQ3Alc0s8z5nG6UkDNs6CR3wU+9
         Hx2NLpNRhtNSnKASkvTYqh9qT7hfdKg5BG1CrowT3mjTE0asnAqsFYl0J1OthBSwXNco
         VXMbm/Badme/6pmsOGUiX8D/8SExhNEMungF34Srmk/XORLoh9dYP6HCdrz/s4BrZQAR
         VyjLcO0U/GJX3HuKK4n4jPzbwgzWd0nOd43fy7KVp8LqUeXkRHzsfMHBrSyASgZBAT63
         CmFrIvBhs/nPrzSYqXQ8duqPrWgYyx51shr/iiQs8I7pdtu8iEy8chfiXgSBCMiPHrH9
         yC0w==
X-Forwarded-Encrypted: i=1; AJvYcCUqlmDNys/fx22VtQI7Nq0edAW1sJRYJ3BE3+mdZW5pHFf5ejKSenZaTaDwpsKBlcgAHOY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi++hFDPr+78BV05UCBa3F22J/JoC5hd1pgDGSvO0OTGc1lonJ
	5UeM/Mw3kbPlawjDxAw62dswnR5JKukn2SjCNBcf5bEnIcI9t7lnqSIhA+Wlcw==
X-Gm-Gg: ASbGnctJRXKi7F0EIS4Tn9LIPLxXTqXJDb2KoWSYE1+skJ87FjLyH/LqFc7jSDGXj8T
	NwtW6gDLM83D3rl6IjzBAKxyeHVtE6R7M5eSHnSyCbxIJuiGljVw6N9L+A23gi2rn55yu2nvBMw
	ozJwUsCykSGj/9rOE2Gci+fsjmAUmNvsSw2p6kZBpwlFMuIyD3NAdY29wQUADKqRfIaZs6SrgoO
	b69Sb9fyP05cCV6a/AoFnNEP5Nmwpsyz8H4U6WH6bASyg+R8dhwT9z1STR2rDnIu02WCBSUHHAV
	COk57T26pjRw+LknXbJQkxDXHKvatYQtD3fX5/L0+IsFsJZwaTERxE/kngr1I4V8Pe+ljp7y5xt
	g4MYjgF3SGVbZQjpYlqLvGh9u+8s=
X-Google-Smtp-Source: AGHT+IEy8ufSHcbc+ADavnHuHdjeWwYzGeLqWIMTojmrkhvXz29J+LHmvBS7mXvk9AkZISMutOMmJw==
X-Received: by 2002:a05:6a21:6d88:b0:220:b05d:214e with SMTP id adf61e73a8af0-2240a01d66bmr1034564637.3.1751480890135;
        Wed, 02 Jul 2025 11:28:10 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b34e3200fedsm13468789a12.73.2025.07.02.11.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 11:28:09 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Lidong Yan <yldhome2d2@gmail.com>,  git@vger.kernel.org,  Lidong Yan
 <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH v3 1/2] bloom: replace struct bloom_key * with struct
 bloom_keyvec
In-Reply-To: <aGVLZ9VUf2M1sWhL@pks.im> (Patrick Steinhardt's message of "Wed,
	2 Jul 2025 17:08:23 +0200")
References: <20250627062154.1121530-1-502024330056@smail.nju.edu.cn>
	<20250628042140.1097910-2-502024330056@smail.nju.edu.cn>
	<aGVLZ9VUf2M1sWhL@pks.im>
Date: Wed, 02 Jul 2025 11:28:08 -0700
Message-ID: <xmqqy0t6curr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> +static inline void fill_bloom_keyvec_key(const char *data, size_t len,
>> +					 struct bloom_keyvec *vec, size_t nr,
>> +					 const struct bloom_filter_settings *settings)
>> +{
>> +	assert(nr < vec->count);
>> +	fill_bloom_key(data, len, &vec->key[nr], settings);
>> +}
>> +
>
> Similarly, this should probably be called `bloom_keyvec_fill_key()`.

If so, a preliminary clean-up patch in front of the series is in
order, as the <bloom.h> header file, without these patches, already
has the follwoing external API functions and structures declared,
that do not follow your naming rules at all (I have removed the ones
that begin with "bloom_" from the below):

    int load_bloom_filter_from_graph()
    uint32_t murmur3_seeded_v2();
    void fill_bloom_key();
    void clear_bloom_key(s);
    void add_key_to_filter();
    void init_bloom_filters(void);
    void deinit_bloom_filters(void);
    struct bloom_filter *get_or_compute_bloom_filter();
    struct bloom_filter *get_bloom_filter();

It is very dubious that murmur3_seeded_v2() is exposed (nobody would
know it is for Bloom filter subsystem from that name); as far as I
can tell, it is only needed for t/helper testing, and makes me
wonder if we can come up with a better division between the
production code and t/helper/ code around there.

Thanks.

