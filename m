Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C46C23C516
	for <git@vger.kernel.org>; Fri,  7 Nov 2025 17:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762535801; cv=none; b=goW3HqtSWhHI3iH7QPlsUpeucbYjhIaXEM++MhUFqfjeI23v8hvtTPFO586O5oHOrLMI1aImCjeW7USIDeoUlCGUr7QZMLgGwHsD+Mmj0vEYA2VSJrnMwQu3qLI7e6/f6K4liteIWX/5volksmalsLDMSshYoi4ZnUOKzUgd1Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762535801; c=relaxed/simple;
	bh=aBwr87zs3eRzMixiPq83LVGtD8gWjfGQkuDU1+WNyOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhdQgr3mb+ksFbHWHIsNz4e9Ll2ibck6lCHXY0VoWTTfFLA/rHAQ/mmtle8hWamSdU1gp1/VkXqBch2OlaqINQ+zsRJj5axUvsJwCbM43Fu5DFtKL2WslhUJsZbc+4W0bAolUlz8hcZbwSUs+PcPuHBeMnS4satVteyqWFyZq4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EwAQjp2R; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwAQjp2R"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-443ac891210so442844b6e.1
        for <git@vger.kernel.org>; Fri, 07 Nov 2025 09:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762535799; x=1763140599; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ibSSM3Ez/iHZVX9HfIPrhFzaBb39VshU3Xf4Y8ZY8G4=;
        b=EwAQjp2RblhB4PAH+lT/KngZ/l0fmM9Ep2MZ/qDC+rebomTpCP75vj6gnXy/Lu+kvv
         LXqUIEApVuMiCDyyjh9ubDX6mfUu5wEfwpV2iYE/est+bnQino5ZdhR6Cg0G7o39scgM
         SsInAAvWvYcjHaSMajhL6Cv2MTK/TzG8Kcgh9PP9oZadq6izsAATFJdz41ZnWxwVU40R
         i/QesZXdI4Z9o/PmvDVG9owmBsYEdq71Dvc2Qe/LTDwQQ8RWmytaR276aFzkygXAAwPY
         txe0SNkaFBcSig7l08YjmypMjahIFA78wZV4qdYMkQ2flm4ftkGkrMB6oXktyx72vRap
         gC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762535799; x=1763140599;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ibSSM3Ez/iHZVX9HfIPrhFzaBb39VshU3Xf4Y8ZY8G4=;
        b=UXTVS4+MyrRYOCjjSfGduSNUwkoy4OvqsSuP/NizT3gopR04OeeWFU5SCVAcRczBiT
         2bcMTU5gcDcGZO9BjtV1o/LZRVvupPjVTtb9FSUFAeBaZKrOmmuw2BfFv7j/XPsPKAz2
         q8wwASIjH9TJQqzLJTxEwaImH19TVBlInKXdP5/TEuIbS0SxYby8+MlblKHOLsSyHno8
         ekKmSsC8/PqYEoGsIUKnwte7E/dCBxSuFP4kPKboRpN2YKZiZ9/ckh9Ro/kPgzqalFGI
         LLPYkAheha9/1rAUGSDCNb9nUkatobBa6MOzgF5FMphjNuz9AGVRC3R0awKI+tIfmbx9
         hyhw==
X-Forwarded-Encrypted: i=1; AJvYcCVfa1jNrTvjeNM7mC7x6ZOn5FdNVXWWUWUyW96M12gVv9JZaLyHAls6JOxAk/KejoiHcjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvxtQkBAn+Are0MlyKKhjxzy1Wp0FBUT9XnBYZa0B8VLoDiTj+
	CTVoE4bWItJXOq52uZNe82rrhXDiaKfnfm5/m4RCqg6KjPAdvPb+PYlt
X-Gm-Gg: ASbGncsT9heIg+LtzbqgnreJdetL+XAZKTD8VzipVmQDbHVsf3Ib1zfrC1xVvGWjep/
	iQW6z+EMoifQXLB5qqkivAiwY1EBpYQ058ljQxB1RP/Q+3oWZff+13Koy1wg7J2QKcXsX9qw0i9
	Re4rKLkgyYXv8ifKZcKUi4Bbc/vRee4QyoWNtUS4X3QaO6qNiOE2qjPnjmOYWaS2jvkiUSiM4cw
	QzMQnJ6yapnbDfb0X4Coro5um4eagaObTseS5MruRdVjUb7iVZ25soEE3hasPWc5SzW2y42WJlq
	m+ikPlkUXgmrKtnFiV/rtd/Cfye9qNRjpho2NRO2aGQj2zj+ZT4OJR52NmlLgermU+ctfwvzr89
	MH/JiVqkw/AchIOs2w1oeXsO0kkz/sK5DjSwMZiEPxELOfRD+/EQHha84yqs2q+13lNzTeg==
X-Google-Smtp-Source: AGHT+IEWY1Aj2xPE+YSJdBuCEEczxO5G7hdFRv33dx/3F19RnZ9EB3WXNvAp34OeNxhGibUBL1eBbg==
X-Received: by 2002:a05:6808:2223:b0:44f:6d70:45af with SMTP id 5614622812f47-45015d04a95mr2253207b6e.9.1762535798995;
        Fri, 07 Nov 2025 09:16:38 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-656c57bf0casm2587458eaf.10.2025.11.07.09.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 09:16:38 -0800 (PST)
Date: Fri, 7 Nov 2025 11:16:35 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	karthik.188@gmail.com
Subject: Re: [RFC PATCH] diff: add option to report binary files in raw diffs
Message-ID: <ikzwvvyyhuhvr7picunl3r4zem4cn566zpjxpmh6u4oq6ncswa@cdfokimobtms>
References: <20251104021455.379807-1-jltobler@gmail.com>
 <xmqqa512sfcj.fsf@gitster.g>
 <xmqqzf92quen.fsf@gitster.g>
 <nxl3sgs3h2psylifnbwcjmubdfmfhj53jjun5nsa4aqq5robh7@quga463ajvbu>
 <xmqqtsz8nbwv.fsf@gitster.g>
 <z5mkdl67vx47na5critwtyz7cacvhs6iixy46ia3svdoq7xui5@ckpfnjw3dkoq>
 <20251107083015.GA18670@tb-raspi4>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251107083015.GA18670@tb-raspi4>

On 25/11/07 09:30AM, Torsten Bögershausen wrote:
> On Thu, Nov 06, 2025 at 03:42:49PM -0600, Justin Tobler wrote:
> > On 25/11/05 12:04AM, Junio C Hamano wrote:
> > > Justin Tobler <jltobler@gmail.com> writes:
> > Currently the output in the next version will look like:
> > 
> >   :100644 100644 a1961526 e231acb1 binary=yy M	foo
> >   :100644 100644 31eedd5c 402a70d7 binary=nn M	bar
> >
> 
> I think that is a good solutution ;-)
> When I once developped the
> git ls-files --eol option someone (Junio ?) convinced my to
> use a TAB as a seperator.
> In this case just before the filename:
> 
> git ls-file --eol | xxd 
> 00000000: 692f 6c66 2020 2020 772f 6c66 2020 2020  i/lf    w/lf    
> 00000010: 6174 7472 2f20 2020 2020 2020 2020 2020  attr/           
> 00000020: 2020 2020 2020 092e 6369 7272 7573 2e79        ..cirrus.y
>                          ^^
> 00000030: 6d6c 0a                                   ml.
> 
> This makes the output both human readable and machine parsable:
> All info is before the TAB here. (And may be parsed again in a second
> round, if needed).
> Thoughts ?

So the raw diff format for a normal diff pair is as follows:

  :<src mode>SP<dst mode>SP<src sha>SP<dest sha>SP<status>[score]TAB<src path>[TAB<dest path>]LF

When the `-z` option is used, tab and LF are replaced with a NUL byte.
So we do already use a tab to delimit between the score/paths. If we
wanted to drop avoid using comma to delimit between extended raw diff
output we could use a space instead and use TAB to indicate the end.
Maybe something like:

  :100644 100644 a1961526 e231acb1 binary=yy crlf=nn    M    foo
  :100644 100644 31eedd5c 402a70d7 binary=nn crlf=yy    M    bar

or we could maybe move the extended info towards the start of the line
and leave the remaining bits the same:

  :binary=yy crlf=nn    100644 100644 a1961526 e231acb1 M    foo
  :binary=nn crlf=yy    100644 100644 31eedd5c 402a70d7 M    bar

With either of these formats, the expectation would be parsers continue
reading space delimited "key=value" pairs until they encounter a tab. I
do think this latter format looks a bit nicer and I don't think it would
meaningfully impact the complexity of the parser. Ultimately, I don't
feel super strongly one way or the other though. I may go with this last
format in the next version since it does look a little nicer IMO. I'm
still very much interested in folks thoughts here though. :)

Thanks,
-Justin
