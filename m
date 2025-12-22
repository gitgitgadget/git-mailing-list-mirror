Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DD930C62F
	for <git@vger.kernel.org>; Mon, 22 Dec 2025 08:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766392016; cv=none; b=dg8RiPJpwZC1KjB0qqgaflbpwjM6B9NKjdRHDXGgg8oKtMEMBr9mti093vaEl+rOAQivHzVfTj8eC07oUgNuwWtf2LzWnyE29YfpiIhHuJ11F5qdC0qGHDpTEXldrsuA4YSRtnAl9ZLfeQ8bL2QasW3O9r71cJ7dfPweW41/5vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766392016; c=relaxed/simple;
	bh=oq8kbPkJFFyoZS43el/RXhhgV3VfV6aVA4p6PiLz/HA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RmLRCy5PRXvAwhvOjCRCEn+Wnv8iG2Q2kJO+x65JwWsZ7w4IMcNUF18AIFpOs4nRP/J+Yo40TLlfjMRw+gzJ0PeML+2S4AxINXuJPrgPsSCnu/1IWiHDeHhKhZ3nnWZYl+WgrMOn9QSI3uWGpJjlhqV35yIYT3V9y/WDC7iH2MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNdkrgnE; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNdkrgnE"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4775dbde730so2939565e9.3
        for <git@vger.kernel.org>; Mon, 22 Dec 2025 00:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766392013; x=1766996813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0kVw2/Jw+12+LtTA7iefY1tT/h9i4MMV8ReAJ6/FdQs=;
        b=QNdkrgnEYt8+y8PYmvRyXqaeKLH8Ch9yURNV1hFUKzl8+V5kRwx8wwVlRbcyvzqrwz
         3at1MKHoB1x81voKI4UTi4yhwrLflIgekAdwDZoD7nvygZULRTkUEUO0WqsGK4vhBeMX
         EulyQB1RlUtVdG9gi+O8ax6qQeXNxMjxzw9xCMOIC98ELVRXfrMu60jbNfMyW302z/iW
         w3fPisB9+thWMt37B81cHrjRRFC5VDDbj5xxUp8tsU7MX+CXDGhdooM4LiyTGoR8JkKh
         NK1K+AURIHtaUnYmGuafrmGqZrcEeRXol4IrjJtDA9wSSF0ECFyeDX8kXDk8LvfCytt4
         lNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766392013; x=1766996813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kVw2/Jw+12+LtTA7iefY1tT/h9i4MMV8ReAJ6/FdQs=;
        b=PQagzetiQGXlAB0PwBA/FAiHayeJq2EUReUoavhR6oDefTX7xyKHAC1lgQnadnfbn+
         UEtCx38VMbeqzwa1UCCGklsQZwNro5NpVRhHYyGL9FGVHnK7BF7ykZTzyVTF8BdkM9vY
         9rkJCydZH2R1y+oWWTOwUwb5AxJtigu9Hoan58tc28IKl8fxO0ZFCNOoU15NQCxcfoI8
         BzOrcK9uDaJUY3vxPUN1uKvFP5oqrHwScbtf1mfYTvsIhMsYWHvIA6pFye32zlRjotgP
         Q5GWxYorTC64S5wVR6XB/qI7XrRjgORRLgljR11a+GTPdLsFOarfVQw3+eT4qzsn5our
         LT5w==
X-Gm-Message-State: AOJu0Yy67JNBlAPEshML8L4t2OpmzN8xecNSyw3Oh0DmAvLQSLhKtaS7
	4UQQ5r5Mr3lhKumTkQh7Cqjh1628CkBZcY1a9bKGbGyFiIkwGZD2UlrI/bW8ZwlyPdI=
X-Gm-Gg: AY/fxX73Q2sUKsPaF6F1GRgFS213v6AzIsHtXniutzYsDU8RZP37pfFPi2zrgP5bl9Y
	ToIe9P4/7HVxLiewPFFqXM4uYpebbniihOOa6+BEztfJszibMWMvbBjREOcfNYPQE8k+4AjN/nN
	Nidj9DoOcr/5uWzNVWyum3/hcErZ2JfrnzUv8adu8jTNAel6hnd+XSH8GZ/3QFHOoGpVYJxkEzj
	XmW/UnLmdjKEgWZXmCxbFGxwGia4DaXSE86C2BaUvIa3i82fWPybPMf+du0qU6/ZKtbjPD84xiP
	dOLoqyMgcG2Mq1fV9zd4UZMglo/dbhTiE7L8ZZQCHlamNt/j7O+moBkUSsYT6HuV3YuJ87UrRNL
	cglaV5mfe+3S8TDlCaiQOcZCsMpBc+dc560UXMv6HfF994Bi+ImkZgZBm0uPmFTQYSMyvTjKQpJ
	eNK83ivra/X0RrrA==
X-Google-Smtp-Source: AGHT+IG+tQ370GXrf8nsfW/tLgYoX4/VdBjRHUcBZQYfuMrij3H7buVggg1ecpd7jRzhu6Y5h6XSEg==
X-Received: by 2002:a05:6000:2305:b0:429:cf2b:cb0a with SMTP id ffacd0b85a97d-4324e4bf220mr7239377f8f.2.1766392013128;
        Mon, 22 Dec 2025 00:26:53 -0800 (PST)
Received: from desktop ([194.127.199.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4325dbc522esm10041387f8f.11.2025.12.22.00.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 00:26:52 -0800 (PST)
Date: Mon, 22 Dec 2025 08:26:51 +0000
From: Matthew Hughes <matthewhughes934@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] maintenance: add config option for config-file
Message-ID: <fmj4be365s6jczb6p2ccb6a6vh64bltgfl5neshu6g7hrabzeb@twzrzmprhotf>
References: <20251218184751.31209-1-matthewhughes934@gmail.com>
 <20251218184751.31209-2-matthewhughes934@gmail.com>
 <xmqqike2x4ei.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqike2x4ei.fsf@gitster.g>

On Fri, Dec 19, 2025 at 05:27:33PM +0900, Junio C Hamano wrote:
>  * maintenance.configFile specifies an additional file to which
>    maintenance.repo configuration items are written out when "git
>    maintenance register/unregister" works.  
> 
>  * "git config" is not affected, so "git config set --global
>    --append maintenance.repo foo" would still write into the
>    per-user configuration file.
> 
>  * Also, the general config API does not pay maintenance.configFile
>    at all, so setting it does not affect "git config list", for
>    example.
> 
>  * You'd need an extra "[include] path = maintenance.config" in the
>    configuration file because of the previous point.
> 
> Am I following you well so far? 
 
Yep, this is a good summary of what my change looks to achieve. From Patrick's
response (https://lore.kernel.org/git/aUT8Vcevf8WiQgn0@pks.im/) I understand
the requirement of the extra "include.path" setting is likely not acceptable
for a usability point of view.

> Giving an explanation on your _intent_, along with the sample configuration,
> would help your readers, and I would expect something with a similar degree
> of detail as above in the log message.

Thanks for the feedback, I'll look to be clearer with my intent in the future.

> I am not sure if singling out "maintenance" is the right approach to
> solve that issue.  If we had a mechanism to have two per-user
> configuration file, where one is read-only (as far as Git is
> concerned) which is covered/overlayed with a separate read-write
> file, not just "maintenance register/unregister" but all other
> things that writes into "git config" would use that overlayed file
> without touching the base configuration that is read-only.  Wouldn't
> that be closer to what you want?

Indeed a read-only config as you described would be a more general solution,
and a better one than focusing on single commands like this change does. I'm
now curious if a similar idea has been discussed in the past? I'll go have a
look in the history of this mailing list.

That leads me to think my proposed change is too narrow in scope, and risks
dividing functionality: where some commands are taught to consider the separate
types of configuration, while others are not.

For background: I singled out "maintenance" only because it's the first git
command that I can remember seeing that was writing to my global config
(outside of "config" itself).

