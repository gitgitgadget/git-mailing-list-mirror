Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3279CC433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 23:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F261161107
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 23:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbhDHXkK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 19:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbhDHXkI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 19:40:08 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDA1C061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 16:39:56 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id e14so5761352ejz.11
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 16:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=rYwnKPe7Vs1SkTpGVPmER7LoEpUXbkWSW6fs+ah7qYQ=;
        b=iq8yhcQgL0Y+SFgxH1M/t9DL8djMov2ReGiJiPbUD54O69QMZDoz1sZ8iZFZof+sQi
         6SheKu2WzADGLhPCKnVMHjKNd21i63Gmc6XsrmkHpaX4Ff8F3ZcbYanEHz48i76QsUR6
         ynU4romdZ1sXP4nOq7r45MB4Xhnd+HSPP6b0KlMeTOmqdSRwgYmBdqqajfVIYqzPKbdH
         Si8z9KXJTloYzchyEmHfuoLoepfokDEQrdydyNJ6mdCBslSBybswRzr5Sqxf7FZkE5iK
         3rnKSzqAGpzDVlJRcfERLDY2w/EIHN0OIbQ/W8KNnP1MiGof6d1JO8RM/yCo/2UDoBc+
         kKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=rYwnKPe7Vs1SkTpGVPmER7LoEpUXbkWSW6fs+ah7qYQ=;
        b=qunWLaqT7KUy/Y0SlzeTOSa9IhYtVnyu46WBLJucM/tDL23Jd4L3s2kJlnYjYQ4jMc
         Ii7M7Wo88yA23aXOHpla38v9f2fUDRFismHwZIlelJWaUrU7iuHbK+iXy4sjws51QXnJ
         troG4TbnYwMm+LS8FEd5Mu6cb7HWaP6H18NCY53yXOdBfVgT3L6fE7hPEaK0SYgpjf8b
         OB7pslDU/pvBObVAtsltu2EOf3tBxOHRUxRwaQgKJk6cbMtGpyyn5hCfYCDvBJmldmPt
         GrJHT9g++ONif9g4ekJ9nP9U3+6a4v4DniA1hd6a5RFeqJhl7vffqxdh2rEbuRwJjyOJ
         G34A==
X-Gm-Message-State: AOAM531PBsYB26uGZxo7nAm3OuddU6ZvqUepr9w5mWSDKwGS7cAf1xun
        6fpY5zPKXS4NCOsB3L9L5jY=
X-Google-Smtp-Source: ABdhPJwqsoMlgwvkiwDVAIhUoz1KkE4RiMKd8BSVar40wp/cwW4Zgzb8KIS1ccPtKhu+Es0J5f9jdw==
X-Received: by 2002:a17:907:2be9:: with SMTP id gv41mr464747ejc.298.1617925195090;
        Thu, 08 Apr 2021 16:39:55 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id ca1sm420077edb.76.2021.04.08.16.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 16:39:54 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH] config: Introduce GIT_CONFIG_NOGLOBAL
References: <a23382059bb57022dd1e40d1c2c9a11307b0ff3b.1617891426.git.ps@pks.im>
 <xmqqczv4vgck.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqczv4vgck.fsf@gitster.g>
Date:   Fri, 09 Apr 2021 01:39:54 +0200
Message-ID: <87wntcgxbp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 08 2021, Junio C Hamano wrote:

> Patrick Steinhardt <ps@pks.im> writes:
> [...]
>> Introduce a new GIT_CONFIG_NOGLOBAL envvar, which is the simple
>> equivalent to GIT_CONFIG_NOSYSTEM. If set to true, git will skip reading
>> both `~/.gitconfig` and `$XDG_CONFIG_HOME/git/config`.
>
> I do not think we'd add an unbounded number of new configuration
> sources to the existing three-level hierarchy of system-wide
> (/etc/gitconfig), per-user ($HOME/.gitconfig), and local
> (.git/config), so it is not too bad, from scalability point of view,
> to keep adding new GIT_CONFIG_NO$FROTZ variables.
>
> Let me go in a couple of different tangents a bit, thinking aloud.
>
> Tangent One.  I wonder if the presense of includeIf.<cond>.path
> changes the "we won't have unbounded, so adding another here is OK"
> reasoning.  If somebody wanted to say "Do not use the paths that
> match this and that pattern", it is likely that we'd end up having
> to support a single variable that allows more than one "value".  In
> a straw-man syntax "GIT_CONFIG_EXCLUDE='/home/gitster/*
> /home/peff/*'" might be a way to say "do not use files that are
> under these two directories.
>
> And when that happens, we'd probably notice that it is easier for
> users to configure, if they can treat 'system' and 'global' as just
> another special pattern to place on that list. //system and //global
> might be the syntax we'd choose when time comes, i.e.
>
> 	GIT_CONFIG_EXCLUDE='//system //global'
>
> might become a more scalable replacement for
>
> 	GIT_CONFIG_NOSYSTEM=yes GIT_CONFIG_NOHOME=yes
>
> Tangent Two.  One thing we never managed to properly test in our
> test suite is the unctioning of GIT_CONFIG_NOSYSTEM.  As we do not
> want to get broken by whatever is in /etc/gitconfig, all our tests
> run with the environment variable set.  For the same reason, in
> order to avoid getting influenced by whatever the tester has in
> $HOME/.gitconfig, we export HOME set to the throw-away directory
> created during the test and control what is in the config file in
> that directory.  In hindsight, it might have been a better design to
> use GIT_CONFIG_SYSTEM variable that points at a path to be used as a
> replacement for /etc/gitconfig when it is set; pointing /dev/null
> with the variable would have been the natural way to say "do not use
> anything from system configuration".  And GIT_CONFIG_GLOBAL can
> easily follow the same pattern.
>
> So, from these two perspective, for the longer term end-user
> experience, I am not 100% onboard with GIT_CONFIG_NOGLOBAL.  An
> alternative that allows us to move away from GIT_CONFIG_NOSYSTEM in
> the direction to the tangent #2 would be not to repeat the same
> mistake by doing GIT_CONFIG_NOGLOBAL, and instead adding
> GIT_CONFIG_GLOBAL, which is
>
>  (1) when not set, it does not do anything,
>
>  (2) when set to "/dev/null" (a literal string; you do not have to
>     spell it "NUL" when on Windows), it acts just like the case
>     where your GIT_CONFIG_NOSYSTEM is set,
>
>  (3) when set to any other string, it is taken as a filename that
>      has the global configuration.  Unlike $HOME/.gitconfig or
>      $XDG_HOME/git/config, it is an error if the named file does not
>      exist (this is to catch misconfiguration).
>
> And once this is accepted by users and established as a pattern, we
> could migrate GIT_CONFIG_NOSYSTEM to GIT_CONFIG_SYSTEM=/dev/null
>
>
> Having said all that (meaning: I am not 100% onboard with _NOGLOBAL
> and think _GLOBAL=/dev/null might be a better design), let's give it
> a review under the assumption that _NOGLOBAL is the design we would
> want to choose.

I think doing this via env vars is inherently nasty, but can't think of
a good way to implement it properly without major refactoring.

IMO the "properly" would be that we'd just support this sort of thing as
first-class config syntax, as I've suggested before e.g. in the repo
hooks/config topic.

But to do that we couldn't "stream" the config reading as we do now,
we'd need to read system/global/local, and when we saw some new
meta-syntax apply those ignores to files we already read, and only then
start streaming things to config callbacks.

See "config.ignore.*" in
https://lore.kernel.org/git/87y2ebo16v.fsf@evledraar.gmail.com/
