Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463A617A58F
	for <git@vger.kernel.org>; Tue, 29 Oct 2024 10:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730197867; cv=none; b=Zefut4QchlzMzexu3bd/dUvpU+fjiWLekOqP2Ppcr1Jtt5z+3Sg12XJk/hRibUiYdqraoV7ML1ltfM1J2rjHqevhF1OqDgMwhe/LEdQSuyG4sZ6uPF13Hak7c7dQAT2hyNXhLMPkeEL02+DlBw3O7OV6XnQBYTIBoWTfno3kedQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730197867; c=relaxed/simple;
	bh=oomge6ZxWo2d35l9NMz0WNIRd2ctbIlbMIp/oO0RZhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nwb7Wh2XzMawzuCfnbpybs2tbiX8+9zwSxNNBUzsdrsHDwLWcMIb85GfDmCN/KQ87df0u2JyFTwZNNGIUroweUd+dZlA+skclbTDBW+Z8wGhwwuBdoS0zc9vh8brWcivjQ1uBBlT9HHvDVtK5oA3nPlVtjg3lIyghQOWVt8HiD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAOWzB0n; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAOWzB0n"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e30db524c2so3969263a91.1
        for <git@vger.kernel.org>; Tue, 29 Oct 2024 03:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730197864; x=1730802664; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yyiPgnDJSDyi18ugCoraY2/u/YycQlZs/8ADqI4ZomA=;
        b=MAOWzB0ntfvUYbN6MnqbU2C1xvUKREONn1nvR7+zjIJDvEINYmtf+dhTGgP29Ihj/e
         OyRhhEUxlsCOm5BsRYw+Vvysk0lH5iwqJCuZghbpTfvV1gAbwCTT8v/73b2TOIGoIud0
         zn4k8NIYyqDmkGb/obG2bxjWy2hIGFDVaib1t31cEssORa3eHWt8vhgGlN4ObVUyoiI1
         ZfkpiK0bkAfPHkQk0Ys7k4KO4VhwZTBUBWFXzwn3JCHSPlH7YTD/+pOngjo6iRpDLEbD
         80c7hQEKAQpkDESIN+BXR/U504TgjYjNo0bx2vGKVrTtFmS6Rk6VbOz3nFqoHh7qWplu
         OgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730197864; x=1730802664;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yyiPgnDJSDyi18ugCoraY2/u/YycQlZs/8ADqI4ZomA=;
        b=N68O1XhyZYE2F+mAVG/sDX6Ml/QnjkmwpQaJMbTnHWlI3KRI/W+jVXJN7MF+4TZ1/I
         rESsjS1aMNM4oXjn2amDH9tlgIafAWQ1jd80GzpNOD4/K1Eo91EyuwbGiTCeNtlgksNH
         btCqHZ+pbTAVDOHrqlPZe2ESv5l7x+V8j2FrK9q5u9+oambOoYhzGROu4THSHhIsO8GS
         eY6XXZ/H/sd5dvwEThrMdPI4KTx/kTmXe2pkN1tI1lZUb0mH5GaKvGkYKKGPskFLKdnR
         lDI6gL3zVbzGNIZgkNp1lPSL4Yc1PI5ervw9U211Em+LElhndPrMlXw955IwHBo0xPXU
         x+KA==
X-Forwarded-Encrypted: i=1; AJvYcCVejf87CIf/Em0aK3146teEGe/UAF7Ff167XYL7SnLIhgHH/xq1JS202EZgLe5IOnHix98=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVCfaf/53WPYMfc2JrRdYRrjemWP8Tryc2bjY9H0Evut3VfzGf
	SgRf+yDlaPDxc0kGjWmkC6h0lXwbf36FpeosHWfqYfcLU6Sy04kEL6/9tw==
X-Google-Smtp-Source: AGHT+IHQdaNJP4kcKRWwSnrtyLxJstr+lT49gdo8/8bqYHtFrw9IfNfMJjkBYFxgedGyv7goUAfO+A==
X-Received: by 2002:a17:90a:d913:b0:2e2:c15f:1ffe with SMTP id 98e67ed59e1d1-2e8f0d62e7bmr12318872a91.0.1730197864469;
        Tue, 29 Oct 2024 03:31:04 -0700 (PDT)
Received: from ?IPV6:2409:40c2:805f:eb9e:840e:5586:842:93e5? ([2409:40c2:805f:eb9e:840e:5586:842:93e5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e36a4860sm9032615a91.32.2024.10.29.03.31.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 03:31:04 -0700 (PDT)
Message-ID: <00094bf3-61df-44ec-a469-a3b33399a306@gmail.com>
Date: Tue, 29 Oct 2024 16:00:57 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] show-index: fix uninitialized hash function
To: Taylor Blau <me@ttaylorr.com>
Cc: gitster@pobox.com, git@vger.kernel.org, sandals@crustytoothpaste.net,
 Patrick Steinhardt <ps@pks.im>
References: <xmqqzfqi4oc6.fsf_-_@gitster.g>
 <20241026120950.72727-1-abhijeet.nkt@gmail.com> <Zx7WaEn6nvtjhs/B@nand.local>
Content-Language: en-US
From: Abhijeet Sonar <abhijeet.nkt@gmail.com>
In-Reply-To: <Zx7WaEn6nvtjhs/B@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/10/24 05:40, Taylor Blau wrote:
> On Sat, Oct 26, 2024 at 05:39:50PM +0530, Abhijeet Sonar wrote:
>> As stated in the docs, show-index should use SHA1 as the default hash algorithm
>> when run outsize of a repository.  However, 'the_hash_algo' is currently left
>> uninitialized if we are not in a repository and no explicit hash function is
>> specified, causing a crash.  Fix it by falling back to SHA1 when it is found
>> uninitialized. Also add test that verifies this behaviour.
> 
> This commit description is good, and would benefit further from a
> bisection showing where the regression began. I don't think that it is a
> prerequisite for us moving this patch forward, though.

On bisecting, the offending commit appears to be c8aed5e8da (repository:
stop setting SHA1 as the default object hash).

Another related commit is ab274909d4 (builtin/diff: explicitly set hash
algo when there is no repo) which did something very similar to my patch.

Thanks


