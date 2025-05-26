Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF95A1B87D9
	for <git@vger.kernel.org>; Mon, 26 May 2025 14:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748268780; cv=none; b=rr+JA6cF/13RpfI36JtwhF+ddl5D9XutM7Sm33OItK8IkLE+txrS4g++WqT+PtX3jhxUdQX+E9v/oWUj/JiMrDxxSJqfpmflisLWeD5vdDZDPf+dSTRPJhdeuRzxXaCf7rKE9VYISAjzuXUTDibztYGg6GbUTTC/lM95RZwiwEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748268780; c=relaxed/simple;
	bh=XVqnyBfvdzmbDoDXshXePdzI0L+Qq9vGXbkNJGr85CI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGRFamGaZvlgqQLvRMSzuDB6F+Mk24spvkPVB/neR+WYmZbZG1zFeoh3ulq6echvHb/ZiZc5He+sSuoU3XfZfqUKMRTAsdnMeQEbDB2iGp3jhnT9QI5z3ayzOhsUuv56Ia9MoQpzAPsxjGTCSO3Buu6z8o5pwYSQrQf98ri7/jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+IzWn7o; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+IzWn7o"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b07d607dc83so1359463a12.1
        for <git@vger.kernel.org>; Mon, 26 May 2025 07:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748268778; x=1748873578; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jzRMaGtCND9koZkgL3nNbeYy9ZKvvQc8pb28dqadRXU=;
        b=g+IzWn7oVXgtLoAvY900YTic9y796bIB5YNhtMKPkGJ37qKtLz48IpV1cmORdkcQ7Y
         PuKtGbV1S7x06K8FCXK0rRJnWT1DOTLQPPPm7/6ZI18t0V5/oqjVDcpkcaSWFu9NpVnJ
         UoYJ9iIs9pnPo8BRz+qwBEFT2hxAZb7elARpJwudbO30eB07t3uf2xT+bPknfQRFenr0
         RJ5DA5JD8dlnxmCwPdhgcr4AHOK8w3Zs4UpVshdmnJiI7493O7LftQPr/MqDTI3mzI3F
         cN0Key3OwEol4sEsxzdcOX1mwNxdN1fHabNLBtwQN1d05MpA7td21UrsTeyYbyJQvarm
         ZYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748268778; x=1748873578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzRMaGtCND9koZkgL3nNbeYy9ZKvvQc8pb28dqadRXU=;
        b=qQfEFoA6usDCj5EpdxxG42FyMq3PntORv1QcYYpPxbfo9iYolkwW+8mELF9hOMMDPB
         V2UJeh4rnjNUHvDr2Zxske+rfW8tZbCUSdVeQyfxHssmCkzEt3DJuyDvtaJkn8luFac6
         9kFtRzRnDHSB5PIbQa9x4LnI1cyPtIFUCouhepXIObS6DTIeXMt6SDEcqTGuMyyTA+x0
         mhbUQeOOijbGp/PBpRAeFjmf0YGRDILAvQM5yjxjt1MZi5h2/x3dkaSyNmz59u1bsIay
         jUC4QaDDIMH00tq1f7+tjjJsmBG1ZuEUMOY56tBtUQ/7Fd9XaYZjA0wM4CszI0XcrhzR
         gpBA==
X-Gm-Message-State: AOJu0YwASJ5knHHw2PwUkPaElf0VJY4zUxtIx8m9sj3k6YdzHba1gKg3
	jY9FfTrPswFxNedPCcS/NWdMxtFKQfalYZyuACqs1VNMk+ayG7OciA+hyPzzuBj6
X-Gm-Gg: ASbGncsi07BL6zsnEKnRRWwrMIBUxEikjlvmGYWBUEceMjkiukD9HiTjeaIAV/Us7q2
	rHxgbqxPspfQKlzxg+tsvE4+D35ghqqxvDwzRK1874qNXer/ZXKaTzk2iVdsER8tXqcz5D8/UY/
	8kB4GayxrciEETVQQZSI81foUPnvhkWgSx4iVjsDjlKsEgNK9tFG+HWs0ND+sOz+BurHC+V5WvL
	bkWTnkHS5QhfUePHe7pbhL3IguIVKcv7aGN9DgzEtOHhlc2MIHcKhtECO3GZN7tqrg4T5i38EOM
	dBsp5XdfR3YQ09Nrr4Y18bBYU9QDjIU9uImKvAkOppvAjX1NUNN52HyQhQ==
X-Google-Smtp-Source: AGHT+IG4xCmH5sMKCSaBZTEIW7/rsyiuYBGfV0K9fG0azEslxMXRiZSFYz6kYm6MhKZp29In5AEYkg==
X-Received: by 2002:a17:90b:4b51:b0:30a:214a:c64f with SMTP id 98e67ed59e1d1-311106b339fmr11359034a91.32.1748268777747;
        Mon, 26 May 2025 07:12:57 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-30e5545849asm12711082a91.0.2025.05.26.07.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 07:12:57 -0700 (PDT)
Date: Mon, 26 May 2025 22:13:02 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/8] string-list: return index directly when inserting
 an existing element
Message-ID: <aDR27iI_cAFAnTWI@ArchLinux>
References: <aCoDB9P5XV1lHMil@ArchLinux>
 <aCoDW8CcWeq8T9hp@ArchLinux>
 <aCrbKI_c5Bma8ZDQ@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCrbKI_c5Bma8ZDQ@pks.im>

On Mon, May 19, 2025 at 09:18:00AM +0200, Patrick Steinhardt wrote:
> On Sun, May 18, 2025 at 11:57:15PM +0800, shejialuo wrote:
> > When inserting an existing element, "add_entry" would convert "index"
> > value to "-1-index" to indicate the caller that this element is in the
> > list already.
> > 
> > However, in "string_list_insert", we would simply convert this to the
> > original positive index without any further action. Let's directly
> > return the index as we don't care about whether the element is in the
> > list by using "add_entry".
> > 
> > In the future, if we want to let "add_entry" tell the caller, we may add
> > "int *exact_match" parameter to "add_entry" instead of converting the
> > index to negative to indicate.
> > 
> > Signed-off-by: shejialuo <shejialuo@gmail.com>
> > ---
> >  string-list.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> > 
> > diff --git a/string-list.c b/string-list.c
> > index 8540c29bc9..171cef5dbb 100644
> > --- a/string-list.c
> > +++ b/string-list.c
> > @@ -40,14 +40,13 @@ static int get_entry_index(const struct string_list *list, const char *string,
> >  	return right;
> >  }
> >  
> > -/* returns -1-index if already exists */
> >  static int add_entry(struct string_list *list, const char *string)
> >  {
> >  	int exact_match = 0;
> >  	int index = get_entry_index(list, string, &exact_match);
> >  
> >  	if (exact_match)
> > -		return -1 - index;
> > +		return index;
> >  
> >  	ALLOC_GROW(list->items, list->nr+1, list->alloc);
> >  	if (index < list->nr)
> 
> Okay, let's assume that "index == 2" here and we have an exact match.
> We'd thus return `-1 - 2 == -3`.
> 
> > @@ -65,9 +64,6 @@ struct string_list_item *string_list_insert(struct string_list *list, const char
> >  {
> >  	int index = add_entry(list, string);
> >  
> > -	if (index < 0)
> > -		index = -1 - index;
> > -
> >  	return list->items + index;
> >  }
> 
> So we'd now realize that `index < 0` and thus calculate `-1 - -3 == 2`,
> which is the original index indeed. So this is a nice simplification
> that retains the original behaviour indeed.
> 

That's right. Actually, when I find out this by simply calculating `(-1
- (-1 - index)) == index`, I am a little surprised.

> I think we could simplify the code even further by inlining
> `get_entry_index()` now that `string_list_insert()` is a trivial wrapper
> around it. But I'll leave it up to you whether we want to do it or not.
> 

That's right. But as code it is, let's just keep this which won't hurt
too much.

Thanks,
Jialuo
