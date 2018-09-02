Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08CAC1F404
	for <e@80x24.org>; Sun,  2 Sep 2018 07:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbeIBMIs (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Sep 2018 08:08:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34076 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbeIBMIs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Sep 2018 08:08:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id g33-v6so14848354wrd.1
        for <git@vger.kernel.org>; Sun, 02 Sep 2018 00:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Jz4eEoEYH8t/MFcl+kAiTkh7CIiOTCjl/U2NmgVAjx0=;
        b=BivVSJkufxEwA8qFDboHqIJL9/3F0mLm6Ofweao0uNjFHt1SlvmEovkjMyRVXQokBX
         GtNyzUUKTXgRmXOw7irVKJIGGWCyCj9oTrqkz1Dt44515rsBD6Op3UDUorjYOvGl626B
         ggaXpM+aXf01tPpKNkhzvnE1+v2YG95xgJtLDAwcvbuKeq44v5ECTx5w+IEL2JoZy78G
         oBG9dAZK6GbxDaUIOypA8JKC65A4a8lmM1yWcebBqkgFyKrW88+8ujYZocFdYMJDQXVk
         kdq0j49Dz7qCzB+glPeZu3lzPzSXwI2Ft/GExPQJKAT6yWyQhTpMU7G1RP25h3F8610C
         OSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jz4eEoEYH8t/MFcl+kAiTkh7CIiOTCjl/U2NmgVAjx0=;
        b=CD0ILeLPyCAcoc/zu1s/vbLDEAUH5z4QSDuczCQSjpyorgXdi4Ri/o4lCgtyzGTYII
         jr/dXivCbqWpr9zm1d7bN/jQJiRcMZ8gQ/IiPq6M6nuo5iuiotBREFt1ftw5w8AH3u9b
         sttKeWXlw3Je1Vfe03iFTYnRcipzX3SdAndAhfv4yv5a2xh5CmUqpkm+ihrNioeX7+78
         C3eeAnMXaRVp8X0pd5MlT6R7i348qL5PLAA0T5uvDkFXC6ClZzooUMdtv3IKFkNKgt9B
         dY7Lgf+svy14rMoNuEnEwz4pYvuqLkbPz6rdoBKi1mOymDpVo+tQ53F7nnre1O+vo9+L
         jMyg==
X-Gm-Message-State: APzg51C0x6WPerIyyVXeK52MkkoSF+d3eOyTWpgclToSM2ZzPeGkTojv
        qfJp7SepcL4LH6mOAy9mNiE=
X-Google-Smtp-Source: ANB0Vdbn//zdtHz2ov0jVE3c3dCi/vqSMk300v6tm1579n0x8c3dW7ETNSVmX0N7V/i5dszYmUt71Q==
X-Received: by 2002:a5d:4512:: with SMTP id s18-v6mr16450798wrq.82.1535874835155;
        Sun, 02 Sep 2018 00:53:55 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:4006:df00:35fa:ab91:ab14:2e07])
        by smtp.gmail.com with ESMTPSA id o3-v6sm11202838wrn.58.2018.09.02.00.53.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Sep 2018 00:53:54 -0700 (PDT)
Date:   Sun, 2 Sep 2018 09:53:53 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Kevin Willford <kewillf@microsoft.com>
Subject: Re: [BUG] index corruption with git commit -p
Message-ID: <20180902075351.lkfnekklnwot7lzf@ltop.local>
References: <20180901214157.hxlqmbz3fds7hsdl@ltop.local>
 <87tvn8c166.fsf@evledraar.gmail.com>
 <20180902050803.GA21324@sigill.intra.peff.net>
 <20180902071204.GA2868@duynguyen.home>
 <20180902072408.GA18787@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180902072408.GA18787@sigill.intra.peff.net>
User-Agent: NeoMutt/20180622
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 02, 2018 at 03:24:09AM -0400, Jeff King wrote:
> On Sun, Sep 02, 2018 at 09:12:04AM +0200, Duy Nguyen wrote:
> > diff --git a/builtin/commit.c b/builtin/commit.c
> > index 2be7bdb331..60f30b3780 100644
> > --- a/builtin/commit.c
> > +++ b/builtin/commit.c
> > @@ -432,6 +432,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
> >  		if (update_main_cache_tree(WRITE_TREE_SILENT) == 0) {
> >  			if (reopen_lock_file(&index_lock) < 0)
> >  				die(_("unable to write index file"));
> > +			ftruncate(index_lock.tempfile->fd, 0);
> >  			if (write_locked_index(&the_index, &index_lock, 0))
> >  				die(_("unable to update temporary index"));
> >  		} else
> 
> Doh, of course. I even thought about this issue and dug all the way into
> reopen_lock_file(), but for some reason temporarily forgot that O_WRONLY
> does not imply O_TRUNC.
> 
> Arguably this should be the default for reopen_lockfile(), as getting a
> write pointer into an existing file is not ever going to be useful for
> the way Git uses lockfiles. Opening with O_APPEND could conceivably be
> useful, but it's pretty unlikely (and certainly not helpful here, and
> this is the only caller). Alternatively, the function should just take
> open(2) flags.
> 
> At any rate, I think this perfectly explains the behavior we're seeing.

Yes, this certainly make sense.

For fun (and testing) I tried to take the problem in the other direction:
* why hasn't this be detected earlier (I'm reasonably be sure I did the
  same operation a few times already without seeing the corruption)?
* how easy it is to reproduce the problem?
* Is it enough to do an interactive commit with nothing needing interactive?

So I tried the following and some variants:
  > for i in $(seq -w 0 100); do echo $i > f$i; done
  > git add f* && git commit -m add f* && git rm -q f* && git commit -m rm -p

but I didn't succeed to recreate the problem. So I'm still wondering
what is special in my repository & tree that trigger the corruption.

Anyway, thanks to al of you for looking at this so quickly.

-- Luc
