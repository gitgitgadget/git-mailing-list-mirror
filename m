Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3C0B646
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 19:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723058017; cv=none; b=M6VHQJrUaMl4t6TZ5g+v450S7PIiSgGOpz1DvDGPpwKgtChH3RkKK+fd7qBlL+Brc735dgaz6GlKv/WLhfAhzxEFQF1hVP6pRyg4r0sJBpjriRLpWuXQ4zi2DLYJM4O7x+rB3RTHdTpqoWY9CYWeW8rrb2EbCSvCuXOM2mk23/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723058017; c=relaxed/simple;
	bh=ZwMkujYWjiV4PwcKA5C0KDm+kIt9y0PanmbXbbyb03I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFm5Y/wvlavHS0sfCXy6quCzD6SHUegXbPIgc6OvLzcf0xCWWZpLvNZLsZnD9yDGSVEe5+PcJXo31jye5xE1iStCwEek2RqhFLbIEXv56uhuT1WZPvh/KZ3KGj/FAT5f82VwNGZi6/7nshJRmi99zwNUOjmNzWtWdfJLxFbUQSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbJJXnHX; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbJJXnHX"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7093472356dso106571a34.0
        for <git@vger.kernel.org>; Wed, 07 Aug 2024 12:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723058015; x=1723662815; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WbZyV+2IpqVnrYtpmI633XwI1K33vSqBG/q8hp0/H0o=;
        b=PbJJXnHXnEtZDOZR54iJg4rAQ356AMKKawEOwoiSf5btOCGrq3om5D7yeSmjVpk1+A
         J+6BqBLMUiHl/cROkqfWX55xRXLqX07ecZmt9oYcyrw/fTUkIn4XxEVbrH8p3x55rxYg
         RE9LRcOKqydHPyJU/YAgR7xPR815tCVq1Lh7jRkCmqOoNJNpYH8drfmH4CP/rJ+PPjGW
         JgY2adCirtP2jAKe/ABnJ6JyZKb2XIQps7VjRDMW9irVnESvpLxYgXJlnxF4QINRS+1q
         r2Jm+AjmMtsvaPzhW4vV3EKH+bSBaWCvW4QBE6Z4/7qeduM/FPKwUaxTf/gKEyQaRBtc
         E9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723058015; x=1723662815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbZyV+2IpqVnrYtpmI633XwI1K33vSqBG/q8hp0/H0o=;
        b=GPBqyIDAjNXRQN/T/yt5DcplLeg57Qu51VLdJkde94BHIMndEfOW0pXgLBTq3DBodg
         R8RBkxmZAplqCCopumBcUWEdzRj24K2OFeVty7rMZBLBMVVXRVlKIpMSvPkWENsGcC09
         qKt0pVNe3CoGNP8r+ZAQKlOm/Z5nlnOK7sqN0l/RQcJ4m5JpExwSSlrGATjjvs67rfY9
         2jmGFCrzAuPtcy7KTs0D2O+mecEkmRwRVeZoFlP+zelmZLOhU06Gd3ttqJvYrtbqgdLt
         lAvmO+SFZ8tnHetXFDFyENNLkO7ukXSJTWHSXOxGmh4cxZ1DJRVnrbOmsr7VqdIFH4K+
         wLpQ==
X-Gm-Message-State: AOJu0YxxgS1YaOE7Vf5rV7ugpnPq9tMBeh6PllZ6oxrRDfPzL1BBgaI0
	Tg2sdmyEFonS/pvOEpFRV7teEwa4ImjUZDOMvBY44VYBc2YxIwFP
X-Google-Smtp-Source: AGHT+IEq92OfGPzV5wJOoPadrvIZhKHrWckf7GbmdShOH/CoAHGs/Arokmso8LtBque8NVSQhb+mLA==
X-Received: by 2002:a05:6830:628c:b0:709:3f84:c1e0 with SMTP id 46e09a7af769-709b996ac80mr23658862a34.26.1723058015524;
        Wed, 07 Aug 2024 12:13:35 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70a31d9df69sm4859269a34.13.2024.08.07.12.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 12:13:35 -0700 (PDT)
Date: Wed, 7 Aug 2024 14:12:47 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 9/9] reftable/stack: handle locked tables during
 auto-compaction
Message-ID: <cyvkxpz3ro5zq6san5jtjyhhdxhw6j4tu7fcubmzolo3xifdke@zohma4ybye7d>
References: <cover.1722435214.git.ps@pks.im>
 <cover.1722862822.git.ps@pks.im>
 <1ef560feb1906c160ad7c81a30e9bd4fc92d2eca.1722862822.git.ps@pks.im>
 <sct3bl7ztqwyym3wqh3jvz7vefr5gk4mf6dhsaasdihszcnnlf@s23uyyiwwbu3>
 <ZrMGyMTm3jXLSLtI@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrMGyMTm3jXLSLtI@tanuki>

On 24/08/07 07:31AM, Patrick Steinhardt wrote:
> On Tue, Aug 06, 2024 at 01:46:35PM -0500, Justin Tobler wrote:
> > On 24/08/05 03:08PM, Patrick Steinhardt wrote:
> > >  	REFTABLE_CALLOC_ARRAY(table_locks, last - first + 1);
> > > -	for (i = first; i <= last; i++) {
> > > -		stack_filename(&table_name, st, reader_name(st->readers[i]));
> > > +	for (i = last + 1; i > first; i--) {
> > > +		stack_filename(&table_name, st, reader_name(st->readers[i - 1]));
> > 
> > I might be missing something, but why not set `i = last` and `i >=
> > first`? It looks like everywhere we reference `i` we subtract one
> > anyways. Since `last` is already at the starting index, it seems it
> > would be a bit more straightforward.
> 
> You are missing the case where `first == 0`. With `first = 0`, `i >=
> first` would be truish when `i == 0` and thus we would continue to loop.
> We then execute `i--`, wrap around, and still have `i >= first`.
> 
> Thus, an endless loop is born :)

Ah, thanks for explaining! This version of the patch series looks good
to me.

-Justin
