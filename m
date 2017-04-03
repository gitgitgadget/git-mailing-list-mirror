Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D8121FAFB
	for <e@80x24.org>; Mon,  3 Apr 2017 19:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751468AbdDCTLS (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Apr 2017 15:11:18 -0400
Received: from mout.web.de ([212.227.15.14]:56587 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751282AbdDCTLR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2017 15:11:17 -0400
Received: from birne12.local ([195.198.252.176]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Mbdf3-1cexXb0ZRl-00J3Vu; Mon, 03
 Apr 2017 21:11:06 +0200
Subject: Re: [PATCH v4] http.postbuffer: allow full range of ssize_t values
To:     David Turner <dturner@twosigma.com>, git@vger.kernel.org
References: <20170403173015.15327-1-dturner@twosigma.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <1cc11732-cf47-8d07-cb57-1e962ba1613f@web.de>
Date:   Mon, 3 Apr 2017 21:11:00 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170403173015.15327-1-dturner@twosigma.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:+ycbaQDbcCfhqj6oIqgVsiHfWBQN1QASGKWa7ssPMxYzvMFMiRh
 T1xwRvdjpQ5J4hFeJB+NCUEzUpstyhCzXgs5EfGXJWLie5f3w/svCoFgOJc39SQjhUCVTmo
 iBSnT2h4KKrNDZd1/6lds+tX07hV39UHrwn3xSGXYcEMP2KvxKvFN/nK1PFMNY/NHRKOr85
 Ss3XhNITJLoc6W6LuppvQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6JYKYxVgPzE=:+dTmAAeMN+q4nRkjiUVNUv
 uETA5gvR73lKZNFF/NaC/BfTTMdUln/EBNcwYBs011OLsmySM3aV3P2597SGNMMfxKdVla+Zj
 nvcO/W/AOEIuqZ10WeTM0aOv7RZsGUyrIzd9QOssWagPpQx1joYgaldajtCPPjyJxr7gkCN9N
 U7BGgp2UwUUDxBpeHy6F9B/QCGWknBEEdJzin4lA5qwlhmXOnDNDNqMvl5sLvhQOmNDPMDaXb
 4aPPijzV+ABRAqesH17TIYsOBi/6FeB88f/66baqIrH2HGUYC7D5SlwhKGO1LKYb+HbR3GBVz
 3nSNTxrXCY2KRd9I8OyMjHZk1GiGKTwOGgpioWvAOevSYiK0wKYCfpqTAsH0x9JuncuOYJh1Y
 5IzEPdRGlEVTfU3Hv3EycVthlc4JkyHBJxJPydo2ICtbUiLjp5vV1Fa9QyTI2wOo/WEbcUm13
 oAZ10tG1qCtjpIYOAtFS56L8r8/D+0gMFfKfWxyUP96CBEuilrUc4f7QhZV1jiAFeJJoJ/w21
 sO3oHqoTI7M4RU5qRgv7/qH82FbRlBH8SOewFAVsav4voUXT8x7NXh0qtrGY5g4uwCxuhe4Ib
 yUMTAm8tX5P0GKpQL95dRTBDm2JQ4Lu8A+begcM6qEkt4QYoXwtk3S/OHxiNvs7Hdm8bB0BWC
 i5v+RhTQbkPo99PFMkdhZCIAZaLcZPL21NVO4ctdqermV7k8xx2Fg+qiOGe6o+LHmPcn2D9Ga
 4CCBnJmWafru6ZdCs1wpZHhg5JRAY7PIjNFs72aKNTXrQTm/2YEmxLG3gyDhngPTMa3iNVzSX
 m702Y3kS7biyevQOKcng04AFNyCxD4cB/E8ZtilCBH619znE3gqMvg6wrVNsDbo4QPk6g4hkg
 mri8nzTAfii7xcQUrmZw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03.04.17 19:30, David Turner wrote:
> Unfortunately, in order to push some large repos, the http postbuffer
> must sometimes exceed two gigabytes.  On a 64-bit system, this is OK:
> we just malloc a larger buffer.
> 
> This means that we need to use CURLOPT_POSTFIELDSIZE_LARGE to set the
> buffer size.
> 
> Signed-off-by: David Turner <dturner@twosigma.com>
> ---
>  cache.h       |  1 +
>  config.c      | 17 +++++++++++++++++
>  http.c        |  4 ++--
>  http.h        |  2 +-
>  remote-curl.c |  6 +++---
>  5 files changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/cache.h b/cache.h
> index fbdf7a815a..5e6747dbb4 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1900,6 +1900,7 @@ extern int git_parse_maybe_bool(const char *);
>  extern int git_config_int(const char *, const char *);
>  extern int64_t git_config_int64(const char *, const char *);
>  extern unsigned long git_config_ulong(const char *, const char *);
> +extern ssize_t git_config_ssize_t(const char *, const char *);
>  extern int git_config_bool_or_int(const char *, const char *, int *);
>  extern int git_config_bool(const char *, const char *);
>  extern int git_config_maybe_bool(const char *, const char *);
> diff --git a/config.c b/config.c
> index 1a4d85537b..de5b155a4e 100644
> --- a/config.c
> +++ b/config.c
> @@ -834,6 +834,15 @@ int git_parse_ulong(const char *value, unsigned long *ret)
>  	return 1;
>  }
>  
> +static int git_parse_ssize_t(const char *value, ssize_t *ret)
> +{
> +	ssize_t tmp;
> +	if (!git_parse_signed(value, &tmp, maximum_signed_value_of_type(ssize_t)))
> +		return 0;
> +	*ret = tmp;
> +	return 1;
> +}
> +
>  NORETURN
>  static void die_bad_number(const char *name, const char *value)
>  {
> @@ -892,6 +901,14 @@ unsigned long git_config_ulong(const char *name, const char *value)
>  	return ret;
>  }
>  
> +ssize_t git_config_ssize_t(const char *name, const char *value)
> +{
> +	ssize_t ret;
> +	if (!git_parse_ssize_t(value, &ret))
> +		die_bad_number(name, value);
> +	return ret;
> +}
> +
>  int git_parse_maybe_bool(const char *value)
>  {
>  	if (!value)
> diff --git a/http.c b/http.c
> index 96d84bbed3..22f8167ba2 100644
> --- a/http.c
> +++ b/http.c
> @@ -19,7 +19,7 @@ long int git_curl_ipresolve;
>  #endif
>  int active_requests;
>  int http_is_verbose;
> -size_t http_post_buffer = 16 * LARGE_PACKET_MAX;
> +ssize_t http_post_buffer = 16 * LARGE_PACKET_MAX;
>  
>  #if LIBCURL_VERSION_NUM >= 0x070a06
>  #define LIBCURL_CAN_HANDLE_AUTH_ANY
> @@ -331,7 +331,7 @@ static int http_options(const char *var, const char *value, void *cb)
>  	}
>  
>  	if (!strcmp("http.postbuffer", var)) {
> -		http_post_buffer = git_config_int(var, value);
> +		http_post_buffer = git_config_ssize_t(var, value);
>  		if (http_post_buffer < LARGE_PACKET_MAX)
>  			http_post_buffer = LARGE_PACKET_MAX;
>  		return 0;
> diff --git a/http.h b/http.h
> index 02bccb7b0c..f7bd3b26b0 100644
> --- a/http.h
> +++ b/http.h
> @@ -111,7 +111,7 @@ extern struct curl_slist *http_copy_default_headers(void);
>  extern long int git_curl_ipresolve;
>  extern int active_requests;
>  extern int http_is_verbose;
> -extern size_t http_post_buffer;
> +extern ssize_t http_post_buffer;
>  extern struct credential http_auth;
>  
>  extern char curl_errorstr[CURL_ERROR_SIZE];
> diff --git a/remote-curl.c b/remote-curl.c
> index e953d06f66..69b4d71e4c 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -614,7 +614,7 @@ static int post_rpc(struct rpc_state *rpc)
>  		 * and we just need to send it.
>  		 */
>  		curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, gzip_body);
> -		curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE, gzip_size);
> +		curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE_LARGE, (curl_off_t) gzip_size);

Is this cast safe, or can it silently truncate ?
Or is it more save to die() in this case, similar to ehat we do in git-compat-util.h?

static inline size_t xsize_t(off_t len)
{
	if (len > (size_t) len)
		die("Cannot handle files this big");
	return (size_t)len;
}


 
>  
>  	} else if (use_gzip && 1024 < rpc->len) {
>  		/* The client backend isn't giving us compressed data so
> @@ -645,7 +645,7 @@ static int post_rpc(struct rpc_state *rpc)
>  
>  		headers = curl_slist_append(headers, "Content-Encoding: gzip");
>  		curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, gzip_body);
> -		curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE, gzip_size);
> +		curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE_LARGE, (curl_off_t) gzip_size);
>  
>  		if (options.verbosity > 1) {
>  			fprintf(stderr, "POST %s (gzip %lu to %lu bytes)\n",
> @@ -658,7 +658,7 @@ static int post_rpc(struct rpc_state *rpc)
>  		 * more normal Content-Length approach.
>  		 */
>  		curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, rpc->buf);
> -		curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE, rpc->len);
> +		curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE_LARGE, (curl_off_t) rpc->len);
>  		if (options.verbosity > 1) {
>  			fprintf(stderr, "POST %s (%lu bytes)\n",
>  				rpc->service_name, (unsigned long)rpc->len);
> 

