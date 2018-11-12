Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 058C51F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 19:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbeKMFT5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 00:19:57 -0500
Received: from mout.web.de ([212.227.17.12]:36249 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725749AbeKMFT5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 00:19:57 -0500
Received: from [192.168.178.36] ([79.237.252.49]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MaJvw-1g2Qas3IwC-00JnZw; Mon, 12
 Nov 2018 20:25:02 +0100
Subject: Re: [PATCH 7/9] object-store: provide helpers for loose_objects_cache
To:     Jeff King <peff@peff.net>, Geert Jansen <gerardu@amazon.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Takuto Ikuta <tikuta@chromium.org>
References: <20181112144627.GA2478@sigill.intra.peff.net>
 <20181112145056.GG7400@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <a766f9c6-4df9-c249-2b7b-89a2f4ccf405@web.de>
Date:   Mon, 12 Nov 2018 20:24:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181112145056.GG7400@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:DdT5JEXNY/42ViJbhDSWRX2KQR4R8Jn5xT3XacWSDivSzxe1n/q
 x80l7uXH+RMMG8jOil3+MY7kkcD6nwP8FFUKvn54NXzXzeekNBqj5JXCSuGn1lglit+pznM
 8sdHcKWs/onBfjWJnDOV3nzAmjG56KGYKhYBQs+Ac2G6kigXVIge+t3wAycFQP79a5Ij+T9
 +uVuSTBNNbBrnqZjj73FQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RnEHqQrvEwg=:swwrGPxJMbV6mb8Qk3+eZo
 cEzlZIAt+Lx9IjozJzFNh3Z6k2tCKWKcdtL8RfR6ISN1Pk+pFIJ8oQWQ8zL5JEgZebsBV/aY0
 mtq15yicTIpVnAeSeDuqVax994Pkyr9ZWofoRlTKpQJUYp8PcZPrJWTSuYtb5RlYuNxI8MsVP
 0WBzXICc8x0iu0BkV+2Ss0zxB09A0blrtUl7ylbksi3sel+yXh2HWddBgdxKjolfNOm6uygCB
 fHrGbBEILoUohZnQwoWrbgYhuIx+eT15eRTonmGWge4yGRPOWEXHjHU6OQ90fm1gJTVQWBHkp
 Av/B2CFFoCbBdso5JsxbEoulGWQOTGByQU3sW4AkxZ582QYblj+WWdakceKh7fPMy2joiLIOX
 UMKwa6AWXw323PH9vbzTCP4Z1Nk56tCRm57wGM9SdArR/h3OXccL7hPrIM8yM8aycRwYRlmt7
 Z2rWehGjx+I8D7e5XIkVnV8GAUec9i3e47gxwZRSj2xWrdLcj5YY4fZgi8PxVoniRPM/RUsoU
 W+xfW20sguB4gqTizCsd2+6EY+SKE2Xl4V3i9gfqGxestNI4xWltUU73bxecKzhbcgzVNW3Eq
 IDNff6iAdIqjuWJCNZ0RktkNh+jzaAT6uQxaOuz8vrf+G9ZxOm7wzp+1AdiNbhxa1dNIRzkMy
 9mnFLlWtAlwqlj8swWoNIVP7ZlQaqQSw4YDMlNndP9hEiMgNoUa3sgPT3bFEB3rovjghUIz8A
 vvt7jtO8Z+/DRKUxG1iih/U5TlTlhKobCFs1x6x34dWK3vY6v6HKx8lgefOAgW1t6k+W4kslA
 sDf7b8fpGr+fDje0+8jH3ezT2elQPcMSJh+ff8j3Eeevm1TuRdSMf5xxWvO+uR+W2EELzmefs
 zRdGdj2oL7jcGt0B+Q2Z3JxhJ2YTzWz8y9RJRdQF+N37gv8XoLBA+uquXWWcPj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.11.2018 um 15:50 schrieb Jeff King:
> --- a/sha1-file.c
> +++ b/sha1-file.c
> @@ -2125,6 +2125,32 @@ int for_each_loose_object(each_loose_object_fn cb, void *data,
>  	return 0;
>  }
>  
> +static int append_loose_object(const struct object_id *oid, const char *path,
> +			       void *data)
> +{
> +	oid_array_append(data, oid);
> +	return 0;
> +}
> +
> +void odb_load_loose_cache(struct object_directory *odb, int subdir_nr)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +
> +	if (subdir_nr < 0 ||

Why not make subdir_nr unsigned (like in for_each_file_in_obj_subdir()), and
get rid of this first check?

> +	    subdir_nr >= ARRAY_SIZE(odb->loose_objects_subdir_seen))

Using unsigned char for subdir_nr would allow removing the second check as
well, but might hide invalid values in implicit conversions, I guess.

> +		BUG("subdir_nr out of range");

Showing the invalid value (like in for_each_file_in_obj_subdir()) would make
debugging easier in case the impossible actually happens.

> +
> +	if (odb->loose_objects_subdir_seen[subdir_nr])
> +		return;
> +
> +	strbuf_addstr(&buf, odb->path);
> +	for_each_file_in_obj_subdir(subdir_nr, &buf,
> +				    append_loose_object,
> +				    NULL, NULL,
> +				    &odb->loose_objects_cache);
> +	odb->loose_objects_subdir_seen[subdir_nr] = 1;

About here would be the ideal new home for ...

> +}
> +
>  static int check_stream_sha1(git_zstream *stream,
>  			     const char *hdr,
>  			     unsigned long size,
> diff --git a/sha1-name.c b/sha1-name.c
> index 358ca5e288..b24502811b 100644
> --- a/sha1-name.c
> +++ b/sha1-name.c
> @@ -83,36 +83,19 @@ static void update_candidates(struct disambiguate_state *ds, const struct object
>  	/* otherwise, current can be discarded and candidate is still good */
>  }
>  
> -static int append_loose_object(const struct object_id *oid, const char *path,
> -			       void *data)
> -{
> -	oid_array_append(data, oid);
> -	return 0;
> -}
> -
>  static int match_sha(unsigned, const unsigned char *, const unsigned char *);
>  
>  static void find_short_object_filename(struct disambiguate_state *ds)
>  {
>  	int subdir_nr = ds->bin_pfx.hash[0];
>  	struct object_directory *odb;
> -	struct strbuf buf = STRBUF_INIT;
>  
>  	for (odb = the_repository->objects->odb;
>  	     odb && !ds->ambiguous;
>  	     odb = odb->next) {
>  		int pos;
>  
> -		if (!odb->loose_objects_subdir_seen[subdir_nr]) {
> -			strbuf_reset(&buf);
> -			strbuf_addstr(&buf, odb->path);
> -			for_each_file_in_obj_subdir(subdir_nr, &buf,
> -						    append_loose_object,
> -						    NULL, NULL,
> -						    &odb->loose_objects_cache);
> -			odb->loose_objects_subdir_seen[subdir_nr] = 1;
> -		}
> -
> +		odb_load_loose_cache(odb, subdir_nr);
>  		pos = oid_array_lookup(&odb->loose_objects_cache, &ds->bin_pfx);
>  		if (pos < 0)
>  			pos = -1 - pos;
> @@ -125,8 +108,6 @@ static void find_short_object_filename(struct disambiguate_state *ds)
>  			pos++;
>  		}
>  	}
> -
> -	strbuf_release(&buf);

... this line.

>  }
>  
>  static int match_sha(unsigned len, const unsigned char *a, const unsigned char *b)
> 
