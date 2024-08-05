Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49123F9D5
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 15:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722870585; cv=none; b=hrQJfkmXoNaZRkiyAhjTkJJQYup1bO0SByqmk/azFU1ZPcCVrYdclH9Ph8tJwz4RN45XF8nZwbOZa7vZpyCADfRhDwQmyIdZ5ekVbYnZOcirW1a1NP42cd0IBDeL7DSmRn5n2G7xXEdaxCKh18cr4BJ/Ja4wpfTgpV46obQODyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722870585; c=relaxed/simple;
	bh=N61wQoBIEIurmvZKT2GSRGwCD40vohqrRXtQI82BC8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hr7eUhryBkY/LKYrTEQJQyTspRDzYdRj2uJyk3HAARP5FwjvQInc8MmCqcGwP6NZoWsJPHiW1YHiluPKV+HyKgl6YwWi0LzmOSzlueuPJsOpolHcB3ENId48gmgImqQJ7eAsd2TgiFlBsWo+jRp+IW/PZVJhwXDywWMB7+gPrkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XU8vkN8I; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XU8vkN8I"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7b0c9bbddb4so5038852a12.3
        for <git@vger.kernel.org>; Mon, 05 Aug 2024 08:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722870583; x=1723475383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7u7tF9uvHc0Hf4MY181vQSjGNohkUylv524qwC6cvkk=;
        b=XU8vkN8IZM4mNLRkf0ZwZ45mwGZGUrL3dn7A4OyMqbD0iaAlLEBE+GBy9yp2iHuevG
         s9U2XxJ+QuMvKCBqqModytQT0IoKfdLnGV0hx+5ikiHGgLrUQ3KzzCec9ppWiPH1Tdnk
         3Uq8iDpJwjgDQzWXJwmARNe+a0q5rT6OedsI+PLNPOx2FDcA11Wt8okv+I8b3mcWm35t
         xRXkCrdiBQPO5fG0KQWcZdIc81bMP0tcqQrnCnUdbFjfd/IDX04ZtRDGjZcbTJ36Q/Xc
         kF9eQNPvbGesZliTBFEHRXPryBeIJkAz5pcIvg6zvP0qh5vFhiKLoQNbWD32KCIiIlqU
         AU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722870583; x=1723475383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7u7tF9uvHc0Hf4MY181vQSjGNohkUylv524qwC6cvkk=;
        b=qQMdRakNdMq8e6MYAsjVxTPKnjScHgv2RPnhdRx1MEB0K6cCq8plUdY7VzYqaDtsjP
         vNQ/GV1JPwOLftcag2e8yJY4P+J/fB9+CaUZDvOKYh983Qunc/pVKSpIbuyVwlOIqfFF
         19IDFTpw6s3BSOVsocnPLMySbcJxpPwQHfqHnLPsQuYngcpL8y97yonI6o51BAVPloPj
         aDsWV1k4QXbs+xJAe8DrJlVW9b0S9KQaIVZ72P1sT+Vl0DcIOcltt0XI6Ii2JzUYGZVJ
         8QBrHFa+iEg0NHY/iXj3nzGg7X4jeSjq45DFergvw4CEr0pWF9iLUDQX9SK8CJC9Ypjc
         DWBg==
X-Gm-Message-State: AOJu0YygFyEZR1+RUmfvEKbJcQwwiEj3TGDv6ibdRkkX4m2SFki6UX1S
	Km5dAmBsfrD11XGNE0kV+/f/sDqSBuJpcDUXoiQJ4paiDiNe1Wo0
X-Google-Smtp-Source: AGHT+IGORkUYlgglI57Fiae1+4vVd7QyYIQ2VmtFlSVjB6vFd62IcFxu5FsnWv43TrpdWIefH4FFvA==
X-Received: by 2002:a17:903:1106:b0:1fd:9e88:e4d1 with SMTP id d9443c01a7336-1ff5747edeamr97202825ad.51.1722870583088;
        Mon, 05 Aug 2024 08:09:43 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff592aee19sm68845605ad.282.2024.08.05.08.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 08:09:42 -0700 (PDT)
Date: Mon, 5 Aug 2024 23:10:10 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v14 03/11] fsck: add a unified interface for
 reporting fsck messages
Message-ID: <ZrDrUp0jeeIOnn0D@ArchLinux>
References: <ZqulmWVBaeyP4blf@ArchLinux>
 <ZqumN5cfsQYHlU5X@ArchLinux>
 <ZrDMXgEuE8yeSzkw@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrDMXgEuE8yeSzkw@tanuki>

On Mon, Aug 05, 2024 at 02:58:06PM +0200, Patrick Steinhardt wrote:
> On Thu, Aug 01, 2024 at 11:13:59PM +0800, shejialuo wrote:
> > @@ -254,9 +251,9 @@ static int report(struct fsck_options *options,
> >  	prepare_msg_ids();
> >  	strbuf_addf(&sb, "%s: ", msg_id_info[msg_id].camelcased);
> >  
> > -	va_start(ap, fmt);
> > -	strbuf_vaddf(&sb, fmt, ap);
> > -	result = options->error_func(options, &report,
> > +	va_copy(ap_copy, ap);
> 
> Can't we use `ap` directly instead of copying it? We'd have to get rid
> of the call to `va_end` as our caller already does that, but other than
> that I don't see any reason to copy the argument list here.
> 

Thanks, Patrick! This is right. I will fix this in the next version.

> > +	strbuf_vaddf(&sb, fmt, ap_copy);
> > +	result = options->error_func(options, fsck_report,
> >  				     msg_type, msg_id, sb.buf);
> >  	strbuf_release(&sb);
> >  	va_end(ap);
> 
> Patrick


