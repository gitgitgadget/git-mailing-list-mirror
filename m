Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32CF1DFF8
	for <git@vger.kernel.org>; Sun,  2 Jun 2024 17:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717348421; cv=none; b=R3CNWVs8IvOSbcq7GJKPhGVMnjmbBzG8aSO9CioPVc7ftvtLhnePW7uHn+XHGcKnNeUSlVxTFw71+u+MCbMFB8TRDYx6XAorOIy4eYn0qWDRz77eP9Hf9czUmeouRAVJ9zbvrrE/jcRJTb2cTUKchfccg9q5TtWc8+E3MNu15Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717348421; c=relaxed/simple;
	bh=750IgPXqLT2Gw7nUhr6Sfzf5am7Xkuk4fv0VQCxLbr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SVqSGIoa9DO8SEo8p70ZQ7anD1ScmWzAzBOEiEaj7VJve/DAvCRxMn0lXh0tvXWM1QTY9BRWJGt1cUqTZRu5pB+EwidyapkRVVJ95lXnVd1PkxN3CTRCT2uR6KeXxBGbhYxNUr01WVvF7WUSSR/3qdBV5J4MbWzCA5w0UUxfDMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PE82AuQ1; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PE82AuQ1"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-35dceef4227so2443542f8f.0
        for <git@vger.kernel.org>; Sun, 02 Jun 2024 10:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717348418; x=1717953218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FlefKdoshJJhgRL2RoGsiaOgsjIqjYCu3MnOeHxXpbk=;
        b=PE82AuQ1jo+gHv7vf3sXHcDOZIRHj44tewg4QoIL2TmU5Bu0GCVQZiSPHCo+L2bHw/
         AY9ZaXVxkYj8yub4MM23IsWrJj/W+Xn3oPLp02pvaCnMa14342eVQcxz4WtfPS8Jbzop
         zmCl/Jf+4RmUg2ZcQa0XeAEM1+raZLKkqAEoQaCEY2B5Xd6R7j2guxQBRk8JEu/YkGmV
         C6g0ZfuCQMrtXoh7cJmiZ5LBzvX6ZrYxRvfVuWAQ1RBBt9YhXS3SeoQXOJ3N8mE/A9i7
         y2xaFUtrSbFZyPJHAOCPqD1kgTGVGr2fxiUBTILnsNJA/qCDIy/U7tpfLlS1aWE0XQkw
         JaMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717348418; x=1717953218;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FlefKdoshJJhgRL2RoGsiaOgsjIqjYCu3MnOeHxXpbk=;
        b=YhXDHEtl8dAMA3FcYwxXtHDeU/pgImwTckVOCwRkKDLK7S8PU0oeMq0kIVqo5I0Js2
         3kfYMI6n9ZnlfFFKZujtzBM3IaOXTlp6eW4rhOfd2fOtIYz6UbQyYTzLKr+5rWgHiv81
         0R/cw8WmWoyeMu4srqhx780BKbxR5x7Rzd+htmR7v4OcS8HF7shOjTdom04UdvDAqp81
         TR7sifWVjxvFGl0Hc0J5Ls4TY+t3xY6yoG5fsuZx11/1iEJUkCGqKeu6HoGOIQF8x4hF
         /1eulNVJdreL3Vx1KG+xRXFUBaaeZz7keUYASJA0Umf/oJ3KmUyBegvGA0PmKW5U39RN
         L4qw==
X-Gm-Message-State: AOJu0YwKQOLGHm5ITDoweY6OOUxQjwUV9cr+OaKUU3pnobFM9Q/D51Eb
	PluhlDoQhBkjgfAvYEgRm8Wp+uZm+6RAZcaw1q/4TWADmKeGaK2uZMF6ZQ==
X-Google-Smtp-Source: AGHT+IGPa2d3qVy/0iylBVxkD0hU425pzZKlVxbUI0HKj3QghfhYkpMM1qdbtDjkG/Mc9Cj6gC130Q==
X-Received: by 2002:adf:ec48:0:b0:34d:7a12:454b with SMTP id ffacd0b85a97d-35e0f28b1f7mr4283366f8f.39.1717348417997;
        Sun, 02 Jun 2024 10:13:37 -0700 (PDT)
Received: from gmail.com (35.red-88-14-62.dynamicip.rima-tde.net. [88.14.62.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35e5047f75esm3454390f8f.35.2024.06.02.10.13.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jun 2024 10:13:37 -0700 (PDT)
Message-ID: <1ccc6c1a-0a1e-46ff-8311-abdbbdb4a60d@gmail.com>
Date: Sun, 2 Jun 2024 19:13:36 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] use the pager in 'add -p'
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com> <xmqqwmn79u98.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqwmn79u98.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, Jun 02, 2024 at 09:36:35AM -0700, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
> > Hopefully, we'll find a way to avoid sending ANSI codes, on demand,
> > without disabling it entirely with color.ui=never or any other global
> > option.  To make this usable:
> >
> >   (1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,s,e,p,|,?]? | vim -
> >
> > However, the current functionality meets my current needs, so I'm happy
> > with it.
> 
> Yup, if it really is needed we could do || or anything "unusual" to
> signal the unusual nature of the command.
> 
> Or ">" command can send the output to specified file without
> coloring, and the user can do whatever they want to it.  

Interesting;  perhaps intuitive and in line with other 'isatty()'
conditions we have.

> 
> In any case, unlike "Let's not just do pager, but have a facility to
> pipe to anything and make the pager a default destination" that was
> a natural match to the originally proposed behaviour, these two are
> quite different and can be left totally outside the scope of the
> topic.
> 
> > One final note;  I preferred to model the help text this way:
> >
> >     y - stage this hunk
> >     n - do not stage this hunk
> > ...
> >     g - select a hunk to go to 
> >     / - search for a hunk matching the given regex
> > ...
> >     | - pipe the current hunk to the pager, or |<program> to use a program'
> >     ? - print help
> 
> That's fine.
> 
> The 'g' and '/' commands take _mandatory_ arguments, but we do not
> even mention it in the help text.  But we need to say something for
> this new thing, because it is _optional_ and if you do not give a
> program, it does not ask.
> 
> A possibility is to phrase it like so:
> 
>     | - pipe the current hunk to the program (or "%s" by default)
> 
> and fill %s with the program you'd use if not given, i.e. initially
> the value of the GIT_PAGER but updated to the last used program
> after the user uses "|<program>" form to specify one.

And this one too;  a nice way to allow reusing the previous value.
Perhaps we'd better find a way to introduce some form of CTRL+P, or
arrow-up...  I dunno.

Interesting ideas.  But my preference is to queue this series as it is,
if no major issue is pointed out.  And leave for future series this
topics or the others mentioned in the thread: the 'interactive.'
setting suggested by Peff, or the '-P' switch, by Dragan.

Let's see what others say.

Thanks.
