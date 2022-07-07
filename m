Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F6EC43334
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 18:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236290AbiGGSaB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 14:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236489AbiGGS3M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 14:29:12 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF6F6051C
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 11:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1657218467;
        bh=+GdFz1WNrb+ggv0MdzyHxakOgfxpsuEq9PT49jdMDAE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=oizNtydPTi2FT+oXJwLD3Kz2lVM3wMXb3m/84SgYxxDTjFJ7dInz9xrMrnSAWo24O
         Gd3AxJ7dftHLm2Sji4g/7gPR17auk7mTau8hA9ozBuOE2klviN7Ws7ZVt4yzUWBRHK
         TwgC4e4o6iYoDS4GJObHpjhug3q85K8PPvb9c5MY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.19.130]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N3Xjb-1nQrx21QZ9-010UGA; Thu, 07
 Jul 2022 20:27:47 +0200
Message-ID: <69cae987-e6cd-d4f5-9119-b393efe544a2@web.de>
Date:   Thu, 7 Jul 2022 20:27:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0
Subject: Re: [PATCH] builtin/mv.c: use correct type to compute size of an
 array element
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqq8rp54r4l.fsf@gitster.g>
 <220707.86y1x585wy.gmgdl@evledraar.gmail.com>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <220707.86y1x585wy.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rIi1sY4aNr2cCj1CNhlRjuI+ajfUUi80C3YbwyIF5F3mdDwN5CA
 lSUDToJH7xCoEUrkWivIlTXeaDL8v4jrSaNODcLk9dq5tJ0rwK+9hmnKHLhUjEuMxLhZKKp
 Bb6THcFRXfEpP6fIIjf5kXZ8tSGAQvoiAelCe3EvUVnZ80kxIL1UwggPGmMB0nx2lSH6u4x
 iEfUhB+NM+BBQ2UxIRr2A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xUi8t8nJ0yY=:Mc/Hly+cWxd3ZqYStXxFUQ
 HMUrA6dhmciuZogJQHs6f/Vk5a2xLkBqOi8ZtRbAZEg3+8lUhzKl7xAwdxZVs7F6SafiSr1m8
 q0bnVUvPA5RIH0ZqPh6yq1394wS3cJZaye616OA5qeAd5s5t4jo4jJeFTYbzsPZ2BxpUOqd2b
 6T1M91nRIoRYyg2WIR2O0f1cyqQENIWZlMte9R06xECMbjrPjBd31AmkIsyE/dz0i9jAbNTm+
 0HLLW+1Ro6PgqZNdCBwS50Q9R6Ku9WH4D35leoTz58GjYY74EgX9D6RrSZC1EwFgg2dpfICJt
 evvzbPCx9DtlnAaZqEx0p23rAdD866s1pH4rIItN3/FCI7yC7dh5Qk3astOERUihny+JlOsg8
 YMlfuRWu6spkqS+6+lw98i/bMM5og07mkzDadFiXcq0YxsL7ALSZZHfoH/1rJPUYuOJE1Ym0l
 XXRGYyR8sBiruTVxbp+aPEMXEUmHH4m0b8sKWYzrkNmtBytUFh0HYO+k8zSs+6xcs/UzDFB67
 82HGeCx292CDKDJTmqLo3+0dXZPgDcbe2LcKxhIy49OQlCj2or8Yl6zXdXENcMZwD7ri98FmR
 A2Zgsf+0L1uX0QUKAG+KnSUn33Hkxdu8d5Z9aj22cBU90PTypH+gJmm3EqDylXhYwOLOdMQaq
 mcrbIG/6R937gnvHMrQwFZRDRmT06RFe2JaZEuxSyTMEzY4JKhlGWizIDvWqOOd78vCLRRdfZ
 dTm56EAFnwoSB/R7wMpSUx4uzh85yvKJq/xFa2+/s7M/JKH8GBD9D71PyaSnCKBd9+WDUrqJj
 ML0yhHXpZHQkVvk7yI3GZ8URqyyt7VQpbBhQ8NfVWm8C6lbruFPJPJrgB24KcBkCkpt2Pl63A
 vgy1W5FqyITSed/2vIIPsevTi4XZHfio9Tc0UVMsvd4rzk0Hyd35WNdRYHX4qWoFwrMRvvN5G
 rFWaTt3HTUw6l9dELrLSLcVt+85xXMYqWx0g7hokJ8ejkqCwM3ilP+QVk3JPBHcTfxDbKlEJ1
 AVBZ4YJKTr9vTpt5ZM6HnKkx3Xnmdb7gJ3sfVHfs4W7jwgkueUsF61V4DulHQDVMWmN0zGdrB
 24lnxvQfyIXQ/fYGsFkLorfc+ruVfyqT8TT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.07.22 um 14:11 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Wed, Jul 06 2022, Junio C Hamano wrote:
>
>> The variables 'source', 'destination', and 'submodule_gitfile' are
>> all of type "const char **", and an element of such an array is of
>> "type const char *".
>>
>> Noticed while running "make contrib/coccinelle/array.cocci.patch".
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>
>>  * There is this rule in the array.cocci file:
>>
>>         @@
>>         type T;
>>         T *dst;
>>         T *src;
>>         expression n;
>>         @@
>>         (
>>         - memmove(dst, src, (n) * sizeof(*dst));
>>         + MOVE_ARRAY(dst, src, n);
>>         |
>>         - memmove(dst, src, (n) * sizeof(*src));
>>         + MOVE_ARRAY(dst, src, n);
>>         |
>>         - memmove(dst, src, (n) * sizeof(T));
>>         + MOVE_ARRAY(dst, src, n);
>>         )
>>
>>    but it triggered only for modes[] array among the four parallel
>>    arrays that are being moved here.
>>
>>    There are a few tangents.
>>
>>    * Should we in general use sizeof(TYPE) in these cases, instead
>>      of the size of the zeroth element, e.g.
>>
>>  		memmove(source + i, source + i + 1,
>> 			n * sizeof(source[i]));
>>
>>      It would have been caught by the above Coccinelle rule (we are
>>      taking the size of *dst).

You mean using normalization rules for memmove like we have for memcpy,
to cover a wider range of combinations without having explicit rules for
each one?  Makes sense -- memcpy and memmove take the same arguments, so
we should treat them the same.

>>
>>    * Shouldn't we have an array of struct with four members, instead
>>      of four parallel arrays, e.g.
>>
>> 		struct {
>> 			const char *source;
>> 			const char *destination;
>> 			enum update_mode mode;
>> 			const char *submodule_gitfile;
>> 		} *mv_file;

Possibly, but that would require restructuring the code.  Currently the
function internal_prefix_pathspec() is used to build the string arrays
source and destination separately.

>>
>>    The latter question is important to answer before we accept
>>    Coccinelle-suggested rewrite to use four MOVE_ARRAY() on these
>>    four parallel arrays on top of this fix.
>
> This seems to be the same sort case as noted in 7bd97d6dff3 (git: use
> COPY_ARRAY and MOVE_ARRAY in handle_alias(), 2019-09-19).
>
> I tried (going aginst the warnings in that commit about the
> non-generality) updating the rules to catch these cases, which yielded
> the below. I wonder if we should apply some version of it. I.e. one-off
> fix these, and perhaps have the cocci rule BUG() if we see this sort of
> code again (the form technically could be used, but it seems all our
> uses of it are ones we could convert to the simpler one...).

Having a loose rule and inspecting its results carefully can work, but
having such a rule published and run by CI pipelines etc. risks adding
defects and false positives.  I'm not sure it's much of a win to come
up with a loose Coccinelle rule instead of grepping and hand-editing if
great care needs to be taken in both cases.

>
> diff --git a/add-patch.c b/add-patch.c
> index 509ca04456b..eff338d3901 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -915,10 +915,9 @@ static int split_hunk(struct add_p_state *s, struct=
 file_diff *file_diff,
>  	file_diff->hunk_nr +=3D splittable_into - 1;
>  	ALLOC_GROW(file_diff->hunk, file_diff->hunk_nr, file_diff->hunk_alloc)=
;
>  	if (hunk_index + splittable_into < file_diff->hunk_nr)
> -		memmove(file_diff->hunk + hunk_index + splittable_into,
> -			file_diff->hunk + hunk_index + 1,
> -			(file_diff->hunk_nr - hunk_index - splittable_into)
> -			* sizeof(*hunk));
> +		MOVE_ARRAY(file_diff->hunk + hunk_index + splittable_into,
> +			   file_diff->hunk + hunk_index + 1,
> +			   file_diff->hunk_nr - hunk_index - splittable_into);

OK.

>  	hunk =3D file_diff->hunk + hunk_index;
>  	hunk->splittable_into =3D 1;
>  	memset(hunk + 1, 0, (splittable_into - 1) * sizeof(*hunk));
> diff --git a/builtin/mv.c b/builtin/mv.c
> index 83a465ba831..f6187d1264a 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -282,14 +282,11 @@ int cmd_mv(int argc, const char **argv, const char=
 *prefix)
>  remove_entry:
>  		if (--argc > 0) {
>  			int n =3D argc - i;
> -			memmove(source + i, source + i + 1,
> -				n * sizeof(char *));
> -			memmove(destination + i, destination + i + 1,
> -				n * sizeof(char *));
> -			memmove(modes + i, modes + i + 1,
> -				n * sizeof(enum update_mode));
> -			memmove(submodule_gitfile + i, submodule_gitfile + i + 1,
> -				n * sizeof(char *));
> +			MOVE_ARRAY(source + i, source + i + 1, n);
> +			MOVE_ARRAY(destination + i, destination + i + 1, n);
> +			MOVE_ARRAY(modes + i, modes + i + 1, n);
> +			MOVE_ARRAY(submodule_gitfile + i,
> +				   submodule_gitfile + i + 1, n);

A simpler approach could be to mark the entries as invalid somehow and
skip them in the final loop instead of compacting the array like that.
We don't shrink the allocation anyway, so there's no need to move half
the entries on average on each such a delete.

>  			i--;
>  		}
>  	}
> diff --git a/commit.c b/commit.c
> index 1fb1b2ea90c..c23d3e3678f 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -151,10 +151,9 @@ int register_commit_graft(struct repository *r, str=
uct commit_graft *graft,
>  		   r->parsed_objects->grafts_alloc);
>  	r->parsed_objects->grafts_nr++;
>  	if (pos < r->parsed_objects->grafts_nr)
> -		memmove(r->parsed_objects->grafts + pos + 1,
> -			r->parsed_objects->grafts + pos,
> -			(r->parsed_objects->grafts_nr - pos - 1) *
> -			sizeof(*r->parsed_objects->grafts));
> +		MOVE_ARRAY(r->parsed_objects->grafts + pos + 1,
> +			   r->parsed_objects->grafts + pos,
> +			   r->parsed_objects->grafts_nr - pos - 1);

Is that -1 correct?  Yes, it's needed because grafts_nr is incremented
already above, before making room and actually adding the the new item.
Confused me for a minute.

>  	r->parsed_objects->grafts[pos] =3D graft;
>  	unparse_commit(r, &graft->oid);
>  	return 0;
> diff --git a/contrib/coccinelle/array.cocci b/contrib/coccinelle/array.c=
occi
> index 9a4f00cb1bd..988ff9a3fda 100644
> --- a/contrib/coccinelle/array.cocci
> +++ b/contrib/coccinelle/array.cocci
> @@ -73,6 +73,15 @@ expression n;
>  + MOVE_ARRAY(dst, src, n);
>  )
>
> +@@
> +expression D;
> +expression S;
> +expression N;
> +expression Z;
> +@@
> +- memmove(D, S, (N) * Z);
> ++ MOVE_ARRAY(D, S, N);
> +
>  @@
>  type T;
>  T *ptr;
