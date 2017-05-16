Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37D5B1FAA8
	for <e@80x24.org>; Tue, 16 May 2017 16:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753234AbdEPQl2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 12:41:28 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36630 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753232AbdEPQl1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 12:41:27 -0400
Received: by mail-pf0-f194.google.com with SMTP id n23so19390206pfb.3
        for <git@vger.kernel.org>; Tue, 16 May 2017 09:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gWu+bxNxNKNwY0o0J344+2cAjHcQBast24bvFNKmItI=;
        b=hZEtjPE4vb/vPviJUn0Jf7gOJo8P6CLQLgV4zCi3uJjtR7KO5yQG60oimBRobBsd9O
         AJ499u8WmbRWT3yT+FODMZb5RXRwqXUYJCfZr2OuxbZZqQvCgxt7YTuAbXRjXLLMHkyL
         zx6Yh6bU98o6TlcqxyXswNpuJ1bbHwF8vvgg7HYTCex8gy2+VczTkTeKo67eJFC4RDAn
         mpHJPPuZaG0DHpS8USwUIkoOKT86m5O1dZW4ZPGYiKAwHI9yerquPgL6Ib0ATtCWkISm
         4Eo9A8VBZUegcU8t+6l/fH0hubm0iFdc5jClWsprDiJdrSVrQb0rXjqzcPE5zry4m0zO
         2x2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gWu+bxNxNKNwY0o0J344+2cAjHcQBast24bvFNKmItI=;
        b=kMe+saNszQI2NyysTo8G0Cqik/sctfdl6McTS96/DIpnShMMglhvs1nk1hyMjyLhRU
         lgaCpL+A1UvfnkMkcmWvWHHuWbh6ap9c/F/1qR1W3AEbjb2U/NLR+3RDB9+3qrqypvBq
         QJfoRDPvCe3mRWWRAGz+fxXOZgGBxfYafiLnVbep4ETLnHwopK9oTHSLyJL/CmIPgm/O
         MxjhmYjMsvTioobWtrlj2wJHKoScP3Qrb9HYQnTdjA8ILKwohke+5M2FiNUsN9hG91FO
         18r/HznFpsxBdlpJT8x7Vk2AoT7pJ+CzUcA5PMddtHhP9ar5YhREIsrmWNtpB5TgDmKD
         zasg==
X-Gm-Message-State: AODbwcCNj3If1TcqmedGdxbYPZCg2e25YW8aAc3wa5lB1A8z9LVwo0lC
        ylx/bNX5kZ2pyKb3tRU=
X-Received: by 10.98.210.199 with SMTP id c190mr13295441pfg.87.1494952886957;
        Tue, 16 May 2017 09:41:26 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:6582:4c54:354a:7413])
        by smtp.gmail.com with ESMTPSA id y20sm18339408pfb.93.2017.05.16.09.41.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 May 2017 09:41:26 -0700 (PDT)
Date:   Tue, 16 May 2017 09:41:24 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Rannaud <eric.rannaud@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeremy Serror <jeremy.serror@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: git rebase regression: cannot pass a shell expression directly
 to --exec
Message-ID: <20170516164124.GO27400@aiede.svl.corp.google.com>
References: <CA+zRj8X3OoejQVhUHD9wvv60jpTEZy06qa0y7TtodfBa1q5bnA@mail.gmail.com>
 <20170516032503.bzkxmtqpmppxgi75@sigill.intra.peff.net>
 <20170516033736.23cfkouus3p67vhc@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170516033736.23cfkouus3p67vhc@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(+Brandon Williams, who may have more context for execvp-related things)
Hi,

Jeff King wrote:
> On Mon, May 15, 2017 at 11:25:03PM -0400, Jeff King wrote:

>> One hack would be to look for BASH_FUNC_* in the environment and disable
>> the optimization in that case. I think that would make your case Just
>> Work. It doesn't help other oddball cases, like:
>>
>>   - you're trying to run a shell builtin that behaves differently than
>>     its exec-able counterpart
>>
>>   - your shell has some other mechanism for defining commands that we
>>     would not find via exec. I don't know of one offhand. Obviously $ENV
>>     could point to a file which defines some, but for most shells would
>>     not read any startup files for a non-interactive "sh -c" invocation.
>
> So I was thinking something like the patch below, though I guess
> technically you could look for BASH_FUNC_$argv[0]%%, which seems to be
> bash's magic variable name. I hate to get too intimate with those
> details, though.
>
> Another option is to speculatively run "foo" without the shell, and if
> execve fails to find it, then fall back to running the shell. That would
> catch any number of cases where the shell "somehow" finds a command that
> we can't.

Hm.  execvp explicitly does this when it hits ENOEXEC, but not for
ENOENT.  Do you know why that is?

I think we want to behave consistently for shell builtins and for
exported functions --- they are different sides of the same problem,
and behaving differently between the two feels confusing.

Thanks,
Jonathan
