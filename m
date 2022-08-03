Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81D6C19F2B
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 21:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236259AbiHCVes (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 17:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbiHCVeq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 17:34:46 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752851C93C
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 14:34:45 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id o22so7566462edc.10
        for <git@vger.kernel.org>; Wed, 03 Aug 2022 14:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=kTYTTV9lPZOolda2yk6/EJuPC1RjGw2ZMoGdJLK0qwM=;
        b=KyWrl4tZ96U56g4nlC8DPeHL/rjmolnO+5k8RUvQmbqB4uWPV7HvSctUu/6y0/yGm2
         hsuBAOT8e8rKLNRLL/6EeyF5rFj4eRgcFK6upSvqqFAw6wGc0/n2K05iefSha1lhhiaV
         gtPu9K23Y+XAhbQDeh+zjgxWe/Azlo1T9gar2bPWs+cexJ37B5rUMtXfe6NH0ex1lb+5
         gMdSLOWXI+dNu96707EHeEm7BqK/58Lp52RRymX9yJjmUH5iWalu7qTIliT3ctXe7fJw
         +ot63n2nTVldc1yQIthH4uozd9c2ywkB794BlkaRaYRuNfxcVCyk8AU2vrgmkupAS1ja
         gtLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kTYTTV9lPZOolda2yk6/EJuPC1RjGw2ZMoGdJLK0qwM=;
        b=gLYsw4BvVasTcTnHOp6O3ryAIGbn9Hsw50QyiEzbs73C40FLO58n/J+SY9KefCyNwO
         /ntHMyyMHuUi5Nq5qV5FbkyaS0JJvruxwwBu70dIIuAuNPBqGmZLeohewkszmYhiiH7e
         Dnk/nFg72iyjq5aJkN5Kztd4B9DzTyJzxp43b5UdDEjW5SiPpRdfK+pVNzKkdPUr4nx3
         XA6j7zuVZ71D60bCqaqy9X1c9jcSczHAezNmM8wjhsCHOvcL3zzdxVvZgV+RiCy2XpJY
         oJrDAK7xNin+eXrsyZ8srhJ+0GsSzlWem97FD9EEa+Mk9nhQEJ47OfIhKnqn5sRo0MF2
         QxVg==
X-Gm-Message-State: ACgBeo3GdFQuuTY6h5/UHToNax/Pb1x3yXXlFa91IgvruU7YPMW3TgNI
        GHJlXxATbr4EPClvh9i4tAXAfQlv+oQ=
X-Google-Smtp-Source: AA6agR6e3Ed4mfAo+zcJEoD/SfOzPBEUFzy6/k5ocqjZ2tmEDzn9ZMi76dG1X5Suh5+JgrlTojBzxg==
X-Received: by 2002:a05:6402:3485:b0:43d:7fe0:74d1 with SMTP id v5-20020a056402348500b0043d7fe074d1mr19232707edc.413.1659562484045;
        Wed, 03 Aug 2022 14:34:44 -0700 (PDT)
Received: from localhost (78-131-14-72.pool.digikabel.hu. [78.131.14.72])
        by smtp.gmail.com with ESMTPSA id j21-20020a170906279500b0073065767404sm4621499ejc.34.2022.08.03.14.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 14:34:43 -0700 (PDT)
Date:   Wed, 3 Aug 2022 23:34:30 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 01/20] git.c: update NO_PARSEOPT markings
Message-ID: <20220803213430.GB10040@szeder.dev>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <20220725123857.2773963-2-szeder.dev@gmail.com>
 <220725.86mtcxp8ib.gmgdl@evledraar.gmail.com>
 <20220802173754.GA10040@szeder.dev>
 <xmqqsfmefjja.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqsfmefjja.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 02, 2022 at 02:00:09PM -0700, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > Dunno.  I don't like this NO_PARSEOPT thing, and instead of testing it
> > I'm thinking about removing it altogether.
> 
> Sorry if this is obvious to the others, but I am confused here.
> 
> Lack of NO_PARSEOPT bit is used as a mark to say "this subcommand
> takes '--git-completion-helper' option to help listing the options,
> so include it in the 'git --list-cmds=parseopt' output", right?  I
> do not mind removing an unused or unnecessary bit at all, but what
> is your plan of getting rid of the bit?  Will we make sure everybody
> supports the "--git-completion-helper" option?

A bit of clarification first:  This NO_PARSEOPT flag only matters for
git commands for which we don't have a corresponding _git_cmd()
completion function in our Bash completion script.  If there is such a
function, then either:

  - that function has a hardcoded list of --options, for commands that
    don't use parse-options, or

  - it invokes '__gitcomp_builtin cmd' to complete --options with the
    help of '--git-completion-helper'.  Note that this works even if
    said 'cmd' were marked with the NO_PARSEOPT flag, moreover,
    'cmd' doesn't even have to be a builtin, i.e. 'git send-email
    --git-completion-helper' works as Ævar pointed out.

For the many builtin (mostly plumbing) commands that do use
parse-options but don't have such a _git_cmd() completion function, we
added the generic fallback __git_complete_common() to complete their
options with '__gitcomp_builtin cmd'.  And this is where the
NO_PARSEOPT flag matters, because the completion script only ever
invokes that fallback function for commands that are not marked with
that flag.  See 9f642a7169 (completion: add --option completion for
most builtin commands, 2018-03-24) for more details.

So far so good.

Now, instead of relying on (possibly outdated) NO_PARSEOPT markings
telling us not to use that fallback function, i.e. not invoke certain
commands with '--git-completion-helper', I'm considering whether we
could rely on our git commands behaving sensibly when invoked with
'--git-completion-helper'.  I.e. a git command either supports that
option and lists all its --options, or fails fast because of the
unknown option without printing anything to stdout.  Then perhaps the
completion script doesn't even have to pay attention to this error,
because it will do the right thing as long as the

  options=$(git builtin --git-completion-helper)

command fills $options with the list of --options or leaves it empty.

AFAICT almost all builtins behave sensibly in this sense (I haven't
looked at non-builtin git commands yet), with the exception of:

  - 'git credential' and 'fast-import': these two attempt to read from
    stdin before recognizing the unknown --git-completion-helper
    option and hang.  On one hand, this hang can be easily prevented
    by redirecting stdin from /dev/null (but 'fast-import' leaves
    behind a crash file, which is not nice).  OTOH, I'm inclined to
    consider this behavior as a bug: all commands should fail fast on
    unknown --options.

  - 'git rev-parse --git-completion-helper' prints
    '--git-completion-helper' to stdout.  I forgot about this, but
    this is how this command is supposed to behave.  I guess I'll just
    have to special case this command in the completion script...

Of course we can only do this with git builtin commands, because those
are under our control and we can make sure that they behave sensibly.
We must not pass '--git-completion-helper' to any 'git-foo' command
that might be present in $PATH, because who knows what they might do.

However, I'll definitely need to think more about corner cases, e.g.
hitting 'git cmd --<TAB>' while outside a repository doesn't even
reaches parse_options() if that command requires a repository.  But
let's leave that for later and get this series in shape first.

