Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 015AC20951
	for <e@80x24.org>; Fri, 17 Mar 2017 21:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751259AbdCQVhD (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 17:37:03 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35391 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751179AbdCQVhC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 17:37:02 -0400
Received: by mail-pf0-f174.google.com with SMTP id x63so37211848pfx.2
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 14:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b/JedPuzFiuP57wjPIkP1v7YjH0VlfJYxEl3Mxkiwmo=;
        b=Q6oAqFVggvL8SWHLQmZG0TM9pI7bNduXqQtFgOZmN++nBFaJ6Zqo3Ead9AZJyjO7TB
         bN5odVMyS8j86N8ArITEgjIuV1IeG/Z7TOaMd+ZAgG6wS2snAfkJXpgwVAN3DW/1ULFV
         qTS8SXqxQPKdxVTyoGVBPvpjpWgwjNbfR18JBJXTHKxG0/VpF+gXX9wlzyH60uDUC8jv
         Wso7eEgkIbxUudxUr2mPS37ELKyB4xlAinW+t577pMkDH4vSxYub5E8032y5v3qnlx9Q
         SXc4jDp22ktj0BSxnbdVue5es3ifH/sNeZ297x3MUQ7hzRPMErK+O4uL8J6xOHWBZD35
         cT/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b/JedPuzFiuP57wjPIkP1v7YjH0VlfJYxEl3Mxkiwmo=;
        b=hm//1fdKDeg6ag5van19KX6mMCMZu21yvi+58pqVTPeMPXnEE39q+69ij6n224sEh+
         zD+REtJb+cl1gdTPBONjWGUAT24VZwHJCWwbUvNpmQGcNN1uPNrnPUHR0Iy6ZBhgecAm
         l17YxgBVZLlTvl+hhV7RGusclIxf/mEbFeQmS9gAc0aJTWbaKZN6uCFZAjZbFqM9kFXo
         9VFj8RDK9pL4oUXVxWCtCWsVH57TBUrbPGzMEZPpoIlVMrHTnBHU7uqNL1Ymczm4dKtk
         20z6UgXL1swQifWotr3lLN4fhPEXLFYNTVNCZ+LP/RH0ycLwNuWfWDAvqaJX10z6VezA
         S+Cg==
X-Gm-Message-State: AFeK/H1oO3ZZGmjRJ0rJOsxLj4ybXRYnGXGBXMAyKa59nNmmpTdCcra4ESNrGOCHGAIAvVpO
X-Received: by 10.84.177.36 with SMTP id w33mr22392756plb.105.1489786096625;
        Fri, 17 Mar 2017 14:28:16 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:c001:d329:ba91:25ca])
        by smtp.gmail.com with ESMTPSA id p77sm18555190pfj.99.2017.03.17.14.28.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Mar 2017 14:28:15 -0700 (PDT)
Date:   Fri, 17 Mar 2017 14:28:14 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 08/10] clone: teach --recurse-submodules to optionally
 take a pathspec
Message-ID: <20170317212814.GB63813@google.com>
References: <20170313214341.172676-1-bmwill@google.com>
 <20170316222952.53801-1-bmwill@google.com>
 <20170316222952.53801-9-bmwill@google.com>
 <CAGZ79kbvxpAEzVnNYRQ7VqzY30_oH4FGw3cH0TCwzCwCfy3HZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbvxpAEzVnNYRQ7VqzY30_oH4FGw3cH0TCwzCwCfy3HZw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/17, Stefan Beller wrote:
> On Thu, Mar 16, 2017 at 3:29 PM, Brandon Williams <bmwill@google.com> wrote:
> > Teach clone --recurse-submodules to optionally take a pathspec argument
> > which describes which submodules should be recursively initialized and
> > cloned.  If no pathspec is provided, --recurse-submodules will
> > recursively initialize and clone all submodules by using a default
> > pathspec of ".".  In order to construct more complex pathspecs,
> > --recurse-submodules can be given multiple times.
> >
> > Additionally this configures the 'submodule.active' configuration option
> > to be the given pathspec, such that any future invocation of `git
> > submodule update` will keep up with the pathspec.
> 
>   Additionally the switch '--recurse' is removed from the Documentation
>   as well as marked hidden in the options array, to streamline the options
>   for submodules.  A simple '--recurse' doesn't convey what is being
>   recursed, e.g. it could mean directories or trees (c.f. ls-tree)
>   In a lot of other commands we already have '--recurse-submodules'
>   to mean recursing into submodules, so advertise this spelling here
>   as the genuine option.
> 
> would also be worth mentioning?
> 

Yeah I can just add this into the commit msg.

> 
> >  static int option_no_checkout, option_bare, option_mirror, option_single_branch = -1;
> > -static int option_local = -1, option_no_hardlinks, option_shared, option_recursive;
> > +static int option_local = -1, option_no_hardlinks, option_shared;
> >  static int option_shallow_submodules;
> >  static int deepen;
> >  static char *option_template, *option_depth, *option_since;
> > @@ -56,6 +56,22 @@ static struct string_list option_required_reference = STRING_LIST_INIT_NODUP;
> >  static struct string_list option_optional_reference = STRING_LIST_INIT_NODUP;
> >  static int option_dissociate;
> >  static int max_jobs = -1;
> > +static struct string_list option_recurse_submodules = STRING_LIST_INIT_NODUP;
> > +
> > +static int recurse_submodules_cb(const struct option *opt,
> > +                                const char *arg, int unset)
> > +{
> > +       if (unset)
> > +               return -1;
> > +
> > +       if (arg)
> > +               string_list_append((struct string_list *)opt->value, arg);
> > +       else
> 
> in this case I'd rather set the removed (int) option_recursive, because, then
> we would not need to sort and remove duplicates later on.
> Instead we can pass the string list literally to the config setter.
> (and in case option_recursive is set, we add an additional single
> "." then)

That's just one more thing to worry about though.  This felt a little
bit cleaner than doing more special casing.

> 
> > +               string_list_append((struct string_list *)opt->value,
> > +                                  (const char *)opt->defval);
> > +
> > +       return 0;
> > +}
> >
> 
> >
> > -       if (!err && option_recursive) {
> > +       if (!err && (option_recurse_submodules.nr > 0)) {
> 
> Well, checks like these would become more tangled.
> So maybe we could set option_recursive unconditionally
> in the callback (unless unset was given, then we reset it to 0)
> and later have a check if we need to add "." (when the string list
> is empty).
> 
> Speaking of unset, this seems like a regression here, as the callback
> would error out to "git clone --no-recurse", which is a valid use case
> currently? (Searching for "git clone --no-recurse" yields no results
> via Google, so maybe this use case is not so valid)
> 
> To get the behavior as is for unset we could just clear the string
> list instead of returning -1.

Yeah I can do that.

> 
> Thanks,
> Stefan

-- 
Brandon Williams
