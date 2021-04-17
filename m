Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD14EC433B4
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 09:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88043611EF
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 09:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235936AbhDQJLz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Apr 2021 05:11:55 -0400
Received: from mout.web.de ([212.227.15.4]:42959 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229870AbhDQJLy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Apr 2021 05:11:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1618650676;
        bh=yRkKupt/dsxe+XKjWgCaamwUOWqDo41aduh8Xzxaa40=;
        h=X-UI-Sender-Class:From:Subject:To:Cc:References:Date:In-Reply-To;
        b=QJiDf7JzcvP2mwq37tnL09RNl8dON68FOOoQQ47KO5eaYV6PNME+WOxTO3wLwyklp
         T1uZXCyiHH8PItQGkew47FQApvuBQoG0vo3HtzhOEUx92CYN/HHZkLo6iE5Fj5mUOf
         ufa9IeuKsiVIYwEf0axkm4b4SM6dbf0l4vXWjupg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.31.60]) by smtp.web.de
 (mrweb002 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0Lo0M4-1m0BAp3aTQ-00fzh8; Sat, 17 Apr 2021 11:11:15 +0200
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe=2e?= <l.s.r@web.de>
Subject: Re: [PATCH] [GSOC] ref-filter: get rid of show_ref_array_item
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Hariom Verma <hariom18599@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
References: <pull.928.git.1617975348494.gitgitgadget@gmail.com>
Message-ID: <4c4eded7-3bb3-7ae9-6455-468b9522978c@web.de>
Date:   Sat, 17 Apr 2021 11:11:14 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <pull.928.git.1617975348494.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Y4QrFtugVq++oyPaA1z02YHCTAR6eERdMK+uVjgfm3YprHcpy0P
 4cvP1CP7wE1YZIAtpPLmX0IBa1TJU6NRVlAePzM3c3wqYwTtHek3EUp7otKzPsQPsu/3wfp
 wpu2aWzGYIbb53vygC1z/Zgq6Jf886Gg/gm+VqIffif+ovhcqwQPjbOWX2lDN/TIfKpYc9P
 ofJ2GyjrDCpOHE/k2dx7A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TfuEbK737Wc=:spa5MluXmveGAb+3MGVdn3
 illHlOXWGuwnssXzmDHpy6abK/BK1jKDOa7gktj/+UdwfFxfD0VAV4WmnbWw10DUq0dPz6jII
 2QgU+ZNyRAjn2fAiD3uBQXm6AWbf2atS5LV9JKArmP8MK/l9oPFWx6YTon/XUY/m+ZCs/S3Pb
 wmJZ2Wa1XG2Nd7FNi6chaFbgwM6V04cQVAJftYYSHd/Tu/dc1oOoFXKfVudEiYT3kxaHBtFav
 R/xlFJ7vF6vqcXCUmzXRLBGWWLwXO+EUfekYwk4QDKt6VJ7oSXA9+WnvrOMEmCIabhpHk/mK0
 GaDgUxU8CguHqmayctdoBTrj7KGvbDCbhtkUDGcOvFfXAYbH0JpFQQQBjMhgHfQDl6n5yC8MY
 dB2Q4rDJLzoqLgtqoW1R6D5COKRjei1SRm5zPItGjRy3mh7O8g/Ao0Tb3g0e5B0+DqghCe48p
 5MGUDQL57eJoxaxxw4b1B0RC1q9hA6cTv//T/alqNehCSKdilw0E1Gv1M4nUZ3JtpGPv1fS/3
 P0h9txYoGoCwPQq9YWdU83+T0jSF0i1uToyC8188uJXiRWiUdxP72M8eCKyWQ7CTC+pN8ULg9
 pQIqaJcvBIA5UnsnX3ITwDrssmP1zEcDNECKFFg/4YJ6O5FAup+C8AIVPCV0ASC/TtiWHMlF1
 yjRH+snGrN7qhQfzF2sA4yp5nLQcwis2Ml1t+OqRvY0rpIfqT2hRGbZFjTctW0BQZpo7T91ns
 ZwULp05Bwm2S91GETho7OQa7BRRtyTNRo5xxzipyYw6yQ5Oy+ZUN4mXIAm5hlXt8UHNKEFLZ9
 GimVkuZOvytDBd7v/+Vy/qmn3tQaDSFU1FJTKAbxKbwcgwQmVRDmXCJ+aoOkytQLBWebbhoK0
 xAHOq2ldt0gg2aPpy+eBWbq/huhSaod9BObwe2vv3KhC7+JukWYK43k44mupkMWHCA9j11Vt5
 fM5rQxXaf+q3Anwj1HaH+X6f3WAfmQq8xQMJvtViubQ08VPGSwzLI0EUwl5fRXw3V+sYF+Wxt
 ds66h2rng+ThMubx0TfOCfFpne31o+rUdSzEYY0lr1SYBDk1gDQx95OaMT7OIe9Sm6dfNiCdW
 5ZO7GOzWK2Y9F8J2vQgl8e00s5D0MyVGPWNn8k5RNtICw1qpsw1X7sKvnjABXT5ksdFWaP/fo
 Ovlhz6U6ZaYeinVPCxrqtT2q92AHck/T6G8Hur0swwjyCZY+sGt+0M9x0R95eJeB4N4h0=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.04.21 um 15:35 schrieb ZheNing Hu via GitGitGadget:
> From: ZheNing Hu <adlternative@gmail.com>
>
> When we use `git for-each-ref`, every ref will call
> `show_ref_array_item()` and allocate its own final strbuf.
> But we can reuse the final strbuf for each step ref's output.
> Since `show_ref_array_item()` is not used in many places,
> we can directly delete `show_ref_array_item()` and use the
> same logic code to replace it. In this way, the caller can
> clearly see how the loop work.

Inlining an exported function that is not providing the right level of
abstraction is a bold move that simplifies the API and can unlock
improvements at the former call sites, like the possibility to reuse an
allocated buffer in this case.  OK.

> The performance for `git for-each-ref` on the Git repository
> itself with performance testing tool `hyperfine` changes from
> 23.7 ms =C2=B1 0.9 ms to 22.2 ms =C2=B1 1.0 ms.

I see a speedup as well, but it's within the noise.

> At the same time, we apply this optimization to `git tag -l`
> and `git branch -l`, the `git branch -l` performance upgrade
> from 5.8 ms =C2=B1 0.8 ms to 2.7 ms =C2=B1 0.2 ms and `git tag -l`
> performance upgrade from 5.9 ms =C2=B1 0.4 ms to 5.4 ms =C2=B1 0.4 ms.

On my system there's no measurable change with these commands.

Nevertheless I think reusing the buffer across the loops is a good
idea.

> Since the number of tags in git.git is much more than branches,
> so this shows that the optimization will be more obvious in
> those repositories that contain a small number of objects.
>
> This approach is similar to the one used by 79ed0a5
> (cat-file: use a single strbuf for all output, 2018-08-14)
> to speed up the cat-file builtin.
>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>     [GSOC] ref-filter: get rid of show_ref_array_item
>
>     Now git for-each-ref can reuse final buf for all refs output, the
>     performance is slightly improved, This optimization is also applied =
to
>     git tag -l and git branch -l.
>
>     Thanks.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-928%2F=
adlternative%2Fref-filter-reuse-buf-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-928/adlte=
rnative/ref-filter-reuse-buf-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/928
>
>  builtin/branch.c       |  8 ++++----
>  builtin/for-each-ref.c | 13 +++++++++++--
>  builtin/tag.c          | 13 +++++++++++--
>  ref-filter.c           | 24 +++++++++---------------
>  ref-filter.h           |  2 --
>  5 files changed, 35 insertions(+), 25 deletions(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index bcc00bcf182d..5c797e992aa4 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -411,6 +411,8 @@ static void print_ref_list(struct ref_filter *filter=
, struct ref_sorting *sortin
>  {
>  	int i;
>  	struct ref_array array;
> +	struct strbuf out =3D STRBUF_INIT;
> +	struct strbuf err =3D STRBUF_INIT;
>  	int maxwidth =3D 0;
>  	const char *remote_prefix =3D "";
>  	char *to_free =3D NULL;
> @@ -440,8 +442,7 @@ static void print_ref_list(struct ref_filter *filter=
, struct ref_sorting *sortin
>  	ref_array_sort(sorting, &array);
>
>  	for (i =3D 0; i < array.nr; i++) {
> -		struct strbuf out =3D STRBUF_INIT;
> -		struct strbuf err =3D STRBUF_INIT;
> +		strbuf_reset(&out);
>  		if (format_ref_array_item(array.items[i], format, &out, &err))

This function didn't call show_ref_array_item() to begin with, so
strictly speaking it's not related to change in the title.  It is a
preexisting example of show_ref_array_item() not being flexible enough,
though.  I think it makes sense to have separate patches for inlining
the function verbatim and reusing the output buffer when
format_ref_array_item() is called in a loop.

>  			die("%s", err.buf);
>  		if (column_active(colopts)) {
> @@ -452,10 +453,9 @@ static void print_ref_list(struct ref_filter *filte=
r, struct ref_sorting *sortin
>  			fwrite(out.buf, 1, out.len, stdout);
>  			putchar('\n');
>  		}
> -		strbuf_release(&err);
> -		strbuf_release(&out);
>  	}
>
> +	strbuf_release(&out);

err is no longer released, and it is also not reset in the loop.
That change is not mentioned in the commit message, but it should.
Why is it safe?  Probably because format_ref_array_item() only
populates it if it also returns non-zero and then we end up dying
anyway.

That makes leak checking harder, though -- it's not easy to see if
err hasn't simply been forgotten to be released.  I'd just retain
the strbuf_release() call at the end of the function -- it
shouldn't have a measurable performance impact and documents that
this function is cleaning up after itself.  Thoughts?

>  	ref_array_clear(&array);
>  	free(to_free);
>  }
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index cb9c81a04606..157cc8623949 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -22,6 +22,8 @@ int cmd_for_each_ref(int argc, const char **argv, cons=
t char *prefix)
>  	struct ref_array array;
>  	struct ref_filter filter;
>  	struct ref_format format =3D REF_FORMAT_INIT;
> +	struct strbuf output =3D STRBUF_INIT;
> +	struct strbuf err =3D STRBUF_INIT;
>
>  	struct option opts[] =3D {
>  		OPT_BIT('s', "shell", &format.quote_style,
> @@ -80,8 +82,15 @@ int cmd_for_each_ref(int argc, const char **argv, con=
st char *prefix)
>
>  	if (!maxcount || array.nr < maxcount)
>  		maxcount =3D array.nr;
> -	for (i =3D 0; i < maxcount; i++)
> -		show_ref_array_item(array.items[i], &format);
> +	for (i =3D 0; i < maxcount; i++) {
> +		strbuf_reset(&output);
> +		if (format_ref_array_item(array.items[i], &format, &output, &err))
> +			die("%s", err.buf);
> +		fwrite(output.buf, 1, output.len, stdout);
> +		putchar('\n');
> +	}
> +
> +	strbuf_release(&output);
>  	ref_array_clear(&array);
>  	return 0;
>  }
> diff --git a/builtin/tag.c b/builtin/tag.c
> index d403417b5625..b172f3861413 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -39,6 +39,8 @@ static int list_tags(struct ref_filter *filter, struct=
 ref_sorting *sorting,
>  		     struct ref_format *format)
>  {
>  	struct ref_array array;
> +	struct strbuf output =3D STRBUF_INIT;
> +	struct strbuf err =3D STRBUF_INIT;
>  	char *to_free =3D NULL;
>  	int i;
>
> @@ -63,8 +65,15 @@ static int list_tags(struct ref_filter *filter, struc=
t ref_sorting *sorting,
>  	filter_refs(&array, filter, FILTER_REFS_TAGS);
>  	ref_array_sort(sorting, &array);
>
> -	for (i =3D 0; i < array.nr; i++)
> -		show_ref_array_item(array.items[i], format);
> +	for (i =3D 0; i < array.nr; i++) {
> +		strbuf_reset(&output);
> +		if (format_ref_array_item(array.items[i], format, &output, &err))
> +			die("%s", err.buf);
> +		fwrite(output.buf, 1, output.len, stdout);
> +		putchar('\n');
> +	}
> +
> +	strbuf_release(&output);
>  	ref_array_clear(&array);
>  	free(to_free);
>
> diff --git a/ref-filter.c b/ref-filter.c
> index f0bd32f71416..9e38e42fb7ae 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -2435,27 +2435,21 @@ int format_ref_array_item(struct ref_array_item =
*info,
>  	return 0;
>  }
>
> -void show_ref_array_item(struct ref_array_item *info,
> -			 const struct ref_format *format)
> -{
> -	struct strbuf final_buf =3D STRBUF_INIT;
> -	struct strbuf error_buf =3D STRBUF_INIT;
> -
> -	if (format_ref_array_item(info, format, &final_buf, &error_buf))
> -		die("%s", error_buf.buf);
> -	fwrite(final_buf.buf, 1, final_buf.len, stdout);
> -	strbuf_release(&error_buf);
> -	strbuf_release(&final_buf);
> -	putchar('\n');
> -}
> -
>  void pretty_print_ref(const char *name, const struct object_id *oid,
>  		      const struct ref_format *format)
>  {
>  	struct ref_array_item *ref_item;
> +	struct strbuf output =3D STRBUF_INIT;
> +	struct strbuf err =3D STRBUF_INIT;
> +
>  	ref_item =3D new_ref_array_item(name, oid);
>  	ref_item->kind =3D ref_kind_from_refname(name);
> -	show_ref_array_item(ref_item, format);
> +	if (format_ref_array_item(ref_item, format, &output, &err))
> +		die("%s", err.buf);
> +	fwrite(output.buf, 1, output.len, stdout);
> +	putchar('\n');
> +
> +	strbuf_release(&output);
>  	free_array_item(ref_item);
>  }
>
> diff --git a/ref-filter.h b/ref-filter.h
> index 19ea4c413409..baf72a718965 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -119,8 +119,6 @@ int format_ref_array_item(struct ref_array_item *inf=
o,
>  			  const struct ref_format *format,
>  			  struct strbuf *final_buf,
>  			  struct strbuf *error_buf);
> -/*  Print the ref using the given format and quote_style */
> -void show_ref_array_item(struct ref_array_item *info, const struct ref_=
format *format);
>  /*  Parse a single sort specifier and add it to the list */
>  void parse_ref_sorting(struct ref_sorting **sorting_tail, const char *a=
tom);
>  /*  Callback function for parsing the sort option */
>
> base-commit: 2e36527f23b7f6ae15e6f21ac3b08bf3fed6ee48
>
