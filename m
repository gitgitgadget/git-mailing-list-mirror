Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FD128684
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 09:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727082433; cv=none; b=p1hrUAecsD8bdRL7N5tyZlBh1OfTWTqXYS7iaUrKDf/4n82ZPayyySgjM4zMJcDRVXPN6Yo1c3IGryn/IlC33qP41oy6pMEQgvNh/c72ylJYxEy4ESM7b/j/AtpDEsE174N81i30KtzlYnMNsyaGkzQkYQCh2n/+0DEYjJp039o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727082433; c=relaxed/simple;
	bh=56jihNcGqgKQ74ZMDfutZ+MEUbfqVCxyAn5ygJ3b+Vw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lqTxzDA6JBHoQycLdqRhhuNdS8TJwS8xwoqNBUOqNqwViZX7z/xAiGKXtvEjkcTeJwO5G3xh+TorWtxxkJDBSdfR6dP4N7b32HQNV1iRdjaawsQnogn9wE1IxLx/UxG3sY9uHESGQybmE+iMoS1TxjYXHMhmWQuEeihbj/RbAv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WyKSnihz; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyKSnihz"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cb806623eso33810495e9.2
        for <git@vger.kernel.org>; Mon, 23 Sep 2024 02:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727082430; x=1727687230; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZENDZoPXcg9bvI1P7B2Qlt/g1S/eCyZyZ6iCmfTtJQY=;
        b=WyKSnihzuqCG6ETptMKPKBqO0TbFHJGJtTtvy/CVB3/qakOVqbniMTuGlxrmA56Sca
         nKfAmE9ts8PNtaZlA2hmLFoLmTfcWG+k/0y8STBVUlI+I4xBR1+OWfLEOwuJNZLD9MHE
         TXPDCqGZDwXizpogBhmCsyhYbn/EWDLm7/Mq+yqr4dY97wfZJVVQojtgxuJX1Zni2XQA
         aYXJ1YoYQofGOluiXtp1bZl4xL1jf9cGBnDwSwz69vmAZ4G+QEWgiIvFN3sOKlsAUwWm
         V4rZxuEvCl6F3f9AlUl/zicbbEYfKEe0ZyErtc4sqQcNl8ynmgaHh5E8iKpVhkTThlnr
         TygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727082430; x=1727687230;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZENDZoPXcg9bvI1P7B2Qlt/g1S/eCyZyZ6iCmfTtJQY=;
        b=B9b7ga6OmVGQ/1NzuG8X3rsLrQI3G7nuTRtpUXvJwMGeGGxGIUKVYVhM/TavfS0KJX
         Rc20zcP4dZjImNTrKZ9eE+cdluHd478AV9sG/SVZw6hS00TrvsSiHrrTxkENkxIJVk9K
         XPgHnL5i2wU991UNjh9tsK2kdlB2yX6I88j/Wnr3sD0HHM9WRTnno+gG3L1Y2R/QKmis
         ZiogVdNzPIYKoSZNHuji0bB0XI7vR0QH1j7xSceFgiphgFT53Y1nkeP7VtOIsxLtVe/v
         VmAkWqD2prkSao/+SMMyouwaavzjNJh8bxqbylod2g7sLpCmv7PRSaqtc/FiiWOGZ0tV
         pmiw==
X-Forwarded-Encrypted: i=1; AJvYcCV4pkPM8Eslyrgwis2L5AGvf+BF95XF0GqHyz1oVil0aHn09OvguBTfn7SQekva2ZwR9Rs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd9t4sD1dCqxEHXWaoDCsGOfvjhEqNPqvOUqKV3o/r/1+dvZ/E
	X+N35Z7uAUccvJq7hahW5VqNENICg62x9mxqt8iv73WIfTpzRueL
X-Google-Smtp-Source: AGHT+IEVAbGxBlG3rJbP8OTXeowgh1W92sHfqx1bYWDGUYFGvWO61kLgeGEruZ9OBL5rj24/LN9nAA==
X-Received: by 2002:a05:600c:4e8f:b0:42c:b2fa:1c0a with SMTP id 5b1f17b1804b1-42e7ad7313emr66338495e9.23.1727082429265;
        Mon, 23 Sep 2024 02:07:09 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:61a:f001:1402:4f50:9447:3e15? ([2a0a:ef40:61a:f001:1402:4f50:9447:3e15])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e8364sm23939387f8f.43.2024.09.23.02.07.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 02:07:08 -0700 (PDT)
Message-ID: <2ad1f7b1-714c-4d6e-89a6-fd65271222b9@gmail.com>
Date: Mon, 23 Sep 2024 10:07:08 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] add-patch: edit the hunk again
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 Git List <git@vger.kernel.org>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
 Junio C Hamano <gitster@pobox.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <21ddf64f-10c2-4087-a778-0bd2e82aef42@gmail.com>
 <4dd5a2c7-26a8-470f-b651-e1fe2d1dbcec@gmail.com>
Content-Language: en-US
In-Reply-To: <4dd5a2c7-26a8-470f-b651-e1fe2d1dbcec@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rubén

Thanks for the re-roll. I'm still not convinced that changing this 
without keeping an easy way to get the current behavior is a good idea.

On 18/09/2024 18:51, Rubén Justo wrote:
> The "edit" option allows the user to directly modify the hunk to be
> applied.
> 
> If the modified hunk returned by the user is not an applicable patch,
> they will be given the opportunity to try again.
> 
> For this new attempt we give them the original hunk;  they have to
> repeat the modification from scratch.
> 
> Instead, let's give them the modified patch back, so they can identify
> and fix the problem.

It's still not clear how an inexperienced user is meant to do that.

> If they really want to start over with a fresh patch they still can
> say "no" to cancel the "edit" and start anew [*].

This is not very obvious to the user, it would be much better to give 
them the choice when we prompt them about editing the hunk again. We've 
been giving the user the original hunk for the last six and a half years 
so I think it's a bit late to unilaterally change that now.

> diff --git a/add-patch.c b/add-patch.c
> index 557903310d..75b5129281 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -1111,7 +1111,8 @@ static void recolor_hunk(struct add_p_state *s, struct hunk *hunk)
>   	hunk->colored_end = s->colored.len;
>   }
>   
> -static int edit_hunk_manually(struct add_p_state *s, struct hunk *hunk)
> +static int edit_hunk_manually(struct add_p_state *s, struct hunk *hunk,

I would add
				const struct hunk *backup,

here

> +			      size_t plain_len, size_t colored_len)
>   {
>   	size_t i;
>   
> @@ -1146,6 +1147,10 @@ static int edit_hunk_manually(struct add_p_state *s, struct hunk *hunk)
>   				      "addp-hunk-edit.diff", NULL) < 0)
>   		return -1;
>   
> +	/* Drop possible previous edits */
> +	strbuf_setlen(&s->plain, plain_len);
> +	strbuf_setlen(&s->colored, colored_len);

then we can restore the back up here with

	*hunk = *backup;

That would make it clear that we're resetting the hunk and would 
continue to work if we change struct hunk in the future.

>   	/* strip out commented lines */
>   	hunk->start = s->plain.len;
>   	for (i = 0; i < s->buf.len; ) {
> @@ -1157,12 +1162,13 @@ static int edit_hunk_manually(struct add_p_state *s, struct hunk *hunk)
>   	}
>   
>   	hunk->end = s->plain.len;
> +
> +	recolor_hunk(s, hunk);
> +

This means we're now forking an external process when there is no hunk 
to color. It would be better to avoid that by leaving this code where it 
was and restoring the backup hunk above.

>   	if (hunk->end == hunk->start)
>   		/* The user aborted editing by deleting everything */
>   		return 0;
>   
> -	recolor_hunk(s, hunk);
> -
 >
>   		/*
>   		 * TRANSLATORS: do not translate [y/n]
> @@ -1289,8 +1290,14 @@ static int edit_hunk_loop(struct add_p_state *s,
>   					"Edit again (saying \"no\" discards!) "
>   					"[y/n]? "));

I think we should make this a three-way choice so the user can choose to 
keep their changes or start from a valid hunk.

>   		if (res < 1)
> -			return -1;
> +			break;
>   	}
> +
> +	/* Drop a possible edit */
> +	strbuf_setlen(&s->plain, plain_len);
> +	strbuf_setlen(&s->colored, colored_len);
> +	*hunk = backup;
> +	return -1;
>   }
>   
>   static int apply_for_checkout(struct add_p_state *s, struct strbuf *diff,
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index 718438ffc7..f3206a317b 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -165,6 +165,19 @@ test_expect_success 'dummy edit works' '
>   	diff_cmp expected diff
>   '
>   
> +test_expect_success 'editing again works' '
> +	git reset &&
> +	write_script "fake_editor.sh" <<-\EOF &&
> +	grep been-here "$1" >output
> +	echo been-here >"$1"
> +	EOF
> +	(
> +		test_set_editor "$(pwd)/fake_editor.sh" &&
> +		test_write_lines e y | GIT_TRACE=1 git add -p

This is still missing "n q". Apart from that the test is looking good.

Best Wishes

Phillip

> +	) &&
> +	test_grep been-here output
> +'
> +
>   test_expect_success 'setup patch' '
>   	cat >patch <<-\EOF
>   	@@ -1,1 +1,4 @@
> 
> Range-diff:
> 1:  bcf32d0979 ! 1:  2b55a759d5 add-patch: edit the hunk again
>      @@ add-patch.c: static int edit_hunk_manually(struct add_p_state *s, struct hunk *h
>        	/* strip out commented lines */
>        	hunk->start = s->plain.len;
>        	for (i = 0; i < s->buf.len; ) {
>      +@@ add-patch.c: static int edit_hunk_manually(struct add_p_state *s, struct hunk *hunk)
>      + 	}
>      +
>      + 	hunk->end = s->plain.len;
>      ++
>      ++	recolor_hunk(s, hunk);
>      ++
>      + 	if (hunk->end == hunk->start)
>      + 		/* The user aborted editing by deleting everything */
>      + 		return 0;
>      +
>      +-	recolor_hunk(s, hunk);
>      +-
>      + 	/*
>      + 	 * If the hunk header is intact, parse it, otherwise simply use the
>      + 	 * hunk header prior to editing (which will adjust `hunk->start` to
>       @@ add-patch.c: static int edit_hunk_loop(struct add_p_state *s,
>        	backup = *hunk;
>        
>      @@ t/t3701-add-interactive.sh: test_expect_success 'dummy edit works' '
>        	diff_cmp expected diff
>        '
>        
>      -+test_expect_success 'setup re-edit editor' '
>      -+	write_script "fake_editor.sh" <<-\EOF &&
>      -+	grep been-here "$1" && echo found >output
>      -+	echo been-here > "$1"
>      -+	EOF
>      -+	test_set_editor "$(pwd)/fake_editor.sh"
>      -+'
>      -+
>       +test_expect_success 'editing again works' '
>       +	git reset &&
>      -+	test_write_lines e y | GIT_TRACE=1 git add -p &&
>      -+	grep found output
>      ++	write_script "fake_editor.sh" <<-\EOF &&
>      ++	grep been-here "$1" >output
>      ++	echo been-here >"$1"
>      ++	EOF
>      ++	(
>      ++		test_set_editor "$(pwd)/fake_editor.sh" &&
>      ++		test_write_lines e y | GIT_TRACE=1 git add -p
>      ++	) &&
>      ++	test_grep been-here output
>       +'
>       +
>        test_expect_success 'setup patch' '
