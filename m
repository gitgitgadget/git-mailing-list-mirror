Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4368C3CF4F
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 17:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712512136; cv=none; b=DqgkqbQFmEtWh2I423LGS5U+M7uoYp5Hfc3L8vV57XviXFkT9QtesCXE1mncgQuDwICwmrQNM62X3f+PWm/eFf6onYNDC6mJXFjx9vG8Eadf6uwETTADIu2AGcd2/SJAk+N7QckhdgVeFVYMevB0cNfvMMbdioTN9WLuxkjfkQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712512136; c=relaxed/simple;
	bh=sgYE7m9liMGrUAaH9dojxX0GgHOWbTdy7U/nmcQaRks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CoGecbNTpX0VWZPfJ+MrHdTeABwrf6l4UF0pb7WVZzPmtOzv2p+I5CUVoPeBa+Xb8HITaCTfk9xV42Nyj5k85p4IRGORLSQ0Ez7MYJNW7rTxwzCYKq9pJWw22DCa3PHnAErtYdNfmDK2BZnzoE+ZFXYTX9rr1XuKcQH56MIi5Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=da++ajvA; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="da++ajvA"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d4360ab3daso42957221fa.3
        for <git@vger.kernel.org>; Sun, 07 Apr 2024 10:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712512133; x=1713116933; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yQGe7ZNnCa/lgwnJeySZC6eGjCBQwowifiRWlhbVEig=;
        b=da++ajvArgpvIzcD50ClC7s3saDoPO40lgpJ3zQIdmhUjtlHUY8De6YUMwI+xNF1TR
         G4pb2sIk40w4ZWT4vuxws7TSac3F7L9rkH8PPWdTIKHascPJpyIMONL17B4I20xwkgGl
         Abs6b92sfv6uc3WIsj9O8pbTKKoFVNsPOr5RAWgfu/8ZIG5tTJ6xbD+MCaXaiS51NjWV
         6WCO/RVLXqnL8gpyxPjjVKxYnpgfue5lbH1WGnDWb/ci3W8ypkk9Lps2oADN8i8plRAP
         CHJz0KQPZJyFFQJEJ1S5ksuzqUfFe2Ws88glUo30hr7tCI235wOdsBW1tTmG/45Cpx9X
         GOUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712512133; x=1713116933;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yQGe7ZNnCa/lgwnJeySZC6eGjCBQwowifiRWlhbVEig=;
        b=LkTPkV51qI5IZkfnQi3Z7USqul/AY3uP9Usdz78X+1JL43i58VzGzuGhH0hbUVelxg
         LEiwnKGd6UI9BMG95ibjEUCghrRlIkX1SVZj50rDSMfl3h3MJpjuO39O7/FH+CtxM8Zf
         Nd/RSaoHGh5wp3kY2ExKQHS5YAem0CS8v+tj3QrCc/WSLgjr7qNikjbehAKHJNTR9+c1
         psDoAWUK57JwgtdeAxI3mzkpVuFMVWz9LOp32Q9Ic3WRS4AbvTeYmNqHXezKwI5a57MV
         NcSlK7w3rmIzDa/EruGKfkFgdqDfzxIEhgdbviq0sJ3Tzgv/kG5c12bWPEQC8/cnm0d7
         aV+g==
X-Gm-Message-State: AOJu0YzbedNo+3sQkDPahT4K8t/ozRv1zF5lKgjVk5wdyI85+TCNoIDU
	TIPM2r8Te7dZb1V2tA76MGMaPNnJDkte2qVgULhlQJDOHT/oLHQ7/SNDxgiG
X-Google-Smtp-Source: AGHT+IGPf9RT/NHnqSvmlaS2z2W3YBrUjMc7ddKiN0uQgLalbMMj+3rEUIdxKW/IgF6G0M1U3ErBww==
X-Received: by 2002:a2e:8504:0:b0:2d8:875c:3fdf with SMTP id j4-20020a2e8504000000b002d8875c3fdfmr1131368lji.21.1712512133026;
        Sun, 07 Apr 2024 10:48:53 -0700 (PDT)
Received: from gmail.com (4.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.4])
        by smtp.gmail.com with ESMTPSA id w1-20020a5d6081000000b003455d32e944sm3452727wrt.96.2024.04.07.10.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 10:48:52 -0700 (PDT)
Message-ID: <1323321b-554e-4b16-a814-03710c50db99@gmail.com>
Date: Sun, 7 Apr 2024 19:48:48 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] fix a leak with excludes_file
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>
References: <f4af1e88-5bd9-4b3c-8691-84dbf0ca3ee2@gmail.com>
 <xmqq7chajs3e.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <xmqq7chajs3e.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, Apr 06, 2024 at 10:53:09AM -0700, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
> > We call twice to git_config(): first to get the main git-branch(1) options,
> > and second to get the ones related to the sequencer.

Obviously I meant git-rebase(1) -- or any other command that uses the
sequencer under the hood.

> Adding a parallel API
> next to the existing git_config_pathname() and interpolate_path()
> and convert only these callers that touch excludes_file would not
> help other callers that hold the pointer git_config_pathname()
> returned.

It does not have to be like that.  We may no longer need the current
and problematic git_config_pathname().  However I did not want to go
that far in this series.

>  config.c         | 4 +++-
>  t/t7300-clean.sh | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git c/config.c w/config.c
> index eebce8c7e0..ae3652b08f 100644
> --- c/config.c
> +++ w/config.c
> @@ -1584,8 +1584,10 @@ static int git_default_core_config(const char *var, const char *value,
>  	if (!strcmp(var, "core.askpass"))
>  		return git_config_string(&askpass_program, var, value);
>  
> -	if (!strcmp(var, "core.excludesfile"))
> +	if (!strcmp(var, "core.excludesfile")) {
> +		free((char *)excludes_file);

Aaah, you prefer this :-( ...  this free is what I was referring to, in
the message you are replying to, as the simpler fix ...

It obviously plugs the leak and so my itch is gone;  therefore OK by me
to the series I have seen that you have already sent with this.

Still, I find the approach in this series more interesting than the
simple free.  The strbuf saves us from subsequent free+alloc's, for
exactly the same "core.excludesFile".  The strbuf states clearly, IMHO,
who owns the pointer.  And other niceties.
