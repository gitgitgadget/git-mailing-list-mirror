Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53CF22082F
	for <e@80x24.org>; Sun, 25 Jun 2017 21:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751353AbdFYVIw (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Jun 2017 17:08:52 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34802 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751343AbdFYVIv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jun 2017 17:08:51 -0400
Received: by mail-wr0-f195.google.com with SMTP id k67so26344653wrc.1
        for <git@vger.kernel.org>; Sun, 25 Jun 2017 14:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vsz2Xoflo+x181QIOhuujFt4ARtdmflj9uZ8djIohng=;
        b=n9s9nURTEw7Q/m+BQpVTuCEYn/7Q2ZH7mGahyx+EEAmAHX+7UCIa6RtyCqzPyvA2R2
         vy79jLocKVv7V8vsBdC/POtdEONd+GD7y1vz/PeW2mO8IDftJPoi+E33r2F3tG9YZxgr
         3P08t1p6uzEYSpqz+VaWcPUHfHAk/FcG3jMN6UGZvnnRuKVQhdf9fRFgnuKsjbokEK+1
         XDIUx0FKOQK4wxR5dE0UhfHxRfgbK/pHb2ArHUTY71vbEEyXRzgApNSz3fEKqp+efO4q
         Po99cdJphSikHajxHZmBGxJW2eB1/ceSitzRsIFDEm6/5m7MR+6GzhK4IL8qw5BQ0ajd
         p2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vsz2Xoflo+x181QIOhuujFt4ARtdmflj9uZ8djIohng=;
        b=HTk5dz4iWM6KwlEnhVMVCuI3F3zHp7PO3bQ3EOhnTGEfZEsbSzkwryMPDm1FJEwPXi
         5MF2xQUEFEvXwFR4EEvILrBuR7YkIQKFHXoDzVg7dC1Y4FseR40WAE0DvMU6m8hlXpS/
         i97wI5bNPGIDfuXRER8VZdZKG32T6o+OLLuwSlT//7fhX0reMf0VR03IeF2ZMkstoBtg
         lshEiAWKB1rWOvfrTIXYU4u56I/5XEuLK2mz8iSwD8MzreBbXB5ogBBFhoD9nQ35HOlP
         XFz4iW4zha+hWxe3hTpQK1EKWRyMT5a2OfySY1KmG09ZTlrPUD6A/7OLvU3BU942HBuT
         tTsA==
X-Gm-Message-State: AKS2vOwPMrM+6v8ev/TR3f5EcMEpPXi+ClDGh0UGHJCPSsXu9pmu/Jcx
        zonMehLy1xBYBg==
X-Received: by 10.28.216.21 with SMTP id p21mr10233959wmg.29.1498424929456;
        Sun, 25 Jun 2017 14:08:49 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id k45sm15928591wrk.45.2017.06.25.14.08.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Jun 2017 14:08:48 -0700 (PDT)
Date:   Sun, 25 Jun 2017 22:09:09 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH v4 5/5] stash: implement builtin stash
Message-ID: <20170625210909.GB7737@hank>
References: <20170608005535.13080-1-joel@teichroeb.net>
 <20170608005535.13080-6-joel@teichroeb.net>
 <20170611212739.GA7737@hank>
 <CA+CzEk9i8H2BAUrL854WJELCTa-O1ONMWa0uOcTsW=WxnB_22Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CzEk9i8H2BAUrL854WJELCTa-O1ONMWa0uOcTsW=WxnB_22Q@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/19, Joel Teichroeb wrote:
> On Sun, Jun 11, 2017 at 2:27 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> >> +
> >> +int cmd_stash(int argc, const char **argv, const char *prefix)
> >> +{
> >> +     int result = 0;
> >> +     pid_t pid = getpid();
> >> +
> >> +     struct option options[] = {
> >> +             OPT_END()
> >> +     };
> >> +
> >> +     git_config(git_default_config, NULL);
> >> +
> >> +     xsnprintf(stash_index_path, 64, ".git/index.stash.%d", pid);
> >> +
> >> +     argc = parse_options(argc, argv, prefix, options, git_stash_usage,
> >> +             PARSE_OPT_KEEP_UNKNOWN|PARSE_OPT_KEEP_DASHDASH);
> >> +
> >> +     if (argc < 1) {
> >> +             result = do_push_stash(NULL, prefix, 0, 0, 0, 0, NULL);
> >> +     } else if (!strcmp(argv[0], "list"))
> >> +             result = list_stash(argc, argv, prefix);
> >> +     else if (!strcmp(argv[0], "show"))
> >> +             result = show_stash(argc, argv, prefix);
> >> +     else if (!strcmp(argv[0], "save"))
> >> +             result = save_stash(argc, argv, prefix);
> >> +     else if (!strcmp(argv[0], "push"))
> >> +             result = push_stash(argc, argv, prefix);
> >> +     else if (!strcmp(argv[0], "apply"))
> >> +             result = apply_stash(argc, argv, prefix);
> >> +     else if (!strcmp(argv[0], "clear"))
> >> +             result = clear_stash(argc, argv, prefix);
> >> +     else if (!strcmp(argv[0], "create"))
> >> +             result = create_stash(argc, argv, prefix);
> >> +     else if (!strcmp(argv[0], "store"))
> >> +             result = store_stash(argc, argv, prefix);
> >> +     else if (!strcmp(argv[0], "drop"))
> >> +             result = drop_stash(argc, argv, prefix);
> >> +     else if (!strcmp(argv[0], "pop"))
> >> +             result = pop_stash(argc, argv, prefix);
> >> +     else if (!strcmp(argv[0], "branch"))
> >> +             result = branch_stash(argc, argv, prefix);
> >> +     else {
> >> +             if (argv[0][0] == '-') {
> >> +                     struct argv_array args = ARGV_ARRAY_INIT;
> >> +                     argv_array_push(&args, "push");
> >> +                     argv_array_pushv(&args, argv);
> >> +                     result = push_stash(args.argc, args.argv, prefix);
> >
> > This is a bit of a change in behaviour to what we currently have.
> >
> > The rules we decided on are as follows:
> >
> >  - "git stash -p" is an alias for "git stash push -p".
> >  - "git stash" with only option arguments is an alias for "git stash
> >    push" with those same arguments.  non-option arguments can be
> >    specified after a "--" for disambiguation.
> >
> > The above makes "git stash -*" a alias for "git stash push -*".  This
> > would result in a change of behaviour, for example in the case where
> > someone would use "git stash -this is a test-".  In that case the
> > current behaviour is to create a stash with the message "-this is a
> > test-", while the above would end up making git stash error out.  The
> > discussion on how we came up with those rules can be found at
> > http://public-inbox.org/git/20170206161432.zvpsqegjspaa2l5l@sigill.intra.peff.net/.
> 
> I don't really like the "argv[0][0] == '-'" logic, but it doesn't seem
> to have the flaw you pointed out:
> $ ./git stash -this is a test-
> error: unknown switch `t'
> usage: git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
> [...]

I just went through the thread again, to remind myself why we did it
this way.  The example I had above was the wrong example, sorry.  The
message at [1] explains it better.  Essentially by implementing the
rules I mentioned we wanted to avoid the potential confusion of what
does 'git stash -q drop' mean.  Before the rewrite this fails and
shows the usage.  After the rewrite this would try to stash everything
matching the pathspec drop, which might be confusing for users.  

[1]: http://public-inbox.org/git/20170213214521.pkjesijdlus36tnp@sigill.intra.peff.net/

> I'm not sure this is the best possible error message, but it's just as
> useful as the message from the old version.
> 
> >
> >> +                     if (!result)
> >> +                             printf_ln(_("To restore them type \"git stash apply\""));
> >
> > In the shell script this is only displayed when the stash_push in the
> > case where git stash is invoked with no arguments, not in the push
> > case if I read this correctly.  So the two lines above should go in
> > the (argc < 1) case I think.
> 
> I think it's correct as is. One of the tests checks for this string to
> be output, and if I move the line, the test fails.

Right, that test that fails only when the "To restore..." string is
printed to stdout.  So moving the "printf_ln()" to the line you did
only makes sure it's not printed there.  Reading the code again and
trying to trigger this print in the shell script stash makes me think
this is not even possible to trigger there anymore.

After the line

test -n "$seen_non_option" || set "push" "$@"

it's not possible that $# is 0 anymore, so this will never be
printed.  From a quick look at the history it seems like it wasn't
possible to trigger that codepath for a while.  If I'm reading things
correctly 3c2eb80fe3 ("stash: simplify defaulting to "save" and reject
unknown options", 2009-08-18) seems to have introduced the small
change in behaviour.   As I don't think anyone has complained since
then, I'd just leave it as is, which makes git stash with no options a
little less verbose.  [Adding Matthieu to cc as author of the above
mentioned commit]

> I agreed with all the other points you raised, and they will be fixed
> in my next revision.

Thanks!
