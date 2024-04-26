Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A524428E0F
	for <git@vger.kernel.org>; Fri, 26 Apr 2024 20:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714164078; cv=none; b=rvgQB5u9zuNRnfuStu7l808rs34SS42s1j5Km0Q8oPgXoDvJsycEtnwsOA7ZWzdn9iL+0vDgcgEif5SCSMFralhK7J1zt4peyOPFwwpXWoVh3Rje1vkky5QUazz/4GSe9NAEEMemsbDFCUbZaVaMaSIHMN29utcuLEFReoMh24Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714164078; c=relaxed/simple;
	bh=dBFthAJ94uH5/IvgbTCv1+FTMY860E70P6RVKVxCFiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BrdCVLhWGlwHhXRxkhwFX5qTNFhdeSSnqfEoLp/Jd9weOtX8WQATHlO3HEqA9W8WDgg/h9ERfBSBGTfCpu1WdoUcIqHiwQKxxSA5D+UItb4y3T1KJNVGleGq6O67p2lFOFDFjokoYpyS3XhpWReT48ns5OIjKxQOOb+BvL5qXKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kK4/emOy; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kK4/emOy"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41bab13ca4eso4922505e9.1
        for <git@vger.kernel.org>; Fri, 26 Apr 2024 13:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714164075; x=1714768875; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r5fyMoXC2usv3c01ZTjV5rPL3r/wB/rAETL3ARiXpMM=;
        b=kK4/emOyLws9EcUBcv7b9hws1OBOuWdEWPLeNQE2u4sRfxuuBtQ0khXUnxVKd90igz
         U3COKD/RcdLICTqh2qUufs+RKSw7tuD3EN3fQLoAjO8Zq+dTzsGDWbIM2wii4Y03yVGi
         0Ap8UrGnmz8zIgmG8sykHJOFnfSFVhe0oghM6keK43CldOfVRey6st0+AxZdQrxkn+k9
         x73A4P8oE3n2efLYcVw0NF7r7+OlwU4lDONiF36Jdua5t6XGZleI+xT0/lR+WC38Y2m0
         QA5w223x+WE6eHBQysw65rWFgQksIkgZ4LW2fpFxRhh0cVSbhYLuwIdTOLYz35rm1tPF
         t+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714164075; x=1714768875;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r5fyMoXC2usv3c01ZTjV5rPL3r/wB/rAETL3ARiXpMM=;
        b=GnB9oykFBOrfHCvc0iS7L0p8e+cQhkK+WSaW33d9CyHcOjOmTSP8BF8tUpG3GFhQds
         frK31FOI7YsXK8OPtgQ/7jv4QcC9u6y6lK14WXPU9ssN7v8ayflAH8S9lvL4oFxziNXY
         BEwjEzknoo++ngCd+9bbeVHS6iDCY3HVPepTR9mUMlas6gU3kKXWfgTOEbQqeNYRqNlO
         GAFg9a6Y/RfpUI4Ag9G0gc2Ij1EUmfSEvRxg/uqceVKFRgYDGF7U+BZ0vbY2i0s9/Q9r
         V9g7SyznL4JhXH7NCSpK7/YCzg1mmoYTDXyyw/YN+LYQmrQ5VU3ccqM+R6vuCTyg024m
         kbCA==
X-Gm-Message-State: AOJu0YxeNlpWxs0tVdIDZKbBOBvBhL8z11LqOU/Eqal8q7kfyWdlMetB
	4c6Vhkiux/EmoFu4IGBtRJECWY1tT1UPw9EcCh3NBRL2oQ7Y9JOU
X-Google-Smtp-Source: AGHT+IG3TSmBphWgCjdgRMqPszaT9t/52y8pgdSi9m7dh52bHjTvrq2SeKo7vWMva3nIHCoJ/EN2Ng==
X-Received: by 2002:a05:600c:4587:b0:418:4851:a08a with SMTP id r7-20020a05600c458700b004184851a08amr3014390wmo.37.1714164074712;
        Fri, 26 Apr 2024 13:41:14 -0700 (PDT)
Received: from gmail.com (244.red-88-14-52.dynamicip.rima-tde.net. [88.14.52.244])
        by smtp.gmail.com with ESMTPSA id v2-20020adfe282000000b00346ceb9e060sm23062793wri.103.2024.04.26.13.41.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 13:41:14 -0700 (PDT)
Message-ID: <433fe12c-170c-48b8-9654-f70d238ab120@gmail.com>
Date: Fri, 26 Apr 2024 22:41:13 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] add-patch: response to unknown command
To: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>, Phillip Wood
 <phillip.wood@dunelm.org.uk>, Patrick Steinhardt <ps@pks.im>,
 Junio C Hamano <gitster@pobox.com>
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
 <6d421c67-9e10-4a7b-9782-38ba8e9da915@gmail.com>
 <db1d540f-30ae-4d4c-883b-088bcfe68140@gmail.com>
 <b209a2b8-f98f-4f14-a687-9022d30968dd@gmail.com>
 <20240425014432.GA1768914@coredump.intra.peff.net>
 <19ff10e9-12be-4a50-9163-1fe71414fd46@gmail.com>
 <20240426202333.GB13703@coredump.intra.peff.net>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <20240426202333.GB13703@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, Apr 26, 2024 at 04:23:33PM -0400, Jeff King wrote:
> On Thu, Apr 25, 2024 at 05:04:45AM +0200, Rubén Justo wrote:
> 
> > > The test_cmp output looks
> > > like this:
> > > 
> > >   -(1/1) Stage addition [y,n,q,a,d,e,p,?]? Unknown command 'W' (use '?' for help)
> > >   -(1/1) Stage addition [y,n,q,a,d,e,p,?]?
> > >   +(1/1) Stage addition [y,n,q,a,d,e,p,?]? (1/1) Stage addition [y,n,q,a,d,e,p,?]?
> > >   +Unknown command 'W' (use '?' for help)
> > > 
> > > which makes me suspect a race. Perhaps because the prompt is going to
> > > stdout, but the "Unknown command" message goes to stderr?
> > 
> > I have to read the thread pointed by Eric, but my knee-jerk reaction has
> > been to think in something like:
> > 
> > diff --git a/add-patch.c b/add-patch.c
> > index 447e8166d2..0090543f89 100644
> > --- a/add-patch.c
> > +++ b/add-patch.c
> > @@ -292,6 +292,7 @@ static void err(struct add_p_state *s, const char *fmt, ...)
> >  {
> >         va_list args;
> > 
> >         va_start(args, fmt);
> > +       fflush(stdout);
> >         fputs(s->s.error_color, stderr);
> >         vfprintf(stderr, fmt, args);
> 
> I think the "just send it all to stdout" approach makes the most sense
> here, but in case we don't do that: I don't think this will fix it. In
> the output above it is the "Unknown command" output which is delayed,
> which is sent to stderr via err().

Very true.

I'm happy with what Junio has just queued.  I do not plan to send a new
iteration, unless a new test break appears :-)

Thanks, all.
