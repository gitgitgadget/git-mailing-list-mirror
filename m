Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6F771F461
	for <e@80x24.org>; Wed, 28 Aug 2019 09:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfH1JeO (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 05:34:14 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40333 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfH1JeO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 05:34:14 -0400
Received: by mail-wm1-f65.google.com with SMTP id t9so928740wmi.5
        for <git@vger.kernel.org>; Wed, 28 Aug 2019 02:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZbgjBUAGA4sWscanYyjdn+WpWhXQg+bNUj6kb793u0s=;
        b=nOuu7jKHC2iYnLmz115ejnTi+riEmmPaF1v9BmRnyAIffWyU4WjSNHn6+8A84tkvJe
         XK1JwIJlZ3tJH8UrmxenVLECCDZJ/vbSoKNVHeB8rNxZmmE0ga+kgEOXTu8jbOvNocto
         a58TN2rxx/l5nTUG27d5gDgymFClx0C/uo0UiUJT8f7IBWYAGcHeoW/2UGCA1Eyi9/Lh
         5XVSDDbMls8YHxav6MrADcjq5+ZvyzDp5wxZjZWLlkeWdGebV0qNqsEi92L4YxZSMuiT
         VjpmTIHhZwv+HKarD7Qa2JF41g7x8GSAXNThsB4pIc4UdoJP1XecHd48ckc1JjNgFlP2
         fqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZbgjBUAGA4sWscanYyjdn+WpWhXQg+bNUj6kb793u0s=;
        b=R4Gq7lVHszz0T5VDkRGhWtXH0VX4JCG63aq4NiXRP+Cn2T7rPSX/5bo4X7GdvwwE5Q
         GEtnGOJCeBgjKHf6/otYC5lTLsJBtv2KV9GFxOVOVX4F4OAus1E1/7ZKTOQKaW/TlfPn
         eW8AWkM8uDB6ekdXowVOYL8GNDgUVDd/t8HpoumHOcxXsz4LgFVvOxIqsn0tDidGV7Ll
         CaVphB9lRjI+zlq+DeJBDND+K/7IuynmOwLuhIui82BhsLhDqJSDONviGhXi3iNfP9ZG
         Nonlf8pny//jQJcD6sPuHFrQ/PlDQtPUmheAl1KAt3mYccUQlAajTH99OMAPDFMKX/Qb
         w4yQ==
X-Gm-Message-State: APjAAAUN3O25q8DfGmJa6yrZ/ABQgu8iDX9QFOax80++Gt4ohkA6LYfQ
        FIPVsFZnFGWun6tnbgWltBc=
X-Google-Smtp-Source: APXvYqwRCtgyjTtwy55f+N67Q6vaL38Ctcyk8GFB0LJMHm4oYOV1y9J2HKVGT0xH9wYuF8Gtih57bw==
X-Received: by 2002:a7b:cb89:: with SMTP id m9mr3815025wmi.50.1566984851295;
        Wed, 28 Aug 2019 02:34:11 -0700 (PDT)
Received: from szeder.dev (x4db66bea.dyn.telefonica.de. [77.182.107.234])
        by smtp.gmail.com with ESMTPSA id b15sm1432079wrt.77.2019.08.28.02.34.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 02:34:10 -0700 (PDT)
Date:   Wed, 28 Aug 2019 11:34:08 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/1] upload-pack: fix race condition in error messages
Message-ID: <20190828093408.GD8571@szeder.dev>
References: <pull.324.git.gitgitgadget@gmail.com>
 <5c313aba7e97cb93e7d07f6d5dfaf0febe8a2f8b.1566956608.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5c313aba7e97cb93e7d07f6d5dfaf0febe8a2f8b.1566956608.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 27, 2019 at 06:43:29PM -0700, Derrick Stolee via GitGitGadget wrote:
> Test t5516-fetch-push.sh has a test 'deny fetch unreachable SHA1,
> allowtipsha1inwant=true' that checks stderr for a specific error
> string from the remote. In some build environments the error sent
> over the remote connection gets mingled with the error from the
> die() statement. Since both signals are being output to the same
> file descriptor (but from parent and child processes), the output
> we are matching with grep gets split.

In the spirit of "An error message is worth a thousand words", I think
it's worth to include the error message causing the failure:

  error: 'grep not our ref.*64ea4c133d59fa98e86a771eda009872d6ab2886 err' didn't find a match in:
  fatal: git upload-pack: not our ref 64ea4c13fatal: remote error: upload-pack: not our ref 63d59fa98e86a771eda009872d6ab2886
  4ea4c133d59fa98e86a771eda009872d6ab2886
  error: last command exited with $?=1

I tried to reproduce this specific error on Linux and macOS, but
couldn't yet.

> To reduce the risk of this failure, follow this process instead:

Here you talk about reducing the risk ...

> 1. Write an error message to stderr.
> 2. Write an error message across the connection.
> 3. exit(1).
> 
> This reorders the events so the error is written entirely before
> the client receives a message from the remote, removing the race
> condition.

... but here you talk about removing the race condition.

I don't understand how this change would remove the race condition.
After all, the occasional failure is caused by two messages racing
through different file descriptors, and merely sending them in reverse
order doesn't change that they would still be racing.

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  upload-pack.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/upload-pack.c b/upload-pack.c
> index 222cd3ad89..b0d3e028d1 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -613,11 +613,12 @@ static void check_non_tip(struct object_array *want_obj,
>  	for (i = 0; i < want_obj->nr; i++) {
>  		struct object *o = want_obj->objects[i].item;
>  		if (!is_our_ref(o)) {
> +			warning("git upload-pack: not our ref %s",
> +				oid_to_hex(&o->oid));
>  			packet_writer_error(writer,
>  					    "upload-pack: not our ref %s",
>  					    oid_to_hex(&o->oid));
> -			die("git upload-pack: not our ref %s",
> -			    oid_to_hex(&o->oid));
> +			exit(1);


So, the error coming from the 'git fetch' command in question
currently looks like this:

  fatal: git upload-pack: not our ref 64ea4c133d59fa98e86a771eda009872d6ab2886
  fatal: remote error: upload-pack: not our ref 64ea4c133d59fa98e86a771eda009872d6ab2886

Changing die() to a warning() changes the prefix of the message from
"fatal:" to "warning:", i.e. with this patch I got this:

  warning: git upload-pack: not our ref 64ea4c133d59fa98e86a771eda009872d6ab2886
  fatal: remote error: upload-pack: not our ref 64ea4c133d59fa98e86a771eda009872d6ab2886

I don't think that "demoting" that message from fatal to warning
matters much to users, because they would see the (arguably redundant)
second line starting with "fatal:".

As for the problematic test, it checks this error with:

  test_i18ngrep "remote error:.*not our ref.*$SHA1_3\$" err

so changing that prefix shouldn't affect the test, either.


Unfortunately, however, while running './t5516-fetch-push.sh -r 1,79
--stress' to try to reproduce a failure caused by those mingled
messages, the same check only failed for a different reason so far
(both on Linux and macOS (on Travis CI)):

  error: 'grep remote error:.*not our ref.*64ea4c133d59fa98e86a771eda009872d6ab2886$ err' didn't find a match in:
  fatal: git upload-pack: not our ref 64ea4c133d59fa98e86a771eda009872d6ab2886
  fatal: unable to write to remote: Broken pipe
  error: last command exited with $?=1

And with this patch:

  error: 'grep remote error:.*not our ref.*64ea4c133d59fa98e86a771eda009872d6ab2886$ err' didn't find a match in:
  warning: git upload-pack: not our ref 64ea4c133d59fa98e86a771eda009872d6ab2886
  fatal: unable to write to remote: Broken pipe
  error: last command exited with $?=1

We could make the test pass by relaxing the 'grep' pattern to look
only for 'not our ref.*<SHA...>', but I doubt that ignoring a broken
pipe is a such good idea.

