Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C435A267386
	for <git@vger.kernel.org>; Thu, 13 Nov 2025 03:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763003526; cv=none; b=KjfCB5H23Ovjkp01klCQDnaURvFZ2W3gcKZcedUJOthYvTsKtjgU8vffCLLAOzPaKq7fmIxxgzvB7jZ5wDKQmj4O5iyUNNRkkzf+5JCDykqU0keXAtUjCvMpjUYxhkNAfhrqOP7PQDBbsENQLziKjaL5qmFdH8qFWGbrKEHSke0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763003526; c=relaxed/simple;
	bh=3KvTvaasZN6X16jFqj+VvMEFG55e5jnB6YaNfeadF6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vt9kNKlcYaiaWXfLxEgvZN/3IwfUYlt+j8mo1rh6NgXyWEW73VDCdTaO0JvXrKeKONUYp00BjVaG5JmVAeThEZVADyF83BmESycfudFXxKEf/HE7ufgqZO23lqoB10LNDpG2Ao08CGJs+GaoRx8kus4tzjFi9p9JOF+yg2xgG1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=FVkhWc8k; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="FVkhWc8k"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-63fc8c337f2so315639d50.0
        for <git@vger.kernel.org>; Wed, 12 Nov 2025 19:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1763003524; x=1763608324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oNi4Flyl2nLgG5ZdyguqtGiHqQ0dyFRINlDkfXbcT+4=;
        b=FVkhWc8kadnAExe0xHU5CglVjrOafLUzqoNUwCK8n+S5k6Sj3GV6dYSbX5rJyI5YQE
         eQheKvh//YqREFjmxVuRFZisQYwiGnHDMLDhq8MenGDQ7526DjAfW/F8obxqzTPJ4afo
         g0L/YZ+6/AV0rlQqwolUextadsGO9QlIMw1igYMPsNCTJIbB0VA62+obaGHu3AGi41yJ
         pZYmVn0We2mwL5SuNKXTZz36YiTYjhZTWqoZ2Zo73y0t98hHf9ySHEfYxDWp1eU5sDnj
         avQ1VRqejDdv2AhICcQKfk9mDZZtRCZqTIyxReGEnSWli0jYWIIs420F2W34UhglNdtj
         sMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763003524; x=1763608324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNi4Flyl2nLgG5ZdyguqtGiHqQ0dyFRINlDkfXbcT+4=;
        b=HER8dr3sEVWhiboDH9M4GYBJnRUIxZQ8WER0mZinBQFdXT6hsNhWHJe7EEC47DJF3h
         qami5sF4bRzX127mb0OIWLsaxCBP2QIMEs+m5w8f5dBIWYnDb2kz1LjaE1+706bJXn5x
         bghHsoh6+5D/0pSiB8hAlGbMA9eYm+gMvNq9mA9VThv+itG0yDducxOXwaci167qzT1g
         +GxLAaLMZElSyrd0UtjK7e73weJq2al7X7m0qpYGrjLHdCKxmVNNR6xfooBrIhxdxigQ
         6Z/l6pZUpc7yeqKVZrxB8TS3HwqiiJ5naPVoNQyS4XBtvCmfV5GV0tRGMQpJIwQtw9/7
         3TVQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/PVg8dTsxAWEiVJwc/wK6iKk8K4+zrX1VEllLV96FByGf/EeaMGGSNWhPnA8SAztBYc4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2xUAlWpMWUOBLkuW7AoSUeTYBR89cE9iQqjtysib8QlqLm3FP
	yXeSUnY5X6Ft2Zfr1nstnBBQ+wxYrOTJ2AooKKCSq6vGx3//6DmpQSnnZYULGEjrCK+wLd/seey
	VsA48k34=
X-Gm-Gg: ASbGncvCZH43iHjIrCPGkw8+0Tiuo/Pi+gdxIsXR1hR1a7CsNwDM/aSRtkSQpEGy3+k
	He1fTaQLIs0EJuLsROqjxg/UU4odIjKu7wh0NLV83uIXxahG6OQRloC+nTiWHTiBZcxCG2reMp2
	LYEMntjFhrZHbuLc2SyMmIrZqjsQRBcM5Ksu6lstXPqty5w/5/AXu5r+KDbA3s6VgZT/mek04zP
	7Lm+XaYno6pWrI+PqbfNJ6r7ngRJqfEeQCFPM2thKreIY/4jz3+QLTG7xiOu+mF7Q2yb2K+A61E
	U1gLX5zzUCdMMz5sC8ARK+cM7HBqepGxhrybec2ZGYZ5YYCU8xW1aK+XWeLkJqZQdIiH0ifB1Pr
	mNIAC3wPDlHzoN95tbaBwL3gr65/te8daicy6SSLuzqAW9VKKqVdrppMeDkxOLmwtmBcdaVZrsd
	9B8lIuuPX5FEfPHs4FBnNNRPSk35jHW+xkglbz/JisDhLH5F4=
X-Google-Smtp-Source: AGHT+IFA5Yxe1FxAA7AgKvCE/iK2DvESst7bj7Qtk1Cn4Cwik3I6awyGBI2GZY27vJtdXQbl8hcqAg==
X-Received: by 2002:a05:690c:8687:10b0:786:7bb3:a6ab with SMTP id 00721157ae682-7881369701cmr75981237b3.46.1763003523724;
        Wed, 12 Nov 2025 19:12:03 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-788221a000csm2744477b3.60.2025.11.12.19.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 19:12:03 -0800 (PST)
Date: Wed, 12 Nov 2025 22:12:02 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	correctmost <cmlists@sent.com>
Subject: Re: [PATCH 3/9] Makefile: turn on NO_MMAP when building with ASan
Message-ID: <aRVMggZi7I3vizc9@nand.local>
References: <20251112075522.GA978866@coredump.intra.peff.net>
 <20251112080215.GC979063@coredump.intra.peff.net>
 <aRRu1cxpIzd60AoU@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aRRu1cxpIzd60AoU@pks.im>

On Wed, Nov 12, 2025 at 12:26:13PM +0100, Patrick Steinhardt wrote:
> On Wed, Nov 12, 2025 at 03:02:15AM -0500, Jeff King wrote:
> > diff --git a/Makefile b/Makefile
> > index 7e0f77e298..0f44268405 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1587,6 +1587,7 @@ SANITIZE_LEAK = YesCompiledWithIt
> >  endif
> >  ifneq ($(filter address,$(SANITIZERS)),)
> >  NO_REGEX = NeededForASAN
> > +NO_MMAP = NeededForASAN
> >  SANITIZE_ADDRESS = YesCompiledWithIt
> >  endif
> >  endif
>
> Let's also apply this to Meson. Thanks!

Not to derail us too far off topic, but... ;-)

I wonder what (if anything) our policy should be for keeping the
Makefile and Meson build scripts in sync. On the one hand, I do not want
the two of them to drift (too far) apart. But on the other, I am not
sure that everyone who may be touching the Makefile are necessarily
familiar enough to make the equivalent changes to the Meson build files.

I genuinely don't have a very strong opinion here or even really a clear
sense of what the right thing to do is. Just something that crossed my
mind while reading and figured I'd write down in case others had similar
thoughts.

Thanks,
Taylor
