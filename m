Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2C92D191E
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 14:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757512919; cv=none; b=mQZE183sNLdJJmwV+qFCAbJ7c5cUH8g56lHI8pi4U3CFhgLybKVHvpwVGH8MxI/c0dLLE5NylrUwaFmli3DxgmGPIuqeZy5dvlJUnalD7wJUbvnMcbYSlQEzgNgrbCo2+MZWeSM+l2BDsSFkTfzPkPTFw0efzA/f3+5wTvY1L1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757512919; c=relaxed/simple;
	bh=/d4p06dRbjH7epYV4m+cOnLgEX6/XxYyNjVa4qSVXCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DgKcekKfkF+3rFC4RL21WiEBZFFyrT+0WvAfxwKBiYOKczFN3oRf5lC4C5KEdUfRe5XnQ0J6T60KZnp99FlPkRNmOfXoQ+ORZI7TntGRTyUNgVJqXisr5OzBcy24x6aCE9n67V2g2XVDUcJ3M/o7E3yCo3R0TCOVMN5QMiOMoVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIFZTJ1S; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIFZTJ1S"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45cb659e858so47622035e9.2
        for <git@vger.kernel.org>; Wed, 10 Sep 2025 07:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757512916; x=1758117716; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mHow1FmYGHA4vFb7rS5DkYTHjK1mt9p5YTIlJUB7Fqo=;
        b=QIFZTJ1Sb3cFsMjjZKGVxDF3KVvwSBVQzVq3Cgtds4h68rRps2R4I+Ib6qaGyLdi53
         +OrmzjCQ9liFU/SVaUB70E6ovJxjY/scBeE3H8VXKuLc4pWjyG0Zrrj6pMs140ir8xRb
         vQaKePUeLMyRBY+DjA7eu5crh7YCGFzSt474q7ZXYH0UkmYVmSyR/G0yViRqPVC6LUOr
         I419vpg6X3RJKIhIo2RqL8sQwujIWTNt0030bGyK3OkvfUTunKaQ1SBW/y6bYyiEqN2n
         yF1nxUTDWDP72yjl9akilN2F4UJ3eCqjBm0hbdi9DW4YUn0wbSCV63pysAMu24VD2NFC
         oqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757512916; x=1758117716;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mHow1FmYGHA4vFb7rS5DkYTHjK1mt9p5YTIlJUB7Fqo=;
        b=rFi/srW8WhnShaoZc1UCkVz5JYKXmIkJ1yfzaoNh7IRZ3rZ1AhaACcLMvdMlrMNtT6
         bd3wk4LlP2LchHqDhI7jGQmLlECsdtjDE80y0awqE638BDTqTWIgme4NCgdCwvqfUEp0
         yhrg9V1vI0p6oZKFSgJouvw912i1jiAEyA0XZExtpk5noNCqMZoyNYA0UKc/P0oa4WOr
         o6k40ZcD5wAfRFhgCTvKlk1oOoIaAslpIgwNKYu0jBBcZ6dKYu8+AT9wKpwjHGq84IrV
         toTgsI4780UZm1sX8DasyreLAFn+ADlalaglHyQ/h02rcY0Kq9SpQumQou7GoARNx5PV
         Ur+w==
X-Forwarded-Encrypted: i=1; AJvYcCUnACdUgjR+pYUs6Q9YXc4NpCIN+TIbTL2oZ+6tiMYEyEdrmnHctAqKNmeb6OEtezk9PGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE7E1/+pjzwVYBs1Fm6Fapa39N3MxrMf2AD5rIU8Ko9k4JVRUm
	O3KAgzQio5X/Aj1opZ0zmW6/1ydA0HC9RzDdASGprilzguBf3nFGigvW
X-Gm-Gg: ASbGncuVFSefKikVhyDCnV2XZqK5Pg7EXpUDtLLjDwLDZUsruiYz8J65w3J4IKAprkn
	rjWywfEXwqlqqMPfGO97lK+VfEL6l1B/3/uM9KlhhTAKsmd+GJck4rOecnWTV5HD8jDJ3NpAHq5
	KJ9F9AictQXyU+eqTZ99Jg9unEp3DhJyRNfx+3ooW3mRlLVv5nkrvlLZhb2v1Kq2130WJrJm3P/
	hHFyrg4Bmas7dcYq6/qchfQnw9zxKbBk9c4nvXnMqLRWVv/gGhIPG0+5Q2tFMd5zInaD6zxAx6a
	hIGO2cPDvGw17UhrDEHoc54Bv64hokfIHKmnx79X/2mP0pLsdzA+CL2+C/X/u/17O3EQR4/l6V2
	4PWAloVhCxyUz8xwZ2CVw1sigKzf3/ijvQcx6OGGyIfxq/e8Wb4Y+mXeiHqen9Bx5dXv38aXETU
	g=
X-Google-Smtp-Source: AGHT+IG1ggNvAfudBE/kHbHRbh8h4cMV3bFhM2oF7z8GEcnOMd9+uZbDzk15NEfTyXWl41Ux/Iz7wQ==
X-Received: by 2002:a05:600c:3b8b:b0:45d:d356:c358 with SMTP id 5b1f17b1804b1-45dddec3b92mr179368395e9.16.1757512916020;
        Wed, 10 Sep 2025 07:01:56 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45deff57c33sm31679835e9.1.2025.09.10.07.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 07:01:55 -0700 (PDT)
Message-ID: <fcb3355d-c9df-408a-9e28-421a7a18e1fd@gmail.com>
Date: Wed, 10 Sep 2025 15:01:54 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH RFC v3 01/18] sequencer: optionally skip printing commit
 summary
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Junio C Hamano
 <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>,
 Martin von Zweigbergk <martinvonz@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
 <20250904-b4-pks-history-builtin-v3-1-509053514755@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20250904-b4-pks-history-builtin-v3-1-509053514755@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 04/09/2025 15:27, Patrick Steinhardt wrote:
> 
> diff --git a/sequencer.c b/sequencer.c
> index aaf2e4df64..7066cdc939 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1742,7 +1742,7 @@ static int do_commit(struct repository *r,
>   			refs_delete_ref(get_main_ref_store(r), "",
>   					"CHERRY_PICK_HEAD", NULL, REF_NO_DEREF);
>   			unlink(git_path_merge_msg(r));
> -			if (!is_rebase_i(opts))
> +			if (!is_rebase_i(opts) && !opts->skip_commit_summary)

I think it would be cleaner to make rebase set the new option and remove 
!is_rebase_i(opts) here.

Thanks

Phillip

>   				print_commit_summary(r, NULL, &oid,
>   						SUMMARY_SHOW_AUTHOR_DATE);
>   			return res;
> @@ -3139,8 +3139,12 @@ static int populate_opts_cb(const char *key, const char *value,
>   	else if (!strcmp(key, "options.default-msg-cleanup")) {
>   		opts->explicit_cleanup = 1;
>   		opts->default_msg_cleanup = get_cleanup_mode(value, 1);
> -	} else
> +	} else if (!strcmp(key, "options.skip-commit-summary")) {
> +		opts->skip_commit_summary =
> +			git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
> +	} else {
>   		return error(_("invalid key: %s"), key);
> +	}
>   
>   	if (!error_flag)
>   		return error(_("invalid value for '%s': '%s'"), key, value);
> @@ -3698,11 +3702,13 @@ static int save_opts(struct replay_opts *opts)
>   				"options.allow-rerere-auto", NULL,
>   				opts->allow_rerere_auto == RERERE_AUTOUPDATE ?
>   				"true" : "false");
> -
>   	if (opts->explicit_cleanup)
>   		res |= repo_config_set_in_file_gently(the_repository, opts_file,
>   				"options.default-msg-cleanup", NULL,
>   				describe_cleanup_mode(opts->default_msg_cleanup));
> +	if (opts->skip_commit_summary)
> +		res |= repo_config_set_in_file_gently(the_repository, opts_file,
> +					"options.skip-commit-summary", NULL, "true");
>   	return res;
>   }
>   
> diff --git a/sequencer.h b/sequencer.h
> index 304ba4b4d3..1767fd737e 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -52,6 +52,7 @@ struct replay_opts {
>   	int keep_redundant_commits;
>   	int verbose;
>   	int quiet;
> +	int skip_commit_summary;
>   	int reschedule_failed_exec;
>   	int committer_date_is_author_date;
>   	int ignore_date;
> 

