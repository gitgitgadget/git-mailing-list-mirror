Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BE661F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 19:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbeKMFTx (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 00:19:53 -0500
Received: from mout.web.de ([212.227.17.12]:43885 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725749AbeKMFTw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 00:19:52 -0500
Received: from [192.168.178.36] ([79.237.252.49]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MUncu-1fz9Lc2dzg-00Y9ZP; Mon, 12
 Nov 2018 20:25:08 +0100
Subject: Re: [PATCH 9/9] fetch-pack: drop custom loose object cache
To:     Jeff King <peff@peff.net>, Geert Jansen <gerardu@amazon.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Takuto Ikuta <tikuta@chromium.org>
References: <20181112144627.GA2478@sigill.intra.peff.net>
 <20181112145558.GI7400@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <a08d8e20-ecb5-3135-f294-56dec1730b5f@web.de>
Date:   Mon, 12 Nov 2018 20:25:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181112145558.GI7400@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:xt8ggDiPBBMSgl5lm4x5DDrD/4eGdOelIkz5BXmOwz47dNENXIv
 nspkWQS9lYq8hVWUuj6Qqn6YrqeC1kZEsmITwUixiBud2SmCy1E7dn1xzuyAamTL91s6lVT
 GbrVlrrMfPQP5rnmAPIYzvlzs0tyRfCJupIAo43r5fbMq+ofjxDN+IU/9owg2IubA26YDQr
 eii1L3hlMPoT1w3UNU2MQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DYVsiR4Nwcc=:UyjjjhQprvm61I24VjKfSm
 RVYo6MCdQkQNHoTOIR/PB9ULLFFmlSyNddwq8wcqsLLCjpUpz8HQQeesTI3eEQ8zuBIy0btRb
 qsQ69mYixVffDxLx305Ry55MGUiXEx3YWDXyWJRsblbFXb4pF1abJbM5WnGQuTZoZkfkPvcwu
 D/q9VGcC8zkkYT2L35GH+Fc9bLDCAAEWeYQ3poMDSgvPL/0OmaAwWzRplM6NrZPbX//MIZlXV
 eKVE3bdH5P73Ajrj4H/YV80Co13GEFIstf2RwISW8//gvK1VJAnE0FrvERdoS+j3KRkZqTBxJ
 n0y7h7i4SgOPztTRGFiZIOOVywKwim1v8dSDaWF0FDAOmJcHhGAe/2FUqXiP4kQvsIQGRjA6r
 C7Utms71VzurTAeI1qqvBckyJddDfIUVMNQlAWzCL2uLQ/ODIx0eRYdKTQbLLCk+DAe/L3KPw
 4+fVt/2F2bsg1CPOFn29DMzgK6Y6tONXjBSqFeN53Ov8qy8DiKiJ2Q5a7jdej+f3PzdcuVvs2
 E0RhYPVXCb6UeTdFLkzcsbfHbUvlWXjuSJnO1T7WPnNiScOJ4vfyjB9UOeMVwUqEdDlvq+NYD
 uzxXsQ/TZwYjFntLeOz99chv9QphbQ/zgPn7KMDn0argEnLvZ845RJPiWlVxKFSa8CddPCgTT
 PDtU8WF2czkBmSpfJNbsqH93KqEhKBH37hkDxmlIJD+QUy5CUks/a7ENVok3KKFon4SDx5pr1
 2VlHYxH93kYMk9m1Oos3LNNb5IjB/4xcmYie39VHukrLoX12rkeY5GsIhoZS+HLEG4kC+i0Qw
 EemKuwg1BCnf1EF/g8pZ/bkQ7UQV0UANNpFDQ8x96ekVPJPGP6laAW5xcYjBUVAXoBsefvxJb
 DIlt7if7gggAxZOfC4ZMA26VTi1PzykHOpbS9Nak1H8yPhEu/90dcaYBMb0Mei
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.11.2018 um 15:55 schrieb Jeff King:
> Commit 024aa4696c (fetch-pack.c: use oidset to check existence of loose
> object, 2018-03-14) added a cache to avoid calling stat() for a bunch of
> loose objects we don't have.
> 
> Now that OBJECT_INFO_QUICK handles this caching itself, we can drop the
> custom solution.
> 
> Note that this might perform slightly differently, as the original code
> stopped calling readdir() when we saw more loose objects than there were
> refs. So:
> 
>   1. The old code might have spent work on readdir() to fill the cache,
>      but then decided there were too many loose objects, wasting that
>      effort.
> 
>   2. The new code might spend a lot of time on readdir() if you have a
>      lot of loose objects, even though there are very few objects to
>      ask about.

Plus the old code used an oidset while the new one uses an oid_array.

> In practice it probably won't matter either way; see the previous commit
> for some discussion of the tradeoff.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  fetch-pack.c | 39 ++-------------------------------------
>  1 file changed, 2 insertions(+), 37 deletions(-)
> 
> diff --git a/fetch-pack.c b/fetch-pack.c
> index b3ed7121bc..25a88f4eb2 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -636,23 +636,6 @@ struct loose_object_iter {
>  	struct ref *refs;
>  };
>  
> -/*
> - *  If the number of refs is not larger than the number of loose objects,
> - *  this function stops inserting.
> - */
> -static int add_loose_objects_to_set(const struct object_id *oid,
> -				    const char *path,
> -				    void *data)
> -{
> -	struct loose_object_iter *iter = data;
> -	oidset_insert(iter->loose_object_set, oid);
> -	if (iter->refs == NULL)
> -		return 1;
> -
> -	iter->refs = iter->refs->next;
> -	return 0;
> -}
> -
>  /*
>   * Mark recent commits available locally and reachable from a local ref as
>   * COMPLETE. If args->no_dependents is false, also mark COMPLETE remote refs as
> @@ -670,30 +653,14 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
>  	struct ref *ref;
>  	int old_save_commit_buffer = save_commit_buffer;
>  	timestamp_t cutoff = 0;
> -	struct oidset loose_oid_set = OIDSET_INIT;
> -	int use_oidset = 0;
> -	struct loose_object_iter iter = {&loose_oid_set, *refs};
> -
> -	/* Enumerate all loose objects or know refs are not so many. */
> -	use_oidset = !for_each_loose_object(add_loose_objects_to_set,
> -					    &iter, 0);
>  
>  	save_commit_buffer = 0;
>  
>  	for (ref = *refs; ref; ref = ref->next) {
>  		struct object *o;
> -		unsigned int flags = OBJECT_INFO_QUICK;
>  
> -		if (use_oidset &&
> -		    !oidset_contains(&loose_oid_set, &ref->old_oid)) {
> -			/*
> -			 * I know this does not exist in the loose form,
> -			 * so check if it exists in a non-loose form.
> -			 */
> -			flags |= OBJECT_INFO_IGNORE_LOOSE;

This removes the only user of OBJECT_INFO_IGNORE_LOOSE.  #leftoverbits

> -		}
> -
> -		if (!has_object_file_with_flags(&ref->old_oid, flags))
> +		if (!has_object_file_with_flags(&ref->old_oid,
> +						OBJECT_INFO_QUICK))
>  			continue;
>  		o = parse_object(the_repository, &ref->old_oid);
>  		if (!o)
> @@ -710,8 +677,6 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
>  		}
>  	}
>  
> -	oidset_clear(&loose_oid_set);
> -
>  	if (!args->deepen) {
>  		for_each_ref(mark_complete_oid, NULL);
>  		for_each_cached_alternate(NULL, mark_alternate_complete);
> 
