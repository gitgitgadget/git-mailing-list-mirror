Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C028C132C23
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 19:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713295484; cv=none; b=cwjNP4tATsJEoxZidEOtXbhjkRhC80vXVUvJAm6hK0lB9/1TIZ2vD6jGxc5h7oXxBwOSm13QM2nrzeoteH+7vJpawPP54fEeud5EbnAJSBcEkGSa2Xg0tALNGZsxMncRO0j/pPYPHHtUIYmmfXTeW7dasY1aVKuQIAJRVLtzczk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713295484; c=relaxed/simple;
	bh=2aJzH8483U97/Il/wf2UVwj9E+9AfOtTmmnLnedO0tI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZxpOTlcMxq0qrfINkuqOij3Wgb2dHeaCWWx2zsYtOih3G9blZvwBx4yeEx+RWhCdhI04t9FDvfcJP3x4m1VnYByfzsKjdvHy7X24ozuzywZFfY0wkzRHWzBKWGq5ez5BD/mtzbjDxDDLB0JHAz2r0ycnciHDmq54Dg1g7nTVbJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AU3qwGj9; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AU3qwGj9"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d895e2c6efso61480561fa.0
        for <git@vger.kernel.org>; Tue, 16 Apr 2024 12:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713295481; x=1713900281; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r5cMDEt2RyNb+Yk6c8SOIgSMqET/8KA8HUq05WyRTmE=;
        b=AU3qwGj9ct/+QviMGRmRZxomVjcz5/xwFME9KlAND94z1ILhWPeQbC+ttKIkVlWjC7
         SOURuxphFlIMdJFrB5UUtJJuUfdRj9bkOEiwVu9gsZikSni7ozKeJueZM5zmhwoLrRVM
         ElHsfyd0s4tmR6WS0OZxZQq71w8a2jtUF5dolqowPPex4eZ0izw1C3TRu2dSeurnmTxT
         xgsl5LUMvfAK8XDvham27cUANTvYIliIcPKhMejQRHQrxtcY2ZKdz+0v7Rd8+cavVhAp
         4+0q0vSL23/R9UM3HGEPD+Wkvo6IbGfIFi0kgSTd8cbLfk6/bisce1Kx1bYn0vErHA1/
         XuHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713295481; x=1713900281;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r5cMDEt2RyNb+Yk6c8SOIgSMqET/8KA8HUq05WyRTmE=;
        b=iN38GcZ0CVW1f99jHV5B9Sr2iLWQAIAfupJSL7/HNcSqksZFl7dca0CTm/Wcb3xxq/
         ZqvXt/9dMQUPNiLqS1DkHpqb0MZowOTKm0AjNJBpIaU/ZQbCeMlfEQbfCQ8+oVcD9TQl
         YdCpCIuvXW9mQwdzQjXRi1QIH0TTXDPNYw8U0xPvZR6ixX239u9Zjp1ZWWAqJATMucSm
         L3ANQxUepEUaWKAoYr5qoWDHCB4REbTDj0yhvor4Wyrb1/O5GyckqFTkeirkGjTw/AnH
         eZuteIXBS+vLWPJL9+5D/pL13Y/fAt/y2UscwNvjnmh0j5kkX5ytGR4fKhWpYdBBrWHJ
         JAsg==
X-Forwarded-Encrypted: i=1; AJvYcCU2ETJrmpCwyAiDgIcVlPmZTV0lLJnNYpOOHgGeLBxxeP1q1N9w62GjKp//dfoJxjKRyEHMGq5c9xea0omuIR06GQ7H
X-Gm-Message-State: AOJu0YwueRJCr9IRmJ8xE0ROcQuYjRZO0MryiOkY0zNdzVNin4GEg5aJ
	I914CmLE+5Kra2RsbmfNsy0QQU6vRfSqzNlQf1zY2lL0bqIgGkho
X-Google-Smtp-Source: AGHT+IHIgCOYYljs9CZ1fXKNms0kBsB6ez7QZDHXkw4mWX+vlm1fsZSfZK1J2NyfBy+qYIiuLxp13A==
X-Received: by 2002:a2e:9416:0:b0:2da:af46:2fb with SMTP id i22-20020a2e9416000000b002daaf4602fbmr2711926ljh.15.1713295480709;
        Tue, 16 Apr 2024 12:24:40 -0700 (PDT)
Received: from gmail.com (91.red-88-14-45.dynamicip.rima-tde.net. [88.14.45.91])
        by smtp.gmail.com with ESMTPSA id je7-20020a05600c1f8700b00416a43d60e6sm24434529wmb.39.2024.04.16.12.24.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 12:24:40 -0700 (PDT)
Message-ID: <20685fa0-815f-4cdf-95e0-7206588552b5@gmail.com>
Date: Tue, 16 Apr 2024 21:24:39 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] add-patch: response to invalid option
Content-Language: en-US
To: phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
 <15f9252c-212f-43eb-84f3-6046fb2fab38@gmail.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <15f9252c-212f-43eb-84f3-6046fb2fab38@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Apr 16, 2024 at 10:41:32AM +0100, phillip.wood123@gmail.com wrote:

> Thanks for working on this, it is a nice follow up to your last series.

Thank you for your interest!

> 
> On 15/04/2024 20:00, Rubén Justo wrote:
> > 
> > +		} else {
> > +			err(s, _("Unknown option '%s' (use '?' for help)"),
> 
> As this is an interactive program I think "Unknown key" would be clearer.

Maybe you have "interactive.singleKey" set to "true"?

Perhaps "key" refers more to the key pressed by the user.  My impression
is that "option" have a clearer and wider audience.

> Something like this (which also adds coverage for '?' and 'p')

I know we don't have a test for the help.  I noticed this in my other
series.  And I decided not to include a test for it then.  Maybe in this
series it makes sense.

However, I would prefer to keep a test only on the new error message.

Thanks.
