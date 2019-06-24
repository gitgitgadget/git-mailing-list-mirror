Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 108E21F4B6
	for <e@80x24.org>; Mon, 24 Jun 2019 09:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbfFXJbD (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 05:31:03 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:37775 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfFXJbD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 05:31:03 -0400
Received: by mail-wm1-f49.google.com with SMTP id f17so12607753wme.2
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 02:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=TVb2CUOYq4YNFBsYgeNW0Pa8KO/DqfZN9DvkBhh5hP8=;
        b=a0C9AhTfMtea6AuCE75phk71gZ1WDzSVvuidpb1e99mKRwU+WnNdyzD/uweiSY1iLF
         cvl9U3iHUMOOGN8YYOPCIXmScOXVlWGqsyJsHerDAsYkvNCRpbX5LGAa23aG46SEmeyN
         C7knymSjJL83E1eNGRHYry7YPcJp573ROCWGkWihUBhg7KjxdeVLPDK4tbv+xoOoFInv
         R4hpk+LLcs3MOZk+ZH6Xylgts0p6s8ftLHRXZDtLY5+pHnceVHuGmFeOF84E0THQwRUa
         M+LZFiI2K5BPOZDS6X13M25fxRp9rmtOGSwioDweLPrFceFDFOoOQN7MWeZ9Vmto/T9R
         5KnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=TVb2CUOYq4YNFBsYgeNW0Pa8KO/DqfZN9DvkBhh5hP8=;
        b=W2HvXYS+kN62LHxurzZbEaBNyM5kEtuVoZ0aqGjNU5R4ePM80vQDHs5YW9MDo7G/KA
         hX4XDKK+kHxgq6SK5TZO6BwgLxsSJWR6pDfC3GNOJgzElaU+HuwaEsX8SIgx63OJzO0l
         Ay7yJRBAhLBOK7eYJQfNIbWwcinKCqfIOtsvr83OEWCScX3oCaaZrfbRcGKv3PfYGSVL
         O/XPdlhI+b1I9k4k6bGno4hFhyx0vCaUzTUqDn9Mg6Oag2ZnAJosxTpDQuiJOHqmT5fB
         sVKJ5xyaz9KbXOzSAiNjdybw6cbfip+Pd788twORwwQZYSJLAgzXzj/248XwC8uJJDNa
         TJ5g==
X-Gm-Message-State: APjAAAWgleNR+WtFpvOsWYfEU7I8OJtM1rTm6ZCWDCp58prESNmwKBaL
        NhPxuT9nyyaEiaPC2AYfGIg=
X-Google-Smtp-Source: APXvYqzs8EPkcpF2Bfb6Oa3XNolIsGnj1HEVpvffjBzviDX5rBcTP5UKtovDQbUUDIVfnI9eMr/JvA==
X-Received: by 2002:a7b:cc97:: with SMTP id p23mr15649759wma.120.1561368660759;
        Mon, 24 Jun 2019 02:31:00 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id 5sm23324478wrc.76.2019.06.24.02.30.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 02:31:00 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Wong <e@80x24.org>, Janos Farkas <chexum@gmail.com>,
        git@vger.kernel.org
Subject: Re: 2.22.0 repack -a duplicating pack contents
References: <CAEXt3sqno7RAtuwQ_OpD3aLkEORLaf6aNeNKGQL0BKezD+wWTw@mail.gmail.com> <875zow8i85.fsf@evledraar.gmail.com> <20190623180226.GA1100@sigill.intra.peff.net> <20190623180825.3ospajjgat3clwiu@dcvr> <20190623224244.GB1100@sigill.intra.peff.net>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190623224244.GB1100@sigill.intra.peff.net>
Date:   Mon, 24 Jun 2019 11:30:59 +0200
Message-ID: <874l4f8h4c.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 24 2019, Jeff King wrote:

> On Sun, Jun 23, 2019 at 06:08:25PM +0000, Eric Wong wrote:
>
>> > I'm not sure of the right solution. For maximal backwards-compatibility,
>> > the default for bitmaps could become "if not bare and if there are no
>> > .keep files". But that would mean bitmaps sometimes not getting
>> > generated because of the problems that ee34a2bead was trying to solve.
>> >
>> > That's probably OK, though; you can always flip the bitmap config to
>> > "true" yourself if you _must_ have bitmaps.
>>
>> What about something like this?  Needs tests but I need to leave, now.
>
> Yeah, I think that's the right direction.
>
> Though...
>
>> +static int has_pack_keep_file(void)
>> +{
>> +	DIR *dir;
>> +	struct dirent *e;
>> +	int found = 0;
>> +
>> +	if (!(dir = opendir(packdir)))
>> +		return found;
>> +
>> +	while ((e = readdir(dir)) != NULL) {
>> +		if (ends_with(e->d_name, ".keep")) {
>> +			found = 1;
>> +			break;
>> +		}
>> +	}
>> +	closedir(dir);
>> +	return found;
>> +}
>
> I think this can be replaced with just checking p->pack_keep for each
> item in the packed_git list.
>
> That's racy, but then so is your code here, since it's really the child
> pack-objects which is going to deal with the .keep. I don't think we
> need to care much about the race, though. Either:
>
>   1. Somebody has made an old intentional .keep, which would not be
>      racy. We'd see it in both places.
>
>   2. Somebody _just_ made an intentional .keep; we'll race with that and
>      maybe duplicate objects from the kept pack. But this is a rare
>      occurrence, and there's no real ordering promise here anyway with
>      somebody creating .keep files alongside a running repack.
>
>   3. An incoming fetch/push may create a .keep file as a temporary lock,
>      which we see here but which goes away by the time pack-objects
>      runs. That's OK; we err on the side of not generating bitmaps, but
>      they're an optimization anyway (and if you really insist on having
>      them, you should tell Git to definitely make them instead of
>      relying on this default behavior).

This sort of thing (#3) strikes me as a fairly pathological case we
should try to avoid. Now what we've turned on bitmaps by default people
will take the sort of performance increase noted in [1] for granted.

So they'll be happily running with that & then get a CPU/IO spike as the
*.bitmap files they'd been implicitly relying on for years in their
default config goes away, only to have it re-appear when "repack" runs
next.

I can't think of some great solution for this case, some thoughts:

 a. Perhaps we should split the *.keep flag into two things or
    more.

    We're using it for all of "I want this *.pack forever"
    (e.g. debugging) and "I want only this *.pack to contain the data
    found in it" (I/O & CPU optimization, what Janos wants) and "I'm
    git.git code avoiding a race with myself" (what you describe in #3).

    So maybe for the last of those we could also use and understand
    *.tmp-keep, at which point we wouldn't have this race described in
    #3. The 1st of those is a *.noprune and the 2nd is *.highlander (but
    whether it's worth splitting all that out v.s. just having
    *.tmp-keep is another matter).

 b) Shouldn't we at least print some warning to STDERR in this case so
    e.g. gc.log will note the performance degradation of the repo in its
    current configuration?

>   4. Like (3), but we _don't _see the temporary .keep here but _do_ see
>      it during pack-objects. That's OK, because we'll have told
>      pack-objects to pack those objects anyway, which is the right
>      thing.
>
> -Peff

1. https://github.blog/2015-09-22-counting-objects/
