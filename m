Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE8F2A1CA
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 19:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722971446; cv=none; b=cohyRKlWfbbRQSfRWgQqVuTJqNqrdnZS2pmWUcJT4PrYnyhoN3c+1Ot31skaCzETAtB5g7jgWbem0o51v52/ODRCe3DCjMHr0I/7mfaNTNGK0FbZG/IOsLjFL+2RjJrWLLGj+2GhvMRiXzjwbAl0FW5jC8vASMJOmkJ7ydXLapE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722971446; c=relaxed/simple;
	bh=aWDbfbWXAKF8UsEI+blL16nBEQj8eL7SSD24w+6z/yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8mCfVAPNEXJBpHPbE2ZqGetDsnVgqdMcfF9x8Xb5RhDg67gXyDhbHW2SSFc91JADDqnpU3lwkU74Kts6eV0YeyTu62LrGirVfx3PzxlfJpfp3KkCJ4lXmZamEXdCfA0rPeL135o0pX30mHFUP2BwabZKD5GNBwfdG8C+oFipkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDKDflCg; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDKDflCg"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-260f057aa9bso633702fac.2
        for <git@vger.kernel.org>; Tue, 06 Aug 2024 12:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722971444; x=1723576244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ezCUgj+k1Na61+dLSW72WO1yZ5B4+OsztYr5hxrx2vg=;
        b=LDKDflCgZvuJpSJX80BvZ/W4/ekCfR75sID7/uW4atPm813p/cCC5bnNWGJ1Wsykip
         vccMpx+x5pzxCq5rxn18qATmq/7/At2Sh0Xqf/mzcqDafN2gxKU8Jd/ZdoU8XCuX8VS/
         rfrcz1rchrIH525EQjP9qD4oRe1B+NWzuLUQcHVysY15uzLH7fm0moLoH+RNeO4dZNkZ
         U927Hdi+6VWS4u4SNPKOMzrGNIcDYyeVibBWwqZMc8m+e2j70ZE6AGMaXwhq1csnYo8v
         svpeUYiZfC+INPQiJQ3EiVRGYmEN+KdBUvar7Fds77FVJ2V9r/kRT72SnIPr1L4ytV/e
         fR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722971444; x=1723576244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezCUgj+k1Na61+dLSW72WO1yZ5B4+OsztYr5hxrx2vg=;
        b=IEoE1v1gLzxI5SzhtK52Hw0ylQYEUqfyFBbOPBWlp+WZaimYnQvcYOHkTwrdUIvcbg
         r3X36nHl8KMPXG7cEkp9NY0mR2v97U5ADm8fzts+lTfldqFtAU0KL6/qBIXmxBV1SxAE
         PB2RDxhTZPAkQh71T10S7MtMDN8l19P9WH7Z8t5vBJVZfOKhuWV2f2HjOn1bbjl3ZMk8
         9ZPlE1+tNcmaUmcVfjOSXoz+BXSuJ6u/6CrwC/hXHMbwoF6i2bK58FbFkAT1Y8DlFEpr
         DKJmJ0PNSXThGYOlF4GxSr1qkMX9YRb0+j2xmzkmq5ijrDLVWXK3gECqNk9Et3Df+A67
         wAqw==
X-Forwarded-Encrypted: i=1; AJvYcCWsSlnyxF9sE5DHqHBt9O6R6OXDX0u5GNpt+7rOfoeLxUiiGeg9TOdonff+L1tUMzGDq+il8BMyYAHme8HUmZo22bhI
X-Gm-Message-State: AOJu0YyduxVUG6my+O+NsXHYtTF8U885rffHmMEPTM8fdagn7cbiABqk
	qNOnL/hPWdNBd1YXctq22KDT0OdyVq6QlsKnD79yh8rgwWPOv+Af
X-Google-Smtp-Source: AGHT+IHoOlO42z7Xj4NQ58gknBEWYtNFLygiQWscPsuC7nhdXPSj7PM+I17J9HHxpNmJ5dSSt+rtnQ==
X-Received: by 2002:a05:6871:7813:b0:260:3fb2:b724 with SMTP id 586e51a60fabf-26891f26d4cmr19215964fac.46.1722971444285;
        Tue, 06 Aug 2024 12:10:44 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2689a67521dsm3383728fac.48.2024.08.06.12.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 12:10:43 -0700 (PDT)
Date: Tue, 6 Aug 2024 14:09:56 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [RFC] usage_msg_opt() and _optf() must die
Message-ID: <ttxuw2agwpbl3fc3wwo52mmetaa23ihxxfajnffcz3rudsjzai@3hxqx4okstpj>
References: <20240806003539.3292562-1-gitster@pobox.com>
 <20240806003539.3292562-2-gitster@pobox.com>
 <ZrG_A3UQk56aYJ_m@tanuki>
 <xmqqed71vbps.fsf@gitster.g>
 <xmqqmslptw3u.fsf_-_@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmslptw3u.fsf_-_@gitster.g>

On 24/08/06 10:11AM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> >> I always have to wonder how helpful it really is to print the usage
> >> information in such a context. I feel that it is too distracting because
> >> in many cases, we end up printing dozens of lines of options that drown
> >> out the single line of information that the user actually cares for,
> >> namely why the command has failed.
> 
> Yes.  I do not think I found it useful to give the single-line
> message, blank line, followed by the full usage text even a single
> time myself.

I tend to also agree. The printed usage information is rather noisy and
makes it more challenging to find the information that is actually
relevant. I would be in favor of supressing the usage information
altogether.

If we did want to provide some sort of breadcrumb for users, maybe we
could print a one-liner explaining how to fetch detailed usage
information for a command if desired? Overall it would still be a lot
less noisy.

-Justin
