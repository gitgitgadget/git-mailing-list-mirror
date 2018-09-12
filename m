Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 527BE1F404
	for <e@80x24.org>; Wed, 12 Sep 2018 21:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbeIMC5K (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 22:57:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33882 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeIMC5K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 22:57:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id g33-v6so3573913wrd.1
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 14:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7sC1agAjYOUh3ySP5lZRDlr514tORNj/xbN3yuPsRjk=;
        b=KwpQ43rGbcVeWNX5xgr6cxUhvzfp9uyPjixw/RLvH4MPjk23EDEZaCz89pjDRjCP/q
         eO47pj1uJSBYAv8J0D4ZrAX2U4aW1ZwNMzTn7DiP3ZQIlEXHZFdfNdVkxAaPoU9cwevU
         erQONHAWX1+2IHC39VXBD0SWAJjl5oMGAA9HIMhr4k2dmBu9POkEroVArv1MvdlzIHhs
         Sh5zndan+5WSls7GvRtTwzEs/mY2QfQOBBATnsV5hN1IU0CM00A7lm2AxGrQdrgR9MAq
         WS+lth3s/RS3Np4FOIekYupg6r8t2A4sfD7hKI01tIXqdLFjswR3Dzbx4Vb1U2a5bKFT
         h+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7sC1agAjYOUh3ySP5lZRDlr514tORNj/xbN3yuPsRjk=;
        b=BYau6uoZIhrNfL+xBjNS17/BR6vY3VLktdwn/eIIkocZECisCM1+SVttljz5hKXzdo
         IWXjSZZxNt+zKuq8TXZmHh91q3C+z179SjlPN/Z3xbLbmz4bjHATlR82STECkYKT2Xme
         zC7/9Cnpd9a+DAQgeWCtmQwYJgH4Sk8qH2sU0zQ9bcR9u+x2toqBNzNEu3tnGm3B3vJs
         Pm1ZLIf926z1/e50VQEQFw1CbalWi16rETFYmt3xwRXL8iTKZ3Tm4J3qlNEzDGr+TwFy
         zKKdfILpueV5VxGw9bzfkB3gPlKe7ULh1HwgHarwzy6d+raWClRzkP0IFuAuNoUWkDHZ
         gaxw==
X-Gm-Message-State: APzg51D1L7DY/lDlNWFv61JWzvF2WzdPF+rbd3zCgeUSB3H+J8//hyIp
        ByLwDV2AGUp6AaX1Xw6gBjc=
X-Google-Smtp-Source: ANB0VdbsYy8vjfz5nhnPy2shjIqQmLqsJVYphTfRHBy9Mc4TPfBUD+6kwKuhOTxYqtVHBsGQk7pBWA==
X-Received: by 2002:adf:9051:: with SMTP id h75-v6mr3221761wrh.65.1536789040522;
        Wed, 12 Sep 2018 14:50:40 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o19-v6sm3147740wro.50.2018.09.12.14.50.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 14:50:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] fetch-object: provide only one fetching function
References: <cover.1536767071.git.jonathantanmy@google.com>
        <72399daf65b9c0a7ed12589584f5108a9ff6fc26.1536767071.git.jonathantanmy@google.com>
Date:   Wed, 12 Sep 2018 14:50:38 -0700
In-Reply-To: <72399daf65b9c0a7ed12589584f5108a9ff6fc26.1536767071.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Wed, 12 Sep 2018 08:47:37 -0700")
Message-ID: <xmqqefdyjsgh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> fetch-object.h currently provides two functions (fetch_object() and
> fetch_objects()) that could be replaced by a single, more flexible
> function. Replace those two functions with the more flexible function.

The latter half of the first sentence and the second sentence are
pretty-much repeating the same thing.  

I think you wanted to justify two changes:

 (1) There are two helpers.  fetch_object() fetches a single object
     from a given remote; fetch_objects() fetches a set of objects
     from a given remote.  It is not like the former is implemented
     as a specialization of the latter (i.e. passing length=1
     array), and it is not like the former is optimized specially
     for a single object fetch that cannot be made into such a thin
     wrapper.  It is not like the latter is implemented as a
     repeated call to the former in a loop, either.  There is no
     justification to keep two independent implementations, and
     using a single helper that can be used by all the callers of
     these two would make sense.

 (2) The variant that fetches multiple objects takes oid_array.  To
     be used by all the existing callers of these two helpers, it is
     better to use a different calling convention, namely, a array[]
     and its length passed as separate parameters.
     
Instead of explaining why the new convention is better to justify
(2), the above three lines handwave by saying "more flexible"
twice.  We should do better.

	fetch-object: unify fetch_object[s] functions

	There are fetch_object() and fetch_objects() helpers in
	fetch-object.h; as the latter takes "struct oid_array",
	the former cannot be made into a thin wrapper around the
	latter without an extra allocation and set-up cost.

	Update fetch_objects() to take an array of "struct
	object_id" and number of elements in it as separate
	parameters, remove fetch_object(), and adjust all existing
	callers of these functions to use the new fetch_objects().

perhaps?

> diff --git a/sha1-file.c b/sha1-file.c
> index 97b742384..2edf4564f 100644
> --- a/sha1-file.c
> +++ b/sha1-file.c
> @@ -1317,7 +1317,7 @@ int oid_object_info_extended(struct repository *r, const struct object_id *oid,
>  			 * TODO Pass a repository struct through fetch_object,
>  			 * such that arbitrary repositories work.
>  			 */
> -			fetch_object(repository_format_partial_clone, real->hash);
> +			fetch_objects(repository_format_partial_clone, real, 1);
>  			already_retried = 1;
>  			continue;
>  		}
> diff --git a/unpack-trees.c b/unpack-trees.c
> index f25089b87..82a83dbc6 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -392,7 +392,7 @@ static int check_updates(struct unpack_trees_options *o)
>  		}
>  		if (to_fetch.nr)
>  			fetch_objects(repository_format_partial_clone,
> -				      &to_fetch);
> +				      to_fetch.oid, to_fetch.nr);
>  		fetch_if_missing = fetch_if_missing_store;
>  		oid_array_clear(&to_fetch);
>  	}

Changes to these two callers do explain why <ptr, nr> is an
interface that is easier to use.  Those who already have an
oid_array can pass its fields as separate parameters without too
much trouble, and those who only have an oid (or an array of oid and
knows how many are in the array) do not have to wrap them into an
oid_array.

Thanks.
