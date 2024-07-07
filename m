Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0250F3A8D8
	for <git@vger.kernel.org>; Sun,  7 Jul 2024 18:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720376270; cv=none; b=KgzYbg0/dpWcv6xgPqU9bHUHwJWO/DyT2/X8zSi2YfAf12y/AQuJoKvwOEZhDmgEnMtzLy737RQ0JVFoWZRhfYIp+p+Ep9I3MPlqNtk+ii1EKBmMuTOvaFD6IyJp2aRH4ezzzvCHK47jYoV/snS39ShGKSdc4qMKw1kIKl9XP/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720376270; c=relaxed/simple;
	bh=etpd2bOraW3AHhMxJ3GRbFergVkDN9gf/sYO7xbybN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lb39qIkZR0rx1snPAT0gcqhM5JSHL2GqylVV5Cqz+P/79NJxCpZCaPphGQOP7xH66PdK1HBz9CZnUELcn0/ishLySPkYOCsA61ZJXVXBnQloOPeCkptxfD/HGmeOItotEdUeac09BJ7fZbzvbUyU10acfkB7VSjUtmyfQG6hOks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HpjNosdq; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpjNosdq"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4256788e13bso21762205e9.2
        for <git@vger.kernel.org>; Sun, 07 Jul 2024 11:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720376266; x=1720981066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j85/LhThLgT9lF9Cxsm387utFXgGL2h94i7UGhfKYLk=;
        b=HpjNosdqW3xQ2h0aSWYGl5U16X22QIDwBOowKpSjZ5GFYln58SZt5TFKm3IDVBVlbK
         UcrUitKfQSYSL9BcjcaMfDY32L1PuyqkCAOwXLHXLYiaAFUYvBA1TLxbAw4XBiEI/kZw
         Yuhm1gVY2yRG/uagTZhDI/ORWVZ3H/M51XIQappyR3Dd/DjjhRxuGzWdLW0iBnzxswz6
         WbMm/oprT4jDHA5JzGC3wA/mdE4mCdJ90+a2B/oNi+AnTmwup6slONUrtClQFLBGhO0l
         sPaX51IIlckwCE+k3ZUx05IXOlImMzfq/zjU2Bjq3ut5IxowvoXYPifafJo3lAEqQrm3
         1chA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720376266; x=1720981066;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j85/LhThLgT9lF9Cxsm387utFXgGL2h94i7UGhfKYLk=;
        b=Ck0MjyjYE2008iYfnfUs1GkqaO19rBqy9b0PVVkNE6r4mmlO7hQ16GlQCRyvIPhXRQ
         /IoDw5K3w75pWd16FGRklr+6Gxlc99ArkGed0klUhIVI0VlL+DnUcWsJPrYqaa6oVp/U
         0umTLiWusDJ5JjMUVAwlycxb5FnMsB0xWS05RDjkLDAmXuQ0Qk1DpdpazwsQ8pVPYNgH
         65qlD/Nmmh3hmoV5SGTCb5JISVDmU8rZPoWg7O2nUUUN9ucow+pOhKbPhGbASEo9l1n8
         /dE34JSQpk5kYNTl8Cz8ZmX+eZs6qgtXUu+Syrl5l5Vdn12loOS9KGpcAioIJdLoA0j1
         FF+Q==
X-Gm-Message-State: AOJu0Ywp21liCTM3keba9i69M8r6Hn/TwVH5GYfi0eJvvrgclXKBSXKX
	quRH4KptmO3F/yeH++eUol0DPEUcHvSQ4AQT16vwJYrd86B9/E4v17i/fA==
X-Google-Smtp-Source: AGHT+IEMjP4BODTrXGWCL3d1WCqADlLeHOINE2mh0nDan5as3FnR01Twm2YxjQOk2bhbIkYjR5Kmmg==
X-Received: by 2002:a05:600c:4311:b0:426:60e4:c691 with SMTP id 5b1f17b1804b1-42660e4c88amr24278635e9.11.1720376266346;
        Sun, 07 Jul 2024 11:17:46 -0700 (PDT)
Received: from localhost (85-250-79-88.bb.netvision.net.il. [85.250.79.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42650b26c48sm102711045e9.17.2024.07.07.11.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 11:17:45 -0700 (PDT)
Date: Sun, 7 Jul 2024 21:17:28 +0300
From: Doron Behar <doron.behar@gmail.com>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Re: Re: Remove your ZSH completion in favor of the completion
 script distributed and maintained by ZSH
Message-ID: <peuc54wlxnhga5vy7rdnx4roudtngoztpodhs3f7ggbjfyzjdh@lgocxezv5tlv>
Mail-Followup-To: git@vger.kernel.org, 
	"brian m. carlson" <sandals@crustytoothpaste.net>
References: <mrn75pj663u6ikkwfnoq6c342l7w5plfeju4ji7norsmlzx4jn@3se3fmuqes4p>
 <87cynpnv8m.fsf@igel.home>
 <e4ylt2rihvm2uc22irsxbeid57ijblioekit3o4xpufflrqwal@5t67kr2a5ahq>
 <ZoqtHrKcdliM4Uf9@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZoqtHrKcdliM4Uf9@tapette.crustytoothpaste.net>

> > I personally think that Git is a stable enough project that the
> > commands and options don't deviate enough between the different
> > versions of it, So it'd be easier for you and for the distributions
> > if you'd let go of your implementation.
> 
> I don't think it's super necessary to get rid of either one.  The Git
> functionality is primarily based around bash, which does need this
> functionality.  zsh doesn't, but it can be used there if you want things
> to work exactly as it does in bash and want to have the latest version.

Indeed it would have been ideal if it was possible to use a `zstyle`
variable to control which _git implementation to use. However, that's
not trivial, as it somewhat depends on which _git implementation is
found first in `$fpath`... I'm pretty sure that creating such a
consistent interface (no matter which `_git` is found first) will
require submitting a patch also to the ZSH implementation.
