Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7814215099B
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 10:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727776995; cv=none; b=bwQy27K3JcolteK8Id/aPmjtK5dEHNnK/9ix5RKPUfAYRJ1O8GkqfAuqOXZnLwfdLbQH62Hzt6nB8uO4IBDogY8iQX41Yjo5oltW/qgsdPWBmX4AEbsEcu77gOoutH8FIEcAi8b30gENWX0PmEc5a5da1/4pNsCju+ZEa2RJzp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727776995; c=relaxed/simple;
	bh=FB8dq13/ZTkEpyo76p+jHsfInywJGJ79jTsRvPGolpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LgYR0xA/MZwEBTZ3whn41nyA1hxZHE0UaWn3U1pZPgrVGaV69ZN/+6gpdsmdrwC7pxwQLFb2GFJFNxz/7taAkDhi6ftPYi6dmY0sL9q7Qk8f/ur0hzJwgJSl2578mGJGr4eAbGJb9JV5ADL+JBaQk1ntD4RoDOFhFyhyU2ItlQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N45d9n6F; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N45d9n6F"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8d100e9ce0so530652066b.2
        for <git@vger.kernel.org>; Tue, 01 Oct 2024 03:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727776992; x=1728381792; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I9yWzGj8jcrlXC0/t1itmm0t1YjG0WQaG+sBrN6XWHA=;
        b=N45d9n6FkB9pa+xfoXU8NyH77n6eMR6nmp74LmYqxw2TVSZT58ILRigXe6quXD+W1c
         uP1zWDSMp+6ARC8ikgcQ3eiQjv7n9mTZ9vsgNJuM+3Tj92H3hQcQtC4lTSvbkUInIrAb
         5I3d7nM5W/h4Trp6YlWDJuKpqK06fa9yJl1h5+dUpJ/qj4uVXjuUh16aFEO9PyITQI+k
         haLZMs+3+wjsQ9Xyo92R9E/y1S3YeE4TCf7d5JFfFKDbf4FOKukd0TFrClF9eLaQCsiC
         CSE7a2LmPsL9d3mKZgKA0HUyb0oXSWA6ChiZsoS8es6J+FvC+9ND1+ibZpkROmo6CHL0
         hUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727776992; x=1728381792;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I9yWzGj8jcrlXC0/t1itmm0t1YjG0WQaG+sBrN6XWHA=;
        b=TaASg+qnwPkQ7Ji2DjFAxcyjl5PPFQhuaC/W4j5ZdXqfnIdEA20GLnlexgpUqcP2AT
         tDYAZXRp91kr9pk226Wm3GpMssaHbEV4mUXNhRJPzvhVz3zB1Vombz65Ay1OBPlUHAiU
         0VEU7MnWC3d7gS00u/TQhLIDYh1qdXUqrmwZdVKuKUsk3IkNyrz9kDpky+Mj4E/5uAQs
         gjUh/madrF/BgXojcpOQvlQj8PzI2C4L3m+QsRZU3U46A76UYvmKjOzwTUCcTc8ZuKq6
         R56EqTYLvhWC41KDOB/vqOCp4ze1M6GAqb5g/hLdUTPGTp9c2c5GI23GHKVAvp0bFdDN
         yEYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDcyRJXmxVetjEcROxVOsoqeTUUYjL/HuITGs7pkTlvAkYM8xXDddoURcU1P/MoWpXBnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjMMyzMGFzUo0640KdoY1nIGOU9hfH0fQP0/whubE8kty4juvH
	4VDH59DIaJpp6aCQn6KK3QOECn3XVSJk5ZC5YM/WC2KM11xlry6L
X-Google-Smtp-Source: AGHT+IFcycbU/zIvJsbQ9yv4RTx9fYEAxczNdjfDZcZGjmdJfcs/LZQhHs6HNF3wf6fBsIPI4vsVXg==
X-Received: by 2002:a17:907:6e92:b0:a90:383:5c0c with SMTP id a640c23a62f3a-a93c491f3eemr1639482266b.24.1727776991491;
        Tue, 01 Oct 2024 03:03:11 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:61a:f001:1402:4f50:9447:3e15? ([2a0a:ef40:61a:f001:1402:4f50:9447:3e15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2997d4csm678498766b.188.2024.10.01.03.03.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 03:03:11 -0700 (PDT)
Message-ID: <9c7af640-ee3a-4a17-84f6-f56fee7efe37@gmail.com>
Date: Tue, 1 Oct 2024 11:03:10 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] add-patch: edit the hunk again
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 Git List <git@vger.kernel.org>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
 Junio C Hamano <gitster@pobox.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <21ddf64f-10c2-4087-a778-0bd2e82aef42@gmail.com>
 <4dd5a2c7-26a8-470f-b651-e1fe2d1dbcec@gmail.com>
 <74289d8b-7211-452a-ac76-f733e89112e6@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <74289d8b-7211-452a-ac76-f733e89112e6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rubén

On 28/09/2024 15:30, Rubén Justo wrote:
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
> 
> If they really want to start over with a fresh patch they still can
> say 'no', to cancel the "edit" and start anew [*].
> 
>      * In the old script-based version of "add -p", this "no" meant
>        discarding the hunk and moving on to the next one.
> 
>        This changed, probably unintentionally, during its conversion to
>        C in bcdd297b78 (built-in add -p: implement hunk editing,
>        2019-12-13).
> 
>        It now makes more sense not to move to the next block when the
>        user requests to discard their edits.
> 
> Signed-off-by: Rubén Justo <rjusto@gmail.com>
> ---
> 
> In this iteration, I'm modifying the message 'saying no discards' to
> make its meaning more explicit, perhaps also gaining some clarity
> along the way for the user who wants to restart editing from the
> original patch.
> 
> In the test, I'm adding "n q" to the script as suggested by Phillip.
> 
> And, just a bit of mental peace by restoring the hunk from the backup
> before trimming the two strbuf.

I hoped that change would be in edit_hunk_manually() but it isn't.

I'm afraid I still don't think that changing the default is a good idea 
as it is often very difficult to correct a badly edited hunk. Can we 
offer the user a choice of

     (e) edit the original hunk again
     (f) fix the edited hunk
     (d) discard the edit

In [1] you say you discarded that idea because the wording was too 
verbose but something along like the above should be succinct enough.

Best Wishes

Phillip

[1] 
https://lore.kernel.org/git/6f392446-10b4-4074-a993-97ac444275f8@gmail.com

> Thanks.
> 
>   add-patch.c                | 33 ++++++++++++++++++++-------------
>   t/t3701-add-interactive.sh | 13 +++++++++++++
>   2 files changed, 33 insertions(+), 13 deletions(-)
> 
> diff --git a/add-patch.c b/add-patch.c
> index 557903310d..c847b4a59d 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -1111,7 +1111,8 @@ static void recolor_hunk(struct add_p_state *s, struct hunk *hunk)
>   	hunk->colored_end = s->colored.len;
>   }
>   
> -static int edit_hunk_manually(struct add_p_state *s, struct hunk *hunk)
> +static int edit_hunk_manually(struct add_p_state *s, struct hunk *hunk,
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
> +
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
>   	if (hunk->end == hunk->start)
>   		/* The user aborted editing by deleting everything */
>   		return 0;
>   
> -	recolor_hunk(s, hunk);
> -
>   	/*
>   	 * If the hunk header is intact, parse it, otherwise simply use the
>   	 * hunk header prior to editing (which will adjust `hunk->start` to
> @@ -1257,15 +1263,14 @@ static int edit_hunk_loop(struct add_p_state *s,
>   	backup = *hunk;
>   
>   	for (;;) {
> -		int res = edit_hunk_manually(s, hunk);
> +		int res = edit_hunk_manually(s, hunk, plain_len, colored_len);
>   		if (res == 0) {
>   			/* abandoned */
> -			*hunk = backup;
> -			return -1;
> +			break;
>   		}
>   
>   		if (res > 0) {
> -			hunk->delta +=
> +			hunk->delta = backup.delta +
>   				recount_edited_hunk(s, hunk,
>   						    backup.header.old_count,
>   						    backup.header.new_count);
> @@ -1273,10 +1278,6 @@ static int edit_hunk_loop(struct add_p_state *s,
>   				return 0;
>   		}
>   
> -		/* Drop edits (they were appended to s->plain) */
> -		strbuf_setlen(&s->plain, plain_len);
> -		strbuf_setlen(&s->colored, colored_len);
> -		*hunk = backup;
>   
>   		/*
>   		 * TRANSLATORS: do not translate [y/n]
> @@ -1286,11 +1287,17 @@ static int edit_hunk_loop(struct add_p_state *s,
>   		 * of the word "no" does not start with n.
>   		 */
>   		res = prompt_yesno(s, _("Your edited hunk does not apply. "
> -					"Edit again (saying \"no\" discards!) "
> +					"Edit again (saying \"no\" discards your edits!) "
>   					"[y/n]? "));
>   		if (res < 1)
> -			return -1;
> +			break;
>   	}
> +
> +	/* Drop a possible edit */
> +	*hunk = backup;
> +	strbuf_setlen(&s->plain, plain_len);
> +	strbuf_setlen(&s->colored, colored_len);
> +	return -1;
>   }
>   
>   static int apply_for_checkout(struct add_p_state *s, struct strbuf *diff,
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index 718438ffc7..1ceefd96e6 100755
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
> +		test_write_lines e y n q | GIT_TRACE=1 git add -p
> +	) &&
> +	test_grep been-here output
> +'
> +
>   test_expect_success 'setup patch' '
>   	cat >patch <<-\EOF
>   	@@ -1,1 +1,4 @@
> 
> Range-diff against v2:
> 1:  2b55a759d5 ! 1:  7e76606751 add-patch: edit the hunk again
>      @@ add-patch.c: static int edit_hunk_loop(struct add_p_state *s,
>        		/*
>        		 * TRANSLATORS: do not translate [y/n]
>       @@ add-patch.c: static int edit_hunk_loop(struct add_p_state *s,
>      - 					"Edit again (saying \"no\" discards!) "
>      + 		 * of the word "no" does not start with n.
>      + 		 */
>      + 		res = prompt_yesno(s, _("Your edited hunk does not apply. "
>      +-					"Edit again (saying \"no\" discards!) "
>      ++					"Edit again (saying \"no\" discards your edits!) "
>        					"[y/n]? "));
>        		if (res < 1)
>       -			return -1;
>      @@ add-patch.c: static int edit_hunk_loop(struct add_p_state *s,
>        	}
>       +
>       +	/* Drop a possible edit */
>      ++	*hunk = backup;
>       +	strbuf_setlen(&s->plain, plain_len);
>       +	strbuf_setlen(&s->colored, colored_len);
>      -+	*hunk = backup;
>       +	return -1;
>        }
>        
>      @@ t/t3701-add-interactive.sh: test_expect_success 'dummy edit works' '
>       +	EOF
>       +	(
>       +		test_set_editor "$(pwd)/fake_editor.sh" &&
>      -+		test_write_lines e y | GIT_TRACE=1 git add -p
>      ++		test_write_lines e y n q | GIT_TRACE=1 git add -p
>       +	) &&
>       +	test_grep been-here output
>       +'

