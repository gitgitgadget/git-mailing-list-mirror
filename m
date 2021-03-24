Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B236C433E0
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 17:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD48261A20
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 17:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237281AbhCXR4k (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 13:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237176AbhCXR4J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 13:56:09 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8625C0613DE
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 10:56:08 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id mz6-20020a17090b3786b02900c16cb41d63so1629349pjb.2
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 10:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1Nd6VBuEfYg8YCAcySDHw+ctfMCUYlDF3hA3mGA42KI=;
        b=V6AKbe6VfTiIqns7CoQu03EvYTb9HIbM881rXXyaMe8ZvpsN7W49ThEIvzGCwoYIDy
         geOa+pH9rzQWkOcMP7vdFmlycg3ocfbkVcA/HA22KRcfp5Qyx0s7umTDmhGOv1sMR3i2
         31QxraEdncSiZ2ILh0iG6TfKiErdwM5VF3r/OEq2EDtxJPsysP9lQnHkxOicig7UJi+p
         jmScnSNHs6IM0QfBJOBECfEMZ/bxupwicCfZ3i/WORLkOIafO76TwpCSMF0sgAI+q14z
         EQanwLXpndsIbSHIZcuOpbDBIry7yZeuwqVEX/PvA7R4wBUKX8Q3p8HU8AQM0m3N83Xv
         BxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1Nd6VBuEfYg8YCAcySDHw+ctfMCUYlDF3hA3mGA42KI=;
        b=o76x0t7oRtIVmbYjafB21txVt/Xz4xqbmI2prnTgDxeiyQt5m8gM+x8DSIKEzJHvdo
         y5pR2RJFpjV7l5CnLkhLUnFPBRV78wsNl7KayOu6vNKQySfRFbb/DQnoYCmv4TYIwwLd
         g1ixbko1XedAAYmR6xZh4TYv1fr7PXK1Do0lWKWxAizzbL6Wq11tiHp/k/dtTJoTw45w
         eX4FIlUcMGqY8gr58pgbIqZyRcjZh9VnLlOFTf4mK4aT/pdbdrG4qzzqLk2C5prKrDiA
         1EtKLD0qbX5z1y9budU+jDCKZGGNER7gtjJYsrZ+wEV77eA9luFW2Zh9ZHNk9wCkHzMm
         2biw==
X-Gm-Message-State: AOAM530cYdZMqpCNWPR38e/Mjaw02KhdzxjB9rLx8FliClGf90UQrhhD
        p/I74qoj2Sk6MRn8e4yU9KkEBRLXkeN5Bg==
X-Google-Smtp-Source: ABdhPJxzMB34nz13G46YwkJ9v8uTfJKLMq/2Rq7Q36nb6IunV3UQ2VEzTfnpzWBQYt/QLznSOQpOJA==
X-Received: by 2002:a17:903:31ca:b029:e6:65f:ca87 with SMTP id v10-20020a17090331cab02900e6065fca87mr4694766ple.85.1616608568130;
        Wed, 24 Mar 2021 10:56:08 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:d027:9201:1f66:e720])
        by smtp.gmail.com with ESMTPSA id i14sm3210010pjh.17.2021.03.24.10.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 10:56:07 -0700 (PDT)
Date:   Wed, 24 Mar 2021 10:56:01 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 04/37] hook: include hookdir hook in list
Message-ID: <YFt9MQsJAJsjWqo2@google.com>
References: <20210311021037.3001235-1-emilyshaffer@google.com>
 <20210311021037.3001235-5-emilyshaffer@google.com>
 <87lfashj03.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lfashj03.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 12, 2021 at 09:30:04AM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> On Thu, Mar 11 2021, Emily Shaffer wrote:
> 
> > Historically, hooks are declared by placing an executable into
> > $GIT_DIR/hooks/$HOOKNAME (or $HOOKDIR/$HOOKNAME). Although hooks taken
> > from the config are more featureful than hooks placed in the $HOOKDIR,
> > those hooks should not stop working for users who already have them.
> > Let's list them to the user, but instead of displaying a config scope
> > (e.g. "global: blah") we can prefix them with "hookdir:".
> >
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > ---
> >
> > Notes:
> >     Since v7, fix some nits from Jonathan Tan. The largest is to move reference to
> >     "hookdir annotation" from this commit to the next one which introduces the
> >     hook.runHookDir option.
> >
> >  builtin/hook.c                | 11 +++++++++--
> >  hook.c                        | 17 +++++++++++++++++
> >  hook.h                        |  1 +
> >  t/t1360-config-based-hooks.sh | 19 +++++++++++++++++++
> >  4 files changed, 46 insertions(+), 2 deletions(-)
> >
> > diff --git a/builtin/hook.c b/builtin/hook.c
> > index bb64cd77ca..c8fbfbb39d 100644
> > --- a/builtin/hook.c
> > +++ b/builtin/hook.c
> > @@ -40,10 +40,15 @@ static int list(int argc, const char **argv, const char *prefix)
> >  
> >  	list_for_each(pos, head) {
> >  		struct hook *item = list_entry(pos, struct hook, list);
> > -		if (item)
> > +		item = list_entry(pos, struct hook, list);
> > +		if (item) {
> > +			/* Don't translate 'hookdir' - it matches the config */
> 
> Let's prefix comments for translators with /* TRANSLATORS: .., see the
> coding style doc. That's what they'll see, and this is useful to them.
> 
> Better yet have a note here about the first argument being 'system',
> 'local' etc., which I had to source spelunge for, and translators won't
> have any idea about unless the magic parameter is documented.

It's not a comment for translators. It's a comment for someone helpful
who comes later and says "oh, none of this is marked for translation,
I'd better fix that."

> 
> > +setup_hookdir () {
> > +	mkdir .git/hooks
> > +	write_script .git/hooks/pre-commit <<-EOF
> > +	echo \"Legacy Hook\"
> 
> Nit, "'s not needed, but it also seems nothing uses this, so if it's
> just a pass-through script either "exit 0", or actually check if it's
> run or something?

The output is checked in the run tests later on. I can remove it for
this commit if you want.

> 
> > [...]
> > +test_expect_success 'git hook list shows hooks from the hookdir' '
> > +	setup_hookdir &&
> > +
> > +	cat >expected <<-EOF &&
> > +	hookdir: $(pwd)/.git/hooks/pre-commit
> > +	EOF
> > +
> > +	git hook list pre-commit >actual &&
> > +	test_cmp expected actual
> > +'
> 
> Ah, so it's just checking if it exists...
