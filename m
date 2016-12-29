Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D722F1FCA5
	for <e@80x24.org>; Thu, 29 Dec 2016 13:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752768AbcL2NxP (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Dec 2016 08:53:15 -0500
Received: from mout.web.de ([212.227.17.11]:49913 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752311AbcL2NxO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2016 08:53:14 -0500
Received: from [192.168.178.36] ([79.213.118.247]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M4qWn-1cjc8v1DNV-00yyhL; Thu, 29
 Dec 2016 14:53:08 +0100
Subject: Re: [PATCH] unpack-trees: move checkout state into check_updates
To:     Stefan Beller <sbeller@google.com>
References: <20161228232616.21109-1-sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <fd00a9c2-9c9c-78bd-4700-1333574d0e21@web.de>
Date:   Thu, 29 Dec 2016 14:53:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161228232616.21109-1-sbeller@google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:ZS0g4y2aMmSyEMLSa6pre/KRp7l7b/6NIPXl2Sfmt/XnU+tWq/n
 r7ouqz3Skll9SLzTwbcmgnSy6lbUayADRqoEQyF74x9mDzpmY8Hw+P6oWpMO8IzNWAFDdwo
 rVESK9jGU3rB26TB7a37qnVG7JFYZEB9D5amGVbfMPolg5N+y+dtJognJtItviiWqwwdJhE
 8ew/12afDABmSLQcr3r5w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PBay2h/8nks=:MrfYZyW06yeZAquMXj43lX
 gFvlab/y6NByFVp+zgyr9UhZSN2/1YiPHarq+2aQzJsFklWkLLEV/6nfpIK7DEqPCJYfm53M3
 6NUzMS8t9qinTFQIux5cHSxfhQSeRnUWmdFnxxeilMAJrO4pIkGn+CMrxz2glTYBsGRdDKq7n
 ScqxDmF/rxwm2xTsXuoqL+tgJBDhrVIFato3kfjGJ3apCHHvnXTzXt6TwIpD1NVQBrYoPd1hD
 hAmGbt4Vam8V5FzpYmD4e3ihspkHRW1qjKOGoQfugOMDun+7XvROq0U7KNqsgqKf8N3Be5wpg
 oP8TmPnQNCFF4MtzG8ys5eIV0mcRK0VHgFTMX6J8LD79ygMVVKm/o8EvPZLjxptGuQSyyKwJl
 wcVJN0s/+PEqnqZiEDXpqm5wy6IXAHDjg/o5wiEEyMEtpRPT19FWPeRpqrGmOwdWTAcitlsso
 o5XnMoVDl1gs5vsaMlh3D3tEZpq/cCNQAXw6S36q2Q1fWNilu/i9K8KLPzNVBx9i7jZTSpTJ2
 xwKd0DrbmfgyFT0UtZCbuvCsaj7VVqfePSKM03IsTRfwbFwNsXbiNdgV6xOwDBmNOGrxFZwsk
 7Btpy/cIpHNHIot87ISEBcZpm4zRd2e9DAt1O5rf9og9XjUVaQmH6jiPsM1YEhH9cDdS7GpP+
 UYCvakosWtlZV2GV/4Q4RQBt2txuTQwPseKoZN7JHpaTfKD0UIKMlC4TOJvmd+K2LEhygE3yJ
 m07csJTkzne4586rF79Ijv62I+QVqZ8LHvEvyu0aEEbl6BJN0W17QkBdFw7mhXYSWLP22j2pR
 CT5ixu9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.12.2016 um 00:26 schrieb Stefan Beller:
> The checkout state was introduced via 16da134b1f9
> (read-trees: refactor the unpack_trees() part, 2006-07-30). An attempt to
> refactor the checkout state was done in b56aa5b268e (unpack-trees: pass
> checkout state explicitly to check_updates(), 2016-09-13), but we can
> go even further.
>
> The `struct checkout state` is not used in unpack_trees apart from
> initializing it, so move it into the function that makes use of it,
> which is `check_updates`.

Thanks for catching this, the result looks nicer.

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  unpack-trees.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index ea799d37c5..78703af135 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -224,14 +224,18 @@ static void unlink_entry(const struct cache_entry *ce)
>  	schedule_dir_for_removal(ce->name, ce_namelen(ce));
>  }
>
> -static int check_updates(struct unpack_trees_options *o,
> -			 const struct checkout *state)
> +static int check_updates(struct unpack_trees_options *o)
>  {
>  	unsigned cnt = 0, total = 0;
>  	struct progress *progress = NULL;
>  	struct index_state *index = &o->result;
>  	int i;
>  	int errs = 0;
> +	struct checkout state = CHECKOUT_INIT;
> +	state.force = 1;
> +	state.quiet = 1;
> +	state.refresh_cache = 1;
> +	state.istate = &o->result;

And here (as well as in two more places in this function) we could use 
"index" instead of "&o->result".  Not sure if it's worth a patch, though.

>
>  	if (o->update && o->verbose_update) {
>  		for (total = cnt = 0; cnt < index->cache_nr; cnt++) {
> @@ -270,7 +274,7 @@ static int check_updates(struct unpack_trees_options *o,
>  			display_progress(progress, ++cnt);
>  			ce->ce_flags &= ~CE_UPDATE;
>  			if (o->update && !o->dry_run) {
> -				errs |= checkout_entry(ce, state, NULL);
> +				errs |= checkout_entry(ce, &state, NULL);
>  			}
>  		}
>  	}
> @@ -1100,14 +1104,9 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>  	int i, ret;
>  	static struct cache_entry *dfc;
>  	struct exclude_list el;
> -	struct checkout state = CHECKOUT_INIT;
>
>  	if (len > MAX_UNPACK_TREES)
>  		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
> -	state.force = 1;
> -	state.quiet = 1;
> -	state.refresh_cache = 1;
> -	state.istate = &o->result;
>
>  	memset(&el, 0, sizeof(el));
>  	if (!core_apply_sparse_checkout || !o->update)
> @@ -1244,7 +1243,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>  	}
>
>  	o->src_index = NULL;
> -	ret = check_updates(o, &state) ? (-2) : 0;
> +	ret = check_updates(o) ? (-2) : 0;
>  	if (o->dst_index) {
>  		if (!ret) {
>  			if (!o->result.cache_tree)
>
