Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54F5C433EF
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 14:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237905AbhLUObG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 09:31:06 -0500
Received: from mout.web.de ([212.227.15.3]:33293 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbhLUObE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 09:31:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1640097029;
        bh=JCrj9lom3ltORIUnnEFLyRhlerFRykiSBgGopmQqtvU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=GTY9fS/dEALPmS149juvUnqvAwbbRoaIKYZzYaR7AwCHhs+BTEWk+xfX3gD/UXqgh
         Iahsp28etAJxYloi7N2n+P5Mv55fQZYPoqLY/Kf2YXBn14N077iQVTEKNJyiGcndVS
         1tbSEVFZX26RyYuahcXHZ5yjk5fxlWegkxiulxNc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Ml4B6-1mcPhg3mX6-00lhmr; Tue, 21
 Dec 2021 15:30:28 +0100
Message-ID: <b2dee243-1a38-531e-02b1-ffd66c465fa5@web.de>
Date:   Tue, 21 Dec 2021 15:30:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v7 2/5] object-file API: add a format_object_header()
 function
Content-Language: en-US
To:     Han Xin <chiyutianyi@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
References: <20211217112629.12334-1-chiyutianyi@gmail.com>
 <20211221115201.12120-3-chiyutianyi@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20211221115201.12120-3-chiyutianyi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ql8+MZ0YIHfx8VTN6xe9dqnkXSMgeJxCW0U8s6yxM/MI3gUAJ+l
 oEGcPPL9L9eTcjW1hgCktpxXKGcD2Qx5bf2v9ywtHTt572ZhYnY1qXSZB5fevaJorVT7IUQ
 oYFlL4vD5Tvo2WIDl8J1Oq400yGtGLKLj+qa75gV6LI8WqED22/E3W134ssOp64bRl9J6w7
 2JHvWQiknJLC0a88Ncu6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PHi+OKFUus0=:mBEFWuixUOli7c24rued0t
 7AXMRQiQU6mPiBdKMKQUdfbsLnZwNMjVdAoELauyHD5mszzue9ViMHT/1s13IX1lQ4VvTKlGB
 5WuCjz/GptR4zJdqZlJbWRFpvfTN+hhxf1Cwvgj6GS0LX/FBdXksI1j5m9vS4mZzpcvdqOoB0
 hz2L9e1SmLsAM1ZD/J8cRto+VxXfkHQwg90VMs/r4oEKWf2nnXJ2IrMQNxli9vrcuN/xpYPNL
 /IWViorVA8Z8+vx9Z6w2nVcL3FrbiISFicVJDfo9lkc2SgkRm3lYQIPGTl0Gx1Fo5RRk7kaBE
 jclrMnrMIAkUUOVqi0UJD/dHB3oMLOjHnHml51mEaCn579p0AVBXYOQgeXHkq/nGSuIn4cmWm
 0SOo1mugOPheEwBqzEKANJVopvuLqQyNU7+MGu2k8adGHrKzo6JwbQAsfrQalhgP1ANMYM3ao
 cMVN5jSypWQv2rGNMWJ0SgF+iw89pVUD3mx89BVxBxIB0nGmACKonr77/5J47PbVRO3vuHLON
 VWvVRn7/5fytbMTWyshczwhXjQeEvcK9rxBuEh5u8eRfatm51vwkybwBgplsndAx47BLBIzZN
 srNUOk+3UfUvOqt36lDaIfIVNv4/M47LrNIPPj66EdDVix0UJSDIyn4FXGSsVZ8S0scuvXPuy
 MslqTFnysFY9ai0oFSOyp/331P/Ju+YtwK5uOHxbIMpZayA4p7l8iT+5hZ3g/qcziuVOqX5QQ
 3J/JeDaEvAKGI2auuA6dPUgwyyaOeBjKzRtWZJPsq1WVYHxmPFGXvytwx4QgZqfkT0QC6YtAb
 BimNkHmqbwpeWMn1EjbH38cSXyBYeER9Y0xwgskzcvCWXTnCuyR69cb9gl7O0XxF0AK2a33jn
 03K/wtjBHvznvYXJVikOl6g20kyOS1hL/IndgluDkFEJs0BxeSwZTwBbnLBeyx+Vhs5k6YQVH
 tumrxYIv/cIrR3X+xV3MHGKpoA6M5PdhRuf1sorYq+ZLjTqTzjAASZATbCtlyfIe4uz83v9uc
 QIxUM3J0YYANdt0NlnrgDVcqFRA+hPnavzWeU+XemOZoA4bBW/Yq53ZWEwBJTfaTAQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.12.21 um 12:51 schrieb Han Xin:
> From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>
> Add a convenience function to wrap the xsnprintf() command that
> generates loose object headers. This code was copy/pasted in various
> parts of the codebase, let's define it in one place and re-use it from
> there.
>
> All except one caller of it had a valid "enum object_type" for us,
> it's only write_object_file_prepare() which might need to deal with
> "git hash-object --literally" and a potential garbage type. Let's have
> the primary API use an "enum object_type", and define an *_extended()
> function that can take an arbitrary "const char *" for the type.
>
> See [1] for the discussion that prompted this patch, i.e. new code in
> object-file.c that wanted to copy/paste the xsnprintf() invocation.
>
> 1. https://lore.kernel.org/git/211213.86bl1l9bfz.gmgdl@evledraar.gmail.c=
om/
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
> ---
>  builtin/index-pack.c |  3 +--
>  bulk-checkin.c       |  4 ++--
>  cache.h              | 21 +++++++++++++++++++++
>  http-push.c          |  2 +-
>  object-file.c        | 14 +++++++++++---
>  5 files changed, 36 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index c23d01de7d..4a765ddae6 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -449,8 +449,7 @@ static void *unpack_entry_data(off_t offset, unsigne=
d long size,
>  	int hdrlen;
>
>  	if (!is_delta_type(type)) {
> -		hdrlen =3D xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX,
> -				   type_name(type),(uintmax_t)size) + 1;
> +		hdrlen =3D format_object_header(hdr, sizeof(hdr), type, (uintmax_t)si=
ze);
                                                                      ^^^^=
^^^^^^^
This explicit cast is unnecessary.  It was needed with xsnprintf(), but
that implementation detail is handled inside the new helper function.

(format_object_header() takes a size_t; even if unsigned long would be
wider than that on some weird architecture, casting the size to
uintmax_t will not avoid the implicit truncation happening during the
function call.)

>  		the_hash_algo->init_fn(&c);
>  		the_hash_algo->update_fn(&c, hdr, hdrlen);
>  	} else
> diff --git a/bulk-checkin.c b/bulk-checkin.c
> index 8785b2ac80..1733a1de4f 100644
> --- a/bulk-checkin.c
> +++ b/bulk-checkin.c
> @@ -220,8 +220,8 @@ static int deflate_to_pack(struct bulk_checkin_state=
 *state,
>  	if (seekback =3D=3D (off_t) -1)
>  		return error("cannot find the current offset");
>
> -	header_len =3D xsnprintf((char *)obuf, sizeof(obuf), "%s %" PRIuMAX,
> -			       type_name(type), (uintmax_t)size) + 1;
> +	header_len =3D format_object_header((char *)obuf, sizeof(obuf),
> +					 type, (uintmax_t)size);
                                               ^^^^^^^^^^^
Same here, just that size is already of type size_t, so a cast makes
even less sense.

>  	the_hash_algo->init_fn(&ctx);
>  	the_hash_algo->update_fn(&ctx, obuf, header_len);
>
> diff --git a/cache.h b/cache.h
> index cfba463aa9..64071a8d80 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1310,6 +1310,27 @@ enum unpack_loose_header_result unpack_loose_head=
er(git_zstream *stream,
>  						    unsigned long bufsiz,
>  						    struct strbuf *hdrbuf);
>
> +/**
> + * format_object_header() is a thin wrapper around s xsnprintf() that
> + * writes the initial "<type> <obj-len>" part of the loose object
> + * header. It returns the size that snprintf() returns + 1.
> + *
> + * The format_object_header_extended() function allows for writing a
> + * type_name that's not one of the "enum object_type" types. This is
> + * used for "git hash-object --literally". Pass in a OBJ_NONE as the
> + * type, and a non-NULL "type_str" to do that.
> + *
> + * format_object_header() is a convenience wrapper for
> + * format_object_header_extended().
> + */
> +int format_object_header_extended(char *str, size_t size, enum object_t=
ype type,
> +				 const char *type_str, size_t objsize);
> +static inline int format_object_header(char *str, size_t size,
> +				      enum object_type type, size_t objsize)
> +{
> +	return format_object_header_extended(str, size, type, NULL, objsize);
> +}
> +
>  /**
>   * parse_loose_header() parses the starting "<type> <len>\0" of an
>   * object. If it doesn't follow that format -1 is returned. To check
> diff --git a/http-push.c b/http-push.c
> index 3309aaf004..f55e316ff4 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -363,7 +363,7 @@ static void start_put(struct transfer_request *reque=
st)
>  	git_zstream stream;
>
>  	unpacked =3D read_object_file(&request->obj->oid, &type, &len);
> -	hdrlen =3D xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX , type_name(type)=
, (uintmax_t)len) + 1;
> +	hdrlen =3D format_object_header(hdr, sizeof(hdr), type, (uintmax_t)len=
);
                                                              ^^^^^^^^^^^
Same here; len is of type unsigned long.

>
>  	/* Set it up */
>  	git_deflate_init(&stream, zlib_compression_level);
> diff --git a/object-file.c b/object-file.c
> index eb1426f98c..6bba4766f9 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1006,6 +1006,14 @@ void *xmmap(void *start, size_t length,
>  	return ret;
>  }
>
> +int format_object_header_extended(char *str, size_t size, enum object_t=
ype type,
> +				 const char *typestr, size_t objsize)
> +{
> +	const char *s =3D type =3D=3D OBJ_NONE ? typestr : type_name(type);
> +
> +	return xsnprintf(str, size, "%s %"PRIuMAX, s, (uintmax_t)objsize) + 1;
                                                      ^^^^^^^^^^^
This cast is necessary to match PRIuMAX.  And that is used because the z
modifier (as in e.g. printf("%zu", sizeof(size_t));) was only added in
C99 and not all platforms may have it.  (Perhaps this cautious approach
is worth revisiting separately, now that some time has passed, but this
patch series should still use PRIuMAX, as it does.)

> +}
> +
>  /*
>   * With an in-core object data in "map", rehash it to make sure the
>   * object name actually matches "oid" to detect object corruption.
> @@ -1034,7 +1042,7 @@ int check_object_signature(struct repository *r, c=
onst struct object_id *oid,
>  		return -1;
>
>  	/* Generate the header */
> -	hdrlen =3D xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX , type_name(obj_t=
ype), (uintmax_t)size) + 1;
> +	hdrlen =3D format_object_header(hdr, sizeof(hdr), obj_type, size);
>
>  	/* Sha1.. */
>  	r->hash_algo->init_fn(&c);
> @@ -1734,7 +1742,7 @@ static void write_object_file_prepare(const struct=
 git_hash_algo *algo,
>  	git_hash_ctx c;
>
>  	/* Generate the header */
> -	*hdrlen =3D xsnprintf(hdr, *hdrlen, "%s %"PRIuMAX , type, (uintmax_t)l=
en)+1;
> +	*hdrlen =3D format_object_header_extended(hdr, *hdrlen, OBJ_NONE, type=
, len);
>
>  	/* Sha1.. */
>  	algo->init_fn(&c);
> @@ -2006,7 +2014,7 @@ int force_object_loose(const struct object_id *oid=
, time_t mtime)
>  	buf =3D read_object(the_repository, oid, &type, &len);
>  	if (!buf)
>  		return error(_("cannot read object for %s"), oid_to_hex(oid));
> -	hdrlen =3D xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX , type_name(type)=
, (uintmax_t)len) + 1;
> +	hdrlen =3D format_object_header(hdr, sizeof(hdr), type, len);
>  	ret =3D write_loose_object(oid, hdr, hdrlen, buf, len, mtime, 0);
>  	free(buf);
>

No explicit cast in these three cases -- good.  They all pass an
unsigned long as last parameter btw.

Ren=C3=A9
