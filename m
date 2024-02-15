Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437F88833
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 23:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708040323; cv=none; b=D2eB0NzuFT043AnUMtiijHB86LU7NbQ/W22cPAjq9GVJkVSh8dtQHYq65a3NDs4Am5CJjUYQgufsOU1q7J6ijZkzFiqLRX9hMjfouKtdsCTz6P2kxNQZ/GugpaWmUwTdZuXMEB+7PM2dy51kcT7tvDrq+NbW7aGpiJDoeNGC9hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708040323; c=relaxed/simple;
	bh=es3Zvq+e3rfnHhnTFamYOtXI9TJnZhzUnYSlokt3HZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lVBBtFfY+/zL9TG3U14EbJH85bhPUXZECeDMDOzUTWHAmKzrfiuzNwghNMwGeMd6pru2SjsaUvxj8L7vSr4M0adpsio2lct8wiHnQBPsGtq9pVc1bpom6agLVHQsclj2idRWPidfZlnMCt4vGCFb5HsIGMdF7xu0zz2r99sw9Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUTLIpm2; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUTLIpm2"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41242adfdd7so376175e9.1
        for <git@vger.kernel.org>; Thu, 15 Feb 2024 15:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708040319; x=1708645119; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EMl4kX49ju47cBt7eIipERuS1Z8nXBGK3+MwWNlM0jc=;
        b=SUTLIpm2E7cTFru4mu7bpnYNyVIYnilSYBu3b5wQPf8KpnwbRIJiqMYy8T/z4GY6dE
         n58Ja6Jyr3ULIz/tb2l0pnm9BJCo3Yzk+M0lDMpxLCeB7v06FFHDQxvyVTwk2AM1jtEm
         2eGfmd68fIiqeo2KekV5jMgJAe20G4fEVHT1lYkIZm5pPWSS6x36pb3+ElZopj7bDQjv
         DB+fO02OGOfIUIBX1R3LaTgVuaYmf3PA6PO299OKXe+RE62hKn7GDOaFFS7N6xnSATEg
         Lf3sE8XsM5kKSo81ONOdlDzpTeg5mHjFTM3z+t09aFlsUqb/TPIybn5O6DXn4k5n7HJY
         1I0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708040319; x=1708645119;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EMl4kX49ju47cBt7eIipERuS1Z8nXBGK3+MwWNlM0jc=;
        b=myKTqnaaTPQjmSQ6lNKGBmiAzGlnnsoofacUyQ1kJSDxtLYJalH+mR6d7I7MJEY5da
         lFAuiM6nzUY5lyjxirOyv1gSLgSjO6Mt+mFeLDmU717ltCRd8DU+Kjjo8AlubaIqKMld
         7GKMuLvVJEZCRQQWajBV/cQRxUVi9tkTbpEL1BAxAdP/ADzUL9dwBXGkWd336XzS+XkB
         HUMoZK4nQGbPoVv7NY0gndb5BYe/HPvyTD+RT9f407ZeiUHa4R0WEDUR0mOFksjloxGr
         y1d0bmSrcYDiIy964vTvMIGRDrEJ57yT743gP5lmwZqbZ4FVPtlL6WSUlNHXPnyNN0bN
         AOMw==
X-Gm-Message-State: AOJu0Yz/cfC+xW2t5MXQzYcn9fp0cbN/16vhX9tU6wWO2XSxcXGXxO76
	BiL9pabEuTsC+WjiMr88t2l86CqYFBxdju7C9owl8lTdtG+zXfsZ
X-Google-Smtp-Source: AGHT+IG6YZmNLRhdFxAslNjg0Aj/YdzbAV/Mk4lwIncU5CkaYKln/HzIHcoqJ8ak3SR9YxBgZh2jTw==
X-Received: by 2002:a05:600c:b8a:b0:410:c64e:6e2b with SMTP id fl10-20020a05600c0b8a00b00410c64e6e2bmr2250232wmb.12.1708040319478;
        Thu, 15 Feb 2024 15:38:39 -0800 (PST)
Received: from gmail.com (15.red-88-14-198.dynamicip.rima-tde.net. [88.14.198.15])
        by smtp.gmail.com with ESMTPSA id e25-20020a05600c219900b0040fe4b733f4sm548453wme.26.2024.02.15.15.38.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 15:38:39 -0800 (PST)
Message-ID: <210ae8b5-05cc-42ef-a82e-40fe7b41399b@gmail.com>
Date: Fri, 16 Feb 2024 00:38:33 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] branch: rework the descriptions of rename and copy
 operations
Content-Language: en-US
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org
References: <3cbc78bb5729f304b30bf37a18d1762af553aa00.1708022441.git.dsimic@manjaro.org>
 <e8fdd057-2670-4c93-b362-202a339d5f49@gmail.com>
 <6caad50252bac7f75da8de7e3728a45e@manjaro.org>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <6caad50252bac7f75da8de7e3728a45e@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15-feb-2024 23:27:59, Dragan Simic wrote:
> Hello Ruben and Junio,
> 
> On 2024-02-15 22:52, Rubén Justo wrote:
> > On 15-feb-2024 19:42:32, Dragan Simic wrote:
> > 
> > > Move the descriptions of the <oldbranch> and <newbranch> arguments
> > > to the
> > > descriptions of the branch rename and copy operations, where they
> > > naturally
> > > belong.
> > 
> > Thank you Dragan for working on this.
> 
> Thank you, and everyone else, for the reviews and suggestions.
> 
> > Let me chime in just to say that maybe another terms could be considered
> > here;  like: "<branchname>" and "<newbranchname>" (maybe too long...) or
> > so.
> > 
> > I have no problem with the current terms, but "<branchname>" can be a
> > sensible choice here as it is already being used for other commands
> > where, and this may help overall, the consideration: "if ommited, the
> > current branch is considered" also applies.
> 
> Actually, I'd agree with Junio's reply that suggested using even
> shorter terms.

Me too :-)

> Just like "<oldbranch>" and "<newbranch>" can safely
> be shortened to "<old>" and "<new>", respectively, "<branchname>"
> can also be shortened to "<name>".
> 
> It's all about the context, which is improved by moving the descriptions
> of the arguments closer to the descriptions of the commands.

Your series is an improvement in that respect.  Thank you.

> 
> Though, I'd prefer that we keep "<oldbranch>" and "<newbranch>" (and
> "<branchname>") for now, for the sake of consistency, and I'd get them
> shortened in the future patches.

Nice!
