Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66CF41F404
	for <e@80x24.org>; Tue, 14 Aug 2018 21:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbeHOABQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 20:01:16 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38109 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbeHOABQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 20:01:16 -0400
Received: by mail-pl0-f67.google.com with SMTP id u11-v6so8823112plq.5
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 14:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JhJCjFquAKNkwyAcCcuthQ1/PvttsU429T509l6/9Zg=;
        b=UV6JthjK1GEhJa+tIYRDVZxZnvwjoyoWyZNeGX0+NmU2Q/0qi5aeCc6zEecMf4+jLE
         yfzAbTB3bBqaG6qpCzfl+WaZOpNgOsGSDwruxNgcYt70XvzUl3g8OQDWgzjgI/V9wAPa
         /fQNPpLNVyoZnK0Y6kQYavawW7UPdJOzL3yndyGz77dBs9ACIIWWPJWWHKaKg5bPPA5b
         hawfF4YNDI398vmQwRFRjyylf2Rk9iNHGogTt26zCYcq7bwQwhPgeI0+LwDPgXRGEPg7
         qwkuf5nBInBlZCwTIwEky0T8C2wJoEKqm59ee3C9UmQkG7s5i3fpEAXphNsvHAZ/ep09
         6qJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JhJCjFquAKNkwyAcCcuthQ1/PvttsU429T509l6/9Zg=;
        b=SskuXgHArMjzZXZr8O9atvtj3C6FEsjgYCDCMR9IQDjRy5ANpENAq8trFRH/SWch/f
         JBe28Y6u87rSstMwxJ5JU2wr+2Xt7I0I+Ns9UZpQODCzcAx1bzCa2iA0bYtVmIMDl/88
         MIaOSXWT9mjAgBFbcYudyIL0yQ7iLZYBTZ6RXsRPE6Uxe6cR/oqV2RTATtO9F+AL5RrL
         AjVhV6e3tJQWfNLAXIHVfYKGoyU+0XmoP+myYIZTVbiAIqsTa6wK9SbB2cela+lw+er1
         tWAZamfubpCYKnh4ZMJhjaX0qPiRY5xSH3CpaTLSSG1MOW845eF2dJmReGsjJFdC8H9B
         zITQ==
X-Gm-Message-State: AOUpUlFcTYRlHe+/nAfq6RdO7FZ/KHh/ZKGw2kEVBSAd+/lmlLryBvfb
        3n9cOxRrDfBHAmxxzj7nOcw=
X-Google-Smtp-Source: AA+uWPx4QCB5fNSdouem/zGr9xsf07tC4CMhu47z3WwB0TLt8ore5U/ftNF3YgHIMTJhqplymC1eJw==
X-Received: by 2002:a17:902:26:: with SMTP id 35-v6mr13519002pla.276.1534281133766;
        Tue, 14 Aug 2018 14:12:13 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id d34-v6sm26351749pgb.29.2018.08.14.14.12.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 14:12:13 -0700 (PDT)
Date:   Tue, 14 Aug 2018 14:12:11 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>, Jeff King <peff@peff.net>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] submodule: munge paths to submodule git directories
Message-ID: <20180814211211.GF142615@aiede.svl.corp.google.com>
References: <20180807230637.247200-1-bmwill@google.com>
 <20180808223323.79989-1-bmwill@google.com>
 <20180808223323.79989-3-bmwill@google.com>
 <20180809212602.GA11342@sigill.intra.peff.net>
 <20180814180406.GA86804@google.com>
 <20180814185743.GE142615@aiede.svl.corp.google.com>
 <CAGZ79kZUq5jPqyb=B1ppEi1QhNGmhLXeV6vPn8ouR=YGEN32pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZUq5jPqyb=B1ppEi1QhNGmhLXeV6vPn8ouR=YGEN32pg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:
> On Tue, Aug 14, 2018 at 11:57 AM Jonathan Nieder <jrnieder@gmail.com> wrote:

>> Second, what if we store the pathname in config?  We already store the
>> URL there:
>>
>>         [submodule "plugins/hooks"]
>>                 url = https://gerrit.googlesource.com/plugins/hooks
>>
>> So we could (as a followup patch) do something like
>>
>>         [submodule "plugins/hooks"]
>>                 url = https://gerrit.googlesource.com/plugins/hooks
>>                 gitdirname = plugins%2fhooks
>>
>> and use that for lookups instead of regenerating the directory name.
>> What do you think?
>
> As I just looked at worktree code, this sounds intriguing for the wrong
> reason (again), as a user may want to point the gitdirname to a repository
> that they have already on disk outside the actual superproject. They
> would be reinventing worktrees in the submodule space. ;-)
>
> This would open up the security hole that we just had, again.
> So we'd have to make sure that the gitdirname (instead of the
> now meaningless subsection name) is proof to ../ attacks.
>
> I feel uneasy about this as then the user might come in
> and move submodules and repoint the gitdirname...
> to a not url encoded path. Exposing this knob just
> asks for trouble, no?

What if we forbid directory separator characters in the gitdirname?

[...]
> What would happen if gitdirname is changed as part of
> history? (The same problem we have now with changing
> the subsection name)

In this proposal, it would only be read from config, not from
.gitmodules.

Thanks,
Jonathan
