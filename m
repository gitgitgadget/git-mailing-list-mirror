Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A3E5208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 23:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751561AbdHRXdQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 19:33:16 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34214 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751107AbdHRXdP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 19:33:15 -0400
Received: by mail-pg0-f47.google.com with SMTP id n4so9291776pgn.1
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 16:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J5sRjvVb9Va4E8vBvjcqzh31dt00TumKt4L0rUOyJvU=;
        b=HeZ9nelHjKAxt7iBU88mJJT9PZIliYtyzp2u95aB4Jnb8q8m46zi2irYcw2g2Ki7dI
         FZvZ1vK/1Z98J4eUWBrZDXeXOMCO2xzy9LV2PRapksVd0wpHJVYlPKZIL2y9jokL1vI/
         IzdssD4TXkZ352tn6eQzd/RYiBPwD8JYSskrxX2zfkOnu0vjyMHgNvEgW2gjE1QzodRI
         Y6DI2XGCFEndSNmYFJxBlMiuHzI4Y1sef/pi5SrLKlJQViZyIK2RJdfxPoy2HsciKOxY
         L6p8nQnJtlIobtLIYwEN01t/FTVcUhVjKkAJCU24adu64OrWogI43ylsvha6dFoRcKiq
         OxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J5sRjvVb9Va4E8vBvjcqzh31dt00TumKt4L0rUOyJvU=;
        b=nkon0hMAc5UjpWpiQkRhhr6iVs6iPv70rnnODprd7FI0oy42NRHmHWYw1Iy/LeofT9
         E0nmvF12OAYNI1/TKtsFsRVXImnZv60qNbSypQMXH6wi6AXqbz2m8ibfpJQUdv1glybT
         WjuXAqos8WwggGdmr3Y9egovrQwCmFYgaPeuIqVgfOsK40hddS156bOK/5p/7gv1h7Sl
         vke3atOw02jRuxMdCpS5k2TqGiUKJnsIlbCBAvzuS71abR6zWPE544gHO3Ynie8PhBuO
         BYy4JQmaBiIbZpPXHJWPjvmZMspN6yY+pw6X3XH01G3yR7CZvxIwiTdsr6E5psZk5LeI
         elww==
X-Gm-Message-State: AHYfb5jKOzeMx6MKIvZj37vgqhI9RNBxsCD2ukb5v0vaZpoo/LxPzYuO
        2pckUc9Ragq0tkMc
X-Received: by 10.99.178.73 with SMTP id t9mr9884860pgo.34.1503099194482;
        Fri, 18 Aug 2017 16:33:14 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:ecbe:10b8:47b2:41c3])
        by smtp.gmail.com with ESMTPSA id 17sm13672143pfp.157.2017.08.18.16.33.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 18 Aug 2017 16:33:14 -0700 (PDT)
Date:   Fri, 18 Aug 2017 16:33:11 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        jrnieder@gmail.com
Subject: Re: [RFC PATCH] Updated "imported object" design
Message-ID: <20170818163311.3bef1da7@twelve2.svl.corp.google.com>
In-Reply-To: <78139f5c-a044-9c00-11ff-eb91a70b6ab9@gmail.com>
References: <20170804145113.5ceafafa@twelve2.svl.corp.google.com>
        <20170816003200.19992-1-jonathantanmy@google.com>
        <xmqqa82zjlt4.fsf@gitster.mtv.corp.google.com>
        <20170816143515.0a74f959@twelve2.svl.corp.google.com>
        <c6787a0b-ba7c-106a-66bd-5c2d38752ccb@gmail.com>
        <20170817143905.2ef872e6@twelve2.svl.corp.google.com>
        <78139f5c-a044-9c00-11ff-eb91a70b6ab9@gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 18 Aug 2017 10:18:37 -0400
Ben Peart <peartben@gmail.com> wrote:

> > But if there was a good way to refer to the "anti-projection" in a
> > virtualized system (that is, the "real" thing or "object" behind the
> > "virtual" thing or "image"), then maybe the "virtualized" language is
> > the best. (And I would gladly change - I'm having a hard time coming up
> > with a name for the "anti-projection" in the "lazy" language.)
> > 
> 
> The most common "anti-virtual" language I'm familiar with is "physical." 
>   Virtual machine <-> physical machine. Virtual world <-> physical 
> world. Virtual repo, commit, tree, blob - physical repo, commit, tree, 
> blob. I'm not thrilled but I think it works...

I was thinking more along the lines of the "entity that projects the
virtualization", not the opposite of a "virtualization" - "physical"
might work for the latter but probably not the former.

After some in-office discussion, if we stick to the "promise" concept,
maybe we have something like this:

  In a partial clone, the origin acts as a promisor of objects. Every
  object obtained from the promisor also acts as a promise that any
  object directly or indirectly referenced from that object is fetchable
  from the promisor.

> > This is not true if you're fetching from another repo 
> 
> This isn't a case we've explicitly dealt with (multiple remotes into a 
> virtualized repo).  Our behavior today would be that once you set the 
> "virtual repo" flag on the repo (this happens at clone for us), all 
> remotes are treated as virtual as well (ie we don't differentiate 
> behavior based on which remote was used).  Our "custom fetcher" always 
> uses "origin" and some custom settings for a cache-server saved in the 
> .git/config file when asked to fetch missing objects.
> 
> This is probably a good model to stick with at least initially as trying 
> to solve multiple possible "virtual" remotes as well as mingling 
> virtualized and non-virtualized remotes and all the mixed cases that can 
> come up makes my head hurt.  We should probably address that in a 
> different thread. :)

OK, let's stick to the current model first then, whether our opinion on
other remotes is (1) "we won't have any other remotes so we don't care",
(2) "we have other remotes but it's fine to make sure that they don't
introduce any new missing objects", or (3) "we need other remotes to
introduce missing objects, but we can build that after this foundation
is laid".

> > or if you're using
> > receive-pack, but (1) I think these are not used as much in such a
> > situation, and (2) if you do use them, the slowness only "kicks in" if
> > you do not have the objects referred to (whether non-"imported" or
> > "imported") and thus have to check the references in all "imported"
> > objects.
> > 
> 
> Is there any case where receive-pack is used on the client side?  I'm 
> only aware of it being used on the server side to receive packs pushed 
> from the client.  If it is not used in a virtualized client, then we 
> would not need to do anything different for receive-pack.

This happens if another repo decides to push to the virtualized client,
which (as I wrote) I don't expect to happen often. My intention is to
ensure that receive-pack will still work.

> That is another good point.  Given the discussion above about not 
> needing to do the connectivity test for fetch/clone - the potential perf 
> hit of loading/parsing all the various objects to build up the oidset is 
> much less of an issue.

Agreed.
