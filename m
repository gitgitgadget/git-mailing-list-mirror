Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 224991F453
	for <e@80x24.org>; Wed, 26 Sep 2018 22:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbeI0EeV (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 00:34:21 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40725 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725722AbeI0EeV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 00:34:21 -0400
Received: by mail-wm1-f65.google.com with SMTP id o2-v6so3922563wmh.5
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 15:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=37lfZV0z1uSifTWcutrbeoelLeyjZRd3Ns1towykiVw=;
        b=VqplvLroYXWMKNG8RWnyMDUI/1Z1D/xf2r8qW4UgFSdf3Y1/raLWE+M6Yi3tI9+6JO
         ayGFAZ69KqNYBIPRKyCMPquV+pKwKYGIKF6RAh1brZGZh14/XqNeXes0ncgY431qXvs2
         MxsRh+j25oC7N/jhtp7ruhqwieXi5GVGHR2IVwNvQabKDIvQttcf1DTmDkRyipzopByJ
         3AKq+cjDmr/nUPpKta5ppVae7bcmKY3o+scpUY/osgXy3Qw344dNXUlCVFJXlgvzSLBA
         7uOfwiUPYyka8vFTOZj0umpBqWoO7S0/f3t8BgR0QqrdRII6jjduDoG8NWwmYdW9dPPM
         wdhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=37lfZV0z1uSifTWcutrbeoelLeyjZRd3Ns1towykiVw=;
        b=qli5Gd9dmjpYtDcbOed0IzEB+f7l3J0CgCeZfO5c1KBt0N0SfBn/SQd1/8bqV2mSEy
         9IRmTm8fXwrnaenK1gF61PGwzwXSV4LcVINmFnU6AdfIvAL8ZftX5W2cfBfwjEhpF104
         5Qzyel/oh2tXpU8JeXfPHuPjGRgj0wS9FqiNRJCfVOBT4mM3YTXXdWvyQqy8Y+/4c1cW
         obn8D5aRI8t6OgY/tfVlrwuEupFsxtcVFpOu9IaF7//9YEKIe9iq/rW2Bzs5qzKs4TuW
         L6oje/B472aRKLcsp69wRj3+2oRZmQOQ5b/Rejk97K5KtnE4LlBYzpNs0Jh6PWA3mcno
         FnJw==
X-Gm-Message-State: ABuFfogHXo8Vu21WOxhINpzZTvytdpuibI8k/cVKrQfwoTxrwbrAtJPW
        mOfkOslhu9m7ae02YRfNGoI=
X-Google-Smtp-Source: ACcGV63IeMOwiupflhVAzisD8fOsGLJo92qqB3xlQ9L29KINMSp6znctOwqMqnSB4YE1Q/bM6yvBdA==
X-Received: by 2002:a1c:a9ce:: with SMTP id s197-v6mr3882652wme.77.1538000353998;
        Wed, 26 Sep 2018 15:19:13 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 198-v6sm1062399wmm.0.2018.09.26.15.19.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 15:19:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 4/9] submodule: move global changed_submodule_names into fetch submodule struct
References: <20180925194755.105578-1-sbeller@google.com>
        <20180925194755.105578-5-sbeller@google.com>
Date:   Wed, 26 Sep 2018 15:19:13 -0700
In-Reply-To: <20180925194755.105578-5-sbeller@google.com> (Stefan Beller's
        message of "Tue, 25 Sep 2018 12:47:50 -0700")
Message-ID: <xmqqo9cjj40u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> The `changed_submodule_names` are only used for fetching, so let's make it
> part of the struct that is passed around for fetching submodules.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  submodule.c | 42 +++++++++++++++++++++++-------------------
>  1 file changed, 23 insertions(+), 19 deletions(-)

Yup, the less file-scope static we have and the more of them moved
to a struct, the closer we get to be able to use multiple of them at
the same time, which is a very nice step in the right direction.

>
> diff --git a/submodule.c b/submodule.c
> index 22c64bd8559..17103379ba4 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -25,7 +25,7 @@
>  #include "commit-reach.h"
>  
>  static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
> -static struct string_list changed_submodule_names = STRING_LIST_INIT_DUP;
> +
>  static int initialized_fetch_ref_tips;
>  static struct oid_array ref_tips_before_fetch;
>  static struct oid_array ref_tips_after_fetch;
> @@ -1110,7 +1110,22 @@ void check_for_new_submodule_commits(struct object_id *oid)
>  	oid_array_append(&ref_tips_after_fetch, oid);
>  }
>  
> -static void calculate_changed_submodule_paths(void)
> +struct submodule_parallel_fetch {
> +	int count;
> +	struct argv_array args;
> +	struct repository *r;
> +	const char *prefix;
> +	int command_line_option;
> +	int default_option;
> +	int quiet;
> +	int result;
> +
> +	struct string_list changed_submodule_names;
> +};
> +#define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0, 0, STRING_LIST_INIT_DUP }
> +
> +static void calculate_changed_submodule_paths(
> +	struct submodule_parallel_fetch *spf)
>  {
>  	struct argv_array argv = ARGV_ARRAY_INIT;
>  	struct string_list changed_submodules = STRING_LIST_INIT_DUP;
> @@ -1148,7 +1163,8 @@ static void calculate_changed_submodule_paths(void)
>  			continue;
>  
>  		if (!submodule_has_commits(path, commits))
> -			string_list_append(&changed_submodule_names, name->string);
> +			string_list_append(&spf->changed_submodule_names,
> +					   name->string);
>  	}
>  
>  	free_submodules_oids(&changed_submodules);
> @@ -1185,18 +1201,6 @@ int submodule_touches_in_range(struct object_id *excl_oid,
>  	return ret;
>  }
>  
> -struct submodule_parallel_fetch {
> -	int count;
> -	struct argv_array args;
> -	struct repository *r;
> -	const char *prefix;
> -	int command_line_option;
> -	int default_option;
> -	int quiet;
> -	int result;
> -};
> -#define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0, 0}
> -
>  static int get_fetch_recurse_config(const struct submodule *submodule,
>  				    struct submodule_parallel_fetch *spf)
>  {
> @@ -1257,7 +1261,7 @@ static int get_next_submodule(struct child_process *cp,
>  		case RECURSE_SUBMODULES_ON_DEMAND:
>  			if (!submodule ||
>  			    !string_list_lookup(
> -					&changed_submodule_names,
> +					&spf->changed_submodule_names,
>  					submodule->name))
>  				continue;
>  			default_argv = "on-demand";
> @@ -1349,8 +1353,8 @@ int fetch_populated_submodules(struct repository *r,
>  	argv_array_push(&spf.args, "--recurse-submodules-default");
>  	/* default value, "--submodule-prefix" and its value are added later */
>  
> -	calculate_changed_submodule_paths();
> -	string_list_sort(&changed_submodule_names);
> +	calculate_changed_submodule_paths(&spf);
> +	string_list_sort(&spf.changed_submodule_names);
>  	run_processes_parallel(max_parallel_jobs,
>  			       get_next_submodule,
>  			       fetch_start_failure,
> @@ -1359,7 +1363,7 @@ int fetch_populated_submodules(struct repository *r,
>  
>  	argv_array_clear(&spf.args);
>  out:
> -	string_list_clear(&changed_submodule_names, 1);
> +	string_list_clear(&spf.changed_submodule_names, 1);
>  	return spf.result;
>  }
