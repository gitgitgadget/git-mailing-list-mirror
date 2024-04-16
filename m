Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEE4139D16
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 20:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713299340; cv=none; b=a7sOxP4GpIswDhK5EwZEdFscZaesg+x8sFK6OvXDkykbUmpdUo0LU+Byr5EyUfu6fq1/+pQyrbczb2kt/gM409vRdPtpW5kcYaB6pZev8JQI5/D/qNcVLapsLO6zkgqRTh4a2wE7yyG9gVFzw9UofUDJ9wxgNZxNIeE9FQraDg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713299340; c=relaxed/simple;
	bh=tklCUQCHqgJMnESdY+LOqw8K/ophoaOUh36QPTisEiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lYIJZYxvjVuIESf/ATFT4dGMEP0VliuBTJ5Hz04svURYa65gaVH8S3Gsn+ewWWnWU+vcyBIhZjambrr9x9ClC6j3OJOBcvMtoH7kqyQr3sH3eTnPzVRd1sccOhicfAjhrW7jOPdSCNVS67pGISH9hWDlMhSqBCjmkqyqRCwwKI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVyj5qp/; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVyj5qp/"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41879819915so14996625e9.1
        for <git@vger.kernel.org>; Tue, 16 Apr 2024 13:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713299337; x=1713904137; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F6lvN22zH/KvuHUqWan8P+hyASTxHDeIKBWp36vRH84=;
        b=KVyj5qp/X53w8z/9RmBJjpFROw/nGc6TIbKCS2gBIQDnrr1ZQuAjdi64V5DTsTgnMR
         eEFO93ZAgrMfC5KUgfbUID905yg5onnd3kkRk2B1q5spXBTLlVnQ+8lA+IW04kNMeMq1
         tfhXTYtmK5Oqrn+d+qnMDksF1Prt8JrHLpI5cszuGnmSOFSOyXoYWoelnpRxBmQp/1DN
         kAGRoLFHnK0wHpOl2WGASERlaD5giauoyG+c6od7qjp2VK428IFjU85y6wwYWzh17HYk
         yJyPJvis66QVe7PebeC+2woQa46c9h6Opo4f3MzJ50aHgKkvCan/yzb+opo93nSPWhb4
         gOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713299337; x=1713904137;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F6lvN22zH/KvuHUqWan8P+hyASTxHDeIKBWp36vRH84=;
        b=rWa28om8Rx+vmKgOZfXZW063bxrBywGqxXGTo9+nD2uDWmXQjHU1QObIxbvB9g52E4
         96vHEaDfajkoWAbQ/0p8kxjvsZvpvv7JE+/e/KY9ja7tl9aK9ipYo53iFq51QX8eC1TM
         DtaE6FYB3BtLIeDDHZ+W4x80Aq/YEJZcqe064++xDnScACNd+42I3glsb4lvDB1GlBoI
         JTZerAPyqJled3JsKn7GLI9KFTGro8uTFNMp9e2FQhptC6+XFrEDhfWRf5RIfI41XsZE
         7GtVUnJfjBZPasZDfoaa+kt+GcGyXYvllYiyo8S1pFyPjwoLDzBFOx9iuXybskmCMfa6
         2RDg==
X-Forwarded-Encrypted: i=1; AJvYcCW+0kwCqxdCL7oToMFehImiS3sUUTuh5TGbmqXoUtgOccLUDWXjhl5tRDedffyxv3bIPvdhv72+TazZLKCUvzPBi46V
X-Gm-Message-State: AOJu0Yx6gZhTR1KgGJqbufC1Cig9Y5iiZGpHlLeG/hbnFIujp91QZ8FT
	DrUEFPXmgbKXFhqRU/uE3HSoYURQx85MsRqoVVrkd6N8QWnV5ZBi
X-Google-Smtp-Source: AGHT+IHMj5xhZPcpXFdtpngkANpaJesSN91HXPGAT4hkaqBhWe2QUSolNo513G1u1m6qnFv8untbJQ==
X-Received: by 2002:a05:600c:314f:b0:418:a706:321a with SMTP id h15-20020a05600c314f00b00418a706321amr1148112wmo.26.1713299336784;
        Tue, 16 Apr 2024 13:28:56 -0700 (PDT)
Received: from gmail.com (91.red-88-14-45.dynamicip.rima-tde.net. [88.14.45.91])
        by smtp.gmail.com with ESMTPSA id t7-20020a05600c450700b00417f700eaeasm29278wmo.22.2024.04.16.13.28.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 13:28:56 -0700 (PDT)
Message-ID: <6d90c73b-0026-4715-a00a-084da7ac2c75@gmail.com>
Date: Tue, 16 Apr 2024 22:28:55 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] advice: Add advice.scissors to suppress "do not modify or
 remove this line"
Content-Language: en-US
To: Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
References: <0a7b9172add0a0107e0765a59a798b92161788dd.1708921148.git.josh@joshtriplett.org>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <0a7b9172add0a0107e0765a59a798b92161788dd.1708921148.git.josh@joshtriplett.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Sun, Feb 25, 2024 at 08:21:51PM -0800, Josh Triplett wrote:
> The scissors line before the diff in a verbose commit, or above all the
> comments when using --cleanup=scissors, has the following two lines of
> explanation after it:
> 
> Do not modify or remove the line above.
> Everything below it will be ignored.
> 
> This is useful advice for new users, but potentially redundant for
> experienced users, who might instead appreciate seeing two more lines of
> information in their editor.

Sounds sensible.

> 
> Add advice.scissors to suppress that explanation.

Perhaps "advice.scissorsHint" is a better name?  I'm very bad at
choosing names, but just "scissors" seems too generic to me.

> 
> Signed-off-by: Josh Triplett <josh@joshtriplett.org>
> ---
>  Documentation/config/advice.txt | 5 +++++
>  advice.c                        | 1 +
>  advice.h                        | 1 +
>  wt-status.c                     | 3 ++-
>  4 files changed, 9 insertions(+), 1 deletion(-)

Some tests would be desirable, to ensure that this keeps working in the
future.

> 
> diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
> index c7ea70f2e2..33ab688b6c 100644
> --- a/Documentation/config/advice.txt
> +++ b/Documentation/config/advice.txt
> @@ -104,6 +104,11 @@ advice.*::
>  	rmHints::
>  		In case of failure in the output of linkgit:git-rm[1],
>  		show directions on how to proceed from the current state.
> +	scissors::

Good.  After "rmHints" and before "sequencerInUse".  Looks like the
right position for the new name.

> +		Advice shown by linkgit:git-commit[1] in the commit message
> +		opened in an editor, after a scissors line (containing >8),
> +		saying not to remove the line and that everything after the line
> +		will be ignored.
>  	sequencerInUse::
>  		Advice shown when a sequencer command is already in progress.
>  	skippedCherryPicks::
> diff --git a/advice.c b/advice.c
> index 6e9098ff08..0588012562 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -71,6 +71,7 @@ static struct {
>  	[ADVICE_RESET_NO_REFRESH_WARNING]		= { "resetNoRefresh" },
>  	[ADVICE_RESOLVE_CONFLICT]			= { "resolveConflict" },
>  	[ADVICE_RM_HINTS]				= { "rmHints" },
> +	[ADVICE_SCISSORS]				= { "scissors" },

Ditto.

>  	[ADVICE_SEQUENCER_IN_USE]			= { "sequencerInUse" },
>  	[ADVICE_SET_UPSTREAM_FAILURE]			= { "setUpstreamFailure" },
>  	[ADVICE_SKIPPED_CHERRY_PICKS]			= { "skippedCherryPicks" },
> diff --git a/advice.h b/advice.h
> index 9d4f49ae38..9725aa4199 100644
> --- a/advice.h
> +++ b/advice.h
> @@ -39,6 +39,7 @@ enum advice_type {
>  	ADVICE_RESET_NO_REFRESH_WARNING,
>  	ADVICE_RESOLVE_CONFLICT,
>  	ADVICE_RM_HINTS,
> +	ADVICE_SCISSORS,

Ditto.

>  	ADVICE_SEQUENCER_IN_USE,
>  	ADVICE_SET_UPSTREAM_FAILURE,
>  	ADVICE_SKIPPED_CHERRY_PICKS,
> diff --git a/wt-status.c b/wt-status.c
> index 459d399baa..19d4986351 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1104,7 +1104,8 @@ void wt_status_append_cut_line(struct strbuf *buf)
>  	const char *explanation = _("Do not modify or remove the line above.\nEverything below it will be ignored.");
>  
>  	strbuf_commented_addf(buf, comment_line_char, "%s", cut_line);
> -	strbuf_add_commented_lines(buf, explanation, strlen(explanation), comment_line_char);
> +	if (advice_enabled(ADVICE_SCISSORS))
> +		strbuf_add_commented_lines(buf, explanation, strlen(explanation), comment_line_char);

I wonder if advise_if_enabled() might have a chance here.  I'm just
thinking out loud.  "if(advice_enabled(.." is fine.

>  }
>  
>  void wt_status_add_cut_line(FILE *fp)
> -- 
> 2.43.0
> 

Thanks.
