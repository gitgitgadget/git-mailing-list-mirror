Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C56BD208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 22:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbeHHAx4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 20:53:56 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55540 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbeHHAx4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 20:53:56 -0400
Received: by mail-wm0-f67.google.com with SMTP id f21-v6so673146wmc.5
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 15:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5o5YbONbmhvpQJs/wE62rT1DBnE/CnxgdFLDIJoncA0=;
        b=s0s6/Zi1GPpvuzoxq+AMqP1T7Lkldm2x24W44eW88FSjJJTTPjujfK+yrbXB7FMdeK
         5CmlJ6mTYA0X/hPLL5MoWPxGI336ZYUQ83qkx3oU2jyJyScG4zAUKRJSetNVrDz+ojWP
         KZ8At6zhVCibpGKLwMvFQtgtVitbN/dlIAXjOTC2JZ5bt/bEWO3t8xRWgg9r1E5eizJK
         Uu+ly1CIZE3ugtFXnvSZGON/IebmIZeJR6bvBKtDMShj4B3wvPI3gv9gzdXSjZJHIbOJ
         xR+7v2vbNBgmJdbNntwoK7Dmnc+5i4NHaMVU1l2I+0vgX/ZxowyYCwODmgYy3qgm9979
         raeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5o5YbONbmhvpQJs/wE62rT1DBnE/CnxgdFLDIJoncA0=;
        b=HiX8N6o/bA3ZqZnkaqqE+2P0/Bi74hQmxchCGXSxAcGsDJTA4tfLo+mMkoYdj86kEU
         7fRbtJJS+4n9bOAVxp54TOsCdaS2hNPljxFc8SDUR5QwTTTpsn/fAalnBn3Az0s0G0hH
         XNUYBSIbCJbGPYbc1K79zx1l0JZHKsug2TOxh8/0l/gyv4SsqwfL65DUHkM57sxechOM
         mv9FrtoXcs0hANPWU1hltoCiAbtcODd6IUagLpBpw6Yc+HPjM2TGYB24UiM1tiC5PR+j
         EmsBXe/skc2zHCwp74SFnEO6niYG1I7fKtl52E63+uwldepuo1Gtt9zA7LVnC911mBZa
         8iDQ==
X-Gm-Message-State: AOUpUlFr2z18efRtz7RHSMa/lks6Y9ICO0+fi+WC51ahsGWNzzJ1Pore
        slm+UUUjZV0/QN+NMYjk99o=
X-Google-Smtp-Source: AA+uWPzw+DF4hNqPwHJo8+eY3/PqknEmAxozrBtfTSZHco3A3TOs83f3AvDCtpCSg2IFgVBHZ3TqmQ==
X-Received: by 2002:a1c:5d55:: with SMTP id r82-v6mr177501wmb.152.1533681440647;
        Tue, 07 Aug 2018 15:37:20 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g15-v6sm2439268wrh.48.2018.08.07.15.37.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 15:37:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 2/2] repack: repack promisor objects if -a or -A is set
References: <cover.1533672584.git.jonathantanmy@google.com>
        <61396b2a73a801f62818ad3b691f75170d2e3919.1533672584.git.jonathantanmy@google.com>
Date:   Tue, 07 Aug 2018 15:37:18 -0700
In-Reply-To: <61396b2a73a801f62818ad3b691f75170d2e3919.1533672584.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Tue, 7 Aug 2018 13:12:32 -0700")
Message-ID: <xmqq7el1kdlt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> @@ -293,6 +346,9 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  	if (pack_everything & ALL_INTO_ONE) {
>  		get_non_kept_pack_filenames(&existing_packs, &keep_pack_list);
>  
> +		if (repository_format_partial_clone)
> +			repack_promisor_objects(&po_args, &names);
> +
>  		if (existing_packs.nr && delete_redundant) {
>  			if (unpack_unreachable) {
>  				argv_array_pushf(&cmd.args,

Just a note (and a request-for-sanity-check) and not meant to be a
request to update the code, but with a still-in-pu 4b757a40 ("Use
remote_odb_get_direct() and has_remote_odb()", 2018-08-02) in
flight, repository_format_partial_clone is now gone.

I've tentatively resolved the above to read like so:

		if (has_remote_odb())
			repack_promisor_objects(&po_args, &names);

but I am not sure if it makes sense to always require odb helper to
be present for any promisor.  As long as you do not have need to
actually access these missing objects, you do not need any remote
odb access at all, in which case requiring has_remote_odb() as a
precondition to concatenate the promisor packs to coalesce them into
one pack does not make sense---you only want to know if there are
any .promisor packs.

In other words, I suspect that the world is not black (i.e. partial
clone, which always has remote-odb) and white (i.e. full repository,
without remote-odb).  4b757a40 makes it impossible to have a gray
(i.e. partial clone, but no access to remote-odb), which I am not
sure if it is a good thing.
