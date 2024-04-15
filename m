Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F8774420
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 14:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189948; cv=none; b=C/SjjFxt2/IKKP/Y42k5rRgV9ElA3kWoQe8rp+WmEwZ4Pam3RGAWkjmIWffP+ReNkkSYeX6IEwRWBKg++VuFbDjzyY6u7HXAfwEv5gR7iXgffMnI3tTMPPGKLHzE89qhFN8SPLxlmSwYUAaAR7rzRXkyrFcRU9DCW1bPjDleuEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189948; c=relaxed/simple;
	bh=V+iM9bfu6xlJLR0yofY5RqIY4SuLKrrP2U54OIzq9eY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dPfBiB54n3ebAx3Ahe3NLjeglYR/ouEcaoPsB8Dt8EUneGmtULKYxM918O3t3mxN1WbJgXLBU2ZytM2+xBGIHb+32l/hmb6kd/H33y9eWLu43VuFAZDuYW+7CIiTauuUjoMcdXB/11ov25WrvcZ9gMtPXQkMl/5mLIWHGBG9gBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJVNggMV; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJVNggMV"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d895138ce6so38231961fa.0
        for <git@vger.kernel.org>; Mon, 15 Apr 2024 07:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713189945; x=1713794745; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JkpzZx3esbNi2+Avdzx5+NAoc1NLRz3hKat9ia6IaVg=;
        b=DJVNggMVyRG1E99HpGOBQE6J628sci41+TsDz1O/7igyYFulwXwpLnS0H/kTpZ5VKK
         zjKgC+rpSoKjAQ8HcLJxkAK6HGpzzsChHJrKoKYLAdUWy72Nu2caoD4zV0s97TN05/wt
         JDHHY+3hQudrEiyZX5Vx2QaHoJyA3dLzzJyl3m2shQGxx91QQA0P5Pv83FGS5qmTRRGk
         9xWH471E3yocza9EZh/QxnrdqYJ/XfanC/LR0J/nA2ArgqujLwMeaN3hWOVoI4QBcH4l
         MDKN/2vmppOIP5Gmmw0qAv54Rm8LIk18rIJ+hk3xCeTzTeXaKJmyeRkKL19Zr2Y83Mc0
         AsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713189945; x=1713794745;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JkpzZx3esbNi2+Avdzx5+NAoc1NLRz3hKat9ia6IaVg=;
        b=Ynm+8C4rRlJfIp8gfk/q4xboJtW/fzeYEZNf8WpYoL7+mzTwJdFVQkCu+2C/Kv9Mjl
         7oJ8vlvltgQn0KU11aEUAJLy86ssiMLrokwErpyZ/J89XcaqVc9yNZ/NJuMvdQvxn/30
         GMJ2pD7NSehT43tm4uGs6KMM5IBI9O7SfJQLMf/DXkA4fX/R9ai/WqOf3FkMxfvHkeJg
         jjmnjw77obA21AKnRcovOUPk5GLXLkRo6zjbUL0DTPOUYarIzmO4EzxHE1NdHc75wgq5
         tYvidHJfU5p2j1YJQN3s8leF0QRgeD6Phv7ZjcT44XoOn0HtLppifreft4GgRHfIBSDL
         AXrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUqwaQm4UI8UBSkAmAVFuNarS0Cgi+fES931CfyJxJZjG18Z2eBTvZtJ8ZvWGZaEpDR+PzMz/rn6H3w2amxwZdHQqw
X-Gm-Message-State: AOJu0Yyg3Tx++ccKRD1aUAypU4HA0hsdRHN9rBrfmlHYFNL28ORBRdHn
	iMh+CRq9g4d48zKbVJMYne5ofu9O+b1pQw+RTptleGqVIp/GJxzx
X-Google-Smtp-Source: AGHT+IHJLtQd5b1vogLlfflE9OYrTfmBXZPtUWWBu0JQr00ONOjXlaNt215mEF5ZRJMheyQuQzZk0Q==
X-Received: by 2002:a2e:a0c9:0:b0:2d8:5fb1:4b80 with SMTP id f9-20020a2ea0c9000000b002d85fb14b80mr5922950ljm.24.1713189944556;
        Mon, 15 Apr 2024 07:05:44 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id j14-20020a05600c190e00b00418296091d3sm9066401wmq.19.2024.04.15.07.05.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 07:05:44 -0700 (PDT)
Message-ID: <beebf170-31d0-4ecf-b029-d6bc499f6da8@gmail.com>
Date: Mon, 15 Apr 2024 15:05:32 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4] launch_editor: waiting message on error
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc: rsbecker@nexbridge.com, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <e60c1217-aeb6-48ce-9aa5-7c0b13396e33@gmail.com>
 <96bef5f9-1286-4938-99ec-6beed13ee68d@gmail.com>
 <0258a583-a90a-4434-bb4e-a1672d574b9c@gmail.com>
 <ccbd77a1-d334-4d8f-8de0-b542c79330fd@gmail.com>
 <e208da74-8f16-44ae-912e-ae968da82057@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <e208da74-8f16-44ae-912e-ae968da82057@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rubén

On 14/04/2024 08:39, Rubén Justo wrote:
> When advice.waitingForEditor configuration is not set to false, we show
> a hint telling that we are waiting for user's editor to close the file
> when we launch an editor and wait for it to return control back to us.
> We give the message on an incomplete line, expecting that we can go back
> to the line and clear the message when the editor returns.
> 
> However, it is possible that the editor exits with an error status, in
> which case we show an error message and then return to our caller.  In
> such a case, the error message is given where the terminal cursor
> happens to be, which is most likely after the "we are waiting for your
> editor" message on the same line.

As I've said before I'm not sure how likely that is as I think the 
editor will probably have printed a message if there was an error. 
Assuming the message from the editor ends with a newline the proposed 
change wont do any harm so I don't object to it.

Best Wishes

Phillip

> Clear the line before showing the error.
> 
> While we're here, make the error message follow our CodingGuideLines.
> 
> Signed-off-by: Rubén Justo <rjusto@gmail.com>
> ---
>   editor.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/editor.c b/editor.c
> index b67b802ddf..d1ba2d7c34 100644
> --- a/editor.c
> +++ b/editor.c
> @@ -104,16 +104,15 @@ static int launch_specified_editor(const char *editor, const char *path,
>   		sigchain_pop(SIGQUIT);
>   		if (sig == SIGINT || sig == SIGQUIT)
>   			raise(sig);
> -		if (ret)
> -			return error("There was a problem with the editor '%s'.",
> -					editor);
> -
>   		if (print_waiting_for_editor && !is_terminal_dumb())
>   			/*
>   			 * Erase the entire line to avoid wasting the
>   			 * vertical space.
>   			 */
>   			term_clear_line();
> +		if (ret)
> +			return error("there was a problem with the editor '%s'",
> +					editor);
>   	}
>   
>   	if (!buffer)
