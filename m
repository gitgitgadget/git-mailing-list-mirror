Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592EAC2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 14:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 262DA61244
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 14:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234235AbhFNOZv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 10:25:51 -0400
Received: from mail-ej1-f50.google.com ([209.85.218.50]:42523 "EHLO
        mail-ej1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbhFNOZZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 10:25:25 -0400
Received: by mail-ej1-f50.google.com with SMTP id k25so16999911eja.9
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 07:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=jQ9cDHQXAgRM9gd8PZWmKqrnlfp7/0jyLsyXJQw0yko=;
        b=lgqLqa1BO1E94014bcahf7Yfp/tqijisHlWnA1RSO/iDKAG22VciYvL67Kdwb4JR/6
         /dnSLiGjFzYA6mqcEEc6XYo9c8QUriGwKKnf2nLUgdhTGhgMDKnc4ssYC009AuvX09oA
         LcwYuNUcyrF/r0c1gZxY083a0qo3oBUj8MAsxJ/7tJIbHUlXWUiAk+Oa+hg2svAVgntG
         5J+53BAWOdMua14sH45kDfCMQLk9a/QA0H+aT5HE6f1JFypHc8n42w5hakW8oaywjOJe
         ASLMW2yYWx1ywbWZP08l1ZXRl9Wfj0CLeXJB3m1yghoV+kmRZC8w+17q9g1Zd0IbK0qA
         jenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=jQ9cDHQXAgRM9gd8PZWmKqrnlfp7/0jyLsyXJQw0yko=;
        b=f3nUDiQ1JD+i9GgJHFeSPz0CeTsNLu/0S5wI/oB0PR/NCEUshqd2prreG59kae/erK
         KMrM8bg0aP8Mnk02b3AGaeqxxQ5sfYAdnWyUC05f/uP4SZNLt+Dyc0jaWdG4kei3xFXM
         4Z1cl7kS/9VVWr6BlD8BzT3aR8OVuACR3bT7qyl2urC32BSXNrIQOcZ+EO/3yIgRAeFE
         SLS0wpCybRZxCXlrV8JRssAYNyj6OkV8MyCE/jbei5rTvPWOZDwdpX6kd5zCkil4wmOj
         UPDf+BjF1CSu8PMwQXvVWJ/ap49ulzI0vg9wsNrhmD6Lt0z2JOFkVHuqW4LZsKPLuBdP
         dbjg==
X-Gm-Message-State: AOAM532NFJdID+2EhTSkpW10BOaYGDGaxI6W+yfp3dcimE6Li+ouc0p3
        l0GczlPWIIBmgfXxczekbTadunODMga6WA==
X-Google-Smtp-Source: ABdhPJycPkwG4ResK5DBYgkOuj517yzNtuA2QocrudK9mVlG4PztCuLf2XLFpJhQRYrincIdRzyMdQ==
X-Received: by 2002:a17:906:6d43:: with SMTP id a3mr15602195ejt.142.1623680525956;
        Mon, 14 Jun 2021 07:22:05 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id d24sm9058083edr.95.2021.06.14.07.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 07:22:05 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Luke Shumaker <lukeshu@lukeshu.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] extra: new concept of extra components
Date:   Mon, 14 Jun 2021 16:18:30 +0200
References: <20210614043450.1047571-1-felipe.contreras@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210614043450.1047571-1-felipe.contreras@gmail.com>
Message-ID: <87tum0zfub.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jun 13 2021, Felipe Contreras wrote:

> This patch series introduces the concept of extra components. These are
> components which are not yet part of the core but are good enough for
> distributions to ship, and in fact, they already do.

I like this direction.

> The measuring stick I'm using to gauge if a component in contrib belongs
> in extra is simple: are we already running tests for them with
> 'make test'?

I have a CI failure in one series of mine that seems to be a lack of
updating to CMake in contrib/buildsystems, perhaps we should be adding
that to extra/ too, i.e. extending this to the "make test" run by CI?

Not something that should hinder or necessarily be included in this
series, just a note about a related component.

> And we might move some components from the core which aren't realy part
> of the core to extra, like gitk, git-gui, git-p4, and git-svn.

I'd also like to see us run the tests for the likes of mw-to-git,
diff-highlight and subtree by default, at least under CI or some
"extended tests" mode, even though we may not install them by default.
