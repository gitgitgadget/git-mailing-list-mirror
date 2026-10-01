Received: from mail-oo2-f35.google.com (mail-oo2-f35.google.com [74.125.231.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1FB37A829
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 03:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790824504; cv=none; b=mMlN8mxz8agiv9eGvwE8RnsjlNWEzJxuMuro1z/U74262D34CUaIdnu+MuuH4u6421hDVWqcJeDd6TXZrc50nY9ZP8jz+8sVVHq1Ia0Jj17hPrr04b/s0JCgTC4A0tIDryZUmRAgpoqz2nlNqCUeIw125IdMNzOeNi/FWkM7tLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790824504; c=relaxed/simple;
	bh=FecpBKXKeVo8/77ee2kvPAiiw3S745HdyL/y5Amhe7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DcFTyTHAP3jm8VDjDaEIeWPNIDK/jTpcHX5z/DRljxMadTG2p9NvT3MV6hx9rauGDMZtXYGrvk8VUL3lZ4R+opAUDOOlfypaje07NKbqYdfBl1qJbsOl62rh7YzdXgfsrN4bPZKFNv/QgoxlNbotJwSlkRyVB0LKpIlikAr5Qp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=PBNbMFdC; arc=none smtp.client-ip=74.125.231.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="PBNbMFdC"
Received: by mail-oo2-f35.google.com with SMTP id 46e09a7af769-821ab84c100so46277a34.1
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 20:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1790824502; x=1791429302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cOkxy7gU5YnCWdVpRe1pOxPLQHxUDbTG54fB481xHpg=;
        b=PBNbMFdCVtVy1BNXvLb5X2WxgWU6YnIbafR84TgisRniBNVLQoeAaLJHMzBBS0CYxE
         qH3XxSaYO/aXEbD397fue9gir7Npi8FaQGsRUQ2JcLLqbH6eH8fJcl2F3X7dFQ6Wq7NA
         DbdwzzbhaZpzg4wHlIWt+CPtvHq96Uzqhg9fo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790824502; x=1791429302;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cOkxy7gU5YnCWdVpRe1pOxPLQHxUDbTG54fB481xHpg=;
        b=s4U+6SFVQVeMzM2BNzmPfvf+6Z94FdrxSFZMn3ueb24wW+IWkDVNtbnwZntVvDNVt9
         FgEomCqKeQAEJkl+8/vw0J9x9dKPNfC1fflXNYv8OxTQT2dtoB6NrbhBHKp6aYfT9HpD
         xqb2G9WUtaSAY+UrzrSTLVtMm+eYnwCNhdVVrlcoTb9mf0llNeXOO0+Chpx0odH7yD7v
         IjHy00oPe8uCUR3jL/nuZ60S9nPKWA3sb9dz9qPUnhmUUAqxgTAMCmbvBf1u009k15aR
         L8rjvJ5uhaNT8ybOocKcgofAjNUAPRiJ87VD1tidT8plKQWdBfgYsDo/0QFYvcbsI/CJ
         qFCg==
X-Gm-Message-State: AFuF++nP7MS9wRUXNtFQab7l6i5CSZFBeL7Gs9C9ZZ/lzoqTV8yi4kcR
	TRolVjQFY3mBAZAtUbf3C/PSC/bU1ISlG0pPBiALbs8r6dzFQJp8fU/geAP6V4KnUBKi5Kz+tfm
	Djk1ELPY=
X-Gm-Gg: AYBFou0d0UWfmXaTOc2YQ+nb1MFIdZ9xs+y/wy6VwoVOovhIeuDnopqbecJ3oGK6y3q
	+CZZZD0/Rvk9WC+0p1+D8OaxlxIyobICapmd8CLdG+SpINT0IiZVNsbZfdy4I8sy/6Qtx5kILjp
	e2DkgH6RzSQUx0ql3cLjrW3yNP+7whuoXxSPFoaRm5ybP+rpaj/oJRP1jnru5jw179d9zuBP9x4
	epthIo4vdVboe4BJMWKyiOrM/3YpamYoIH005+jxrDRnLGMkhBPn0dH9/uph+x2W+6arkzZgWny
	Q73+7QL+kjZj9bhg1ddjm2biL03ceeDXnOSl7kIvkPraaqpBK2zIyZqE7VE/c9lc+JEsivxg6mk
	U5oLB9PDH+HpfQDxefeCJ60gacP0qp529hKy46oBvr/u/mJiWIqzHZ9Ec9VFQCgZ85FYnOParuQ
	ey3ms7M/cgoJ0FdGSh2siiSfYCcCJaHjxED9RY9q4kGRCGMEy6JTztec+fq90jXqI3ETdnYXhnK
	ZopCc1vUPIHjKquKqVlPhrCzMSvujAkqkEHJXFzopjcSw2ZkFrhkXt9w2jgMQD6JkAfUzLQ8T2k
	sCIFoh8h
X-Received: by 2002:a05:6830:3816:b0:815:cdb4:4a7 with SMTP id 46e09a7af769-82046cb95e6mr4155181a34.3.1790824502264;
        Wed, 30 Sep 2026 20:15:02 -0700 (PDT)
Received: from com-79390 (vpn-centralus-02.tradc-corp.com. [20.98.136.114])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8212aa11ec3sm1668491a34.11.2026.09.30.20.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 20:15:01 -0700 (PDT)
Date: Wed, 30 Sep 2026 22:14:59 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Ted Nyman <tnyman@openai.com>,
	Elijah Newren <newren@github.com>
Subject: Re: [PATCH 2/4] pack-objects: ensure tree/tag closure with
 '--stdin-packs=follow'
Message-ID: <ar3QM2QkmXfq11xc@com-79390>
References: <cover.1790731662.git.me@ttaylorr.com>
 <6348667e2e3fe63aeb139888e877dd8447570253.1790731662.git.me@ttaylorr.com>
 <a78a38ca-b08a-4194-b17c-b8802e4d43a7@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a78a38ca-b08a-4194-b17c-b8802e4d43a7@gmail.com>

On Wed, Sep 30, 2026 at 02:16:53PM -0400, Derrick Stolee wrote:
> > @@ -3807,6 +3807,7 @@ static int stdin_packs_hints_nr;
> >  struct stdin_packs_context {
> >  	struct rev_info *revs;
> >  	enum stdin_packs_mode mode;
> > +	struct oid_array extra_roots;
>
> I believe this should be an oidset to avoid adding duplicate objects
> that appear multiple times. The order of these extra roots doesn't
> matter (such as in a --topo-order walk). We only care about the
> binary "reachable or not?" question.

Great suggestion! I adjusted it in the following round.

Thanks,
Taylor
