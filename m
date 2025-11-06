Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73312FBDFA
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 21:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762465375; cv=none; b=XmoaaOAEx9gwJtF7240+jd6phAaU2PsMQngA/Jfwwpu5QF43o2mE60Vi2FL+l0lYill8g9vGMSf6uSzzS2/ZezTfByx2sP3rP5wxaO5OQo5CKyYqgUFFKI3ZDhvvaFV0L6Sm1io1fEga55vMZ+1aIIz1Z+Jn1sHomz9O4CrjMtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762465375; c=relaxed/simple;
	bh=MVlZ1ln7R+Nh+s314QKjkvh3582c+KAde54ZWAKL2Sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBRoTJ6IFCWy0cwA7UK/sT3H7ZKrZYtL+DcButTZALMTF6ejuyrWk3lXqtTQJY+fijgK3hl36Blmhf+YOyhfhTGXasqRdw1+giUBi7OB8IX8vx+MRrgoFFmu5714//WZAd4aMWD8T15YbpNnfocvdSRaXQ62hr5bH5/CVCaKy/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QE57AiUO; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QE57AiUO"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7c2846c961fso59328a34.2
        for <git@vger.kernel.org>; Thu, 06 Nov 2025 13:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762465373; x=1763070173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bKvM/0D2prlYVop1khIROIjRQdiLHzjnJIL6STdEiSg=;
        b=QE57AiUOJu3M4OJ5dQGPxaDvS7P1JRWn4E2xWZb/FpNad1tMrVm8rEh8m0YEN3LwkQ
         zOIsjQjIA9RsJmxTsz3k5L2dt3fv3rUBZjIMbta9hSuMEFVU+C3QfBONMlGuR3H7QMnS
         3LjRBnZImf+nMFKfJUHnzyBXV342c2GgFeBNQ5y5v7QV/NMSWBtlor0DSOziLcCWc53Y
         n9P5xqhL3e6eEbloVw3BoL7OzRY63BjX7hwZ5Q1xbBIyNNqZ4SrerGsou28tllYKGZqk
         +6AvHyDi2NJMZgUckjQQmESwlJxr8RqiUBfri/6x2BOawKoOgwl9CV8J7vXZQwJSAkq2
         fmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762465373; x=1763070173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bKvM/0D2prlYVop1khIROIjRQdiLHzjnJIL6STdEiSg=;
        b=WCpN7L2HD5ODNt9MmJpky2IcE2euykuFKYoA94D8sk+PlZxATr2KTVkLiUTkfQCg/1
         7Xd957Le6E1DnCE82MIWJrmCbF0LjrfvTtPC/faYnUWU4hXxXo5tTyR4Xkz7jkwW8ciW
         1Egpts7Bvq1yD6d1culU0VVStfZE3jzttyVf+rq6Oop/Rad/YIoAZj6hztDpZ4yOOYNf
         N9uaDxV2raMgHfgAMq6ATDUFJSt5m723bnz/BeEi+DckHdpVKbRFHEIVLCk5Y5cgMubv
         AjgQxVCqKWhk+juAS5vl2+WDzZDg76PTtZW33F0ZoO4U+xEGA8UMXTPNdWkpJJhMgkxL
         F+2w==
X-Gm-Message-State: AOJu0YyUYu7bWKgeRthnE3saAiQBwx6BSPWtQEECWlIZmhNskAkWaVXG
	lHfxleN9D/CKTIxfJpGQfeZlJNclGuRvaUEa2xAalLKOrQlMiHa/H7gu
X-Gm-Gg: ASbGncvyeCugus/qs5crBWpkHUfghS1owWxSZM+th8SeDTHiNmq/e62Uuamrl4jR16m
	GeCC4xUtbIUi4OUO+dTJ0DRELgDLiN15LUOaYkYF+hFqT31/k3czoxCpix1InwnqIZeLPyG/bjO
	t+lWmocPlq+qcqsst+quCw2xLzWf6OR8uPoEu9prUWvCjLCa51yd+kq5EOb+8+Rz2mHNvtjzQXA
	xIUS+Myv5k8GqdYkrsgtv1Bwu0J+6ipxBdGYAN+hnHTu/axmpwUTKUUm7l92G/nkZM0U3InPW6T
	wJh1Hnt1w8/FdXfpDvcwDsN4Yn+W2LwYlA/MmYUCty765pgLhdOg5R7cLXBD6GHtQBOrJVWeJfC
	Sj1go8udhbjwhsTQmM7grrjmvh5L1oFJecX6oxylnIQ1JdHbvnH7Bxrk9U3dIEPd39iq/ug==
X-Google-Smtp-Source: AGHT+IHmV7xoi8T1CeRord1B48r/rvr4HFj70j03+i0AfM3o7RegIYchHJ9pBJy9PpBwXjnKHTVWHg==
X-Received: by 2002:a05:6830:926:b0:7c5:3d96:bbf0 with SMTP id 46e09a7af769-7c6efcca393mr987724a34.4.1762465372753;
        Thu, 06 Nov 2025 13:42:52 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c6f11323absm340726a34.23.2025.11.06.13.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 13:42:52 -0800 (PST)
Date: Thu, 6 Nov 2025 15:42:49 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com
Subject: Re: [RFC PATCH] diff: add option to report binary files in raw diffs
Message-ID: <z5mkdl67vx47na5critwtyz7cacvhs6iixy46ia3svdoq7xui5@ckpfnjw3dkoq>
References: <20251104021455.379807-1-jltobler@gmail.com>
 <xmqqa512sfcj.fsf@gitster.g>
 <xmqqzf92quen.fsf@gitster.g>
 <nxl3sgs3h2psylifnbwcjmubdfmfhj53jjun5nsa4aqq5robh7@quga463ajvbu>
 <xmqqtsz8nbwv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtsz8nbwv.fsf@gitster.g>

On 25/11/05 12:04AM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > Maybe the output should be something like:
> >
> >   binary=tt,incomplete=ic,crlf=cl
> >
> > or something along those lines. That way we could freely extend in the
> > future without having to worry about a specific order. If we think all
> > of the raw diff extension modes would only report with yes/no for each
> > file we could just do:
> >
> >   binary=yn,incomplete=yy,crlf=nn
> >
> > but maybe we should be more flexible and leave it up to the mode to
> > decide what its values can be?
> >
> > Also, maybe this info could be on a newline following each raw diff
> > entry? Something like:
> >
> >   :100644 100644 a1961526 e231acb1 M	foo
> >   binary=yy
> >   :100644 100644 31eedd5c 402a70d7 M	bar
> >   binary=nn
> 
> I know these are parse-able, but quite honestly, both sounds
> somewhat backwards, if you meant to make this easier to parse by
> simple scripts.  Scripts do not mind their input line wider than 80
> columns, but it is cumbersome if they have to take each pair of
> lines and combine them to process.  And repeated keywords like
> binary= etc., do not look like it is less error prone for scripts to
> parse them out, either.  So, I dunno.

Personally, while keywords like "binary=" add a bit of complexity to the
output, I do like the idea of having the output be self-documenting that
way the parsers can avoid being aware of the inputted arguments or some
predetermined output order. I do agree though that spreading the output
across multiple lines doesn't really help us much as it probably doesn't
matter whether we split on a comma or a newline. It's probably simpler
just to keep it all on a single line.

Currently the output in the next version will look like:

  :100644 100644 a1961526 e231acb1 binary=yy M	foo
  :100644 100644 31eedd5c 402a70d7 binary=nn M	bar

Thanks,
-Justin
