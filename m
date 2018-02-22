Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A89E21F404
	for <e@80x24.org>; Thu, 22 Feb 2018 13:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932555AbeBVNio (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 08:38:44 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:53230 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932455AbeBVNim (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 08:38:42 -0500
Received: by mail-wm0-f44.google.com with SMTP id t3so3961340wmc.2
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 05:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=mfmHvhBxUiV2GaHbyzAWBAvH9UaPFtUo309dLgF2N0s=;
        b=kAEvWOdd/dUReVArVOz7f1MxjFbHobNVoIahWEzh4rSFwAvcOetMwgzZtk2+KMYzXU
         fbj6gZ4A9OlFGb/1QIXTgAP8jBxD36xiO1yrlfVBqAQlrriXiejquqohITkW1K6CXaFA
         cKr+HujXYpnvJiKCA/265TJ3rOjiH+sZ7Z7coqs4wWJs879sJCuboOF8ztIa8g78xYVw
         Zj6lPtPX9SLxqSrYJCmp/5x66Hw3AzZVlVAwAsLlFkEe53YqOTzVGDm6rxOir0bT9NAG
         mW0sDB22d3rxmiqKipF9+rzbK1DEUNwin/8cBGTS6O65dDqEt3BJTepnx8ZZZzQo/WF3
         AFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=mfmHvhBxUiV2GaHbyzAWBAvH9UaPFtUo309dLgF2N0s=;
        b=ewEL5g1CsX6rvqDqsvOcOrg05c1LqplzfsqdwYJOLQLuT67XfNWOxBN0xBSvzTmXXW
         I4zFZhVrlXlMDCHAxBZVc2JO0aufZqqVN8yzmg2/kCtbhq60uecvi9+YZ67cLJJX09uH
         e+iDDfvUoYLEdVBGOjYmN+rCwmqq/Bmu/yW9xsJXv+OeSu8v/2xxadPt/s5gM4O0omiC
         j9l2oRv5nc7IKcbgcOg4Qq4MQ0GN8o9772Ua//j1omAF9N8PrnTGQ0LvO/34eqmd8k/R
         gLgo7558+SHwakU1OedYWHyD3A4ykXUEpAMypXFHIqESsGWe7DjOOltntw0S8HKX2LDQ
         V/NQ==
X-Gm-Message-State: APf1xPC+L0b3ohTy93469HQAlXPoDJmjVgQX1lI0ySmtV2Z67UCHdGVa
        D1E8jE+soG9yDl9b/lJqvWW1yv02
X-Google-Smtp-Source: AH8x226OxOWaQPWeeDyVALal0Urp8wf1inX6Xgvmg4ipX/X7IY3PeKBJ2h5nm4/WS1YywTTDb6zpUg==
X-Received: by 10.80.210.194 with SMTP id q2mr9304021edg.305.1519306721148;
        Thu, 22 Feb 2018 05:38:41 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id x44sm315700ede.7.2018.02.22.05.38.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Feb 2018 05:38:39 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, doron.behar@gmail.com
Subject: Re: [PATCH 1/2] parse-options: expand $HOME on filename options
References: <20180214101019.gaenosifgq3wx2nm@NUC.localdomain> <20180214105149.28896-1-pclouds@gmail.com> <87wozffavp.fsf@evledraar.gmail.com> <CACsJy8BsUsT6iO9_68+rHnZG5B-tcaXZAXR88nh8DgR65zvVKw@mail.gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <CACsJy8BsUsT6iO9_68+rHnZG5B-tcaXZAXR88nh8DgR65zvVKw@mail.gmail.com>
Date:   Thu, 22 Feb 2018 14:38:39 +0100
Message-ID: <87606pf8kg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 22 2018, Duy Nguyen jotted:

> On Thu, Feb 15, 2018 at 5:46 AM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>> In general I'm mildly negative on adding this, for every user like Doron
>> who'll be less confused by a hack like this, you'll have other users
>> who'll be confused about git inexplicably working with ~ in the middle
>> of strings, even though;
>>
>>     $ echo git init --template ~/path
>>     git init --template /home/avar/path
>>     $ echo git init --template=~/path
>>     git init --template=~/path
>
> If you have a directory named '~', I expect you are already used to
> prefixing it with './' because '~' will be expanded in many places
> where you might want to avoid.

Indeed. I've never had this use-case, just saying if it's being changed
it makes sense to have a small test for it somewhere.

>> I think it makes more sense to just leave such expansion to the shell,
>> and not try to magically expand it after the fact, since it's both
>> confusing (user: why does this work with git and not this other
>> program?), and as shown above changes existing semantics.
>>
>> We'll also be setting ourselves up for more disappointed users who'll
>> notice that e.g. `git clone file://~/path` doesn't work, but `git clone
>> file://$HOME/path` does, requiring more hacks to expand ~ in more
>> codepaths. Will they also expact `git log -G~` to find references to
>> their homedir in their dotfiles.git?
>>
>> I think this way lies madness, and it's better to just avoid it.
>
> Well. That's a bit extreme, I think if we add this then we handle case
> by case in future when it makes sense, not blindly expanding '~'
> everywhere.
>
> The problem I have with this --template=~/path is tab-completion
> actually completes the path, which (mis)leads me to think the command
> will accept '~/' too. But this looks like a bug in git-completion.bash
> though, it's a bit eager in completing stuff (or maybe it completes
> "--template ~/path" and "--template=~/path" the same way).

Ah I see, so you're doing "git init --template=~/<TAB>".

> I don't feel strongly about this. I'm OK with dropping these patches
> if people think it's not a good idea (then I will try to fix
> git-completion.bash not to complete '~' in this case).

I don't feel strongly about it either, just mildly negative on
introducing magic that gives you different behavior than shells do by
default.

I wonder if the consistency with the tab completion wouldn't be better
done by teaching the tab completion to just expand --template=~/<TAB> to
e.g. --template=/home/duy/.

On my (Debian) system doing e.g.:

    echo $HOME/bin/<TAB>

Will expand to:

    echo /home/avar/bin/

Maybe we could intercept that in the completion and ~ to the value of
$HOME. It would give completion that did the right thing, without the
expectation that ~ is going to be magic in some places and not others.

>> But I think that if we're going to keep it it needs some tests & docs to
>> point confused users to.
