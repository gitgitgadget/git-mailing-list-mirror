Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 634AA1F404
	for <e@80x24.org>; Tue, 13 Feb 2018 16:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965142AbeBMQwy (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 11:52:54 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35468 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965120AbeBMQww (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 11:52:52 -0500
Received: by mail-pg0-f65.google.com with SMTP id l131so256697pga.2
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 08:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gamjQm3GoL0ffMC5VFjs7aBlJndMdbQkYpCcJh+9Njc=;
        b=BQaewSeji07UfQ5nG5+1sZrFC5F9nCKiGdTrl3ktmZBWTlkO/Z+PxMKa7gwJu3+1Ns
         5rn2DExQdH6xInib0DVJexCMSamiQZZY9YqdK4F5VMgu7UaDdhk/oko4E8DC1CLX5HJb
         KdTjBEKrqm+bfBrf4BkP6nX+mhGskp/QAzUcbPKeZvsIf6oqB95M5R5l04F9DVoJS/l/
         YgvGqCBjaij48rSVsw4UtwdBQ/tsld/dPjRnC9VznSOXx1xRfLOnduJ6vXAtfLHbtMpf
         JAoZU3Ci2S2fyM3+j3SkP1cDUDgW7jgTjqNHYBQOVUaXuKtLefpaZt9VIIh6z2nbxSZ1
         AQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gamjQm3GoL0ffMC5VFjs7aBlJndMdbQkYpCcJh+9Njc=;
        b=d9FD85W4311sDLGD2f5fLQZopBz+rONQMEpml3UyIPDj1CbXE4zxTDj5JqdNCmWPAi
         wdxMboQWoPuk81kO318GCYCmqlYjm1mOleLGjyFdsIPOhJ0p0I+hyXU5bQV9O/Tsn1zS
         ccRALSIMakoQrY58lBPKegG0gD5N13Cl2Eg7z7ZUdnb+D+wx0zYkbtJv1jtlWeyWOh8E
         HKjr0K1M1fv7DcTgqTLRKi6ogg35panx+BNLNl46Nw3jKuc1MisyqzpX9zx2vnbKspUk
         /vtW2l/qGuVbOak1gxMvnXC/BfbbCxdEFvAYVWE4fqMYiwN+lqEsRZjbbhn1vu99wHEx
         xpWg==
X-Gm-Message-State: APf1xPDfARnbikna06u2o6lai1F90ZwoMiyvkvoWVbcwHfRwdw9s/wi+
        OKnbIBK48qI8UrI8BYy/g531wQ==
X-Google-Smtp-Source: AH8x227VvJ/wQfBYJr2fF7T/MsNeONHbws6UrSUkqN06UI8lxRw5OO9VRZ7cBO3n+o3ls9uoDGPFuw==
X-Received: by 10.101.70.69 with SMTP id k5mr1500347pgr.61.1518540772118;
        Tue, 13 Feb 2018 08:52:52 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id k7sm25880704pgt.20.2018.02.13.08.52.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Feb 2018 08:52:51 -0800 (PST)
Date:   Tue, 13 Feb 2018 08:52:49 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 00/26] Moving global state into the repository object
 (part 1)
Message-ID: <20180213165249.GB209601@google.com>
References: <20180213012241.187007-1-sbeller@google.com>
 <20180213114903.GA21015@ash>
 <CACsJy8C8+VnjrhEh3o36GUttZXmfiKxqjzS=2LzmfZKQjogojQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8C8+VnjrhEh3o36GUttZXmfiKxqjzS=2LzmfZKQjogojQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/13, Duy Nguyen wrote:
> On Tue, Feb 13, 2018 at 6:49 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> > On Mon, Feb 12, 2018 at 05:22:15PM -0800, Stefan Beller wrote:
> >> This is a real take on the first part of the recent RFC[1].
> >>
> >> ...
> >>
> >> Duy suggested that we shall not use the repository blindly, but
> >> should carefully examine whether to pass on an object store or the
> >> refstore or such[4], which I agree with if it makes sense. This
> >> series unfortunately has an issue with that as I would not want to
> >> pass down the `ignore_env` flag separately from the object store, so
> >> I made all functions that only take the object store to have the raw
> >> object store as the first parameter, and others using the full
> >> repository.
> >
> > Second proposal :) How about you store ignore_env in raw_object_store?
> > This would not be the first time an object has some configuration
> > passed in at construction time. And it has a "constructor" now,
> > raw_object_store_init() (I probably should merge _setup in it too)
> 
> A bit more on this configuration parameters. Down the road I think we
> need something like this anyway to delete global config vars like
> packed_git_window_size, delta_base_cache_limit...  Either all these
> end up in raw_object_store, or raw_object_store holds a link to
> "struct config_set".
> 
> The ignore_env specifically though looks to me like a stop gap
> solution until everything goes through repo_init() first. At that
> point we don't have to delay getenv() anymore. We can getenv() all at
> repo_init() then pass them in raw_object_store and ignore_env should
> be gone. So sticking it inside raw_object_store _temporarily_ does not
> sound so bad.

I like this approach, I mean at the moment we are replicating a single
bit of data but that allows us to be able to limit the scope of where a
repository struct is passed, giving us a better abstraction layer.

> -- 
> Duy

-- 
Brandon Williams
