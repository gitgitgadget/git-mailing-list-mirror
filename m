Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F37131F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 14:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392725AbfJROhe (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 10:37:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46703 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389378AbfJROhd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 10:37:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id o18so6506307wrv.13
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 07:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S7Aa7+lwMgImGcglW0KQvi7II6SH2KP7FMuMOfzQYdw=;
        b=CNe5ZaJyaxqGffVHcJl9ZFg3afqoFrRMdDKG7d3ZZOkhifSgFwQbnVyloMRD925aXi
         1aHIdzMHkahIi6hDHfF2IgFBj54k3FxHZl5RAJwiqOQimI1Bxpf32tznL4uDty1Fy7KH
         MGGexBoIQUnf8pQb8tHoQYeRipcCKigrO7sllwwWJRH86O3u3jDrnZ1lfAJZIr40Gq7b
         GK1QetmDxAN9KHMnYHh7sVnNDU4RhXeVBwhqmiYife+KkQ631Wk/Aw9qopjHZiHE/9us
         ImHQ7LrdKxDnm+G4e4D363TIWKF+kF21C8sUtuqS+ueoq+KsudYfAKcLQCaGldupUIqD
         cGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S7Aa7+lwMgImGcglW0KQvi7II6SH2KP7FMuMOfzQYdw=;
        b=ab5Kcoy6dsaB8WHMoeWUQ9WeS4C0yhnUv8Uh+Uw4ziIoyPlNuCLLtgrJRO0nviYMhj
         986dMfYySypRInHOoxfghmH0YbrFWBwSKNe83KsbN/NyJNceRRKGU2LHgUKGhEu3I+TX
         uYcWX5tEchNZv63R6aYPXrM020eWgr1AO8YilzrkRJ/WCtZTMVO2R6MQFwj/cOhI9GHl
         TW5BZ3LM23vY79xVr+ZEYy+9ngTdSUYxEiScRKNtE9whnLyXcSVernKK7Lu9D9eDcK/v
         B+g/udLRdoOW0BQOm6PhkRpWobgspmDX9w4tiaa3NpfNyE0Ibgp5pDgqmMty3S9jMdCq
         IGkw==
X-Gm-Message-State: APjAAAWsuVaLItK4/G4yeaLIkPG4pzqu5SWXTg+BBSO9kas1VSB+W2uU
        PCxrjz2WLBz1bumc/jau2jY=
X-Google-Smtp-Source: APXvYqypsgEGVLNd5ZdW2WRDMvyxJhbLtzDVU2zBXe9blQQHw2jd2XKcG6HRpMdc1V0//wfba5UgKw==
X-Received: by 2002:adf:f004:: with SMTP id j4mr8807035wro.68.1571409451668;
        Fri, 18 Oct 2019 07:37:31 -0700 (PDT)
Received: from szeder.dev (x4dbd7267.dyn.telefonica.de. [77.189.114.103])
        by smtp.gmail.com with ESMTPSA id c4sm5648609wru.31.2019.10.18.07.37.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 07:37:30 -0700 (PDT)
Date:   Fri, 18 Oct 2019 16:37:28 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 3/6] completion: return the index of found word from
 __git_find_on_cmdline()
Message-ID: <20191018143728.GC29845@szeder.dev>
References: <20191017173501.3198-1-szeder.dev@gmail.com>
 <20191017173501.3198-4-szeder.dev@gmail.com>
 <CAPig+cTLCTPtUWHKVBQEaP9GkrmrnHPwfef8KnktOSqYQY-jPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cTLCTPtUWHKVBQEaP9GkrmrnHPwfef8KnktOSqYQY-jPA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 17, 2019 at 01:52:27PM -0400, Eric Sunshine wrote:
> >  __git_find_on_cmdline ()
> >  {
> > -       local word c=1
> > +       local word c=1 show_idx
> > +
> > +       while test $# -gt 1; do
> > +               case "$1" in
> > +               --show-idx)     show_idx=y ;;
> > +               *)              return 1 ;;
> 
> Should this emit an error message to aid a person debugging a test
> which fails on a call to __git_find_on_cmdline()? For instance:
> 
>     echo "unrecognized option/argument: $1" >&2
>     return 1
>     ;;
> 
> or something...

When debugging the completion script I frequently resort to 'echo >&2
"<msg>"', for lack of better options.  However, I intentionally did
not add an error message like that here, or in any similar option
parsing loops before, because due to a bug it might spew such a
message to standard error during regular completion (i.e. not during
debugging).

And printing anything to standard error during completion is
inherently bad: it disrupts the command line, can't be deleted (you
hit backspace, and in the terminal it looks as if the error message
was deleted, but in reality it's the command you've already entered
that gets deleted), and the user is eventually fored to Ctrl-C and
start over most of the time.  Well, at least I always end up hitting
Ctrl-C and start over.  Remaining silent about the unrecognized option
is in my opinion better, because then the completion script usually
does nothing, and Bash falls back to filename completion.  Yeah,
that's not ideal, but at least the user can easily correct it and
finish entering the command.

