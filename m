Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A952F690D
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 21:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769723675; cv=none; b=oHDcEjFgAx5hwd3A8QAVJb/LopmLOWFTbB7AaW7RgN+yCvEEY9ZfVVtW/4O8NNCGLNkFmNGsnRl68uFgAnFKYHIBpGkmFgPvMZRdrZH/5a/F6a6WkAS+XjxZM25cyM/9fr3p1ZZwUFBqVWdH1RvROv6GZBzLhmWXrPcVkzjUYCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769723675; c=relaxed/simple;
	bh=k6E1a39U9ex7axUMFiMzVx83gApCfs9fvzNSvCZFEdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHtj2VqeB7rY3Jjsf/MJYKwfeJas4bJ0xhZmOVpEeuL91xypWhV623HPIPLIhrNkb+/R2E9IU70wylK8otm06Twi8WCYQtW2b5yYAjq7ea0hik/P5K77IJxobtp9R9p4nmgCqWrrM7ytyx9hbvohAo7EKHesz3vJgHntOsqWRbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ErmQuvcB; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErmQuvcB"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-4094fbd1808so618830fac.1
        for <git@vger.kernel.org>; Thu, 29 Jan 2026 13:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769723673; x=1770328473; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Eq16VAr7bLb/VMcWrxc8Z0hhkQvXN8KE8da6JcXdrHA=;
        b=ErmQuvcBGXNCV48WQxV74Irc3ac8gPZy0Id0+aneaz6NxUPUDfQ9FygBHCzjip9gik
         Bx432iemwoazDbs1u9RxUlXYyrSsJPyztXMDd/k/QtIb0iTJ1zYrEX50J4m4JUM1W35w
         Cns4Toxoqyfb+2oIYC6rRnXU93XamARBm0Aworl2IZGluzGDO/yVZ4UYwN6s6m/LCexm
         kdz7TdyujEjTMe4/h8YWcXFnqPG/NPmARX3WhFMNWw3ua7zwQSDAyPqRRwK8OuInyhzH
         gqyUXqQ7S0KDOFe/kxAWF6cFfPl8HdfewcJ96iuE7VBLtRsaRqaEdjIhuL5b1KgwqQlX
         BH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769723673; x=1770328473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eq16VAr7bLb/VMcWrxc8Z0hhkQvXN8KE8da6JcXdrHA=;
        b=DzIrXh1ECG2CxveUS/SzFszf+ecgTbNP7FOea/Yp5khTLokWgw6dJfpYOPNIuGdqNm
         kDxvqbkBWWTk/CiXh/ptIVyiWuVXjApWUNTj8OJ+AX41ovyfLm3ZIVt3KaizsOudUyJA
         cgUkNdsYuvZEH14zeLAxs1XQ1AOp/0iwhL6qQ09fjhJe5fY7Dh8wpr4g5DTnTMPMgRmF
         Mrqc+cFp2oWLNegck4I8D2nXzsQi0/Zy4jjDJr0gKw/eCEe5ZSVGIPTK9XKQlteSFPCt
         oxxe/g6fdBZddUWhvS44nN0z+oV39w9e336l/zz0VcedTs8iELElfCyJQHxWO7u1HCi2
         qU9g==
X-Forwarded-Encrypted: i=1; AJvYcCW5IEk78iJsKxydkO+wmoHw0ahzyTHNwrSmosXsTAVf2o6NoOoxrzVLyxwrH+rdPn2pbx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUl7GdIvuS43E4W4j/41Iic6ki1RPwpZXm5+zUUqL18QCtONKk
	hlSBAcmS0+8FxMA3sKyaUPzu/P3NVcnNQy6YZO2jmjfNNPisxqwpX6sq
X-Gm-Gg: AZuq6aJ4l2H0dOmAz7ztWWYDcymPbTg3tPVX4V90oe84eOOGaQhywsCisQ0rvEMcGnC
	8NU4nFy1kwQc6pQ56nvEsuAEXQjox1KYblVz4imLITcnHNQd0GxNVTudFBTdlNZbLRXpeKFY6/1
	x8KJX8ygc3SSRZNYQG3wm3BYdhaltYup00EiWnws+39Y1KhBtf1bY/W2mMCm26He+U938wjxz83
	eLt86KZOxx4+JGMrkqqKWlqOLmVhhsn5BkiQhaSfOmKVMRp71leg4k8/S2SI7THe27G6/40IQRV
	E9UqNPI0Qoe6T4ylRL074NSNEUdWzPTaA+DDKcEs+KOwiroWZvoAIffhqOFQDuhCYC9+FekSw/H
	EaeBbUWnJM/7rtGIaLViZbocUDWtEIzqKLh2L4gn2qEZd7WHnfVNBX8iP6R0tgnc7SDbZ5Ktolq
	sr9XEc
X-Received: by 2002:a05:6871:4704:b0:409:54a3:6aa6 with SMTP id 586e51a60fabf-409a6cea567mr669827fac.33.1769723672667;
        Thu, 29 Jan 2026 13:54:32 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-409570f3029sm4626229fac.1.2026.01.29.13.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 13:54:31 -0800 (PST)
Date: Thu, 29 Jan 2026 15:54:28 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 1/4] odb: store ODB source in `struct odb_transaction`
Message-ID: <aXvVeTVujuTzuPp0@denethor>
References: <20260128234519.2721179-1-jltobler@gmail.com>
 <20260128234519.2721179-2-jltobler@gmail.com>
 <aXtDYY0Ao24Mpgyb@pks.im>
 <xmqqcy2sb4qr.fsf@gitster.g>
 <aXu4nttn-SWcMmLL@denethor>
 <xmqqwm109n97.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwm109n97.fsf@gitster.g>

On 26/01/29 12:28PM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > Interestingly, it looks like there are only three users of odb-tmpdir:
> > remerge-diffs, git-recieve-pack, and ODB transactions. All of these
> > use-cases seems like a reasonble fit to create an ODB transaction
> > instead of managing the tmpdir directly. In the case of remerge-diffs
> > the transaction would need to always be aborted. If this is done, then a
> > tmpdir could become an internal detail of the ODB transaction for the
> > files backend.
> 
> ;-)  I agree 100%.
> 
> "Prepare to create objects that may be undone in the end", "Now make
> these objects we created so far as parmanent part of the object
> store", "Reject those objects we created so far as the transaction
> created them is being aborted" are requests at the right abstraction
> level.  "Give me a temporary object directory" is not.

Ok, I'll go ahead and leave the tmp-objdir stuff alone in this patch
series and look into extending the ODB transaction usage to replace
existing tmpdir callsites in a followup series.

Thanks,
-Justin
