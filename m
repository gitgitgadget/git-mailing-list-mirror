Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC6CC433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 17:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B66132083B
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 17:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhia/pMO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387513AbgGaRh1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 13:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733055AbgGaRh0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 13:37:26 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF253C061574
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 10:37:25 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a15so28681347wrh.10
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 10:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HmGyHzEXYSuAY/YBGBdZrsWR2KIC8XAZTgf7dz51KNc=;
        b=nhia/pMOIaggx8abZTvxrwXdxuCjSCvl45qxN2bjFAgBDsBR5OAilEP/cKYUBlERqr
         8zBa1j7ITqUbJJg+nGfL9rrnbGl/0BBzoRU/argeb2UieeV00njdLt1mm/EDwLZyNXgx
         9z/60NOXATGLCJfdvLF4B8wssmG19K5zkzNm/uGfzKTlZhuIgBUeHKnexZR/S2KGbHRd
         yaKekNj9EctfiEUFHiK8NUXEtFpri2D2mxLlE9j7nRMSQ8TELvMDzTSPXyqhf5aq/MBR
         IUpbPPP9SpfLmkZPYeYkFiso1BQvVnIoUPgeNjDX6n5PaoeeUt3M7xGVR6g57P1cBNwX
         fVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=HmGyHzEXYSuAY/YBGBdZrsWR2KIC8XAZTgf7dz51KNc=;
        b=fcObcOIuPuj6YgDVi1QbKLEZIldV5Snauq2TU3V4c0L+g4P3/AqhY0uYKu2um8f7xg
         UxV/BVLQ0cAFVC1x+oGl64zMgbZHVS+pBnml3x4ROXujPyVvFcno/RqEVsCinJdFrCwY
         e+NaqiL/q5MCkjI54OG9dyCVBHO4O1XrBxFikNj+F9lrYXsYfcahymHXsLqpzKAQbS13
         mR755JnJNE9D7F+sLQGDgrrRD3Nwok90aMUCR8y92bahj8sJONrt2AmXrwUHd+jBi0zd
         dnTOfI4qO5T0pJ/0u5YRwY/CiTmJnm4UCgLYGKOE7VAUUmvKFvj0NynxGe2HEVil6A+F
         9lBw==
X-Gm-Message-State: AOAM531y+3JtHaTJeWvxlekalb5znW9Y3/AQt0dEEUO61RYQf4S0Pa4L
        do0zSiatxaKOoFXuZ2TwLKY=
X-Google-Smtp-Source: ABdhPJxEkvARf/MT0elJh2Zpbst55ZybF8RMJEmRugsSs4jdrjljSEW7rQ2Mz+Qbs4o4i8f3RQsX6Q==
X-Received: by 2002:a5d:4750:: with SMTP id o16mr4826815wrs.204.1596217044634;
        Fri, 31 Jul 2020 10:37:24 -0700 (PDT)
Received: from [192.168.0.104] (atoulouse-654-1-421-163.w2-6.abo.wanadoo.fr. [2.6.84.163])
        by smtp.gmail.com with ESMTPSA id k184sm13877583wme.1.2020.07.31.10.37.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2020 10:37:23 -0700 (PDT)
Subject: Re: [PATCH v5 3/3] ref-filter: add support for %(contents:size)
To:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
References: <20200710164739.6616-1-chriscool@tuxfamily.org>
 <20200716121940.21041-1-chriscool@tuxfamily.org>
 <20200716121940.21041-4-chriscool@tuxfamily.org>
From:   Alban Gruin <alban.gruin@gmail.com>
Autocrypt: addr=alban.gruin@gmail.com; prefer-encrypt=mutual; keydata=
 mQINBFcsWp4BEAC6dalBNr/CZCvvfeARylnjAaZCxMPwUHXAyf4xotA59sNcyVmaFQ6KxQEs
 R20CSJhO6HqCh4bR9/994vdc4cGuNaWf82eYRYzqCzwFWvFJHj83QgDR2cjtz4frKpj3jSFJ
 No3KBlMmpU8yvSnYaCxjqHxBB+fZwkmmONj/57KdFRU83DvDllQdAxXfxEavL3qUKjVbld29
 o82M2xsN8ZN5KTw7rAMHcigYVnlrgP50euxz3WvfrV+Mky2W7q7m5rTK7eXqOKhewsKcxo0I
 AP+H0Nt91YTmMIAX2Ba25IfHI99kUCLpbHX9xdvj5UH1SZsG84APahdI3CXYibfYIS+qssoo
 72qj7eBIoCFbVS4Q5AINxojio32orGBDE8CaCy3EzTF+vwJ+h4uUKrTX4wyUMy8nXS0UxZqD
 aQsS7Di6LdAHu+4uf064mXdgjehJ2uHAydFnCThMoxckRoSZ70iCPwgconhNrnuTmunJ43BF
 YjAurjg8y3WrMPJuJaI42q0sYbAX21XeayyMI8dzoNwyG6s+v0Udb/uxdYnHhsGx1oXjYCeR
 nyBdVwdMLWFP4XmJH7JueGUZ37TLh719ME6HYRpfM3sh915ywPxKxQYmGC9iXRThXdGK7ipq
 hJM5RtMq4QPGg+/ShgTZaDdFuMnG8Zrq6W+O29h9NB5rQ/UvBwARAQABtCNBbGJhbiBHcnVp
 biA8YWxiYW4uZ3J1aW5AZ21haWwuY29tPokCcAQTAQIAWgIbAwIeAQIXgAULBwgJCgQVCAkK
 BRYAAQIDHxhoa3A6Ly9wb29sLnNrcy1rZXlzZXJ2ZXJzLm5ldC8CGQEWIQS1T1bLFrFdtpxn
 TIMOC58lWpNWKgUCWRSuYAAKCRAOC58lWpNWKoCfEACHmff95NF5OrBKN+GPYo3TOojjgjio
 CREt9BNIU1ltbks33N/84QF1ifjFF5xjK1XpNhZdk2Nxk+Uf3ByAS24i0b7/BM58RX3sJMHd
 mklCbqBGLBTS+bO/3nc+1snb7FPmjoi3IXznQ25ZXiV/9MUABUBZi7odwNhxeI3Hd2PaX/x5
 ZM0BApqhmBrueUd0JKqY7f/7a+0rTJ8fIHV9ml3cVWf72t2BVnxJMeNLSAIT1FaL8Okp8ViO
 t7RfjF0JZsYZouhCcw2fx7U0VxXGu6bONdVGxu07I7G3+vjhd2C/ld0dgRRjx8viA5HecUSf
 bwbviEXlc44TVo8D6tkrKOezctqNTLII498C7gIQZjc+6HmIIQrOzzLX/C27JQbXch+6KtHO
 ThYGzmD0d7EttTRtXnFJFTMbQMMFnc2X+Rh1ubvfp4Zp2U3a7Nh1//4+ikqIAPV8poJcEdQ0
 A6CaGD8pTCMdExDovizfJRU0ZN3AU9UgFsZWkMK7MFyJneRObUf26oXCQH8zVuJEJHrEsYPk
 VHdV1G86d++CdipKqe9iDNBGNa/5Q9IvYEKK6vj4wLS5ZaOwLGfApbsOcDJvFA1ll/KeHvzx
 Ig9dhUnNCtYXKJ1npChigwRbAiAADoTFI2rI69g6ZTTzBd0+9GM4z6RcOJvtGLnViO4tOCmy
 sbwbxA==
Message-ID: <21bb2dad-5845-8cee-8f6a-1089ef7cae3b@gmail.com>
Date:   Fri, 31 Jul 2020 19:37:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200716121940.21041-4-chriscool@tuxfamily.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

Le 16/07/2020 à 14:19, Christian Couder a écrit :
> It's useful and efficient to be able to get the size of the
> contents directly without having to pipe through `wc -c`.
> 
> Also the result of the following:
> 
> `git for-each-ref --format='%(contents)' refs/heads/my-branch | wc -c`
> 
> is off by one as `git for-each-ref` appends a newline character
> after the contents, which can be seen by comparing its output
> with the output from `git cat-file`.
> 
> As with %(contents), %(contents:size) is silently ignored, if a
> ref points to something other than a commit or a tag:
> 
> ```
> $ git update-ref refs/mytrees/first HEAD^{tree}
> $ git for-each-ref --format='%(contents)' refs/mytrees/first
> 
> $ git for-each-ref --format='%(contents:size)' refs/mytrees/first
> 
> ```
> 
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/git-for-each-ref.txt |  3 +++
>  ref-filter.c                       |  7 ++++++-
>  t/t6300-for-each-ref.sh            | 19 +++++++++++++++++++
>  3 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index b739412c30..2ea71c5f6c 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -235,6 +235,9 @@ and `date` to extract the named component.
>  The message in a commit or a tag object is `contents`, from which
>  `contents:<part>` can be used to extract various parts out of:
>  
> +contents:size::
> +	The size in bytes of the commit or tag message.
> +
>  contents:subject::
>  	The first paragraph of the message, which typically is a
>  	single line, is taken as the "subject" of the commit or the
> diff --git a/ref-filter.c b/ref-filter.c
> index 8447cb09be..73d8bfa86d 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -127,7 +127,8 @@ static struct used_atom {
>  			unsigned int nobracket : 1, push : 1, push_remote : 1;
>  		} remote_ref;
>  		struct {
> -			enum { C_BARE, C_BODY, C_BODY_DEP, C_LINES, C_SIG, C_SUB, C_TRAILERS } option;
> +			enum { C_BARE, C_BODY, C_BODY_DEP, C_LENGTH,
> +			       C_LINES, C_SIG, C_SUB, C_TRAILERS } option;
>  			struct process_trailer_options trailer_opts;
>  			unsigned int nlines;
>  		} contents;
> @@ -338,6 +339,8 @@ static int contents_atom_parser(const struct ref_format *format, struct used_ato
>  		atom->u.contents.option = C_BARE;
>  	else if (!strcmp(arg, "body"))
>  		atom->u.contents.option = C_BODY;
> +	else if (!strcmp(arg, "size"))
> +		atom->u.contents.option = C_LENGTH;
>  	else if (!strcmp(arg, "signature"))
>  		atom->u.contents.option = C_SIG;
>  	else if (!strcmp(arg, "subject"))
> @@ -1253,6 +1256,8 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
>  			v->s = copy_subject(subpos, sublen);
>  		else if (atom->u.contents.option == C_BODY_DEP)
>  			v->s = xmemdupz(bodypos, bodylen);
> +		else if (atom->u.contents.option == C_LENGTH)
> +			v->s = xstrfmt("%"PRIuMAX, (uintmax_t)strlen(subpos));
>  		else if (atom->u.contents.option == C_BODY)
>  			v->s = xmemdupz(bodypos, nonsiglen);
>  		else if (atom->u.contents.option == C_SIG)
> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index e9f468d360..ea9bb6dade 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -52,6 +52,25 @@ test_atom() {
>  		sanitize_pgp <actual >actual.clean &&
>  		test_cmp expected actual.clean
>  	"
> +	# Automatically test "contents:size" atom after testing "contents"
> +	if test "$2" = "contents"
> +	then
> +		case $(git cat-file -t "$ref") in
> +		tag)
> +			# We cannot use $3 as it expects sanitize_pgp to run
> +			expect=$(git cat-file tag $ref | tail -n +6 | wc -c) ;;
> +		tree | blob)
> +			expect='' ;;
> +		commit)
> +			expect=$(printf '%s' "$3" | wc -c) ;;
> +		esac
> +		# Leave $expect unquoted to lose possible leading whitespaces
> +		echo $expect >expected
> +		test_expect_${4:-sucess} $PREREQ "basic atom: $1 contents:size" '

There is a typo here, and $expect is written to `expected', but
`test_cmp' wants `expect'.  Fixing those mistakes does not reveal any
broken tests.

> +			git for-each-ref --format="%(contents:size)" "$ref" >actual &&
> +			test_cmp expect actual
> +		'
> +	fi
>  }
>  
>  hexlen=$(test_oid hexsz)
> 

Alban

