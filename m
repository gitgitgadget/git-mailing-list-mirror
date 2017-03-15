Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA9BD202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 17:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751657AbdCORDU (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 13:03:20 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36750 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751277AbdCORCg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 13:02:36 -0400
Received: by mail-pf0-f173.google.com with SMTP id o126so11484128pfb.3
        for <git@vger.kernel.org>; Wed, 15 Mar 2017 10:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=25xJLWGdNLLWY1rP42SM51lsPoknAPyIIbDcSUdKDYQ=;
        b=UhbEwxENt2VKpPeBlcsqUlETcBzzXMddhN1IqVjMt3uomD+fNvg/JBdxZ/sLAky+Wo
         rJAMCMQoOImDUdyAn1QKCNcdbTBsS6VldZwKd68KLR1nV2fDniQmnmGHmmTM3aRHjlVO
         sD8UbqenMIynodrSUa/VFTqiPseDJlsmDSizkVye/qygUuAsGJCjnqISnNHPDCsgwweq
         pUs9CTFBxSCN1UDDTrAIA8CEHT/DsSKXDBhNuQ+4+TpEd4EPF9OATLrFE5ISUleM7o1K
         grdxzsPfZpF5kKdM/r74vNcs9r3tgQgcNGijaWSoekFOWIvWOS0HySOksVYoMPZzLDKx
         FEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=25xJLWGdNLLWY1rP42SM51lsPoknAPyIIbDcSUdKDYQ=;
        b=n7hsIkVdIQr00YA+sMUWjKDEaJq45C8B1daZkuCcjWmi3lLeyDXSuI5FvxLE1+ryjc
         jzVEbIBCP/qcNOovyt7SOXKMpuMhnNUHGWbkYaqXDs5/UiKHIKo3qTr0Uc7kq4vHyYIT
         A7nZhcDD7suFmoJ088QUQJ8QsYUWAX7MPJD7dkF3SMdGQaaglpARl5qYqdyyLH5ESJZU
         hrrPiqGEkMOeIYQrWmnOrmqE0qHy2Vzq0dbJK0Ob8mW1/szqtRo2yQFA3Q+mSNdmcnIw
         pY9a2Ns5QaPhxWp8tAem0J+bsqZ8VRZ8qJk/wocXAO+z2Jfih0QUqzaB8gehTdXQZhod
         yYWA==
X-Gm-Message-State: AFeK/H2KNmKEGAazwNoMGvD3jaJ63RBEmkP2Gq6ogyfXKAswqqxeGAAQJyiq14csLgFnCeYG
X-Received: by 10.98.4.71 with SMTP id 68mr4883808pfe.92.1489597354610;
        Wed, 15 Mar 2017 10:02:34 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:e5fd:c660:1f84:47a3])
        by smtp.gmail.com with ESMTPSA id s21sm5423531pfs.87.2017.03.15.10.02.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Mar 2017 10:02:33 -0700 (PDT)
Date:   Wed, 15 Mar 2017 10:02:32 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 4/4] ls-files: fix bug when recursing with relative
 pathspec
Message-ID: <20170315170232.GA159137@google.com>
References: <20170224235100.52627-1-bmwill@google.com>
 <20170314221100.24856-1-bmwill@google.com>
 <20170314221100.24856-5-bmwill@google.com>
 <CAGZ79kaRP0Gbw+zwot_vYo7E=7GMwU7chJsJ7TL8g4TJwivC5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kaRP0Gbw+zwot_vYo7E=7GMwU7chJsJ7TL8g4TJwivC5Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/14, Stefan Beller wrote:
> On Tue, Mar 14, 2017 at 3:11 PM, Brandon Williams <bmwill@google.com> wrote:
> > When using the --recurse-submodules flag with a relative pathspec which
> > includes "..", an error is produced inside the child process spawned for a
> > submodule.  When creating the pathspec struct in the child, the ".." is
> > interpreted to mean "go up a directory" which causes an error stating that the
> > path ".." is outside of the repository.
> >
> > While it is true that ".." is outside the scope of the submodule, it is
> > confusing to a user who originally invoked the command where ".." was indeed
> > still inside the scope of the superproject.  Since the child process launched
> > for the submodule has some context that it is operating underneath a
> > superproject, this error could be avoided.
> >
> > This patch fixes the bug by passing the 'prefix' to the child process.  Now
> > each child process that works on a submodule has two points of reference to the
> > superproject: (1) the 'super_prefix' which is the path from the root of the
> > superproject down to root of the submodule and (2) the 'prefix' which is the
> > path from the root of the superproject down to the directory where the user
> > invoked the git command.
> >
> > With these two pieces of information a child process can correctly interpret
> > the pathspecs provided by the user as well as being able to properly format its
> > output relative to the directory the user invoked the original command from.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  builtin/ls-files.c                     | 41 +++++++++++++++++-----------------
> >  t/t3007-ls-files-recurse-submodules.sh | 39 ++++++++++++++++++++++++++++++++
> >  2 files changed, 60 insertions(+), 20 deletions(-)
> >
> > diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> > index 1c0f057d0..d449e46db 100644
> > --- a/builtin/ls-files.c
> > +++ b/builtin/ls-files.c
> > @@ -30,7 +30,7 @@ static int line_terminator = '\n';
> >  static int debug_mode;
> >  static int show_eol;
> >  static int recurse_submodules;
> > -static struct argv_array submodules_options = ARGV_ARRAY_INIT;
> > +static struct argv_array submodule_options = ARGV_ARRAY_INIT;
> >
> >  static const char *prefix;
> >  static const char *super_prefix;
> > @@ -172,20 +172,27 @@ static void show_killed_files(struct dir_struct *dir)
> >  /*
> >   * Compile an argv_array with all of the options supported by --recurse_submodules
> >   */
> > -static void compile_submodule_options(const struct dir_struct *dir, int show_tag)
> > +static void compile_submodule_options(const char **argv,
> > +                                     const struct dir_struct *dir,
> > +                                     int show_tag)
> >  {
> >         if (line_terminator == '\0')
> > -               argv_array_push(&submodules_options, "-z");
> > +               argv_array_push(&submodule_options, "-z");
> >         if (show_tag)
> > -               argv_array_push(&submodules_options, "-t");
> > +               argv_array_push(&submodule_options, "-t");
> >         if (show_valid_bit)
> > -               argv_array_push(&submodules_options, "-v");
> > +               argv_array_push(&submodule_options, "-v");
> >         if (show_cached)
> > -               argv_array_push(&submodules_options, "--cached");
> > +               argv_array_push(&submodule_options, "--cached");
> >         if (show_eol)
> > -               argv_array_push(&submodules_options, "--eol");
> > +               argv_array_push(&submodule_options, "--eol");
> >         if (debug_mode)
> > -               argv_array_push(&submodules_options, "--debug");
> > +               argv_array_push(&submodule_options, "--debug");
> 
> Up to here we only rename a variable? If you want to help reviewers,
> please separate this into two patches. One refactoring, stating it doesn't
> change behavior; and the other adding the behavioral changes.

I can do that.

> 
> > +
> > +       /* Add Pathspecs */
> > +       argv_array_push(&submodule_options, "--");
> > +       for (; *argv; argv++)
> > +               argv_array_push(&submodule_options, *argv);
> >  }

-- 
Brandon Williams
