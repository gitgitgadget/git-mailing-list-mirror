Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B37A620437
	for <e@80x24.org>; Mon, 16 Oct 2017 17:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753269AbdJPRSQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 13:18:16 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:56424 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752209AbdJPRSP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 13:18:15 -0400
Received: by mail-pg0-f54.google.com with SMTP id m18so7325430pgd.13
        for <git@vger.kernel.org>; Mon, 16 Oct 2017 10:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HHGTNpd9grdczZkqs5yCkfg5iHfyQDZASRtUwip9eI8=;
        b=CeMaxwowpan3mO07hs9jyeQMkBkmjvRG9oCNZRWk/s3T1XpASo4Hggue25pGV35v5x
         /rW9iT5WY0Kw9TJSpWoegopbpiYnNrsvV2K+yEB8bF+3qizCwBrU5b9HdYI42Z6BaOha
         Qc2bAswGLhnEKXOdG6Z8gTAi9WQoy5DiATmPt31SDEWu9qBwn/l6mKd2PXbHlCFy5IfW
         GH7OTUY/BrhFkZ2fCr1VUDHhfYElDHob0JQYv/q5cbLdilsrQ513lAFspfXO2JZX+fuc
         PMZcpGbBUzRnioMcb3kgLPeWpoV2DNwY0aq1YtN6w3p4qRRcikzts1odxWZj1AMWefRZ
         spOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HHGTNpd9grdczZkqs5yCkfg5iHfyQDZASRtUwip9eI8=;
        b=n/0Emg9/n4UWNIjcGEngjTBU5fSQfKK5XP9HrOACOUeZkeK3ZAgiWzUNqWpDIpHlIy
         KvRez0mTSUCAMeJdT2aNDaNyXgGs8BofaQBySGa+BsjZInXAhLWd71UwwvIYeKSBERMh
         XJ5P1PCE6hj32qYEpDLqlAmj0l4v2PeDUBBVCmUwFYfEs5uUJS4ZaLgyyH+VUTAD5SfP
         1NJ8u34Felhgrs+vyOilDFJRuiAfeth/z7bniWd4GkbTMCnQM3RZboybCBX2j3ru1C1p
         YpXWeKaOgQiKrlX/Aiaq908igildwk7AHosQCuP7JZQUCZgOZ6ykjEHRK0ofZhY8e5xO
         v4JQ==
X-Gm-Message-State: AMCzsaWazmInMEBMm+qWWmP9Y4mMgqn689P7heSw0YVKjCVLnaN2ao8C
        gAUl43TjHnKscMEHMTSTNuv1jTFwup4=
X-Google-Smtp-Source: AOwi7QB9Ou11KkjJ13kYEgbtS4wtuHalvrSjLWnmZXD1hs63T4wwjeU3u8+QuLOw/7XG3YT5Ur5LbA==
X-Received: by 10.98.14.27 with SMTP id w27mr9354200pfi.201.1508174294458;
        Mon, 16 Oct 2017 10:18:14 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:c16b:2b6a:a424:12d2])
        by smtp.gmail.com with ESMTPSA id f131sm16211943pfc.27.2017.10.16.10.18.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 16 Oct 2017 10:18:13 -0700 (PDT)
Date:   Mon, 16 Oct 2017 10:18:12 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, bturner@atlassian.com, git@jeffhostetler.com,
        gitster@pobox.com, jonathantanmy@google.com, peff@peff.net,
        sbeller@google.com
Subject: Re: [PATCH v3 10/10] ssh: introduce a 'simple' ssh variant
Message-ID: <20171016171812.GA4487@google.com>
References: <20170926235627.79606-1-bmwill@google.com>
 <20171003201507.3589-1-bmwill@google.com>
 <20171003201507.3589-11-bmwill@google.com>
 <20171003214206.GY19555@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171003214206.GY19555@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/03, Jonathan Nieder wrote:
> Hi,
> 
> Brandon Williams wrote:
> 
> > When using the 'ssh' transport, the '-o' option is used to specify an
> > environment variable which should be set on the remote end.  This allows
> > git to send additional information when contacting the server,
> > requesting the use of a different protocol version via the
> > 'GIT_PROTOCOL' environment variable like so: "-o SendEnv=GIT_PROTOCOL"
> >
> > Unfortunately not all ssh variants support the sending of environment
> > variables to the remote end.  To account for this, only use the '-o'
> > option for ssh variants which are OpenSSH compliant.  This is done by
> > checking that the basename of the ssh command is 'ssh' or the ssh
> > variant is overridden to be 'ssh' (via the ssh.variant config).
> 
> This also affects -p (port), right?

Yeah I'll add a comment in the commit msg indicating that options like
-p and -4 -6 are are only supported by some variants.

> 
> What happens if I specify a ssh://host:port/path URL and the SSH
> implementation is of 'simple' type?

The port would only be sent if your ssh command supported it.

> 
> > Previously if an ssh command's basename wasn't 'plink' or
> 
> Git's commit messages use the present tense to describe the current
> state of the code, so this is "Currently". :)

I'll fix this :)

> 
> > 'tortoiseplink' git assumed that the command was an OpenSSH variant.
> > Since user configured ssh commands may not be OpenSSH compliant, tighten
> > this constraint and assume a variant of 'simple' if the basename of the
> > command doesn't match the variants known to git.  The new ssh variant
> > 'simple' will only have the host and command to execute ([username@]host
> > command) passed as parameters to the ssh command.
> >
> > Update the Documentation to better reflect the command-line options sent
> > to ssh commands based on their variant.
> >
> > Reported-by: Jeffrey Yasskin <jyasskin@google.com>
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> 
> Thanks for working on this.
> 
> For background, the GIT_SSH implementation that motivated this is
> https://github.com/travis-ci/dpl/blob/6c3fddfda1f2a85944c544446b068bac0a77c049/lib/dpl/provider.rb#L215,
> which does not support -p or -4/-6, either.
> 
> > ---
> >  Documentation/config.txt |  27 ++++++++++--
> >  Documentation/git.txt    |   9 ++--
> >  connect.c                | 107 ++++++++++++++++++++++++++---------------------
> >  t/t5601-clone.sh         |   9 ++--
> >  t/t5700-protocol-v1.sh   |   2 +
> >  5 files changed, 95 insertions(+), 59 deletions(-)
> [...]
> > --- a/connect.c
> > +++ b/connect.c
> > @@ -776,37 +776,44 @@ static const char *get_ssh_command(void)
> [...]
> > +static enum ssh_variant determine_ssh_variant(const char *ssh_command,
> > +					      int is_cmdline)
> [...]
> > -	if (!strcasecmp(variant, "plink") ||
> > -	    !strcasecmp(variant, "plink.exe"))
> > -		*port_option = 'P';
> > +	if (!strcasecmp(variant, "ssh"))
> > +		ssh_variant = VARIANT_SSH;
> 
> Could this handle ssh.exe, too?

Yeah I'll add the additional comparison.

> 
> [...]
> > --- a/t/t5601-clone.sh
> > +++ b/t/t5601-clone.sh
> 
> Can this get tests for the new defaulting behavior?  E.g.
> 
>  - default is "simple"
>  - how "simple" treats an ssh://host:port/path URL
>  - how "simple" treats ipv4/ipv6 switching
>  - ssh defaults to "ssh"
>  - if GIT_SSH=ssh, can set ssh.variant to "simple" to force the "simple"
>    mode

I'll look to adding a few more tests.

> 
> One other worry: this (intentionally) changes the behavior of a
> previously-working GIT_SSH=ssh-wrapper that wants to support
> OpenSSH-style options but does not declare ssh.variant=ssh.  When
> discovering this change, what should the author of such an ssh-wrapper
> do?
> 
> They could instruct their users to set ssh.variant or GIT_SSH_VARIANT
> to "ssh", but then they are at the mercy of future additional options
> supported by OpenSSH we may want to start using in the future (e.g.,
> maybe we will start passing "--" to separate options from the
> hostname).  So this is not a futureproof option for them.
> 
> They could take the new default behavior or instruct their users to
> set ssh.variant or GIT_SSH_VARIANT to "simple", but then they lose
> support for handling alternate ports, ipv4/ipv6, and specifying -o
> SendEnv to propagate GIT_PROTOCOL or other envvars.  They can handle
> GIT_PROTOCOL propagation manually, but losing port support seems like
> a heavy cost.
> 
> They could send a patch to define yet another variant that is
> forward-compatible, for example using an interface similar to what
> git-credential(1) uses.  Then they can set GIT_SSH to their
> OpenSSH-style helper and GIT_FANCY_NEW_SSH to their more modern
> helper, so that old Git versions could use GIT_SSH and new Git
> versions could use GIT_FANCY_NEW_SSH.  This might be their best
> option.  It feels odd to say that their only good way forward is to
> send a patch, but on the other hand someone with such an itch is
> likely to be in the best position to define an appropriate interface.
> 
> They could send a documentation patch to make more promises about the
> commandline used in OpenSSH mode: e.g. setting a rule in advance about
> which options can take an argument so that they can properly parse an
> OpenSSH command line in a future-compatible way.
> 
> Or they could send a patch to allow passing the port in "simple"
> mode, for example using an environment variable.
> 
> Am I missing another option?  What advice do we give to this person?
> 
> Thanks,
> Jonathan

-- 
Brandon Williams
