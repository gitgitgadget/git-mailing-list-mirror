Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2F620E31B
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 12:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751806712; cv=none; b=JMxJhGD8Oo4HfgDhevoPUURhGjbGo7ufgSpv+AKFflzEwPMK5S3dlglf7UVzxsbjmzhn6GghQknU0WTSopBUfyrEfk50pKNWaN/E2biXda73dRceXRMbjTGl9qWdoyGamaiLR54CwawAnADgkPyUvthtHuS0a8e5o9SpBV/ags8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751806712; c=relaxed/simple;
	bh=jHmS8j3IxKYS0kccH1uS1+8RQWBqY4WbPVtQtCo7A+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULrFUTUHk/afX42sJWEVuhssAxcqD3wrNpwa3qnaervBkuJJ5pHJm+i7fq2/k6czJydWom4mhQfsdYQOHDXPjXWDDXnkcaVWxox7k97oTKtWg7bsmMlAdpJlExUr67RyTfWBlvOXfZZxuIx0czqQpNu3shEpvu941vH3MtY5B2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELwObnB1; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELwObnB1"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-74931666cbcso1938457b3a.0
        for <git@vger.kernel.org>; Sun, 06 Jul 2025 05:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751806710; x=1752411510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V5NgAhOzw9wqqDOSlEeeEnEBAHMzhKBNSDG365wgsAE=;
        b=ELwObnB15+4RkQ22hCMrw7eNiU69CukbC9zh1f4ECmzj67j/SrqKzl0otKyQaq4DpG
         aiduU6dbaqhNZO4nO9HIgjDk5/STJggapfc+Svg/9NgwBSo3+dgK8OolqGZpbUljnATN
         HlXpbefZhTxpuxG2sni2IBZAic9oixkjwdZGbTWksrTw2ezwWHJ6/A6u+wNtZOKSq85g
         +WFD9+THdnJnrYXfxQr1xNx+cbzELyrtnDJq/NYEpBrUoaa+FNvwggk9z1RiiemLBekR
         7fAVJXUAzzyDK9HsMIZjrZzmUokNrIkjfHYczk+KMAlZV6a05eGAhlvQRfZCTNOLL/JR
         WBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751806710; x=1752411510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5NgAhOzw9wqqDOSlEeeEnEBAHMzhKBNSDG365wgsAE=;
        b=NXuRmT5Mzg6FmrttLX36bRxlKtpcyrBJ61l3NLQUZS+/JZI9L4HuyXl8rmYA4jULJv
         XJjrEQK8RrHVMYnx+DOyK5jKL9yHX1HJ6iU71waGVu5zwcRU0d43HhZZjZN39Zr+OQln
         Lbc9O6LgP0TNoMdREkZKJjw+Sow/YOCEfh4RIwkZFwEXk5Nsv9QvJoadTETjSShMMq5c
         gx0jbgsxMTqk0r23S7oxpPDXcuvEAy5WhBstEqLn73OdUCxeidLg8BeKfPWwKQOfr6K2
         drJ2oKFcQGSWOe3At5e5rqXe9xtn9sjq6mzvn76MwwQHGzpnXxqhAZ7xc3ZtxGQhH2fO
         QTkg==
X-Forwarded-Encrypted: i=1; AJvYcCXQ2cOyFcOa/wjUbmTj8M1MKWAWTjvjopwm3PJasu0kbGZiniUDM7sWZnsCi7Y+ypZ04go=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU3+VTqNNF8oGbX+I7UAr2kGi98mMfdKpxqBNDrmuV7cOxpzgP
	3AV8SvhnQZy5ujTIQUE2Tzk/atl+u2iDETLlVMi/4V2qDH90YCGVuuOZ+s96Gw==
X-Gm-Gg: ASbGncvkuydxEl7u9NM417OXOExoryEeRZXOVTxWUx0kFc16mVvLYKiVWWwApcBBYDN
	vEOQLBwWx+EC0QolbLMZu3uwbLtsCxLYut8g/+E49zftNZ28woy93PuphZbjvndTlpUTVRayg/4
	yeDCA0uk26KXgsWbFHxlSKurYkXDiuw27TZLBhHXKAUIKoQKWjJpS2N4Qs7bV04QuuLrJhYPRB5
	wUPTPBt0igOLoHcrdOVIFiat8u7Nj74MHIhU8mvbgIlztFW4RT1Q++haK8vWbAbcL3qxp1t2hKP
	cgXo4HmjPLKqw+qAU3No+dpEihyfw6KbZzgg7hzcoF3wziKnu4BsgJFJqg==
X-Google-Smtp-Source: AGHT+IGmzTJJXwK22pXkpgnArzuDQcr3I7la+pMbEBSiHKj1FUBhv9lgjgd3IGxjmnIoch4tv8U89Q==
X-Received: by 2002:a05:6a00:3d0d:b0:748:34a4:ab13 with SMTP id d2e1a72fcca58-74cf6f15ac7mr7274895b3a.6.1751806710501;
        Sun, 06 Jul 2025 05:58:30 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74ce429fde7sm6623051b3a.135.2025.07.06.05.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 05:58:29 -0700 (PDT)
Date: Sun, 6 Jul 2025 20:58:27 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Meet Soni <meetsoni3017@gmail.com>, git@vger.kernel.org, ps@pks.im,
	karthik.188@gmail.com
Subject: Re: [GSoC][RFC PATCH 0/2] Add refs list subcommand
Message-ID: <aGpy8zQRsEjqX3mw@ArchLinux>
References: <20250627074934.1761897-1-meetsoni3017@gmail.com>
 <xmqqh60183ku.fsf@gitster.g>
 <aF-iSSOmcplFjKQt@ArchLinux>
 <xmqqo6u55npk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo6u55npk.fsf@gitster.g>

On Mon, Jun 30, 2025 at 07:05:43AM -0700, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > If so, we would make "git refs list" to place "git for-each-ref" at
> > all. However, in the current implementation, we indeed introduce
> > duplicate code path if we decide to do above.
> 
> I do not know what you meant by your first sentence.
> 

Sorry, I think I made you confused here. My meaning is exactly below
what you have said.

> If you make "git refs list <anything>" a thin wrapper for "git
> for-each-ref <anthing>", you can satisfy "I want to teach any and
> all features related to references to the 'git refs' command" while
> not penalizing existing users.  After all, that is essentially what
> "git branch" and "git tag" do as their listing mode and supports the
> featurs from for-each-ref, isn't it?

That's right. I just want to let Meet know, if we decide to make "git
refs list" a wrapper for "git for-each-ref", we need to change the
current code design as we introduced repeated code path.

---

Sorry for the late reply, as I am extremely busy with my own business.

Thanks,
Jialuo
