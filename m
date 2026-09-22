Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04763388E6F
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 14:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089031; cv=none; b=YDJmJV3TO0MKEoK26VVcKxxAsDaMQge8K6EnTM65bKrQI8YkTRpQp2aNtsIF4h9sI+Nf74dOMWY0bdtkrWsj9OcVsMEQu87UPdkI3cCFMLARu5fFLDuz+qhTUpfdMbTsWOLxjzMynlIMpvRmQJwezWqyggUlHIhPQHwDon+Z58o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089031; c=relaxed/simple;
	bh=d1OEVshEMgm0I6nu070OZNYn9rZ2n09Wa3YlD6PRvuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X1kFBsi+d2Wbrd4pmnrN2oFHuMlPMkKVnvsMIoUxxVd3yXuXGpKkOsPf47ECUX9/eKOJD8gC/7cehEZMgYTMXn2540Yzx0l0SMs/D1G2ssNwkw2MdPmbYlLGb6b0oBaHc/oc649D2ZFkHDV/mv3III9NTdl40AGS9A0wkikaocM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AfwjlilE; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfwjlilE"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4843e397f74so582383f8f.1
        for <git@vger.kernel.org>; Tue, 22 Sep 2026 07:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790089028; x=1790693828; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VR9ZDTo7tvht+oHm9WbWV9f6xocdwnci19x20ddBwtk=;
        b=AfwjlilEkbhN4I6J5YvKhNVci/QWM7rFdCTJt5OCFZRxosSEuj0DDBDyjFxhU+pdpJ
         R4G+UmLWP/EqAIptoxfMMcuHp+AojcPA/f/SNFcnY9oBpZzEOhwrsVbMcVwpdFmz45Iq
         VJ81ghh8H1O4/a9MwTyHWDa22LLUNWwFyyEcsiAQbNEJ0W/IgBfcnoxi+MYzH1qh2T6f
         QClGtFfpjku/Cemsfgiiza1c5D32pDDEB+S0VR+Iw0Ci+9X9nNyLHZjj4Bb23HcEK5lo
         F8I7L6gm3JvIxm4in7Id3/SzWqFc3QUCBrFaZ5KHVR3WStQwlFvAQaENTdi0o3wF9gPR
         eaYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790089028; x=1790693828;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VR9ZDTo7tvht+oHm9WbWV9f6xocdwnci19x20ddBwtk=;
        b=PC+zyXy/YnLl1+S+SgWKa52i8bCAXubOec+Uo8Gu37ChecfIv2oC8OgpxSFwP5n3AV
         ap8cwEsUzzLtocibYCZl3D3s7AjFqAJKdmJSM9OY3oZq09agePzjVaogzJXpR9Fmt6CM
         DSiKqfVz4jMm6l/Jbt8MHeGOgE/cnGC2kD5FKZQR+j4msCSTmBHTWlNllCXwBkM2yDN+
         5JqaK+wIYnqOnaeNDW2aozFi+f001norQo0RcVJ1gAcoEyLBNgVsUSmBTHuhKaz31bNi
         Et1XCUrq1ZLi5boBsyo6uVJcP9OTeTAcXy6nBVnXuEEG2sz1po/Mrm985Fn9I4bRkSZ9
         ANnw==
X-Gm-Message-State: AFuF++mJN+/Uu0v8mg4KSGFcNBuuxAu+CTnuV60EDLstxIJPV1vFt9m7
	Vd9JBA+tqrduXwnH7B0lxHLveD6WM1ooME9jUnoCHsZbFD05cAAugRuD5ElPlKPV
X-Gm-Gg: AYBFou3Gr2K5XCnMzRgFn0/PutCPdJ1tI94y/RTByedDwPc++QnHp1Lgj5RYOypuGm+
	TWLQ43m5jRi74CIvM31Fb44kOmBOHyaL18T7EWstCcwrojAyxuIJHZenWEWFOrpU5G1Xk4UAYLa
	PGBUYPvMe470wmqHokpXZIHJvRL8vFm0jFbozDexi63dI2/ImtDwiAwwXY+otw/rgKAmv63OIci
	3VPqyil2pYbJQlSbATMMzFUr0QQuRK3h3fQCgRbibiJazHSsRJEQvewLsjWo3hpvl7C3173lSNl
	eovikzvN55D3zMXcT0cscCM8TQEzpKYBbaYfHOVbjS0dHv6QNDY3b8UMNx3ehg4tQ77rHmAnV56
	M+QNSYIhhXZVp/Dko7ZrTZ7LfeVIn1i+mF7xCX1HLU+e40Wz/EE+gK2wGQCTyyjnHRVTb9+q44K
	dNK/5mQ4ZVevYHgpnbhAewHEG44bek6ae4gUWP9O87lVHbKKD9IhRFxGk472HDwKlUugdex98gl
	Z1ub+58xAgToom8Ka5umDnaPLqPwuzVYb2NlODA537ShI3jZNOuMQ==
X-Received: by 2002:a05:6000:461e:b0:487:3c8:9675 with SMTP id ffacd0b85a97d-48860f8a898mr4826368f8f.8.1790089027652;
        Tue, 22 Sep 2026 07:57:07 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488627314d2sm5770094f8f.2.2026.09.22.07.57.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 07:57:06 -0700 (PDT)
Message-ID: <ddfd5232-b832-476c-8614-268f8e4bbe28@gmail.com>
Date: Tue, 22 Sep 2026 15:57:01 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v8] var: support broken-down idents, signing key, multiple
 args, and -z
To: Andrew Pleeter <andrewpleeter@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Ben Knoble <ben.knoble@gmail.com>,
 Jeff King <peff@peff.net>, "brian m. carlson" <sandals@crustytoothpaste.net>
References: <xmqq33va1lcg.fsf@gitster.g>
 <20260915220228.42819-1-andrewpleeter@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20260915220228.42819-1-andrewpleeter@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/09/2026 23:02, Andrew Pleeter wrote:
> Hi Junio,
> 
> Thank you for the guidance, and I sincerely apologize for the lack of
> communication. I had posted replies on the GitHub pull request and did
> not realize until now that GitGitGadget does not mirror PR comments back
> to the mailing list.

Ah, that explains the silence! I had a quick look at the PR comments but 
did not notice any response to my question about the use of GIT_SIGNING_KEY.
> I certainly did not intend to be silent or ignore
> your reviews.
> 
> I completely agree with your feedback. Packing all of these features into
> a single commit makes the patch difficult to review and overcomplicates
> the history.
> 
> I will restructure the series for v9 into three separate patches as you
> suggested:
> 
> 1. Add the -z output mode to git var (-l and single-variable).
> 2. Teach git var to accept multiple variables (argc >= 2) with var=value
>     output.
> 3. Expose the broken-out identity components and GIT_SIGNING_KEY.

That sounds like a good direction

Thanks

Phillip

> 
> I will send v9 shortly. Thank you again for your patience and direction.
> 
> Best regards,
> Andrew

