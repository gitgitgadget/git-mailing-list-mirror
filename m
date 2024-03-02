Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1A51B263
	for <git@vger.kernel.org>; Sat,  2 Mar 2024 16:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709396305; cv=none; b=ThzP4jpmDEYIjHfugoqQ/XbprX8WNthWdpBT5/Vj7QaKzP3BJNDqrPCxNw5Y26J8THHKWMmnPOTMJbEbFnMNMATZRvrxX75HzmGrCjTJcIKI+x7um1z/55jpTfGbYtXg+SvyqP+As+Gf6Q0yQum9yi7/wX8TnmkdhWz7wjIwZwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709396305; c=relaxed/simple;
	bh=R/NoOTVLhN+yo+GypV9VDMUKMRTmkXO3DTWpA1VnGgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M45V3Ae+c+kcjLDwWai0h2HzgM60VBykiOMPWtIJacoGa4g6KwTQe2jya3RDlKsXtRAV1+rhkq+Q1yoyqNjuq8iwoM6SMEFXohQDzVwjjOerccO5PremSNh1FHbDyUpicL+07aHThXVgBBEdtJl4PTrXbPwtO049EtDOQMAmZO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlwR3FwR; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlwR3FwR"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-412cbf58fdeso7545815e9.3
        for <git@vger.kernel.org>; Sat, 02 Mar 2024 08:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709396302; x=1710001102; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hnGAqbZO+NEz2tvm9miKzXfpapVfldmYibh++63BXpY=;
        b=IlwR3FwRHgRKJmEfLbeN/ALJDHo3SjctME6dvscVoXkTRmQulp+pSIgECPPBE0u72Y
         SkoV5ye2fo4b9KHTQcrZXBakt6yruR4dZ7vIHgVEb4/vygYEhIjNoMO6jpO1clK4Pqyu
         WOdI4/0i2sEHqpe9v3i98fGeQ5Q6ck0MXEoRXEfJwnMUGEvrl0GJzDZIHRPsjuC4H1Zk
         FEzYVjLXB10mknhfbrbMPE1kX7IwoQhhmPvd0gTSflGf6QxMxiera2V0wgW1+d2BcG+W
         G5vmCzqaPwEchnnKYbw+3l+lbErjPaZhvYUqYjXMsnMCqkkox9MxTKyYXVIJGwoSVfDP
         xSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709396302; x=1710001102;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hnGAqbZO+NEz2tvm9miKzXfpapVfldmYibh++63BXpY=;
        b=UUkDNAPZjU62IVjuRfmD8jZdZkYR0xciUKrsYch/j3kU4qlyhqXJWjcQ7mS/r9OZLX
         f+hXNN+hDlz2XeV95Z/Nrjf6PaRJdTcXPox0SISlKnMc8xGdQOInBxWbNN5UN0+9N6Of
         tOJPqkznwZValGeiEoyQSiKJmixU7bwNrwJXpXB7WgPqh68VDjjFm5cue4yjm/lvo6/V
         Vw9OzMdfKiTSOx24V/KxiJ8bbJmwYy0xEOwtQSiD6kSrCWdjrr8v5N99YUIQ/15YyL2j
         H8oLKF02KlUAfRL1vg39XJFDCfLW3tD7USUDHXJdv5kVWIm53QKW/+RXRWmsg5rtBLIU
         +1VQ==
X-Forwarded-Encrypted: i=1; AJvYcCWn5+g1KJEEIQkchOO8m9lRZXWEcOhSHs0ivIb13VsbgVdsXuyLxm96eK0gQkPUAB99mxu1NUXlCmY20kMkWQWM0Sh+
X-Gm-Message-State: AOJu0Yy5UmwtVPxps6d3g6hKy8M6JtcxQPon1V3LGnoEolNIrS7LTFZq
	g9EcEqS4yQ4aGL0yeJDrRD2TAdKQWdIMjamPo5/2Rk1uBlWNPYtk
X-Google-Smtp-Source: AGHT+IHCpKZR9gX8LfKaNwPZv//2IcdcLwjhDUzrOhD5hjG31UPbwLus2a6U2Nfu7MD4g8edB5IvmQ==
X-Received: by 2002:a05:600c:4746:b0:412:64a5:a21 with SMTP id w6-20020a05600c474600b0041264a50a21mr3356970wmo.40.1709396301649;
        Sat, 02 Mar 2024 08:18:21 -0800 (PST)
Received: from gmail.com (243.red-88-14-45.dynamicip.rima-tde.net. [88.14.45.243])
        by smtp.gmail.com with ESMTPSA id t11-20020a05600c198b00b00412c8117a34sm5372583wmq.47.2024.03.02.08.18.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Mar 2024 08:18:21 -0800 (PST)
Message-ID: <a434de37-7485-4d51-86c4-14b0f477db0c@gmail.com>
Date: Sat, 2 Mar 2024 17:18:16 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] branch: adjust documentation
Content-Language: en-US
To: Dragan Simic <dsimic@manjaro.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <3cbc78bb5729f304b30bf37a18d1762af553aa00.1708022441.git.dsimic@manjaro.org>
 <e8fdd057-2670-4c93-b362-202a339d5f49@gmail.com> <xmqq8r3lnzp0.fsf@gitster.g>
 <2a4de8c4-4955-4891-859c-58730a41e5af@gmail.com>
 <ea15a49aed7b5a74cd9b1bf8a5351df9@manjaro.org>
 <c00f6efe-d1f4-4f2c-99cc-ac7a6d93c9ff@gmail.com>
 <be91f3ad9305366c1385c2da4881537e@manjaro.org> <xmqq8r3g8caz.fsf@gitster.g>
 <35738a93f5cbace5b3235ce614b7afbf@manjaro.org> <xmqqttm3ouxy.fsf@gitster.g>
 <16c1f883-881f-4f8c-95b2-22fb4825b733@gmail.com>
 <96f1afa6-f4ac-4593-9bf4-72dafe3cab85@gmail.com>
 <b6d22f5a66de49efc623eceddbdc6faf@manjaro.org>
 <d1f928b98238a60a96bee0d3f410deef@manjaro.org> <xmqqttlsld4t.fsf@gitster.g>
 <cbaf17e7-37a6-4c2e-82ba-65fe41dd86b1@gmail.com> <xmqqcysff4l7.fsf@gitster.g>
 <d456a80d-5c2b-421b-a849-3c7cce288c6c@gmail.com>
 <253d3c827f6e389d533c60113b08f94f@manjaro.org>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <253d3c827f6e389d533c60113b08f94f@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Feb 29, 2024 at 09:09:25PM +0100, Dragan Simic wrote:
> On 2024-02-29 21:02, Rubén Justo wrote:
> > On Thu, Feb 29, 2024 at 11:33:24AM -0800, Junio C Hamano wrote:
> > 
> > > Do not forget that the objective of the larger-picture-revamping of
> > > this page is to make the description of each option self-contained.
> > > Similarity between -m's description and -c's description does not
> > > count as being uselessly repetitive.
> > 
> > OK.  I was not considering this.
> 
> I'd also like to avoid repetition, but if we want to have self-contained
> command descriptions (which is good), some repetition is unavoidable.

I don't see much of a problem with repetitions.  Within the
self-containmnent aspect it makes a lot of sense.  And, after all, my
messages have been mainly about repeating ... placeholders.

> In fact, we can see what avoiding the repetition has lead us to in the
> current state of the git-branch(1) man page.

Indeed.  I agree that the lack of repetition has brought us here.  But I
think we're not 100% aligned in what repetition is :-), yet.  We're
working on it!

Thanks.
