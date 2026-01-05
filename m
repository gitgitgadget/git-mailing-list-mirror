Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5312D594B
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 19:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767641750; cv=none; b=BnlgfFj6b7iI8Zpx3F87qbzTLeixp1lDgFm9tFYdMYzh/kKbCmpDl+/m5fd3aIRO26by+ZrKnFQjsLEyI+VEmrhbNDl2vQ1dmsBJ8Lxs9lBRCzScOF23dVgkBc9hOpMs6aiBLBTPWnw0IJj1I9RW4w5+LNrKvYXkWrOp6pS5Np8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767641750; c=relaxed/simple;
	bh=mBDrL1xVKK1aB1IHXzWQ8Q/C0SKaJ9dbeNUC9GB+gSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obxUpiE7DLN/9Rvc9ZwmXuKOLvGoElLY9h8Z2Kyrhob7erjidZtd/N50wqXUsF7BaMJYEkApl1IuvYp3bPXwnt4YxV3e7ElmXgipELf3sQMzAHbfrUznSbDreNy4Cf4wH0LIQ8T3q7/Ky4RrTuy/k4m5NiLrCvpmumwwLc8JEXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wqw4N9Nw; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wqw4N9Nw"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47a95efd2ceso2344445e9.2
        for <git@vger.kernel.org>; Mon, 05 Jan 2026 11:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767641747; x=1768246547; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C0xZLrsleCCZ2Rfu9vyMG/awBxHc6T4gf+9wXjaJdWc=;
        b=Wqw4N9Nw8o7pI26QOP32naQdax9GxneCCIzSAy+RjL1WzogmLb85qaJq/WqqZY/UKf
         qLmATAKn/44fgy+EmS8avR9Pw6lCHqZsG8Nuj1YZZZEf9Iqq7qlgBq/wDEugM8N5WL9u
         GVAHfrWkvwAhlVQHqUuuTHQCjDRz6aGNbD54ivfAMx/PGnpcMN//fZMPg0AOh/BbcMRq
         KUFnIUA03NP8TVxbpt+U0fv2dvbFEsydqKpEw/8Afcyko4wRkejHu1fTgYrs7Q2wfhi2
         YboAJK8HOgOnnRFx/9PO1mwhUUpvGl+gpJdm7ZroXkidiUIkZU5KO3pCXmewd2/MlGgS
         p9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767641747; x=1768246547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C0xZLrsleCCZ2Rfu9vyMG/awBxHc6T4gf+9wXjaJdWc=;
        b=IGjnbqlvexXazV7bZiCc7TUmxdarT5SexcdHMlwjCKrOzoVaxaPHx5BAnzhrTTLb/r
         AXrOhvVUPtLHdZal4l7Ru/thDCNrONZuufk+rP3U0F0K4HMqo+KNxcHNB5mFfOXhSaWX
         1+SvlUY1nWK3T+MNORm795Waea/0chNJCSexQHti/ft6EU1Lbxz5wJPjnaWEOQG6Wse6
         68IracXM3VQqym2Fh50mfe2N455Jm6Yxqfu3I+rFmIFeNgRf50Y/nII2zHf2o/zO/LaQ
         66cqX62KU5bxqtdzjUjgPJ+mxhwYAiezW9AKYt98XjkvG5khgDEPERf9fiubdkNeSeX/
         Oc/Q==
X-Gm-Message-State: AOJu0YzoPc8mcQ/FWz1DKLV4cPAKsSj/mckfNuPGQG2faXerbog/VuO7
	6QiCVx0dc34Z9JcGm3toFPxL1+vFb/a9QDXxrxdQQzVjAFcmLbQ+S592
X-Gm-Gg: AY/fxX4YgF8Onc3UFkBtd26FrYGopl/5Ehjb8iQsV/adCXmh6SAXH60kj+V69YuS1ZO
	Yi7RTMuNfddC6aL0OtyLdjHYehirqtr9VPp85amuAL5Fc7y+NFdVESRI/Ohe0IM1CoK/W9PDGqV
	Sba75ay/huOo8kRcbhdbfpmXuoiebxFQkppDVqQ/5iXWq/bbK2jVtqTj7298mhK6gO4ISMfIjmc
	z4W5svIaPdPoCsV/qm36iaKR2bOjAwIVlPKoo7CWCMFRQC/TkE5hnW5lfolWXpbeXxH7gzhFEd8
	K/pEf2MxROk6q5IsPyMhEcWPZAFMGOsvUmt0uwVF1Mqa7XVYP9qS+4qy/SsyIidcigTH9j9bt45
	P6N0830eJcjJWSEyWoOYb7gnFIHiBnguMVZJQt5hLj3Ow8X7Je7On2LQ2QUwuGnaRquDQxnCRYd
	YlPdSllCBWWUeBUHmpfPcXxcl5SVevgm7t6PD57Q==
X-Google-Smtp-Source: AGHT+IFQ2Ov23TSZsMDESzvioAiwmfSaMgdOZOzQf/FDO+IvP0hq6AnD73ond0QJI0nEReFpx9PKCA==
X-Received: by 2002:a05:600c:46c4:b0:47d:403e:90c9 with SMTP id 5b1f17b1804b1-47d7f07031emr5352315e9.11.1767641746996;
        Mon, 05 Jan 2026 11:35:46 -0800 (PST)
Received: from localhost (78-131-14-11.pool.digikabel.hu. [78.131.14.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f695225sm2946565e9.4.2026.01.05.11.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 11:35:46 -0800 (PST)
Date: Mon, 5 Jan 2026 20:35:33 +0100
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC PATCH v4] add -p: show user's hunk decision when selecting
 hunks
Message-ID: <aVwShWyoGBq4BcGR@szeder.dev>
References: <aVgTmYhosEiGG3th@Adekunles-MacBook-Air.local>
 <aVpI36nPuZAEchuM@Adekunles-MacBook-Air.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aVpI36nPuZAEchuM@Adekunles-MacBook-Air.local>

On Sun, Jan 04, 2026 at 12:02:55PM +0100, Abraham Samuel Adekunle wrote:
> diff --git a/add-patch.c b/add-patch.c
> index 173a53241e..bc7a340d21 100644
> --- a/add-patch.c
> +++ b/add-patch.c

> @@ -1448,6 +1448,7 @@ static int patch_update_file(struct add_p_state *s,
>  	ssize_t i, undecided_previous, undecided_next, rendered_hunk_index = -1;
>  	struct hunk *hunk;
>  	char ch;
> +	const char *hunk_use_decision;

'hunk_use_decision' is defined here, but is left uninitialized.

>  	struct child_process cp = CHILD_PROCESS_INIT;
>  	int colored = !!s->colored.len, quit = 0, use_pager = 0;
>  	enum prompt_mode_type prompt_mode_type;
> @@ -1564,8 +1565,17 @@ static int patch_update_file(struct add_p_state *s,
>  			      (uintmax_t)(file_diff->hunk_nr
>  						? file_diff->hunk_nr
>  						: 1));
> +		if (file_diff->hunk_nr) {
> +			if (hunk->use == USE_HUNK)
> +				hunk_use_decision = _(" (previous decision: use) ");
> +			else if (hunk->use == SKIP_HUNK)
> +				hunk_use_decision = _(" (previous decision: skip) ");
> +			else
> +				hunk_use_decision = " ";

'hunk_use_decision' is set here, but only if 'file_diff->hunk_nr' is
non-zero.

> +`
> +		}

Nit: unnecessary empty line before the closing brace.

>  		printf(_(s->mode->prompt_mode[prompt_mode_type]),
> -		       s->buf.buf);
> +			hunk_use_decision, s->buf.buf);

So 'hunk_use_decision' is used uninitialized here if
'file_diff->hunk_nr' is zero.

>  		if (*s->s.reset_color_interactive)
>  			fputs(s->s.reset_color_interactive, stdout);
>  		fflush(stdout);
