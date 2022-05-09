Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3983C433FE
	for <git@archiver.kernel.org>; Mon,  9 May 2022 21:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiEIVn2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 17:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiEIVnX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 17:43:23 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5B712EA03
        for <git@vger.kernel.org>; Mon,  9 May 2022 14:39:28 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e24so21206374wrc.9
        for <git@vger.kernel.org>; Mon, 09 May 2022 14:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ndb6lsn15mjm2DeXRHGeV7AZxZxDrRCzDEhFWxZ+Q0I=;
        b=olNOx8GBKOsmiueFbg8H4NLJDb430ZXleY6Zbz51tYWa7ZPjlHObx82Yyte/Mnz60I
         OxHlEQqKRLgNdst++doEy39qAwtJgkCTrK7q2QnnfV2khEBsUtixwjKnyaBaf0QXPrxw
         +jh2RoU69/CLqKrylJqTSbmivRYeXw2/lI4oALUqVsE+YGaowgqJ74he6VTH4vzt/ebO
         yv5u1tZxEnyEEt+tdibT+iNDQ8ptJuhmZ+eP6WTEkKzy9hd90RkMoqCONRcT7wsWELZG
         5QRQ5230Q8yIhLJcNIQ6A0O/l8Qdda93HEj7c4vbVlM6ViNAbSW0vGxs+O1NrRIptweM
         WTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ndb6lsn15mjm2DeXRHGeV7AZxZxDrRCzDEhFWxZ+Q0I=;
        b=CEi22wJy00OyZp4bHbBpedc5vjdgB0qxK4gdsDDNlLFibVGBXhsUjbFRArFiGkJEu1
         RnyaUdezENoWJaCR2DuQrofhnJ/fWLHG3chKP7hsEchVWFDc/7SUSCkqP3zT5IYD9rLV
         Up7SnEyzvgWZtvZPvUAcKbOK7jCL4bS+RPngxZTA+N6cnHqVDjCIytyml/2fV0zsOgLJ
         zkMN9VYsZ0SzA8K2WGIU95ojKeKTFKVXlkJFarO+PhsB8lobn39umevo85atWFtwwOYu
         4nVBlt9QA2l16/fT2/zUNd/GYQjkG3Mvv9MhhU8drN/n4S0QyH8cEorj2upVDbQjJ9JD
         wYIQ==
X-Gm-Message-State: AOAM533F1Xg25BUEsmHmO8L79eTKIV/t6QD0aZQvGEmC01Dp1h3hiI3e
        7n8bBKkXsH2VYhjk1Yw+FmY=
X-Google-Smtp-Source: ABdhPJxI7h7oQZ7zXXKHkFtpBZaoC7EWrjKk30Hy8KTX38yNshJ3GNuLtmw4zTfgYZWJ0/BQkppYCw==
X-Received: by 2002:a5d:5544:0:b0:20a:819d:5249 with SMTP id g4-20020a5d5544000000b0020a819d5249mr15574839wrw.461.1652132366491;
        Mon, 09 May 2022 14:39:26 -0700 (PDT)
Received: from szeder.dev (92-249-246-75.pool.digikabel.hu. [92.249.246.75])
        by smtp.gmail.com with ESMTPSA id b17-20020adff911000000b0020c5253d8casm12093525wrr.22.2022.05.09.14.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 14:39:25 -0700 (PDT)
Date:   Mon, 9 May 2022 23:39:15 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 3/3] safe.directory: document and check that it's ignored
 in the environment
Message-ID: <20220509213915.GA2043@szeder.dev>
References: <pull.1215.git.1649863951.gitgitgadget@gmail.com>
 <20220427170649.4949-1-szeder.dev@gmail.com>
 <20220427170649.4949-4-szeder.dev@gmail.com>
 <xmqqlevql0lj.fsf@gitster.g>
 <xmqqee1il09v.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqee1il09v.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 27, 2022 at 01:49:32PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > If we had GIT_SAFE_DIRECTORIES that lists the safe directories (like
> > $PATH does), that would have been absolutely necessary to document
> > how it works, but GIT_CONFIG_* is merely an implementation detail of
> > how "git -c var=val" works and I am not sure if it is even a good
> > idea to hardcode how they happen to work like these tests.  The only
> > thing the users should know is that GIT_CONFIG_{KEY,VALUE}_* are
> > used internally by the implementation and they should not muck with
> > it, no?
> 
> I misremembered.  GIT_CONFIG_COUNT and stuff are usable by end user
> scripts, but then ...
> 
> > diff --git a/Documentation/config/safe.txt b/Documentation/config/safe.txt
> > index 6d764fe0cc..ae0e2e3bdb 100644
> > --- a/Documentation/config/safe.txt
> > +++ b/Documentation/config/safe.txt
> > @@ -13,8 +13,8 @@ override any such directories specified in the system config), add a
> >  `safe.directory` entry with an empty value.
> >  +
> >  This config setting is only respected when specified in a system or global
> > -config, not when it is specified in a repository config or via the command
> > -line option `-c safe.directory=<path>`.
> > +config, not when it is specified in a repository config, via the command
> > +line option `-c safe.directory=<path>`, or in environment variables.
> 
> ... this part must clarify what environment variables it is talking
> about.
> 
>     ... via the command line option `-c safe.directory=<path>`, or
>     via the GIT_CONFIG_{KEY,VALUE} mechanism.

Well, the proposed phrasing covers all environment variables that
affect the configuration.

It doesn't feel right to explicitly list all those variables,
including GIT_CONFIG_PARAMETERS, because that vairable is such an
implementation detail that it isn't even mentioned elsewhere in the
documentation at all.  OTOH, listing only some of the ignored
variables but omitting others doesn't feel quite right either, hence
the general "in environment variables".

> or something, perhaps.  I actually do think it is a useful addition
> to have GIT_SAFE_DIRECTORIES environment variable that should NOT be
> ignored.

Is it safe to have such an environment variable?

So, it's quite clear why 'safe.directory' is ignored in the repository
config: it can be under control of someone else, and thus a malicious
repositoy could trivially safe-list itself.  However, it's unclear (to
me) why 'git -c safe.directory=...' is ignored: 8959555cee
(setup_git_directory(): add an owner check for the top-level
directory, 2022-03-02) only states that it's ignored, but doesn't
justify why.  Now, let's suppose that there was a compelling reason to
do so, e.g. in some way that I don't readily see it can be spoofed and
thus could be abused by an attacker to safe-list a malicious
repository.  If that were indeed the case, then couldn't
'GIT_SAFE_DIRECTORIES=/path/... git cmd' could be spoofed and abused
just as easily?

Or to approach it from the opposite direction: if such a
GIT_SAFE_DIRECTORIES environment variable is safe, then why should we
ignore 'safe.directory' in the command line, or in the environment
for that matter?

