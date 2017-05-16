Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E4101FAA8
	for <e@80x24.org>; Tue, 16 May 2017 17:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752521AbdEPRPo (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 13:15:44 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:34594 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752038AbdEPRPn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 13:15:43 -0400
Received: by mail-pg0-f46.google.com with SMTP id u28so79517282pgn.1
        for <git@vger.kernel.org>; Tue, 16 May 2017 10:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w5pKBMH4XyYzJ+qlNdEhu8yLusKfRumK2+s9kp9peEE=;
        b=DzI1CIXBlbUnlYxurCGoyEjRXEUjI3NIyXecLFuzlTlIhe5yn3R8JHVuTR4QFy6nG4
         q7GMnfIKeg13kBNf9CuJbDeIz7lpi6oWm5C4fcZJGMcc8sdXeuFMklPoxhc2fhZkTONx
         eGSlonhvmBlK6CAjHCWBABFmTImGGvRKhJAUn1FRrDa8VT3amLpunFktRHWgIrZgVfuB
         vpArc/7tBebJg02vofKemmBR7m/IWdwkF7gymb26MHcb/8+XRiBrKaLOyjRNaCzygXlL
         CIymiBE6/CqzkWQWzlTxEY4TtxJmgF7mRrKnaemr4DwQqOFaSBichZ8RB9qcgCNgldy2
         Zylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w5pKBMH4XyYzJ+qlNdEhu8yLusKfRumK2+s9kp9peEE=;
        b=RMOyahDzvM20sUkqlRETv7nDo7AnSH0xeeuVSaH1c1M33EB5nK/r1djdnw57ds6srd
         IkYtHtgS8yWIsGjPXH4W+YFXKkC6SvOHDQdEuIghVeiRPglB995O/VUHAn2a3OsA3+qI
         xlvkHob+BMdpfr38UY4UydoLPMdrpNCUAuDH9J5ssgAlQGFR6Oi2lhXNYVAEJdwvj//U
         sMePfATk/r4rLiLNeHyZ2jitY2/TJ+tk2D/NDE6Tli9DKb61VLpZaN8vAiAkBlY4x7FB
         goonNhGLh0/kQhR/CdcLdbNBbLlzLY0oHrrv83J0YHSjlflLqQd81zOpEE5Eey0YcIDt
         MLzQ==
X-Gm-Message-State: AODbwcCpdKKp1rr1hPVdyVml08huYS6lDdPnN3eZ+41a1sPpIT+1ijiI
        hLWbh9W7gC0RovMh
X-Received: by 10.84.237.1 with SMTP id s1mr17414544plk.157.1494954942400;
        Tue, 16 May 2017 10:15:42 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:6c78:c1b9:36d1:fa23])
        by smtp.gmail.com with ESMTPSA id n85sm28649523pfi.101.2017.05.16.10.15.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 May 2017 10:15:41 -0700 (PDT)
Date:   Tue, 16 May 2017 10:15:40 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Eric Rannaud <eric.rannaud@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeremy Serror <jeremy.serror@gmail.com>
Subject: Re: git rebase regression: cannot pass a shell expression directly
 to --exec
Message-ID: <20170516171540.GG79147@google.com>
References: <CA+zRj8X3OoejQVhUHD9wvv60jpTEZy06qa0y7TtodfBa1q5bnA@mail.gmail.com>
 <20170516032503.bzkxmtqpmppxgi75@sigill.intra.peff.net>
 <20170516033736.23cfkouus3p67vhc@sigill.intra.peff.net>
 <20170516164124.GO27400@aiede.svl.corp.google.com>
 <20170516164750.3tw6xlbcbyuu5t72@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170516164750.3tw6xlbcbyuu5t72@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/16, Jeff King wrote:
> On Tue, May 16, 2017 at 09:41:24AM -0700, Jonathan Nieder wrote:
> 
> > Jeff King wrote:
> > > On Mon, May 15, 2017 at 11:25:03PM -0400, Jeff King wrote:
> > 
> > >> One hack would be to look for BASH_FUNC_* in the environment and disable
> > >> the optimization in that case. I think that would make your case Just
> > >> Work. It doesn't help other oddball cases, like:
> > >>
> > >>   - you're trying to run a shell builtin that behaves differently than
> > >>     its exec-able counterpart
> > >>
> > >>   - your shell has some other mechanism for defining commands that we
> > >>     would not find via exec. I don't know of one offhand. Obviously $ENV
> > >>     could point to a file which defines some, but for most shells would
> > >>     not read any startup files for a non-interactive "sh -c" invocation.
> > >
> > > So I was thinking something like the patch below, though I guess
> > > technically you could look for BASH_FUNC_$argv[0]%%, which seems to be
> > > bash's magic variable name. I hate to get too intimate with those
> > > details, though.

One concern with that is what about all other shells that are not BASH?
I'm sure they use a different env var for storing functions so we may
need to handle other shell's too? That is assuming we want to keep the
old behavior.

> > >
> > > Another option is to speculatively run "foo" without the shell, and if
> > > execve fails to find it, then fall back to running the shell. That would
> > > catch any number of cases where the shell "somehow" finds a command that
> > > we can't.
> > 
> > Hm.  execvp explicitly does this when it hits ENOEXEC, but not for
> > ENOENT.  Do you know why that is?
> 
> When execvp(foo) falls back on ENOEXEC, it is not running "sh -c foo".
> It is actually running "sh foo" to run the script contents. So it's
> about letting you do:
> 
>   echo "no shebang line" >script
>   chmod +x script
>   ./script
> 
> And nothing to do with shell builtins.

That's correct, and is the exact behavior I was trying to mimic with the
changes to run_command.
  1. try executing the command.
  2. if it fails with ENOEXEC then attempt to execute it with a shell

> 
> > I think we want to behave consistently for shell builtins and for
> > exported functions --- they are different sides of the same problem,
> > and behaving differently between the two feels confusing.
> 
> Yes, I think ideally we'd handle it all transparently. Although I'd also
> point out that Git the behavior under discussion dates back to 2009 and
> this is (as far as I can recall) the first report. So documenting the
> current behavior might not be that bad an option.
> 
> -Peff

-- 
Brandon Williams
