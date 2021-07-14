Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196E3C12002
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 21:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0166B6128B
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 21:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbhGNVtl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 17:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbhGNVtl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 17:49:41 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CFFC06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 14:46:48 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id c17so5605765ejk.13
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 14:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=fM+kfkrVUcRpaImc1Fib/zuM/DdvzU8OkFUhP26I7rk=;
        b=Abn4sxl9LDyU0Rwhw84zFlLxyUUmiPDQYbs/7y3uw/XXYm3TW03Y81+JADR+Nift+v
         2mNs/EaJ1Z1xnl8OfEVSN5+hIsZi+eH4KSrHQ+povOyGRECTzlHDLVghaoqzB7W2g0oD
         Iuav5/vgYKBtZLtgqIzL2sydM9WgZ8LZIsV/sKVlhpgBJA/RZY8gEeveW7ugoqbH3GWK
         KTshviUFx8l10syno4paJIQR0DJ7g6xUiWO6y2oe68GLghX2R6TOneR/2hKr6oz92ztp
         kehMUVajf1bA63/ABrxGTDh4YB3SlI/NOnO8HRX/pV6zYSYdA9Ybx9uAE/Ip1DiPF6O8
         PYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=fM+kfkrVUcRpaImc1Fib/zuM/DdvzU8OkFUhP26I7rk=;
        b=YkdX72W0Z8t7/ko9ABOXb2lNNiQ2a7tQ9ZjDsoNMI0U2n+JzPOHuiHAfQGnSijuKW2
         pFrd97J1CRMoUfGi4FnNyF4Tl016QRoKqEU84WNBSNza3fBvhIIhtMAF7ZsyuWkdmgk/
         O5Ovh9nOTQ5ZDQ7fh2cKrWetBPeGUzJ9OC5nYD3hyY3wlva37m1kJA+AK1aeetgGd6wW
         t0oqr7mG8qUOrT1LXFKFBXTrXkQAF3hOhnkdWO4xfUyqrRdroKacted8H7s6ZyA7I+E1
         I9ngYBShI52/zIOXkK1F4Ni/183j8Y5py1ZstfH3Oat/4yH4Er/9ITarD9AKGVwHO8rt
         UYZw==
X-Gm-Message-State: AOAM531ILhBE9/ZtLB0LOuWDcw6fN2KPoinA13jbsjHgaRvbO3z9uJqQ
        QppquH2DoL3CmXjE5g2NTMU=
X-Google-Smtp-Source: ABdhPJxasO4tLwevMyTfTZcq3oD1mHHW5RUmlTP64WM7WDgOwYHqwfoqieBXPi6wtblDCFFRydmcPw==
X-Received: by 2002:a17:907:3c81:: with SMTP id gl1mr351520ejc.48.1626299206695;
        Wed, 14 Jul 2021 14:46:46 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id m12sm1178488ejd.21.2021.07.14.14.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 14:46:46 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     emilyshaffer@google.com, git@vger.kernel.org
Subject: Re: [PATCH 3/3] fetch: die on invalid --negotiation-tip hash
Date:   Wed, 14 Jul 2021 23:45:24 +0200
References: <878s293htx.fsf@evledraar.gmail.com>
 <20210714193506.4084421-1-jonathantanmy@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210714193506.4084421-1-jonathantanmy@google.com>
Message-ID: <87sg0gzhys.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 14 2021, Jonathan Tan wrote:

>> >> diff --git a/builtin/fetch.c b/builtin/fetch.c
>> >> index 9191620e50..2c50465cff 100644
>> >> --- a/builtin/fetch.c
>> >> +++ b/builtin/fetch.c
>> >> @@ -1428,7 +1428,9 @@ static void add_negotiation_tips(struct git_transport_options *smart_options)
>> >>  		if (!has_glob_specials(s)) {
>> >>  			struct object_id oid;
>> >>  			if (get_oid(s, &oid))
>> >> -				die("%s is not a valid object", s);
>> >> +				die(_("%s is not a valid object"), s);
>> >> +			if (!has_object(the_repository, &oid, 0))
>> >> +				die(_("%s is not a valid object"), s);
>> > Any reason not to consolidate these, e.g. if (get_oid || !has_object)?
>> > Then we wouldn't dup the err string.
>> 
>> Generally I'd agree, but aren't we explicitly conflating cases where
>> something is a valid way no name an object v.s. being certain that such
>> an object does not exist? I.e. this should be something like:
>> 
>>     if can't get_get():
>>         error "couldn't get the OID of revision '%s'"
>>     if can't look up fully-qualified OID:
>>         error "the OID '%s' does not exist"
>> 
>> Or something...
>
> Good point. I'll use wording similar to yours.

I stole the former from a quick grepping around:

    builtin/bisect--helper.c: res = error(_("couldn't get the oid of the rev '%s'"), rev)

Then http-push.c suggests "perhaps you need to fetch" for
has_object_file(), but I don't know if it applies here...
