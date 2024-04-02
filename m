Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6445F15AAA6
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 17:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712080049; cv=none; b=m7MY3Y9NzQJ+bboG2Vgamrw4vRI+VeSXs+fz1WUi/znofUUvTP5yQErQ3cdBPRdqAfnxQAjTv+tcNl9Nqq6SnmOMSE4oYgzt/U+mdIchyRB+6pL47RSHFiVFlAAtRkULEPVVVpag0vngpvWJKwGr5Fr7PApvWztUbh8bdjuQhig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712080049; c=relaxed/simple;
	bh=P0U7RJGzjjCcLu7yGfz3TZs0NKe9oI5jaTwjSpumUvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2ODGF10ryMBLbGL8TswPytJlN7X3X8PIS1Zxv8tuBsPU+YqZUNF4Z7NdfZCXoCTdG+qIIo3YHg2oArk2mlddZm6HC6lq8sr+Ud49jTTb1Dwna/I9pSV58FcbY5HUG0VaEXUQ+IRVPCuYYNI7igZDYcV0q6td4xlvepho6Fwstc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=So1fFUN2; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="So1fFUN2"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-22e78e78ccdso380459fac.2
        for <git@vger.kernel.org>; Tue, 02 Apr 2024 10:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712080047; x=1712684847; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HFOluSO3qdLuftjAMWLHuo04yJju+89iNyF9+5q7UOQ=;
        b=So1fFUN2WN2hX+zW5ka4QF/1eM1ddOU60f+DUVKJ1M0Q/WWdSgozhaUcAdVpcz5aCk
         r7bPv1fuLYlp6G6ruMAJesL2+1ssiHnBVHKnuUG/K5E5YdRW2xuzlsobCd/gCT684vuQ
         NVTVzftwymv6WkfHCTQmlUg8mJxJszRtgzkgYYV3zYDvOuZk4V/jnZQCnmwC/6oJgRXz
         9WPleLBGhltc1w6PuoNgl2Q3XH3lCEYDkLwSZptN3bScpIA9UvkaQ8eYzBVwcsaJf+aJ
         2dGdmRL6ecEeiFYct0wJWN6gmXzaUtO6sVUxyN+z1g44EB7Hb6XvHeVgElZrXDjILlBS
         R04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712080047; x=1712684847;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HFOluSO3qdLuftjAMWLHuo04yJju+89iNyF9+5q7UOQ=;
        b=C/mZODWdpwLcnve/rxlC+efHCJN0ANJJfXtI/+ypPcEkLgTykDjUkK5QJ6hBQeXhMK
         Ru3JWwPWd8B4Ce8wpRJkR0xDuT2mZS2q5cNb6djIK875c+ysYr/ws8PB2qo9AZdkGM7P
         TvOx4FRhQPekrNwcVyxJw1BsisxJMMTGKjxpizOyI61tkUEVH7A8l2rGP3zx0ZtX1R44
         zb9GIhnoTUw/51RGvId2dzw1J/C/E3GChvN2R0L8e+kdYxnq7cBwRHIfEypTnANXGpgT
         3zActiai0wwb6mwVmgGpC4mZih1pMlT7paQuvWCXnxLLXFc5hfZSADoof/pYJe7rBy21
         q1qw==
X-Gm-Message-State: AOJu0YyV5iYKfoy8qGoZqqDMy+hIoHVhdfHPO7RjQAceAxIY/QEYcl7v
	0KYNw1zQnzTShsjN2LPpGekxHBRt3brNn8npN8kNOkFoavJAhEs956qRP5il
X-Google-Smtp-Source: AGHT+IFfNxTMS9J/0TnLVRons7oJN+Y6Axgn0oOVTvceio+mxeHJSOnk8ACksEN/eIwtlMGMCApvVw==
X-Received: by 2002:a05:6871:3489:b0:22e:8921:a066 with SMTP id ni9-20020a056871348900b0022e8921a066mr1007820oac.31.1712080047521;
        Tue, 02 Apr 2024 10:47:27 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id jd8-20020a0568702a4800b0022e77f822c3sm312044oab.39.2024.04.02.10.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 10:47:27 -0700 (PDT)
Date: Tue, 2 Apr 2024 12:46:30 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 4/7] reftable/block: refactor binary search over
 restart points
Message-ID: <ympg3oam4pty53qnxhtnla2xac73gdqsoclwsuzcmjd4dn4xre@j64veypnecrj>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1711109214.git.ps@pks.im>
 <cover.1711361340.git.ps@pks.im>
 <5e20d93ae000359f2231bf950a930cfc4898ced2.1711361340.git.ps@pks.im>
 <45v2z6uszlkanwl5qhvio4ikrrytztohbmdpnmdwiefyznclum@xhbvlvnfmkmq>
 <Zgw9PlgGDcmwLnDB@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zgw9PlgGDcmwLnDB@tanuki>

On 24/04/02 07:15PM, Patrick Steinhardt wrote:
> On Tue, Apr 02, 2024 at 11:42:29AM -0500, Justin Tobler wrote:
> > On 24/03/25 11:10AM, Patrick Steinhardt wrote:
> > > When seeking a record in our block reader we perform a binary search
> > > over the block's restart points so that we don't have to do a linear
> > > scan over the whole block. The logic to do so is quite intricate though,
> > > which makes it hard to understand.
> > > 
> > > Improve documentation and rename some of the functions and variables so
> > > that the code becomes easier to understand overall. This refactoring
> > > should not result in any change in behaviour.
> > > 
> > > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > > ---
> > ...  
> > > -	i = binsearch(br->restart_count, &restart_key_less, &args);
> > > +	/*
> > > +	 * Perform a binary search over the block's restart points, which
> > > +	 * avoids doing a linear scan over the whole block. Like this, we
> > > +	 * identify the section of the block that should contain our key.
> > > +	 *
> > > +	 * Note that we explicitly search for the first restart point _greater_
> > > +	 * than the sought-after record, not _greater or equal_ to it. In case
> > > +	 * the sought-after record is located directly at the restart point we
> > > +	 * would otherwise start doing the linear search at the preceding
> > > +	 * restart point. While that works alright, we would end up scanning
> > > +	 * too many record.
> > > +	 */
> > > +	i = binsearch(br->restart_count, &restart_needle_less, &args);
> > > +
> > > +	/*
> > > +	 * Now there are multiple cases:
> > > +	 *
> > > +	 *   - `i == 0`: The wanted record must be contained before the first
> > > +	 *     restart point. We will thus start searching for the record in
> > > +	 *     that section after accounting for the header offset.
> > 
> > To clarify my understanding, does a restart_offset not exist at the
> > beginning of a block? I was originally under the impression that the
> > first reset point would be at the beginning of the block (or just after
> > the header). If this was the case, the first restart point being greater
> > would indicate that the wanted record is not contained within the block.
> 
> It wouldn't make much sense to include it as a restart point. A restart
> point is a point where the prefix compression will be reset such that
> the record at that point can be read without reading preceding records.
> This is always implicitly true for the first record in a block as it is
> never prefix-compressed. Consequently, writing a restart point for the
> first record would be a waste of disk space.

Thanks Patrick! Good to know :)

From Documentation/technical/reftable.txt:

> As the first ref block shares the first file block with the file
> header, all restart_offset in the first block are relative to the
> start of the file (position 0), and include the file header. This 
> forces the first restart_offset to be 28.

I'm assumming this is out-of-date.

-Justin
