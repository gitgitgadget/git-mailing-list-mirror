Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6C7D1F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 23:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751750AbdGYXs3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 19:48:29 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:36045 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751730AbdGYXs2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 19:48:28 -0400
Received: by mail-pg0-f44.google.com with SMTP id 125so76410631pgi.3
        for <git@vger.kernel.org>; Tue, 25 Jul 2017 16:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pe41pyEr8rK5OEA+fphBs8shKbuyVuO1laJdq8/jv6I=;
        b=DkyinF95FXCUANkgziArudj0Vgu0T/zMTyi4A699i5pdkD+MfBFjnynWNFcs1Pv2Jp
         mJIjHLmZt1sagqt4cHMXfNwiFC/pYzjfpbInaOYsNkd+n4dz0XY1p1WaKvFG8TJyyOSj
         S03pP9TVdwOSf+kG2wP6tIbaWKePalXCIS8l0cTMyLGZduXlUBIXcDqn32BxZMtwnGp3
         vCPIPK3GFCMAsREN2wMqCQSAhoOQD0JMwGsgF7t68bahseD9FhqH6ALPBYA3S/wJqbMQ
         E9EE4b9YfoN21kUa+ctsU0B00Q3hH80ujzVPcXE3jH+1D5qPkq1ZemrTguskmIFx7ozl
         nNug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pe41pyEr8rK5OEA+fphBs8shKbuyVuO1laJdq8/jv6I=;
        b=kXk3b+x+5v7gfAGC4LavPURH20sWq3JnRX1JLHrbPb7LmiNbEWbmXvflmeVWqc63TF
         ImRLoSEXcqwRrR7WkmT/Wi2JFdOtkQFMiYFqDWI4CbyV+Kf8glgn2WG6dEJTdCN/LZ2Y
         dIF45bVj9M0VPbKRNcEJTrZjVR7Lf8vZ3E6jTenaccqrmoOo+MpfIbeaElTP8hokr+MX
         T7k/hdbsSUPzmnxcyHwrn2e5Ui7h73ueQ7mnpXd+TLzc0VDnrKo8fjXJkAiRpJTDR+c4
         mqs6DqUALB6AYRTy+DXQ9uhoeYLUiImg0hTBDagmskGxI3LcWclyKVP2JIfYmeZmhRbQ
         9/IA==
X-Gm-Message-State: AIVw112tNm3W/zDVo4d4GFGR+hD+tphy87quW1LGkXHukTv7fT+EH2rs
        Y7R1HmM3sZ73ddok
X-Received: by 10.98.138.204 with SMTP id o73mr21300765pfk.5.1501026507974;
        Tue, 25 Jul 2017 16:48:27 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:cccf:9961:8336:68b3])
        by smtp.gmail.com with ESMTPSA id f74sm13683749pfk.131.2017.07.25.16.48.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Jul 2017 16:48:27 -0700 (PDT)
Date:   Tue, 25 Jul 2017 16:48:25 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 06/15] fetch: don't overlay config with submodule-config
Message-ID: <20170725234825.GC71799@google.com>
References: <20170725213928.125998-1-bmwill@google.com>
 <20170725213928.125998-7-bmwill@google.com>
 <CAGZ79kZGFhiNAYqJ9hZqDLEZt-9jYQ=o0ej2VmO0E=pZg85Fsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZGFhiNAYqJ9hZqDLEZt-9jYQ=o0ej2VmO0E=pZg85Fsg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/25, Stefan Beller wrote:
> On Tue, Jul 25, 2017 at 2:39 PM, Brandon Williams <bmwill@google.com> wrote:
> > Don't rely on overlaying the repository's config on top of the
> > submodule-config, instead query the repository's config directly for the
> > fetch_recurse field.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> 
> Reviewed-by: Stefan Beller <sbeller@google.com>
> 
> > ---
> >  builtin/fetch.c |  1 -
> >  submodule.c     | 24 +++++++++++++++++-------
> >  2 files changed, 17 insertions(+), 8 deletions(-)
> >
> > diff --git a/builtin/fetch.c b/builtin/fetch.c
> > index d84c26391..3fe99073d 100644
> > --- a/builtin/fetch.c
> > +++ b/builtin/fetch.c
> > @@ -1362,7 +1362,6 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
> >
> >         if (recurse_submodules != RECURSE_SUBMODULES_OFF) {
> >                 gitmodules_config();
> > -               git_config(submodule_config, NULL);
> >         }
> >
> >         if (all) {
> > diff --git a/submodule.c b/submodule.c
> > index 8b9e48a61..c5058a4b8 100644
> > --- a/submodule.c
> > +++ b/submodule.c
> > @@ -1210,14 +1210,24 @@ static int get_next_submodule(struct child_process *cp,
> >
> >                 default_argv = "yes";
> >                 if (spf->command_line_option == RECURSE_SUBMODULES_DEFAULT) {
> > -                       if (submodule &&
> > -                           submodule->fetch_recurse !=
> > -                                               RECURSE_SUBMODULES_NONE) {
> > -                               if (submodule->fetch_recurse ==
> > -                                               RECURSE_SUBMODULES_OFF)
> > +                       int fetch_recurse = RECURSE_SUBMODULES_NONE;
> > +
> > +                       if (submodule) {
> > +                               char *key;
> > +                               const char *value;
> > +
> > +                               fetch_recurse = submodule->fetch_recurse;
> > +                               key = xstrfmt("submodule.%s.fetchRecurseSubmodules", submodule->name);
> > +                               if (!repo_config_get_string_const(the_repository, key, &value)) {
> > +                                       fetch_recurse = parse_fetch_recurse_submodules_arg(key, value);
> > +                               }
> > +                               free(key);
> > +                       }
> 
> I wonder if it would be better to parse this in builtin/fetch.c#git_fetch_config
> and then pass it in here as a parameter, instead of looking it up directly here?
> That way it is easier to keep track of what a builtin pays attention to.

Really the fact that you can configure individual submodules in
.gitmodules to be fetched recursively or not is a terrible design IMO.
Also this is a per-submodule configuration so having it in
builtin/fetch.c would be incredibly annoying to handle.

> 
> 
> > +
> > +                       if (fetch_recurse != RECURSE_SUBMODULES_NONE) {
> > +                               if (fetch_recurse == RECURSE_SUBMODULES_OFF)
> >                                         continue;
> > -                               if (submodule->fetch_recurse ==
> > -                                               RECURSE_SUBMODULES_ON_DEMAND) {
> > +                               if (fetch_recurse == RECURSE_SUBMODULES_ON_DEMAND) {
> >                                         if (!unsorted_string_list_lookup(&changed_submodule_paths, ce->name))
> >                                                 continue;
> >                                         default_argv = "on-demand";
> > --
> > 2.14.0.rc0.400.g1c36432dff-goog
> >

-- 
Brandon Williams
