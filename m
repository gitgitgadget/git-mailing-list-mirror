Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FF1C4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 13:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbiLTNOq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 08:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbiLTNOn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 08:14:43 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5CC192BB
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 05:14:42 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id n20so29224658ejh.0
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 05:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MiapcVCHePO9WVeEpdHQ4JNME3e927I5zUCW8R0xMxM=;
        b=aO8hUnQY/ll1m3l7gtRKxH847vdFl9d3gIogmoShWzQZhj/va/WKoxLPkUeH25wlF2
         txoipQOthnT0SH+2wo8ssYH9Bw4uIGa8b27xBN0/SW8GHjSrRHtmMqz6pgbEs4DPE0Pu
         rik5xScPnPFgw/i7NHwysYSBoEi5s4GxWANI6D5O7kgy8vq0mtNIPgnM72iZDORx7rAY
         /Do+03gJFnDSy5O/sw93TqNyRyDgdbWQIRsWIckcOeCIimBcaebofJUBC4ihh0r+F7St
         fZ0u3+MvxK/FGGNF5Xt8PBm9gwUYU3m090q7OR9eQbSZhr8dtLTrLvdGLD5nFTYRqJoa
         OCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MiapcVCHePO9WVeEpdHQ4JNME3e927I5zUCW8R0xMxM=;
        b=cMrtdOJ6C2WXyxx+NYZDm50dtQtWzpWAPsS9Xc620E/nlVvx+wVosb7f3WZBNulind
         wEw5xazgqVfp8zdaet2ogqmcvcyEOJkAULECFWOiRmT6CBf5SQtVTVoQhiPYoQ3hRhAp
         bujLTUOZKK16oMY/uOMipCliPPCRaEmbHQVoJOcFMtkc657FOI6Fm/mpac2V5vMS/dGT
         FmvBQL7GXSH0B3Ijs9IH2Ljd6sVacP0uXPn6/FKJBhsH8l3waG7B9j053FnobgjVAhVC
         S/Wf8N+k5U7R5tvkprehOsZp3GH6YpwYyyPgCmHLn8No2YDF6hjf9o6QiQioNPM5PQ47
         Jvsw==
X-Gm-Message-State: AFqh2kooSXOAHHUBrUb72f7r/IEB+nU6FZt1y7UnD2JBnqoldDen+dJf
        N2J3aILSf7qUPIZg4DsQH+DyFrbaPrc/Xw==
X-Google-Smtp-Source: AMrXdXtLxfz24j/8Qo6MB/JBSkpWZxL3nQlE3DbRA3K/cZiPjG6nshHfPLyvlplYH2mKzxwk5528tw==
X-Received: by 2002:a17:907:6f19:b0:7aa:491c:6cdf with SMTP id sy25-20020a1709076f1900b007aa491c6cdfmr2052491ejc.18.1671542080680;
        Tue, 20 Dec 2022 05:14:40 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id r20-20020a1709064d1400b007c0cd272a06sm5702510eju.225.2022.12.20.05.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 05:14:39 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p7cS7-007JBW-1T;
        Tue, 20 Dec 2022 14:14:39 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Siddharth Asthana <siddharthasthana31@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
        johncai86@gmail.com, Johannes.Schindelin@gmx.de, me@ttaylorr.com
Subject: Re: [PATCH v7 0/2] Add mailmap mechanism in cat-file options
Date:   Tue, 20 Dec 2022 14:02:07 +0100
References: <20220916205946.178925-1-siddharthasthana31@gmail.com>
 <20221220060113.51010-1-siddharthasthana31@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221220060113.51010-1-siddharthasthana31@gmail.com>
Message-ID: <221220.865ye6xlmo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 20 2022, Siddharth Asthana wrote:

>          2. Make one call to `oid_object_info_extended()` to get the type of the
>             object. Then, if the object type is either of commit or tag, make a
>     -       call to `read_object_file()` to read the contents of the object.
>     +       call to `repo_read_object_file()` to read the contents of the object.
>      
>          I benchmarked the following command with both the above approaches and
>          compared against the current implementation where `--use-mailmap`
>     @@ Documentation/git-cat-file.txt: OPTIONS
>      -	also need to specify the path, separated by whitespace.  See the
>      -	section `BATCH OUTPUT` below for details.
>      +	on stdin. May not be combined with any other options or arguments
>     -+	except --textconv, --filters, or --use-mailmap.
>     ++	except `--textconv`, `--filters`, or `--use-mailmap`.
>      +	+
>      +	* When used with `--textconv` or `--filters`, the input lines
>      +	  must specify the path, separated by whitespace. See the section
>     @@ Documentation/git-cat-file.txt: OPTIONS
>      -	need to specify the path, separated by whitespace.  See the
>      -	section `BATCH OUTPUT` below for details.
>      +	Print object information for each object provided on stdin. May not be
>     -+	combined with any other options or arguments except --textconv, --filters
>     -+	or --use-mailmap.
>     ++	combined with any other options or arguments except `--textconv`, `--filters`
>     ++	or `--use-mailmap`.
>      +	+
>      +	* When used with `--textconv` or `--filters`, the input lines must
>      +	 specify the path, separated by whitespace. See the section
>     @@ builtin/cat-file.c: static void batch_object_write(const char *obj_name,
>      +			size_t s = data->size;
>      +			char *buf = NULL;
>      +
>     -+			buf = read_object_file(&data->oid, &data->type, &data->size);
>     ++			buf = repo_read_object_file(the_repository, &data->oid, &data->type,
>     ++						    &data->size);
>      +			buf = replace_idents_using_mailmap(buf, &s);
>      +			data->size = cast_size_t_to_ulong(s);
>      +


This series looks good to me at this point, thanks in particular for the
repo_*() change (will make something I plan to submit soon easier).

These[1][2] are nits I came up with while reviewing this, not worth a
re-roll, but tweaked some things I found a bit odd, namely:

 * Let's not cast to void **, instead we can just declare a variable for
   the 's' case
 * If we don't need the "buf" return value we can skip the assignment
   (although I guess technically this breaks the encapsulation, so maybe
   we shouldn't skip it)
 * We can skip the NULL assignment in 2/2, and instead just assign to
   the variable as we declare it, and also do the replace/free on one
   line (to make it clear that we immediately don't care about it, and
   only want the size).

I don't think any of it's worth a re-roll, just notes to show you I've
looked at it carefully.

The only unresolved question I had while reading this is if we're sure
that a repo_read_object_file() following the a successful
oid_object_info_extended() is guaranteed to succeed? If not the code in
2/2 has a segfault we might trigger (as buf will be NULL), but maybe
we're guaranteed to always get the already-retrieved object from the
object cache.

1:  fe3cc3715b2 ! 1:  31701b3e55d cat-file: add mailmap support to -s option
    @@ Documentation/git-cat-file.txt: OPTIONS
     
      ## builtin/cat-file.c ##
     @@ builtin/cat-file.c: static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
    + 		break;
      
      	case 's':
    ++	{
    ++		void *obuf = NULL;
    ++
      		oi.sizep = &size;
     +
     +		if (use_mailmap) {
     +			oi.typep = &type;
    -+			oi.contentp = (void**)&buf;
    ++			oi.contentp = &obuf;
     +		}
     +
      		if (oid_object_info_extended(the_repository, &oid, &oi, flags) < 0)
    @@ builtin/cat-file.c: static int cat_one_file(int opt, const char *exp_type, const
     +
     +		if (use_mailmap && (type == OBJ_COMMIT || type == OBJ_TAG)) {
     +			size_t s = size;
    -+			buf = replace_idents_using_mailmap(buf, &s);
    ++
    ++			replace_idents_using_mailmap(obuf, &s);
     +			size = cast_size_t_to_ulong(s);
     +		}
    ++		free(obuf);
     +
      		printf("%"PRIuMAX"\n", (uintmax_t)size);
      		ret = 0;
      		goto cleanup;
    +-
    ++	}
    + 	case 'e':
    + 		return !has_object_file(&oid);
    + 
     
      ## t/t4203-mailmap.sh ##
     @@ t/t4203-mailmap.sh: test_expect_success '--mailmap enables mailmap in cat-file for annotated tag obj
2:  d6c621820d2 ! 2:  14d95db69e9 cat-file: add mailmap support to --batch-check option
    @@ builtin/cat-file.c: static void batch_object_write(const char *obj_name,
     +
     +		if (use_mailmap && (data->type == OBJ_COMMIT || data->type == OBJ_TAG)) {
     +			size_t s = data->size;
    -+			char *buf = NULL;
    ++			char *buf = repo_read_object_file(the_repository,
    ++							  &data->oid,
    ++							  &data->type,
    ++							  &data->size);
     +
    -+			buf = repo_read_object_file(the_repository, &data->oid, &data->type,
    -+						    &data->size);
    -+			buf = replace_idents_using_mailmap(buf, &s);
    ++			free(replace_idents_using_mailmap(buf, &s));
     +			data->size = cast_size_t_to_ulong(s);
    -+
    -+			free(buf);
     +		}
      	}
      
