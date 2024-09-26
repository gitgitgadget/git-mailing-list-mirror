Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E9C15B12A
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 16:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727368901; cv=none; b=bHe0r0Bb/yyNKWx5IcwryQKFFqhvUkTNwnsGBHV6gSayiR2c5QeHUR3GteVam3KgFEF45+ouZR3cZHrw+lRvQomVtExZqvUpRChD9pLa9RqGcnBczVtDb6fq2rNZFXyr1rmA8T22a28+6XejCjlZOoRrxEoxtE2ROAApX566ITU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727368901; c=relaxed/simple;
	bh=ZyG6SxETxSomXPZ762f98OJZmimti0hd160eg3fejCc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FaPOxvsjEaUSjXye2nu/IrJSXvC3AdkLby7GuJVzlAz0mjHXB8n+UjxVX54vgjdAh+Y5w3wxemWTdu4rrGghMzsjUC8wwZfbDgeFBfoz1IlSMQdUrOIY358YQckKCc04TIOsEieRnStdvA/Zxe3gAfhsDR4HRt2C3PgGkjvxWR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYNRkpGc; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYNRkpGc"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7193010d386so1045773b3a.1
        for <git@vger.kernel.org>; Thu, 26 Sep 2024 09:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727368899; x=1727973699; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C80DBZLCshpdQBYdfey6FdU3ugBjyIbYTn5KMSkSoqA=;
        b=fYNRkpGcsaJrQMoO/LJp02TjNgN+fjmf0KUN3m4qfJMaRI7M+OtkmwVpN4gRy40ZD3
         vLLgNsQIKhNdoZxYqYvlcMz/rTCKUkfgxGAtM7uEzsBVX6rFaA7/FSy82kDxSKUR0hyQ
         ob/zABlASsOMDv1LVXTeKtcWKOF83ynbxZMPUvuuDjrFaBZS/UjOgZwoEvn9gEu0tvIH
         Z1kLHejMaI+kxEbOOYmhELZaP1Jg5Ck55XU0kyBKsMVsNZ4em5fqybUXLLBV5OQnLJz4
         5QQruRFnonmfBuYgxCvaw3pmXKkDt/jMSanMrBES8ur9e1hB6oOUcRUZc5SuA8h/dscm
         gE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727368899; x=1727973699;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C80DBZLCshpdQBYdfey6FdU3ugBjyIbYTn5KMSkSoqA=;
        b=CpNv45S6fVvp80pJiz4d7B4Jwb8abw61QK1efw/whmmXYFdYibke+6my3zSFA6rOYB
         Mn/gedqtqWRLtXlnLfKM97eVWi7w7vqYoxbm077glUZT3M6h8MXZv04zIQM8KkSxhpQI
         GMxjAsdcK3ndlBJ60CpiyEA90nkvvukZ6ldjslWxUqk0N2PuJ5+rvQws3HcYh5AgcBNg
         LyvtC2WkLyaONVEhmFgBg7yEGgrbJBEAU2qmNeAK9KVni0Df0osCkPOghEyvDhced8vP
         QCcLh0c71xRsusG+1NptR/eYiOtCbeBw6qH1YnXqZHZ+kuM0OH1U2Zn6kcetM/NjGwK8
         8EsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVU8Su54MnsAx6+rdaLhFA9c6GmIqyVTufxS+amNIPe7iJJS2lew4v/y8fJnCAsgqlQlYs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2LA+xAV2sEnzUKxi4RgZXC86sHv18tyEAY0Kv4bC6UE4VYS+7
	p/2irHNH8NLsBg3RCYtoZynlJZci804mxf+57Mj+Op/3qsJ6koHv
X-Google-Smtp-Source: AGHT+IG1u75PdXMMIKXifBsGlN3PnDG4nj1JvKIyz3WHXNcRvCCtkq4aYB2i8YLNLTXdUKP9pBn41A==
X-Received: by 2002:a05:6a20:9e47:b0:1d3:e4e:ff55 with SMTP id adf61e73a8af0-1d4fa60e5c9mr441880637.7.1727368899241;
        Thu, 26 Sep 2024 09:41:39 -0700 (PDT)
Received: from localhost (217.108.125.34.bc.googleusercontent.com. [34.125.108.217])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264bc1a3sm106683b3a.75.2024.09.26.09.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 09:41:38 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 1/4] git: pass in repo for RUN_SETUP_GENTLY
In-Reply-To: <ZvVumLAFu1LGzXWP@pks.im> (Patrick Steinhardt's message of "Thu,
	26 Sep 2024 16:24:24 +0200")
References: <pull.1788.git.git.1727185364.gitgitgadget@gmail.com>
	<eceb2d835be7168081d6eeffbce57bba89b5f423.1727185364.git.gitgitgadget@gmail.com>
	<ZvVumLAFu1LGzXWP@pks.im>
Date: Thu, 26 Sep 2024 09:41:38 -0700
Message-ID: <xmqq1q16l64d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> -	status = p->fn(argc, argv, prefix, (p->option & RUN_SETUP)? repo : NULL);
>> +	status = p->fn(argc,
>> +		       argv,
>> +		       prefix,
>> +		       ((p->option & RUN_SETUP) || (p->option & RUN_SETUP_GENTLY))? repo : NULL);
>>  	validate_cache_entries(repo->index);
>
> Should we really pass `repo` unconditionally when `RUN_SETUP_GENTLY` was
> requested? I'd think that we should rather pass `NULL` if we didn't find
> a repository in that case. So this condition should likely be made
> conditional, shouldn't it?

Yeah, that is much much more preferrable than my earlier suggestion
to pass yet another Boolean parameter to p->fn().

> There's also a missing space between the closing brace and the ternary
> questionmark.

True, too.
