Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 233132047F
	for <e@80x24.org>; Mon, 18 Sep 2017 16:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932915AbdIRQrN (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 12:47:13 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:51636 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932658AbdIRQrM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 12:47:12 -0400
Received: by mail-pf0-f174.google.com with SMTP id b70so515110pfl.8
        for <git@vger.kernel.org>; Mon, 18 Sep 2017 09:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vJvG8/K6zK7BwhZ8vhqpqTEmYYEFm5boLXDWrTzT+c4=;
        b=sFUasHwp2dQFUCpEHvHVQFQQtsLaWe3po71185uVD2WZkz/Zn/Eeramq1lBROIQ0Yj
         jtKT3J9tMKzmDZoMkYX+wotrpvMeBgXuVl0zZf8925qiDrcZr3inXwR8Jge85QyphL5w
         l5Byew1fR064ah8ApN0U1r7/HhP855e14peRu7Jf3FY1xxE0nrUOBMvryIkPlo6M7bpG
         jayzkzAMWfrLs7YsBPAYfABN1ZvsN0BjBRp2iYgOlOKlg44vkKdaQHUtAcoHRoGibCa3
         anD6mz4tjymqd7sWoZEX6XslTd//PDNjiGrjcK9erFtySage/f9UbBL6HkwZKi9SRXuq
         M1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vJvG8/K6zK7BwhZ8vhqpqTEmYYEFm5boLXDWrTzT+c4=;
        b=iRGr9WTsI1dXO7LY3vCWS3iGllCl0z8mDz/W3qfH7YSsGZR0jSAqaWYdY0pVDK9nAo
         VgcwEjgu9VgGKjanKYomj2cuUp6zRmumqeHNYaXd7b/SuICDwd1qZT/hbhKmawiDtj0/
         G7HbuX/SBlDjBqdaZ4dp+9ZwfkuTHlS9bQM+UsWftwVwqDo2iNQ4hPH2MhYKdnhgEism
         Ga1BJauwPLp3oLxk6VFhcrpncLevCy0lpuJ6G0imKqLatnxUj0KwAAzn91zNlAv5tVup
         VcBLp48o53PZqmflbqbz9k7g6XqcxKE8VHrTbpKRN71m6AgVWtTiNyxrGYix1peQ+b80
         0IgQ==
X-Gm-Message-State: AHPjjUiHYVHs3KM1Xf1XAEYqq0oXU/61K/PfuA9si4CLnVKoHwH21C8f
        L12TVtotoKCUtAst
X-Google-Smtp-Source: ADKCNb5kp1kkqWpGqNGfI6Vw58zA1BufCWqHrDm0wzV9/nFFeVml5KLM6RKAfillJ08OFRUUjuAPDg==
X-Received: by 10.99.127.94 with SMTP id p30mr31726126pgn.397.1505753231490;
        Mon, 18 Sep 2017 09:47:11 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:c140:486c:cfb0:5862])
        by smtp.gmail.com with ESMTPSA id 195sm14925248pgg.42.2017.09.18.09.47.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 18 Sep 2017 09:47:10 -0700 (PDT)
Date:   Mon, 18 Sep 2017 09:47:09 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     git@vger.kernel.org, sbeller@google.com, jrnieder@gmail.com,
        Jens.Lehmann@web.de
Subject: Re: [RFC PATCH v2 2/2] submodule: simplify decision tree whether to
 or not to fetch
Message-ID: <20170918164709.GB144331@google.com>
References: <20170817105349.GC52233@book.hvoigt.net>
 <20170915131853.GA99666@book.hvoigt.net>
 <20170915132021.GB99666@book.hvoigt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170915132021.GB99666@book.hvoigt.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/15, Heiko Voigt wrote:
> To make extending this logic later easier.
> 
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>

I like the result of this patch, its much cleaner.

> ---
>  submodule.c | 74 ++++++++++++++++++++++++++++++-------------------------------
>  1 file changed, 37 insertions(+), 37 deletions(-)
> 
> diff --git a/submodule.c b/submodule.c
> index 38b9905e43..fa44fc59f2 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1118,6 +1118,31 @@ struct submodule_parallel_fetch {
>  };
>  #define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0, 0}
>  
> +static int get_fetch_recurse_config(const struct submodule *submodule,
> +				    struct submodule_parallel_fetch *spf)
> +{
> +	if (spf->command_line_option != RECURSE_SUBMODULES_DEFAULT)
> +		return spf->command_line_option;
> +
> +	if (submodule) {
> +		char *key;
> +		const char *value;
> +
> +		int fetch_recurse = submodule->fetch_recurse;
> +		key = xstrfmt("submodule.%s.fetchRecurseSubmodules", submodule->name);
> +		if (!repo_config_get_string_const(the_repository, key, &value)) {
> +			fetch_recurse = parse_fetch_recurse_submodules_arg(key, value);
> +		}
> +		free(key);
> +
> +		if (fetch_recurse != RECURSE_SUBMODULES_NONE)
> +			/* local config overrules everything except commandline */
> +			return fetch_recurse;
> +	}
> +
> +	return spf->default_option;
> +}
> +
>  static int get_next_submodule(struct child_process *cp,
>  			      struct strbuf *err, void *data, void **task_cb)
>  {
> @@ -1137,46 +1162,21 @@ static int get_next_submodule(struct child_process *cp,
>  
>  		submodule = submodule_from_path(&null_oid, ce->name);
>  
> -		default_argv = "yes";
> -		if (spf->command_line_option == RECURSE_SUBMODULES_DEFAULT) {
> -			int fetch_recurse = RECURSE_SUBMODULES_NONE;
> -
> -			if (submodule) {
> -				char *key;
> -				const char *value;
> -
> -				fetch_recurse = submodule->fetch_recurse;
> -				key = xstrfmt("submodule.%s.fetchRecurseSubmodules", submodule->name);
> -				if (!repo_config_get_string_const(the_repository, key, &value)) {
> -					fetch_recurse = parse_fetch_recurse_submodules_arg(key, value);
> -				}
> -				free(key);
> -			}
> -
> -			if (fetch_recurse != RECURSE_SUBMODULES_NONE) {
> -				if (fetch_recurse == RECURSE_SUBMODULES_OFF)
> -					continue;
> -				if (fetch_recurse == RECURSE_SUBMODULES_ON_DEMAND) {
> -					if (!unsorted_string_list_lookup(&changed_submodule_names,
> -									 submodule->name))
> -						continue;
> -					default_argv = "on-demand";
> -				}
> -			} else {
> -				if (spf->default_option == RECURSE_SUBMODULES_OFF)
> -					continue;
> -				if (spf->default_option == RECURSE_SUBMODULES_ON_DEMAND) {
> -					if (!unsorted_string_list_lookup(&changed_submodule_names,
> -									  submodule->name))
> -						continue;
> -					default_argv = "on-demand";
> -				}
> -			}
> -		} else if (spf->command_line_option == RECURSE_SUBMODULES_ON_DEMAND) {
> -			if (!unsorted_string_list_lookup(&changed_submodule_names,
> +		switch (get_fetch_recurse_config(submodule, spf))
> +		{
> +		default:
> +		case RECURSE_SUBMODULES_DEFAULT:
> +		case RECURSE_SUBMODULES_ON_DEMAND:
> +			if (!submodule || !unsorted_string_list_lookup(&changed_submodule_names,
>  							 submodule->name))
>  				continue;
>  			default_argv = "on-demand";
> +			break;
> +		case RECURSE_SUBMODULES_ON:
> +			default_argv = "yes";
> +			break;
> +		case RECURSE_SUBMODULES_OFF:
> +			continue;
>  		}
>  
>  		strbuf_addf(&submodule_path, "%s/%s", spf->work_tree, ce->name);
> -- 
> 2.14.1.145.gb3622a4
> 

-- 
Brandon Williams
