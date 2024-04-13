Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8AE1F94C
	for <git@vger.kernel.org>; Sat, 13 Apr 2024 15:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713020976; cv=none; b=bsLsEm9bwmHn4ygEd3MKDB/cNfSSxOMDU4ziLK0Kh5y/eE5jLdbibgYli8CV9eY3U7FR6VIODtAW1A//5y2gF4jiR9SMQ2rllUm7+wtcx/hIBg1ewTmX2zV47xwDfvjOpdVluc2eXjz8iCDyMniwtbHe5vBnhwi22AJVOKkGsh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713020976; c=relaxed/simple;
	bh=+im5XUapptUO697WB5gyax87y5oHT5osxNNlM2+HjVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EtBGOuXxwIWhLe6N63cDJzxMZCjpzXvXeKmoj2MaaDpPC80hdvY2ssdzpjp2foBwfv1Stywb67vsf2iYyh4DnrodGVH2ICPoRBrEsKCrNtb5RqFGWaC7ncMt21EzKuvwNC/LroLywfRoxGYVlr+JSEN1rrCYm3YkpL4UqzwwC4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MuxFgqAq; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuxFgqAq"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-343b7c015a8so1266549f8f.1
        for <git@vger.kernel.org>; Sat, 13 Apr 2024 08:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713020973; x=1713625773; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/7+uskYKkWvjLvgAK/zSYHUBE1OdBuNEYm/pPT5869E=;
        b=MuxFgqAqIOw6XT4YauKyc49jkSWO9QXNHaClYEDNOsGogdZmaARixa7Xdsn6wcLotf
         /vBjS5G5baXEEgdbu/O8G9XjI0cTMgz5Bpyf4gkU1YUvsgWQv28GJrQTckC/Lt1P8DI9
         vIo0D5DSvOnQQInmoIdRxG37PFekZB/dr8uRjt99BprzO43rEM6EGWpxhSqTRSDPYUcg
         /wiFCkTcQdqS9ZXllnW+3y2lSBS9pOGYDMia6Pn9Jmx5EiH+b9HmjZ9RVkR8FsH6MtqG
         raXnTYzJb5/pi2M7QJOk/MBlu5BAvMaBieW2x/5nmzRyOUNp19oFjG6II5zVngxuwsZh
         G+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713020973; x=1713625773;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/7+uskYKkWvjLvgAK/zSYHUBE1OdBuNEYm/pPT5869E=;
        b=F3IvYsl/p9nhNW2fNx9RnuuLuubK1Y7bkpNh0Tme57KB260O6/y5EAXaO1goDDAkGr
         K/3DxH6emCQr4R+6FvN1LE3iSU/hW71qpl/mEflvZ8n9VZufQvAcLYUUzLsnwJXrZJkX
         KX9L1jzBxkNOViy2l/vgTwPKt+NGyW0ea6y9iJDmJ/JYsHaHYmUa+8Ee2nmQFgdfn+2l
         rYvin4QR32prGYnbc+MUw7UBBrLUJ9Kmu9Xd9oUCTaErmXZmdAIH8ji4DKQ+ITmKporC
         a1pB6hkr+jbNL6z9/BV/yJPndGlqZXS68f6vQPBLqJ6PazoJkafrj4U4J80m32IyNxIg
         O53g==
X-Forwarded-Encrypted: i=1; AJvYcCWv4eqNWIl1taqjT26DTOtZ7PZSW2u0/ubqG+mjGmqxMGJGowXUYN/yZ4YVza4ETH0Ydt8rcQr2AMaBHWzdXEUvEx/D
X-Gm-Message-State: AOJu0YzbYMDzncAtOtPMOTIrrbi7x+QchEXnAlgf4ofBlVWCa5iAznh4
	VSO8vVti8FVXn8EJk0V5wJBTWo98dBc945PyMvkGfigZbHREyq1KR6qoqA==
X-Google-Smtp-Source: AGHT+IFayoToUdx9xwjEn0o435fJGuxlQvKvUBR8ACPyH2nYAqX/qXw+WszAlhejnvReWUXsFSuZVA==
X-Received: by 2002:adf:e350:0:b0:341:c9d1:eae5 with SMTP id n16-20020adfe350000000b00341c9d1eae5mr3301198wrj.27.1713020972633;
        Sat, 13 Apr 2024 08:09:32 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id r20-20020adfca94000000b00346fdd55b8fsm4343223wrh.115.2024.04.13.08.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Apr 2024 08:09:32 -0700 (PDT)
Message-ID: <782c7127-45d7-4bd6-930f-941a6f43088d@gmail.com>
Date: Sat, 13 Apr 2024 16:09:27 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/2] launch_editor: waiting message on error
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <e60c1217-aeb6-48ce-9aa5-7c0b13396e33@gmail.com>
 <96bef5f9-1286-4938-99ec-6beed13ee68d@gmail.com>
 <0258a583-a90a-4434-bb4e-a1672d574b9c@gmail.com>
 <ccbd77a1-d334-4d8f-8de0-b542c79330fd@gmail.com>
 <c430a194-32ac-403c-a381-801556275f66@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <c430a194-32ac-403c-a381-801556275f66@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rubén

On 12/04/2024 18:15, Rubén Justo wrote:
> When advice.waitingForEditor configuration is not set to false, we show
> a hint telling that we are waiting for user's editor to close the file
> when we launch an editor and wait for it to return control back to us.
> We give the message on an incomplete line, expecting that we can go back
> to the line and clear the message when the editor returns successfully.
> 
> However, it is possible that the editor exits with an error status, in
> which case we show an error message and then return to our caller.  In
> such a case, the error message is given where the terminal cursor
> happens to be, which is most likely after the "we are waiting for your
> editor" message on the same line.

I think it is very likely that the editor has printed an error message 
if it exits with a non-zero exit code and if that message does not end 
with a newline that is a bug in the editor. Do you have a real-world 
example of the problem you are seeking to fix?

Best Wishes

Phillip

> Only clear the line when the editor returned cleanly, and otherwise,
> complete the message on the incomplete line with a newline before giving
> the error message.
> 
> While we're here, make the error message follow our CodingGuideLines.
> 
> Signed-off-by: Rubén Justo <rjusto@gmail.com>
> ---
>   editor.c | 26 ++++++++++++++++++--------
>   1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/editor.c b/editor.c
> index 1da3a26f5d..eb0cfe4a28 100644
> --- a/editor.c
> +++ b/editor.c
> @@ -104,16 +104,26 @@ static int launch_specified_editor(const char *editor, const char *path,
>   		sigchain_pop(SIGQUIT);
>   		if (sig == SIGINT || sig == SIGQUIT)
>   			raise(sig);
> +
> +		if (print_waiting_for_editor && !is_terminal_dumb()) {
> +			if (!ret)
> +				/*
> +				 * Erase the entire line to avoid wasting
> +				 * the vertical space.
> +				 */
> +				term_clear_line();
> +			else
> +				/*
> +				 * We don't want term_clear_line() here
> +				 * because the editor could have written
> +				 * some useful messages to the user.
> +				 */
> +				fprintf(stderr, "\n");
> +		}
> +
>   		if (ret)
> -			return error("There was a problem with the editor '%s'.",
> +			return error("there was a problem with the editor '%s'",
>   					editor);
> -
> -		if (print_waiting_for_editor && !is_terminal_dumb())
> -			/*
> -			 * Erase the entire line to avoid wasting the
> -			 * vertical space.
> -			 */
> -			term_clear_line();
>   	}
>   
>   	if (!buffer)
