Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61831C07E96
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 11:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29CB0611F2
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 11:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbhGKL4P (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 07:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhGKL4O (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jul 2021 07:56:14 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A00C0613DD
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 04:53:26 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id h8so9129699eds.4
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 04:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Zc6dqq1i+vOkJsE0P8tJuloAMbKD+83Su2dU4m4+BKU=;
        b=fXaq2eIJXouQ5ws3SA1cF9AHKsWO06oUGyR1f4wifhbfvPmcYWUembWKTKhnoTv653
         sLbmSJI/g/c5qCtyfOqNOeTvn63PPk9gXqBpHmex1Pk3ku8KphpAW4adljNBz9eeIcWW
         ydKcLRj66ifASMkkrV2A12EhHkWokkPEN7iteNb2jVOHte5SDTiBPlEV2FDmk4I9hSbL
         EnesUCietl3VgfBzB/YZKrSSwPe1NGqZWGAxfO+HAVv+dAU0IPBFUTWwTMcX/pGDCvjx
         iqIbgzXm2nKukaLmyYPqKHH/ux3cVpXQRAvFRF+UnNpqpmRqgnUYoxMZAEhKbFqwOkA2
         lTwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Zc6dqq1i+vOkJsE0P8tJuloAMbKD+83Su2dU4m4+BKU=;
        b=tL3L+m7/HocLvkQTzmKHjOycgK0QFD1xZt25AaX1sfi6E7nXF7MWmSbNXLL2U3XliH
         Knl87T1T25F9E/3m4nb3NhxW41V05y1OyWUsIL5DYWd4EI2eT8AxbPtLTyo1VqAypxEc
         rpXZ9UQrgOe/loqr01zV5MRHfuers7f7ELzfAupDE1OBeQswraAVSvPA4YU8MoHaYl/6
         u/3gv4Q1WUFbg4c4w3JFIYV+b2KCokXYMof5QUKMef38toEhK2JO3uGIj7CMgOwaDEss
         vsq0akfG4xcSibvFgX9+d/xux0QV92VljLYE7ZOKS2qJWtYrJiOBZMBNraqcJBc1An15
         B6+A==
X-Gm-Message-State: AOAM532wTR2rUbk0FgPj0nI1RrA3suAW1G0f3ZlRdo2TPxU1rn38pQMb
        Yt8ufEMYXq9GDYHtltfquyABZ4Dy1uKoKg==
X-Google-Smtp-Source: ABdhPJxH1nHBp8icDwLYQnfU1WuTajcLqBO2fXOArXEL+/qPrposk4UKaaODhP6d4ofOLcfDDACeYg==
X-Received: by 2002:aa7:d457:: with SMTP id q23mr35563744edr.324.1626004405257;
        Sun, 11 Jul 2021 04:53:25 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id hd30sm507013ejc.29.2021.07.11.04.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 04:53:24 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v5 3/6] refs: make errno output explicit for
 read_raw_ref_fn
Date:   Sun, 11 Jul 2021 13:52:00 +0200
References: <pull.1012.v4.git.git.1625597757.gitgitgadget@gmail.com>
 <pull.1012.v5.git.git.1625684869.gitgitgadget@gmail.com>
 <7feedb9720127605b5e84aa1143c6ddc736597f3.1625684869.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <7feedb9720127605b5e84aa1143c6ddc736597f3.1625684869.git.gitgitgadget@gmail.com>
Message-ID: <87im1h3w3w.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 07 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> diff --git a/refs.c b/refs.c
> index 8c9490235ea..5e5e3af8da0 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1675,13 +1675,19 @@ int refs_read_raw_ref(struct ref_store *ref_store,
>  		      const char *refname, struct object_id *oid,
>  		      struct strbuf *referent, unsigned int *type)
>  {
> +	int result;
> +	int failure_errno;
>  	if (!strcmp(refname, "FETCH_HEAD") || !strcmp(refname, "MERGE_HEAD")) {
>  		return refs_read_special_head(ref_store, refname, oid, referent,
>  					      type);
>  	}
>  
> -	return ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
> -					   type);
> +	failure_errno = 0;
> +	result = ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
> +					     type, &failure_errno);
> +	if (failure_errno)
> +		errno = failure_errno;
> +	return result;
>  }

Just reading along again in sequence, and having forgotten where (if
anywhere) this was headed I still find this verbose pattern for /looking
like/ we'll be doing something that's not setting errno, but actually
just setting errno. I.e. the logic is the same as the below squash, but
let's read on...

diff --git a/refs.c b/refs.c
index 5e5e3af8da0..7b3f05a66ff 100644
--- a/refs.c
+++ b/refs.c
@@ -1675,19 +1675,13 @@ int refs_read_raw_ref(struct ref_store *ref_store,
 		      const char *refname, struct object_id *oid,
 		      struct strbuf *referent, unsigned int *type)
 {
-	int result;
-	int failure_errno;
 	if (!strcmp(refname, "FETCH_HEAD") || !strcmp(refname, "MERGE_HEAD")) {
 		return refs_read_special_head(ref_store, refname, oid, referent,
 					      type);
 	}
 
-	failure_errno = 0;
-	result = ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
-					     type, &failure_errno);
-	if (failure_errno)
-		errno = failure_errno;
-	return result;
+	return ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
+					   type, &errno);
 }
 
 /* This function needs to return a meaningful errno on failure */
