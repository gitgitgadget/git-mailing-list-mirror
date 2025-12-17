Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F52935503E
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 17:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765993808; cv=none; b=c7VNZt1+EdExgRqk9yYeznwH+O2ibHO7zvEWl3cv1w6FReD0LLrMdgC/ecG3/txwm+GlpTdgwVI3oY8LczohRL32TWTNA2Hr7uwQW4UWx3NdvoetuK6txbCEWDqPRsQy8BHI5kEOwFR4NGVImfbkpdNgJ9xrwMmkGRkFE/A9RPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765993808; c=relaxed/simple;
	bh=YYw5Y+nkXcfCNdVaCq0JQt+k92E/CKx9dqmLY+AIjRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDc7O2zRNjERlJM7MYr84phDi/646a1o9sAuE/e7Mk1qv9N4jYFRoqknRQx9cWatXpc7pxlTLcQxxqz9/IqM0SfcsoOg4W6Yo9oJaspyN/KVHPaJNzMi+6aw4eUO5eqmx4jswvaoILRcJHyNsZrdAUZrdAUFjNVGw3iTAJetO8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQxDO/9q; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQxDO/9q"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-3e37ad3d95aso4392221fac.3
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 09:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765993803; x=1766598603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JuxNxvvW6jkxJcP2r0+ExzZbu3KRYcC/JW+Duh0umbs=;
        b=PQxDO/9qkKQRqqyQ/bF3JMM2M2yW0EeOLKs1vTeIOfyNX082Tsde8wDa7wTr+vijEE
         6ypgHy49v6Kisqu8o5FIajm5pxUWFMQOLYcBpA5gZlz3nZgvbkn/udrLjRzrH/3XXC4L
         KnZwA/gRqlyQ18VUtoOpSQe6ipAaigJjc0XFReDIDwaKqDzjM74FCvVZyP9gaRnBqeHp
         0ha3ARwQJgz0bKtIGYIyQI3l1XC8rB/uCrgn7d0I0j9Bkayzzg4R6UKos3tDrDe22MYQ
         4wUXtKu1Hclke0sZDH71ZDDljun/r4PJotXOki+qx4vVxsvSqzJk2q0J4C4HgOl67rOF
         fA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765993803; x=1766598603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JuxNxvvW6jkxJcP2r0+ExzZbu3KRYcC/JW+Duh0umbs=;
        b=nx75/lN2ltusxkIV8105BnneFT6PrbWMGTp+V5kzKlImqKp30wtTUvm2gMauu4ZuO7
         8J2X4oImIJuYdIxqZGmken9oNdRAktQgGcelF/9EiCNp37mOm9SFhF7+ucWbc0ST85hs
         gsozzkM+hsjIJQSCozyhx9AwIBEWeJ37flzkdvrrlIoaKRF1pf0mA0cpnFaMfmKtSP+q
         KW+0BHGlM/ma2Tk9mtyHgPayByr8ds490nWsdsqfJwlBJc/MarV1KxzDAFBOGdBVLtI5
         BRdvJHTqmVLkOA6ZhpJMGre+ULoSDHgN6JovboWhU5SsyfKw7rzEk6VPFhfuOpyl02yM
         tmhw==
X-Gm-Message-State: AOJu0YyI0zgtpFE8GbbMf5aO1wObXjCMsj+x+TcwHoaxYe8ZHTotfAqb
	j7FHvu6J8BQyFUf2Ps7JwHWGQMFTZ3Ad8OPnY10pyBvMD9j3t9F1H/Xd
X-Gm-Gg: AY/fxX4s+/s7fgOtRV6khH+BITmsouuHz53hgQQ37HTizKDq4RwtRH/Jn5O4kaNNx4u
	t+9+vPmE3Ot4+WIXXijfMCNTZF0Ep46tBN0fKyEqOguuzLEDd1r5RAnEWWqrzPU6OppbAnoSSlu
	Fv516/9z+lEDPyGObNEs2A9g2qsBU4itXFw4QVzoqSXp5IsHaDVipxHMs6Oe/gj+ub0g8yO/KTw
	VK44Yiq09wanJ4oNchpqXJrqVELD4qHvhAbOPKHipF+MesB0TgWBEU6PnebcvMqwBhEJV2Koiv1
	KOldMnpUiTQ61orWebKH4XtwIMN5ohr2tRaNLHVuSNw7RSbIY/OAWzpbh0NF4oeo27xAvEuT/Ax
	Liz//t5GFQB0btNstnt6QfAfhBLnHufjGRVn77Fg35sOZVaq1+gQk83R5WsM8QKC8F4aqQr86DQ
	j6xoPf
X-Google-Smtp-Source: AGHT+IGhCrkx1xEm5bb8vMbTU3Z8XGl/2OWS10UnCy+DJydgwjP5Xtterg3ova6zKsIxeMBgLu8tcA==
X-Received: by 2002:a05:6820:c96:b0:659:9a49:8e97 with SMTP id 006d021491bc7-65b451875ddmr8457817eaf.27.1765993802808;
        Wed, 17 Dec 2025 09:50:02 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65cff11ef36sm14620eaf.6.2025.12.17.09.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 09:50:02 -0800 (PST)
Date: Wed, 17 Dec 2025 11:49:59 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com, worldhello.net@gmail.com
Subject: Re: [PATCH v4 0/7] builtin/repo: add object size info to structure
 output
Message-ID: <4zhiuhpvik5w2vgawepbvqfsfukkixjk7ht6ixvzhjfbu4wtzz@tqljiqujmy47>
References: <20251215205639.2700270-1-jltobler@gmail.com>
 <20251216173842.3357832-1-jltobler@gmail.com>
 <aUJVzVp9VB7tDfA-@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUJVzVp9VB7tDfA-@pks.im>

On 25/12/17 08:03AM, Patrick Steinhardt wrote:
> On Tue, Dec 16, 2025 at 11:38:35AM -0600, Justin Tobler wrote:
> > Changes in V4:
> > - Unmark "byte" string in "t/helper/test-simple-ipc.c" for translation
> >   to avoid conflict with translated plural "byte/bytes" string.
> > - Remove some unnecessary translations and add comments to clarify some
> >   of the added translations.
> > - Some small changes to the tests in patch 7.
> 
> I had a last tiny nit that doesn't warrant a reroll on its own. Other
> than that this series looks great to me now. Thanks!

Junio also had some small comments. I'll go ahead a send another
version. Thanks for the review. :)

-Justin
