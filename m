Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC471C77B7D
	for <git@archiver.kernel.org>; Wed, 10 May 2023 20:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjEJUNh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 16:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjEJUNf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 16:13:35 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8870173C
        for <git@vger.kernel.org>; Wed, 10 May 2023 13:13:07 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6435bbedb4fso8317350b3a.3
        for <git@vger.kernel.org>; Wed, 10 May 2023 13:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683749586; x=1686341586;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Eu81Z0q7H2kt7YKzDcj8c07mLo55EZZ8Dn3HMxKkqY=;
        b=eXXWY9gqEMSY48dKvI3k7ABbqidI/+hjzu9iCYQCUCA1VtpYFH3NgyTkbUrGJCCcJF
         i7Z6+rxrQDzWqm2yPkN78Aizwu9B9TqktbjOdVNWkaFkKZ+wADaQaEA6giz7M9VstR0K
         upYDByHvowOqDK6luIOHit34KB/4mfNwT3bPOG5egK6qv/cIqrW6JrQqeGL7jAZbqxqm
         qDc3fnnQZkrXdbF8ztsnrjLAU15yUNR9uOV591CiCY5MZDW7ISpLhBa84YIoIJFOjvOL
         rloU6ffxoBEat3eYmtLZ91FVL9k7Bek12mmrbOdHwse50ytH/BcPxfRUQnyT7uwxG7Pg
         qw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683749586; x=1686341586;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2Eu81Z0q7H2kt7YKzDcj8c07mLo55EZZ8Dn3HMxKkqY=;
        b=HXtAQOUDVM4HFBNelZ7NxLoKBohZ3MCMhlRe3f4pRCEaMuMCluja3ggRQifnt1G3vl
         pDU2//s72rkOUeDlFgoS50U7kNLk/DtxP04D5XOjsvZjtJrv4YZVw12QPAWlol7PJ4OD
         BcOMzHF5Xc5GY/NNt1/9giEOVFWYb6cuHD7cJzPTrrFfcqsUxQfkFGQ2hh1oXHD4iBqD
         oQQnaU9t2tB/jhcmHHXSdZaYiXg0II8V+vGGipD0HOAGVI71CZZ7qoHxw4zl5vvDoChj
         M54ybswx/1sFVCeBT4Kb6cePBWAmdRp1eDcHiy2vN3KH386D3Mx7v9siOgqY2jQUq2nR
         Wj7w==
X-Gm-Message-State: AC+VfDzZGjJEWniFYMJNRDgD9zVt3BZ2HJysIUogvwNZFbu5qV2LEsHe
        UK8CP+uvaRunaXTVVhvKc6ZTnw+l2mE=
X-Google-Smtp-Source: ACHHUZ6xg4eL0yDEOyZQAugLcM3N2VUbEs45q6Mu24aUfRarFOEkaMg7FCjlHCkPZb9VrKMd5XaUNA==
X-Received: by 2002:a05:6a20:1608:b0:f2:c2a3:3a1 with SMTP id l8-20020a056a20160800b000f2c2a303a1mr24327771pzj.43.1683749586237;
        Wed, 10 May 2023 13:13:06 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id k25-20020a63ba19000000b0050f93a3586fsm3437052pgf.37.2023.05.10.13.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 13:13:05 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Toon Claes <toon@iotcl.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 1/1] cat-file: quote-format name in error when using -z
References: <xmqqilfhctrr.fsf@gitster.g>
        <20230510190116.795641-1-toon@iotcl.com>
        <20230510190116.795641-2-toon@iotcl.com>
Date:   Wed, 10 May 2023 13:13:05 -0700
In-Reply-To: <20230510190116.795641-2-toon@iotcl.com> (Toon Claes's message of
        "Wed, 10 May 2023 21:01:16 +0200")
Message-ID: <xmqqpm782be6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Toon Claes <toon@iotcl.com> writes:

> Since it's supported to have NUL-delimited input, introduced in
> db9d67f2e9 (builtin/cat-file.c: support NUL-delimited input with `-z`,
> 2022-07-22), it's possible to pass paths that contain newlines.

It has been a while since I saw this patch the last time, and it did
not immediately click to me how "pass paths" relates to passing
object names, which is what "--batch-check" takes.  Perhaps

    "cat-file --batch-check" may be fed object names of blobs and
    trees as "<commit>:<path>", and with its "-z" option, it is
    possible to feed <commit> or <path> with newlines in it.

or something?

> This
> works great when the object is found, but when it's not, the input path
> is returned in the error message. Because this can contain newlines, the
> error message might get spread over multiple lines, making it harder to
> machine-parse this error message.

Good description.  I may suggest

    "the input path is returned" -> "the input is shown verbatim"

because <path> is not the only thing that can contain LF.  E.g.

    $ git show -s 'HEAD^{/introduced in
    > db9d67}'

can find the commit resulting from this patch, so

    $ printf "%s\0" 'HEAD^{/introduced in
    > db9d67}:builtin/cat-file.cc' |
    > git cat-file --batch-check -z 

would be an input record with newline in it, that has no newline in
the path.

> With this change, the input is quote-formatted in the error message, if
> needed. This ensures the error message is always on a single line and
> makes parsing the error more straightforward.

Drop "With this change, ..." and give a command to the codebase to
c-quote the object name in the output, e.g.

    C-quote the object name from the input in the error message as
    needed, to ensure that the error message is on a single line and
    ...

The other side of the coin, however, is that an existing project
that is sane enough not to have a path with LF in it, but is not
sane enough to avoid a path with double-quote in it, would now stop
being able to parse the error message for a missing path.

It is a regression, and we may argue that it is not a large enough
regression to block progress given by this patch, but if it is not
common enough to have funny characters in the paths then we wouldn't
be seeing this patch in the first place.  So I would prefer to see
that we at least admit that we are deliberately making this change
with a known regression.  Perhaps add something like

    Note that if a project already parses the error message
    correctly because it does not have paths with newlines, this is
    a breaking change if it has paths with characters that need
    c-quoting (like double quotes and backslashes) that are not
    newlines.  We consider that this is a small enough price to pay
    to allow newlines in paths because ...

and fill the "because ..." part is sensible.  I am not filling the
"because" part, simply because I do not offhand see any good excuse
to rob Peter to pay Paul in this case.

> @@ -470,8 +471,17 @@ static void batch_object_write(const char *obj_name,
>  						       &data->oid, &data->info,
>  						       OBJECT_INFO_LOOKUP_REPLACE);
>  		if (ret < 0) {
> +			struct strbuf quoted = STRBUF_INIT;
> +
> +			if (opt->nul_terminated &&
> +			    obj_name) {
> +				quote_c_style(obj_name, &quoted, NULL, 0);
> +				obj_name = quoted.buf;
> +			}
> +
>  			printf("%s missing\n",
>  			       obj_name ? obj_name : oid_to_hex(&data->oid));
> +			strbuf_release(&quoted);
>  			fflush(stdout);
>  			return;
>  		}

Interesting.

When running "--batch-all-objects", we do not have obj_name, and we
do not have anything to "quote", but the fallback label is the full
hexadecimal object name, and we do not have to worry about line
breaks.

OK.

> @@ -518,6 +528,13 @@ static void batch_one_object(const char *obj_name,
>  	result = get_oid_with_context(the_repository, obj_name,
>  				      flags, &data->oid, &ctx);
>  	if (result != FOUND) {
> +		struct strbuf quoted = STRBUF_INIT;
> +
> +		if (opt->nul_terminated) {
> +			quote_c_style(obj_name, &quoted, NULL, 0);
> +			obj_name = quoted.buf;
> +		}
> +
>  		switch (result) {
>  		case MISSING_OBJECT:
>  			printf("%s missing\n", obj_name);
> @@ -542,6 +559,8 @@ static void batch_one_object(const char *obj_name,
>  			       result);
>  			break;
>  		}
> +
> +		strbuf_release(&quoted);
>  		fflush(stdout);
>  		return;
>  	}

This is the side that runs without "--batch-all-objects" and always
has non-null obj_name, so it looks a bit different from the other
hunk and is more straight-forward.  Looking good.

Thanks.
