Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F98A1DED52
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 22:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751496127; cv=none; b=CRmJ3hPO9AAlyTDbmCZ21XwNZMSP27vTwdOCTKt/OZQwBDschzR16xk6SqRoIyr6NENDwVQZuBv44qI1gHgQ626NZvak9D9b3rywAxn1d5fqJLq4g0T9Ol00wzY4pKxNvOfGDIyrInfCgSsBd0aY39AhOE52+wmgbSTvi/ZSxs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751496127; c=relaxed/simple;
	bh=P7cD6QfbRG5mstuCsjkMl9FabAMluWlj9xrXuN5Uls4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpC9O3kBoeiOOrSNSB2kgYeP7lCzjgqEb7Uj81jHVxOhHcXiS3/D3bW2Wc+mgQrGeHGMWb9K2NF9HpK5ceHJs9hLrrzS4Ya1wCp6BqdeYNqo29swLwuc2Bm+C9oyDXyZsoPUr/H8DPLE5VS/BdEj9fVY7LtHuIIIrhAS1VjXm88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKCQcB+h; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKCQcB+h"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-311e2cc157bso5798519a91.2
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 15:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751496125; x=1752100925; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Gx7ygXj/QFkHAPHvZbbt+8b+KbWQOlIQW2hVQzSMpQI=;
        b=NKCQcB+hY6Yak7thg3ZnOT+nPYGtnKC6xkdX+zq5dCareYkQNM/NWsGUivqer9C/1Y
         Em5kMqtHmEfeKnluGRQKolBp7hyM3fQABoL+rrVhcyO96ikltc6oTaj4KaF9S/n+d/Vh
         PYnuggYU0vX0ia4SzdvgN12oXhyTNxweREOYYcjyUbaU91YHB0nkwMHlxGCf6Z4uzLIp
         ScibvvKON19kPXfVEmYBLJrmvqQvdteA7FV8P85zFMXoJyqvC0ZXS9KP8CjsrpRzpaoB
         pRDKwxae5pkF2H84vcA2jvQq7BjV14rpjOHPSHpig9g22tXLAMvUADhxQr/N19jRLWr8
         STuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751496125; x=1752100925;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gx7ygXj/QFkHAPHvZbbt+8b+KbWQOlIQW2hVQzSMpQI=;
        b=KJ0E6dMtTH7wXzVA6RGBaBg8DxMRXh9iJHomvQlUknon96/DiNcyfPCARnIVmey34d
         KezzyZHkzxLq+40MZjAQD3T1oRHFvAWwKXgB2M5UTMYEgqj+mVL4YK7mCTkPgOoI0Xz5
         6+WOta/lREb6E59MJVYAhxOhzF/0s0YGUXNXBY4eLpKVMWTC3L1YyQBJzX/9n6EbNXdb
         0k5r2LHPvbuCGfn7BzGzsqA3EqY64s/fhTgC+g1O7W4G9dH7FgXMr3h0ZOHqEXdMOPBS
         klIEEj1o831CKgpAbRgcRBW8vQD8w38MIbrcBPyUfoLObKoDLsSidTjGIqKg6ws4ksXc
         vfdw==
X-Gm-Message-State: AOJu0Yw1J2shjVpPENIIEXmuSaeZ2q6q4d63e9jAJinhgDzCRedX/qWB
	C9YH3l/h5FnDT38gUHJESGabOY6YHbMeBbZkYK8AiLdoTVW4ViHhQxfO
X-Gm-Gg: ASbGncsvT3xfx0RanTLunRA8qIbijn5qdRgwcFTPN1x3hkXfta3oOOYtZQsu8n9PgWs
	R+SzrA4BfAAlxfkUAIJCdeByahN8kbl42GskWUE0vVJCRhA3Pj8tQZnnnwayq37TBqeV+YNYMN9
	eNk0H6EuHyCc8lPfpRDRTjaIigk4vhYGMqjLnlFTdc0JnJxm2kbvQPiAJ46zaf2Frm6Xd19AoOU
	0E7Q82Xe+wI9CP1jGQqwcvCA0ao53LTdNbPdnBfhLwRqfhc44jFMw6LuO+7fNEopVnFvGMB8uIl
	w8PZG1MkNWQsnUhjiiHnbcSaD9FCdrXmR5aTPKSjRt8GIcJHZ6EFSAwPb8+15F+XUtvPF279k/w
	bVXtTb+rSuTxRcrFc+mSTOOc=
X-Google-Smtp-Source: AGHT+IHlxYMUHqstzz6RRPuh5gvc+Esl8ywDsVdJjVtjSBj1BP+ohNdsxNdX3IWvh2iJ0tW37cTQpA==
X-Received: by 2002:a17:90b:5390:b0:313:d6d9:8891 with SMTP id 98e67ed59e1d1-31a90b6824cmr6522535a91.3.1751496125425;
        Wed, 02 Jul 2025 15:42:05 -0700 (PDT)
Received: from Carlos-MacBook-Pro-2.local ([2601:640:8e80:3680:8123:5123:76e8:a897])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31a9cd1ff78sm615327a91.47.2025.07.02.15.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 15:42:04 -0700 (PDT)
Date: Wed, 2 Jul 2025 15:42:03 -0700
From: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, brad@comstyle.com, collin.funk1@gmail.com, 
	pclouds@gmail.com, ps@pks.im
Subject: Re: [PATCH v3] builtin/gc: correct total_ram calculation with
 HAVE_BSD_SYSCTL
Message-ID: <ep4q5xwbys4qwpkmmo5jujzjorrb24v5na4yuwpjr5owojwk2q@omb7xpp4oov5>
References: <20250702154649.44210-1-carenas@gmail.com>
 <20250702202118.48742-1-carenas@gmail.com>
 <xmqq5xgacn2w.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq5xgacn2w.fsf@gitster.g>

On Wed, Jul 02, 2025 at 02:14:15PM -0800, Junio C Hamano wrote:
> Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:
> 
> > -	length = sizeof(int64_t);
> > -	if (!sysctl(mib, 2, &physical_memory, &length, NULL, 0))
> > +	length = sizeof(physical_memory);
> > +	if (!sysctl(mib, 2, &physical_memory, &length, NULL, 0)) {
> > +		if (length < sizeof(physical_memory)) {
> > +			unsigned bits = (sizeof(physical_memory) - length) * 8;
> > +
> > +			physical_memory <<= bits;
> > +			physical_memory >>= bits;
> 
> I do not quite understand this version.  Does the correctness of
> this depend on the machine having a certain byte-order?  

Yes, sorry and as you pointed out it is obviously incorrect and should had
been instead something like (barelly tested, though so please let me make
sure and not waste more of your time)

  uint64_t physical_memory = 0;
  ...
  if (!sysctl(mib, 2, &physical_memory, &length, NULL, 0)) {
  # if GIT_BYTE_ORDER == GIT_BIG_ENDIAN
  	if (length < sizeof(physical_memory)) {
  		unsigned bits = (sizeof(physical_memory) - length) * 8;

  		physical_memory >>= bits;
	}
  # endif
  	return physycal_nenory
  }
		
> then shifting it down by 32-bits to the right may fill the upper half
> with 1 if the result in the 4-byte long is more than 2GB because
> the type of physical_memory is signed, and then we cast that value
> to u64.  Which does not sound correct, either.

note that I changed the type to unsigned previously, but the rest was
obviously wrong.

the shifting was meant to be a cooler way to get those bits cleared,
because I thought that relying in the initialization wasn't as cool
from the previous comments.

> Would it make more sense to pass &u64 and return it only when
> length==8 as you did in v2 while removing the need to cast?

v2 (without the cast) is indeed enough and better, but my concern was
that this affects 32-bit FreeBSD which will be returning always 0.

a fixed version of this, would allow at least a better return, and
because most of the extra work is only needed in Big Endian (which
could only affect Power) then it is almost a free upgrade.

Carlo
