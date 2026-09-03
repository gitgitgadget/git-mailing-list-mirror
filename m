Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F664B270F
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 14:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444693; cv=none; b=cf5zRvOkcQyqSdHayZNBwrHo2qHiIwVkpxKlGJtp49RmaNxvcZnBIRlNKnQ10xZhfj/11jdTesrVwe5xADfSuWTXPFaFl6iV48fW+k6RuV93ed6q+002KUm7baiUYxwR5yJleVOAhMmI5+laehMYrotmVPPQ203aKTjBpPauzAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444693; c=relaxed/simple;
	bh=eCyFRIMJiIEjvPy5HLBJ9NUZmk9syBRjp4cNJ9lHW60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oodTIfnzBNiTYJIsk2mXFy4bV7w1uCMakh73MY5nlt1P4sHzt43GHS4ptJRNICy4VZiTgrYAkfrSwFOmyP+xAboGONRLY80DTP22DWcIYR/ENt+Zy7GZRV7JZLE/A78Pvr+2q42JZ/jNVUdtWnDg7acdZw4G5oqffWUTm96Ffw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StRfEUiA; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StRfEUiA"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-90e828b309eso30933816d6.1
        for <git@vger.kernel.org>; Thu, 03 Sep 2026 07:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788444683; x=1789049483; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9QxWeTbt5E1ZlBkucqB0sOdEK/E4fJlKg4OadQiGng4=;
        b=StRfEUiAHNfN6P9fQ80t+mX3QRPT72T4/XNqh2pNncvncnbWtcZepU83IPs6UTfBY9
         krdOfblKlh5cqhI5WIYzN2MAWgc+KZi9e8vizWqNkw0MvWYqfZ10wR7f22CqNVA4+hr6
         WSyIydxlbcRtp+TryY7jpKPYPdvKXBQQ5RSdpUclEiFcPxtJk8StwyK3qiI76AqSsii/
         2W6fEYIE4eM+kHHxCT8ZjSQwsnZN6950tNnRMhV8qdzo2dLjg9DkYfCH+DG8bNpWEt9O
         UqLeMSkQRxulyH8vwLnzALu5iP5PLpiwCUv6h/wxqkf0w97rD9mP1zk0sdLGjoOINLpv
         NTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788444683; x=1789049483;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9QxWeTbt5E1ZlBkucqB0sOdEK/E4fJlKg4OadQiGng4=;
        b=UZkZbBTMldhnixl8K84YALCZjJLjWVgNm3KPBeuClcwGBLX807hpz4R56/VXiy/sI1
         jFopVrMl2o4MgPrm2b1PMtlzUovq9lefQQCQsB+K969hGxBc3RCI2RQNkiImFXEORx7c
         x4wKxuGGrx05NZt42K0UARQ7byhFo83YE0mFCkWUrzzIO/e2NXWLhfVWWpHu5GYGCtRT
         qmU/AoO2BSbZtC9n4e5jGKGQNX0TljGuHt2j3v7/Fs3U3uBhhJMT/t2B1RXRJK11r2H0
         srnKBKsKa+uHpSpq2caRki9XqQtxGb3WB2Ipcwq1d/6zzGgDndsEP+NsmE/npgSXPPr8
         oxzg==
X-Forwarded-Encrypted: i=1; AKwUvByflnqHQkRVUIYon8y2HLzbAiPmrZhIdgBL3UuuKrFW+7XstvFwKQ+DmMKtoLPNLs5T3g0=@vger.kernel.org
X-Gm-Message-State: AFuF++kpJpRyBeVv9odnK6dhdEemmWJe0NKj/DUMwadCvXDybgICnyXJ
	kBgskZKP5bWf4w1ap46Sp7p0EIixOU2ydjxavXE/8Z16Zw/lwJNQvZGdZweqVA==
X-Gm-Gg: AYBFou3NJ4VKcPlyYc9OjchhMNBFkJaj2WETQU2I2yy8ClMrHlkZHj/Xup0L74597up
	umKFBv8dajS6sOPB+nrlkFiE6oq50VEl1DIBhCr3NBp2yHlIN21OVkH/JSawUG7yzkDk9mUHf2j
	9XqODwA8ZgMBKIS6o5RNz+FHAKaTF2Zl8IfTEN2dbJv+SPG2YLzurUXI6IQ7knv271ApaZNSBP3
	D2kzimOShGpNQZHsrcW1/ifFQuX4ii46TDjD703phlH3zbdi1J2EuMQjS0/a4w+7QBhEr1K8EOy
	PbQHXKGm9r9dKO0SigYIwQ8KrfYGG4vV6GyD1ecRXZlHSWwZjs+uRaHKK4CXjzeRoQ1DMgz/X8/
	0q1Mbux9G/PQhYT4wJBn4TPikQVPGNGCl3TAbC/DuYAT03U/ietA251vHuPDdD55cki/m+9icF/
	u6OMMJ79PCC3SylxyBHUsK72P+EugVhLX8dhvQYvXReE56itP/IcBKlS4yhv+XuYU6G4kQg6Q7g
	SqGBXmUqBcIAdXU7Bg2kMz3+CDyBFhU2Jo3LkWhbidq9AcYQun4em/Yn/L0jGNTJJUkuyA4ujnZ
	lLJR9FnpQdO53GtZB0nsCo7j0LY0Xu+kXY3XwNVQn09kR94DxqATvJjoaIydbLAHkNwvmUIi20j
	1h0Mg2C+XEyj9Iw8ZSJmDyqFeFzI=
X-Received: by 2002:a05:622a:6207:b0:52f:9eff:959a with SMTP id d75a77b69052e-53036bfe464mr162295541cf.11.1788444682686;
        Thu, 03 Sep 2026 07:11:22 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53032ff089bsm45142931cf.4.2026.09.03.07.11.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 07:11:20 -0700 (PDT)
Message-ID: <a63c3bbe-28b8-4026-9c07-11c2d445c504@gmail.com>
Date: Thu, 3 Sep 2026 10:11:20 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rerere: extract logic to determine whether entries
 are stale
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Thomas Bachem <mail@thomasbachem.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20260903-b4-pks-maintenance-rerere-gc-heuristic-v1-0-9929c45a9788@pks.im>
 <20260903-b4-pks-maintenance-rerere-gc-heuristic-v1-1-9929c45a9788@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260903-b4-pks-maintenance-rerere-gc-heuristic-v1-1-9929c45a9788@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/2026 5:04 AM, Patrick Steinhardt wrote:
> When garbage collecting rerere entries we need to figure out whether any
> given entry is stale before pruning it. In a subsequent commit we're
> about to introduce a second caller that wants to determine staleness,
> but the logic is not currently reusable.
> 
> Extract the logic to compute staleness by introducing two new helper
> functions `rerere_gc_cutoffs()` and `rerere_id_is_stale()`.

Thanks for doing these extractions. It reduces complexity in the top-
level logic.

> -static void prune_one(struct rerere_id *id,
> -		      timestamp_t cutoff_resolve, timestamp_t cutoff_noresolve)
...> +static bool rerere_id_is_stale(struct rerere_id *id,
> +			       timestamp_t cutoff_resolve,
> +			       timestamp_t cutoff_noresolve)

This modification of prune_one() to a staleness check is good to
have split, but...

>  		for (id.variant = 0, id.collection = rr_dir;
>  		     id.variant < id.collection->status_nr;
>  		     id.variant++) {
> -			prune_one(&id, cutoff_resolve, cutoff_noresolve);
> +			if (rerere_id_is_stale(&id, cutoff_resolve, cutoff_noresolve))
> +				unlink_rr_item(&id);
>  			if (id.collection->status[id.variant])
>  				now_empty = 0;
>  		}

...this loop gets slightly more complicated. This is not worth
a change, but I'm thinking out loud that I would have updated
prune_one to be this simple:

static void prune_one(struct rerere_id *id,
		      timestamp_t cutoff_resolve, timestamp_t cutoff_noresolve)
{
	if (rerere_id_is_stale(&id, cutoff_resolve, cutoff_noresolve))
		unlink_rr_item(&id);
} 
and left the loop alone. This is only a preference, as your
implementation is also quite clean.

I did look to patch 2 to see if this choice of splitting the
prune_one() method had an impact there, and it doesn't appear
to matter.

The rerere_gc_cutoffs() and rerere_id_is_stale() methods are
needed in patch 2, so this adjustment to prune_one() is
important.

Thanks,
-Stolee
