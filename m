Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2D98203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 22:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756559AbdGXWVp (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 18:21:45 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36944 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756647AbdGXWVn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 18:21:43 -0400
Received: by mail-pf0-f195.google.com with SMTP id y25so4091861pfk.4
        for <git@vger.kernel.org>; Mon, 24 Jul 2017 15:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L2KkukVn44tPPkDACe2odemhYsKmDg8+SpDFGQ9IFb0=;
        b=MUfGJPvCkyxbJZuZyBe+EHERCRN+Jt3mzPSFkLoMLiqxdJXNs1DLqSKAqDYxb+cefy
         mgKxSSZ7mBpvNkCx3mCPzw7TEOrlwA72DgVkZZPUFiQHYbJceyDQqZbIfVWD9AHDz9cj
         Hu5gp4sMvEfXnND8MfZG6AYJygJyhs3Qg4lpGgzLhmo2rnzn4HhbMm8UuVQeE61IhGWR
         U+b0bq6SX04lccBmoooNasBYfUkPsGIfcg/1gyLYNxWoQH9zstegvfLq6HeeZCOhGlhz
         PNHe4o2v6p3YwJVYYRG4mi66Wnkb64tzvsRgvKe7LKa2VndxE4GhjCGF+SfK3Uql+Vfy
         g7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L2KkukVn44tPPkDACe2odemhYsKmDg8+SpDFGQ9IFb0=;
        b=mzJ8ei/Gkt9DDZty/Yf/6W1XwDAHKlhmHm+x7kb54u4gXyCBWujLtsMzbqjZ48nwiO
         FOo0Bk78abyprZjhfYSUNm5dJs+LgWqTCu9+SdaNKAr9a67UWoGp0MwehawcjB5b7L17
         hlJAQgRDbDdw9JVqhZQZbbTTcI1bHiaa/NXeucD1dSHo0Y39W0FvlpT47AaSFHfmb7yh
         Eh7P5GMQf270QwHu/ZuxIk5HyT06u2G5+QAn+o+g6vekdQqWrjVWcIGd1YZiF0jYISt0
         HN+IHbsqYQKQVt/kqIgsjPEFxhEf8jXGMaQFkNYkyulIGh08hHc3mYJKAA/QrM19tROW
         tWWQ==
X-Gm-Message-State: AIVw110kaFAXl5ZlBvruudN1jRVJCZhq2hNzZuuOpjpa5SEIisM2Zqyy
        zzASuHbs2QZKHg==
X-Received: by 10.99.48.7 with SMTP id w7mr17908424pgw.244.1500934902729;
        Mon, 24 Jul 2017 15:21:42 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:f5ce:84d4:f5fa:e09c])
        by smtp.gmail.com with ESMTPSA id m6sm24942992pgn.86.2017.07.24.15.21.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 24 Jul 2017 15:21:41 -0700 (PDT)
Date:   Mon, 24 Jul 2017 15:21:39 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, benpeart@microsoft.com,
        larsxschneider@gmail.com
Subject: Re: [PATCH] sub-process: refactor handshake to common function
Message-ID: <20170724222139.GF13924@aiede.mtv.corp.google.com>
References: <20170724213810.29831-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170724213810.29831-1-jonathantanmy@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jonathan Tan wrote:

> Refactor, into a common function, the version and capability negotiation
> done when invoking a long-running process as a clean or smudge filter.
> This will be useful for other Git code that needs to interact similarly
> with a long-running process.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---

Sounds like a sensible thing to do.

[...]
> --- a/sub-process.h
> +++ b/sub-process.h
> @@ -18,6 +18,11 @@ struct subprocess_entry {
>  	struct child_process process;
>  };
>  
> +struct subprocess_capability {
> +	const char *name;
> +	unsigned int flag;

What does this flag represent?  What values can it have?  A comment
might help.

[...]
> @@ -41,6 +46,19 @@ static inline struct child_process *subprocess_get_child_process(
>  	return &entry->process;
>  }
>  
> +/*
> + * Perform the handshake to a long-running process as described in the
> + * gitattributes documentation using the given requested versions and
> + * capabilities. The "versions" and "capabilities" parameters are arrays
> + * terminated by a 0 or blank struct.
> + */
> +int subprocess_handshake(struct subprocess_entry *entry,
> +			 const char *welcome_prefix,
> +			 int *versions,
> +			 int *chosen_version,
> +			 struct subprocess_capability *capabilities,
> +			 unsigned int *supported_capabilities);
> +

Is there a more precise pointer within the gitattributes documentation
that describes what this does?  I searched for "handshake" and found
nothing.  Is the "Long Running Filter Process" section where I should
have started?

The API docs for this header are currently in
Documentation/technical/api-sub-process.txt.  Perhaps these docs
should also go there, or, even better, the docs in
Documentation/technical/ could move to this header in a preparatory
patch.

Aside (not about this patch): why is the subprocess object called
struct subprocess_entry?  Would it make sense to rename it to struct
subprocess?

Back to this function.  Is this a function I should only call once,
when first launching a subprocess, or can I call it again later?  A
note about suggested usage might help.

[...]
> --- a/t/t0021-conversion.sh
> +++ b/t/t0021-conversion.sh
> @@ -697,7 +697,7 @@ test_expect_success PERL 'invalid process filter must fail (and not hang!)' '
>  
>  		cp "$TEST_ROOT/test.o" test.r &&
>  		test_must_fail git add . 2>git-stderr.log &&
> -		grep "does not support filter protocol version" git-stderr.log
> +		grep "expected git-filter-server" git-stderr.log

This error message looks a little less friendly than the old one.
Is that okay because it is not supposed to happen in practice?

[...]
> --- a/convert.c
> +++ b/convert.c
> @@ -512,62 +512,15 @@ static struct hashmap subprocess_map;
>  
>  static int start_multi_file_filter_fn(struct subprocess_entry *subprocess)
>  {
> -	int err;
> -	struct cmd2process *entry = (struct cmd2process *)subprocess;
[... many lines snipped ...]
> -	return err;
> +	static int versions[] = {2, 0};
> +	static struct subprocess_capability capabilities[] = {
> +		{"clean", CAP_CLEAN}, {"smudge", CAP_SMUDGE}, {NULL, 0}
> +	};
> +	struct cmd2process *entry = (struct cmd2process *)subprocess;
> +
> +	return subprocess_handshake(subprocess, "git-filter-", versions, NULL,
> +				    capabilities,
> +				    &entry->supported_capabilities);
>  }

API looks nice.

[...]
> --- a/sub-process.c
> +++ b/sub-process.c
> @@ -105,3 +105,97 @@ int subprocess_start(struct hashmap *hashmap, struct subprocess_entry *entry, co

Implementation looks sane from a quick glance.

Thanks,
Jonathan
