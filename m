Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1F4C63793
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 08:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C02FB6121E
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 08:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhGVH3j (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 03:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbhGVH3i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 03:29:38 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C876C061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 01:10:13 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id v1so5695755edt.6
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 01:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=TfgOklZb9ZGOwOl51i/1ddzwyEF6nIQDxBKq82PXTvo=;
        b=TIWU2DNBj7QcyeHmN3bbB9Dl0e3EceGv8SUi30X9i7YJBuKpacDjTrgfW6FLHnts64
         nc3hDX1fkFD0PW2yEIn114QFL5+FoAgapwbzVRAMq2b3hOfOltad7S704g/rBe+HZ5I7
         5LcMV0YWeKO1R+x3hwBlbRLBPlxjgFkKzClmeDBgcUpvIXhFJ0D8Y2OJWs0HL65BhR08
         PNFAB2BHbhXfHVBr+A/C1hB8N5zS28qjofSuNa8BdtsmVaRM3kxwZW7ARkupqwBBxSe8
         s1gKDWjNuOi0PqLnAL4UAVjkeIrOOFh5aG3giZCpZfYnXeUQXQPiErJCfjwfjaU5d4KM
         ObHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=TfgOklZb9ZGOwOl51i/1ddzwyEF6nIQDxBKq82PXTvo=;
        b=G3cUw9vPiE5Mk+RhnyRbVTW7EJf5nzLBe6bv41QvL9KXDrGYSAlgJcnHM+N5DQ+G9A
         xgyEro3raVrzqySZXSjIDQxq0fuiun7VYrVZypBBmwXsfv5udvLtZRpKHiL5EmiY2SJn
         PmCAxba6kQgfXfTZ5u6RURrtEG3Uf9prJYIzCCOMXyVeGypnWrUdt40OysvCqU4X5FvB
         Il7/R+t/8UTyBsBxRTDx0WEnIu1OIJwDUVVBLDLWYNd7Gd2DGqtL8cTcgaicJ9maLKOJ
         zFDDDTVYZfAnRILaPoVEcrLwLRcRa+VAqZvIfgHwXHNFYHqlBp7mAbEE7EdVd+g/52zX
         iwDw==
X-Gm-Message-State: AOAM531d+3QN4045wmQc2iDMg01tEzeeTBFoXc3O5zK5AEmiubNTnFnE
        SzxxTI7CGdFYMXHP+1H0GK94h8L8OCdCEQ==
X-Google-Smtp-Source: ABdhPJy6z+T8J40xbjExBNYS8Y9q4udGB8z2zBL7nu1kDzTux9CXKOkoYRec23QHBxJqQMEvB0+BBA==
X-Received: by 2002:a05:6402:128d:: with SMTP id w13mr52480974edv.1.1626941411452;
        Thu, 22 Jul 2021 01:10:11 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id w2sm11922186edx.58.2021.07.22.01.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 01:10:10 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH 2/5] [GSOC] ref-filter: add %(raw) atom
Date:   Thu, 22 Jul 2021 10:06:21 +0200
References: <pull.1000.git.1626939557.gitgitgadget@gmail.com>
 <ecd41b370e62cc88f1606569ec700eaca837fa1f.1626939557.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <ecd41b370e62cc88f1606569ec700eaca837fa1f.1626939557.git.gitgitgadget@gmail.com>
Message-ID: <877dhivkei.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 22 2021, ZheNing Hu via GitGitGadget wrote:

> [..] add a new member in
> `struct atom_value`: `s_size`, which can record raw object size, it
> can help us add raw object data to the buffer or compare two buffers
> which contain raw object data.

I didn't look in detail, just one nit/comment, no need to re-roll for this:


>  struct atom_value {
>  	const char *s;
> +	size_t s_size;
>  	int (*handler)(struct atom_value *atomv, struct ref_formatting_state *state,
>  		       struct strbuf *err);
>  	uintmax_t value; /* used for sorting when not FIELD_STR */
>  	struct used_atom *atom;
>  };
>  
> +#define ATOM_VALUE_S_SIZE_INIT (-1)
> +

This and then later doing (this appears to be the only initialization?):

>  	if (format->need_color_reset_at_eol) {
>  		struct atom_value resetv;
> +		resetv.s_size = ATOM_VALUE_S_SIZE_INIT;
>  		resetv.s = GIT_COLOR_RESET;
>  		if (append_atom(&resetv, &state, error_buf)) {
>  			pop_stack_element(&state.stack);

Is a rather unusual pattern, more typical would be:

	struct atom_value { .... }
	#define ATOM_VALUE_INIT { \
		.s_size = -1, \
	}

Then:

	struct atom_value resetv = ATOM_VALUE_INIT;

You could keep that "#define ATOM_VALUE_S_SIZE_INIT (-1)" to check the
init value, personally I think it's just fine to hardcode the -1 literal
and do "size < 0" checks, which we us as convention in a lot of other
places for "not initialized".
