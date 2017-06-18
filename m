Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 419321FA7B
	for <e@80x24.org>; Sun, 18 Jun 2017 07:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750996AbdFRHVZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Jun 2017 03:21:25 -0400
Received: from mout.web.de ([212.227.17.12]:56612 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750916AbdFRHVY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jun 2017 03:21:24 -0400
Received: from macce.local ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MddJY-1dATP23gBY-00PJKC; Sun, 18
 Jun 2017 09:20:57 +0200
Subject: Re: [PATCH v5 4/5] convert: move multiple file filter error handling
 to separate function
To:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, e@80x24.org, ttaylorr@github.com,
        peartben@gmail.com
References: <20170601082203.50397-1-larsxschneider@gmail.com>
 <20170601082203.50397-5-larsxschneider@gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <be787e74-5f37-8429-9976-abdf8725737c@web.de>
Date:   Sun, 18 Jun 2017 09:20:49 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170601082203.50397-5-larsxschneider@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:2rPpb0pftLKHXk45ZuEIOP13qR0QEtU0Q91U/aOCwBMKP9fCeQn
 v7EcTIQtXZS0A/uoSB9e5RlQ5uBbQbHhJW73uEYGX587E5kEsM6A3wVPvw0wvdA2yCkJc/4
 E/aPr06td+ESJlBS2J8B72mf5sQxtYPYvR7J24FfmyJk+/a7aBWaR26+4EgFXTHmbzx/elO
 A7rnXPC2RyYtQF09LItVQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2y2YtBBwiM0=:yyo8ZULg/aRzI5YA4TJzEt
 IydooJOLnv/G6Zg/esfTEh8e/Ix1fMdd5fPHLZ2QKUlR7ssGCGaH3kbXwPl59hnujqORPonSy
 pLkNDo4zXNmkGbd808/qXh1yuCHp5E3fjESnQ8NVF+VMHuH9wC5WsJRKCEApNA7KfCf9fEd1v
 5ITDnUWVJZ/0nDf1PlfIAFegagVn4dRh8DllbLUKJgkGCAoezEslewVZvWk5mGZ3sjEHvlCm3
 fV6OlFAk1jiWVIn7/rxjc7T90vz985vddLPsxhhOfhaT22kMNCNkdj15zB4iVWadgrS4FfEL+
 qX2holhbsc/Tearsw77dJXWcd23h1jjhQ739VSt8c0Gfnirql29XGNlUairLrxBLK+tKQ91GQ
 KEI+cAwnmFngWXwdvs4Hf6w1dPBoHUBKrY5/mFkuyumb+p/wA5xW92koeJSsDXB0Cc1PrOVdM
 896X51Ca4hYgkoG8v9AKrkGjVvSbdVm4vNVXkG8flS9/w8dG0GRdwe5CFJUqgdPI7mJbCRtwQ
 zXIFfh1UYnBYQhlA0bB6rO0jPwHwBRQ8xliqRLwJvxnuR+wlW1/uAsTFief8mjo1GZ8IeS9/m
 2t8Rgq4Q+PQ6+9+VDVaF5w2/KuAoDuC3TUIYizkBcgBj6UHQZoRAZn+lGTDqvYzu55Vbt5aul
 gDo0P1SlWAJ96P4aEn41Kd0iwowY7QSDo/8bKrwg9YMM6bUPKRvzaQRGE4qZ3TLx5y/QEfV27
 MjZpnEUgF76KTyOA6RP9n7eLJ4NkY3+uUIBqx8Cf2MU4H2XArAePbPrx8yjyM8QAjoLbln9FI
 rdKk/cA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 2017-06-01 10:22, Lars Schneider wrote:
> This is useful for the subsequent patch 'convert: add "status=delayed" to
> filter process protocol'.

May be
 Collecting all filter error handling is useful for the subsequent patch
 'convert: add "status=delayed" to filter process protocol'.

> 
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  convert.c | 47 ++++++++++++++++++++++++++---------------------
>  1 file changed, 26 insertions(+), 21 deletions(-)
> 
> diff --git a/convert.c b/convert.c
> index f1e168bc30..a5e09bb0e8 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -565,6 +565,29 @@ static int start_multi_file_filter_fn(struct subprocess_entry *subprocess)
>  	return err;
>  }
>  
> +static void handle_filter_error(const struct strbuf *filter_status,
> +				struct cmd2process *entry,
> +				const unsigned int wanted_capability) {
> +	if (!strcmp(filter_status->buf, "error")) {
> +		/* The filter signaled a problem with the file. */
> +	} else if (!strcmp(filter_status->buf, "abort") && wanted_capability) {
> +		/*
> +		 * The filter signaled a permanent problem. Don't try to filter
> +		 * files with the same command for the lifetime of the current
> +		 * Git process.
> +		 */
> +		 entry->supported_capabilities &= ~wanted_capability;
> +	} else {
> +		/*
> +		 * Something went wrong with the protocol filter.
> +		 * Force shutdown and restart if another blob requires filtering.
> +		 */
> +		error("external filter '%s' failed", entry->subprocess.cmd);
> +		subprocess_stop(&subprocess_map, &entry->subprocess);
> +		free(entry);
> +	}
> +}
> +
>  static int apply_multi_file_filter(const char *path, const char *src, size_t len,
>  				   int fd, struct strbuf *dst, const char *cmd,
>  				   const unsigned int wanted_capability)
> @@ -656,28 +679,10 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
>  done:
>  	sigchain_pop(SIGPIPE);
>  
> -	if (err) {
> -		if (!strcmp(filter_status.buf, "error")) {
> -			/* The filter signaled a problem with the file. */
                Note1: Do we need a line with a single ";" here ?
                Question: What should/will happen to the file ?
                Will Git complain later ? Retry later ?
> -		} else if (!strcmp(filter_status.buf, "abort")) {
> -			/*
> -			 * The filter signaled a permanent problem. Don't try to filter
> -			 * files with the same command for the lifetime of the current
> -			 * Git process.
> -			 */
> -			 entry->supported_capabilities &= ~wanted_capability;
                         Hm, could this be clarified somewhat ?
                         Mapping "abort" to "permanent problem" makes sense as
                         such, but the only action that is done is to reset
                         a capablity.

		/*
		 * The filter signaled a missing capabilty. Don't try to filter
		 * files with the same command for the lifetime of the current
		 * Git process.
		 */

                 # And the there is a question why the answer is "abort" and not
                 # "unsupported"
> -		} else {
> -			/*
> -			 * Something went wrong with the protocol filter.
> -			 * Force shutdown and restart if another blob requires filtering.
> -			 */
> -			error("external filter '%s' failed", cmd);
> -			subprocess_stop(&subprocess_map, &entry->subprocess);
> -			free(entry);
> -		}
> -	} else {
> +	if (err)
> +		handle_filter_error(&filter_status, entry, wanted_capability);
> +	else
>  		strbuf_swap(dst, &nbuf);
> -	}
>  	strbuf_release(&nbuf);
>  	return !err;
>  }
> 

