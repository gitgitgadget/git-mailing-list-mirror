Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36F4763E6
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711463961; cv=none; b=dZ/uGTDUDYMSXugZVs7GlrRHipIbj67PTMCW1/YaHknSQqASBSQs1HOt8DX9yDWHA5SW0xM7q7q0pxQ8OfRvYbHRdHYc88Ob4rDF3Qcc/ecUx7OGixvPIcV0EOBCr4IH3jkD4okhSF40MySAA46hVoQEE0lxyLSlKNHEZoWYSPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711463961; c=relaxed/simple;
	bh=Vl/2frO5uLrHf4ifahzHlPy9EXFW4PlOZMPdIrutLPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uSA6lyawOuIWAkvlcOki1Q6f1teElrKpYZ9Vdv2We0nRpEECi/WZfz2DTIyr/uQ5H0C3cQ1HvcL0rhnkLsohfvEY5feO22+tMQ7EQ9AcDfN/A6BTs+6GFar42DZMHdFDERLGZXKQmFHLhq7hP4a71BARf8j91j/F+7lA+Atz7uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QyUM5Dwp; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyUM5Dwp"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-513e89d0816so6991066e87.0
        for <git@vger.kernel.org>; Tue, 26 Mar 2024 07:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711463958; x=1712068758; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0zmZ94yA486PNKQo9S/745hgHIvnVPE0rULIL/idw/U=;
        b=QyUM5Dwps5aoo45bJMUQzWqOo0SMVMhF4cN/5js1bvVgBQhosDQoESXqXE9PN9Pi/v
         iZgv19N85uc9T4XNM0OLpHJTiIwabpzvCQuKGwqtRRvezeNEhegI2Q1P/eRM3iYB89mk
         tXjx9lW2MStGf0p5sEjh+Hv55hEZa1bJGPVhZAfw9ymGmSeeVh1e6hqGMzekW2z7Y4ch
         py84XxNSpUDFgXPgjWKH/37lryFSdFVo+nvtYzOQlIvSOil3oDebI0vNku2nUXSo0xK4
         7gJzr49LkilQltpzRt6uTo+VnoAvmoKVVwxGdn/Z7mFVPvW5V0gEW/ilxadqTXPoi9il
         W/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711463958; x=1712068758;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0zmZ94yA486PNKQo9S/745hgHIvnVPE0rULIL/idw/U=;
        b=LXx/bn221ZyrOChy1nB07APiXogC45CMXtaXUGi6DFH/sJsGjrQTRWcJGT2E0NivBT
         rK4+E/SbMKEZcFwlqutqNJ2hzLLejge+vQmm6tfKrfePeFh63oO+kBMZNanD5yxJ6He/
         NqVHB2d61uO5Hp4NUNg2PHRTFZP3a4dvBaVDnf8F3fJAPdcoN0ru65Syn0yWTfXo5IlH
         efa8aXas5f3cTdvmQzYXhiUoq/o0MM09DZTU+eYhMhlua4F6g0yGj+KKn+psdXKq4zGj
         X7gJgyEmcpLMYseG45CklucsnbNwfCeV1s5EM6laZQ4hAeVJxT7JkLikC58FJjjr+zlk
         QnLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmbwr3LaoebgZiCey7RYTXtkegqmpAolX2ZexfeUxqBJY9Xk8Yt/TRKQbZ5cdG+mfP6cyRJOfgT+5dRvuDAk7bdQzs
X-Gm-Message-State: AOJu0YwbPHZqJMaW+Urf+6CTdUaVeZDvK2DOuIzawcLjsWZVKL4DLRUI
	gpcdjRiz3g8i6anTTbh4vzwb20qMtfjMobfelTaVyke3qRud2qSf
X-Google-Smtp-Source: AGHT+IGlDKceHOiZ3JNoVNcM2/3B5r+lo/Yt5r9kPJE6U7SYqDj/fOBsCGxJU7wY6/QtXUbyGcrH1Q==
X-Received: by 2002:a19:ae14:0:b0:513:97e2:43e6 with SMTP id f20-20020a19ae14000000b0051397e243e6mr6276918lfc.10.1711463957534;
        Tue, 26 Mar 2024 07:39:17 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id u10-20020a17090663ca00b00a4a33cfe593sm2445834ejk.39.2024.03.26.07.39.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 07:39:17 -0700 (PDT)
Message-ID: <b3c6a5dd-2d78-4149-95f4-57cf8bd1240a@gmail.com>
Date: Tue, 26 Mar 2024 14:39:18 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/2] add-patch: do not print hunks repeatedly
Content-Language: en-US
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 Git List <git@vger.kernel.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>
References: <2c99dee8-fa6b-4f4f-93b4-3f7a8e0901f9@gmail.com>
 <6f2ed406-2152-476b-b463-3010afe7e11e@gmail.com>
 <c123bf09-7f4c-46f5-aa09-48b2816bf85d@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <c123bf09-7f4c-46f5-aa09-48b2816bf85d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rubén

On 26/03/2024 00:17, Rubén Justo wrote:
>      $ git add -p
>      diff --git a/add-patch.c b/add-patch.c
>      index 52be1ddb15..8fb75e82e2 100644
>      --- a/add-patch.c
>      +++ b/add-patch.c
>      @@ -1394,7 +1394,7 @@ N_("j - leave this hunk undecided, see next undecided hunk\n"
>       static int patch_update_file(struct add_p_state *s,
>       			     struct file_diff *file_diff)
>       {
>      -	size_t hunk_index = 0;
>      +	size_t hunk_index = 0, prev_hunk_index = -1;
>       	ssize_t i, undecided_previous, undecided_next;
>       	struct hunk *hunk;
>       	char ch;
>      (1/4) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? U
>      y - stage this hunk
>      n - do not stage this hunk
>      q - quit; do not stage this hunk or any of the remaining ones
>      a - stage this hunk and all later hunks in the file
>      d - do not stage this hunk or any of the later hunks in the file
>      j - leave this hunk undecided, see next undecided hunk
>      J - leave this hunk undecided, see next hunk
>      g - select a hunk to go to
>      / - search for a hunk matching the given regex
>      e - manually edit the current hunk
>      p - print again the current hunk
>      ? - print help
>      @@ -1394,7 +1394,7 @@ N_("j - leave this hunk undecided, see next undecided hunk\n"
>       static int patch_update_file(struct add_p_state *s,
>       			     struct file_diff *file_diff)
>       {
>      -	size_t hunk_index = 0;
>      +	size_t hunk_index = 0, prev_hunk_index = -1;
>       	ssize_t i, undecided_previous, undecided_next;
>       	struct hunk *hunk;
>       	char ch;
>      (1/4) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?
> 
> Printing the chunk again followed by the question can be confusing as
> the user has to pay special attention to notice that the same chunk is
> being reconsidered.

As we print a long help message if we don't re-display the hunk it ends 
up being separated from the prompt. Personally I find the help message 
quite annoying when I've fat-fingered the wrong key - I'd prefer a 
shorter message pointing to "?" to display more help. We already do 
something similar if the user presses a key such as "s" that is disabled 
for the current hunk.

> It can also be problematic if the chunk is longer than one screen height
> because the result of the previous iteration is lost off the screen (the
> help guide in the previous example).
> 
> To avoid such problems, stop printing the chunk if the iteration does
> not advance to a different chunk.
> 
> Signed-off-by: Rubén Justo <rjusto@gmail.com>
> ---
>   add-patch.c | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/add-patch.c b/add-patch.c
> index 444fd75b2a..54a7d9c01f 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -1394,7 +1394,7 @@ N_("j - leave this hunk undecided, see next undecided hunk\n"
>   static int patch_update_file(struct add_p_state *s,
>   			     struct file_diff *file_diff)
>   {
> -	size_t hunk_index = 0;
> +	size_t hunk_index = 0, prev_hunk_index = -1;

I found the name a bit confusing as we have keys for displaying the 
previous hunk and it make me think of that. As it is used to record the 
index of the hunk that we've rendered perhaps "rendered_hunk_index" 
would be a better name. Also as it needs to hold a negative value we 
should declare it as ssize_t like the variables on the line below.

>   	ssize_t i, undecided_previous, undecided_next;
>   	struct hunk *hunk;
>   	char ch;
> @@ -1448,10 +1448,14 @@ static int patch_update_file(struct add_p_state *s,
>   
>   		strbuf_reset(&s->buf);
>   		if (file_diff->hunk_nr) {
> -			render_hunk(s, hunk, 0, colored, &s->buf);
> -			fputs(s->buf.buf, stdout);
> +			if (prev_hunk_index != hunk_index) {
> +				render_hunk(s, hunk, 0, colored, &s->buf);
> +				fputs(s->buf.buf, stdout);
> +				strbuf_reset(&s->buf);
> +
> +				prev_hunk_index = hunk_index;
> +			}
>   
> -			strbuf_reset(&s->buf);

I'd be inclined to leave this line as is to make it clear that the 
strbuf is always cleared before adding the keybindings.

>   			if (undecided_previous >= 0) {
>   				permitted |= ALLOW_GOTO_PREVIOUS_UNDECIDED_HUNK;
>   				strbuf_addstr(&s->buf, ",k");
> @@ -1649,10 +1653,12 @@ static int patch_update_file(struct add_p_state *s,
>   			if (!(permitted & ALLOW_SPLIT))

style: as you're adding braces to the other clause in this if statement 
you should add them to this clause as well.

Best Wishes

Phillip
