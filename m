Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7605FC4338F
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 21:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EE5B60C41
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 21:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbhGVUkb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 16:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbhGVUka (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 16:40:30 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D56C061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 14:21:04 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id h2so8553401edt.3
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 14:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=107txN6I9gXMwcuUep9YHO+I4V75C089944z9AuIBfQ=;
        b=faqZRT9YwHNAXJczBsHR6EbHIun/tmK9Ih7sL4BdGFhBSxcsmyBFERTHRtQDpJu3rK
         +bHrbiQGzpip1F31v3b6GoW+rV70v5oe1vK5CBLZ0hQdupzaRqqAiRtaVY4Y0kCbq1MD
         zrAmc8nNEOxTgwp0Gek5H88x3Izswd2bIZT5xWTqMFeNuBwh/PfSOY/WmuQHfPeZxjOj
         h2dJmI5R8+mZR9BQt1nrcA5mAJZ0ZhrciHN7bCJAJ02NecNfxuIUXXotS79ElZQZR/uY
         OOocVnna+lOu/mJgQ5bFdqzTvb4pBAKeM+cuRE2b0ULlsJI1ehye0c90Nt20T34caAep
         sx/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=107txN6I9gXMwcuUep9YHO+I4V75C089944z9AuIBfQ=;
        b=D91L5alZifBz3zFKVrsWGTIPO/mb/mg9HlUffsqhQ8RhK/H/gw9YBfjHuPVFN7i1CJ
         PrjeWmcj5YUaR+AHD9GjNpbBQF8dbqmCzivMf2QrgryhA2QwHB9atQ1ivKZjSe7nSvDQ
         E+hgbMRe+uwwOx69OxQzuYxktIUHksY4uJoUnX9JtEb06FrA7seGZ7S0kPW+lDTY1Kw9
         UWxFW3kboFoDJ8OL57nekBOXUkU9tsClVS+spY+LXaUTybnrU1bs6npDrwNZbSn3VZ0M
         mf0s7BQBbLmT2fRqgicrj6W4vaUlAPOKC/iXzHFaQqAzAeY4KljUzrtK9/ZJWb1MbMYH
         2NUQ==
X-Gm-Message-State: AOAM5310MKSApUrbtc9DtZYqH3ON4o+0RCWYYdLjigbrLzN+2A4R6WTw
        2DZ0aVIuricRuGQ2zkG3pao=
X-Google-Smtp-Source: ABdhPJwfRIZVlHSiC5DH3KhNxqnsbQS9/jZQylDsYAD+4aEyrMZ/Dg8kti7XrcMwF0ru2habG/iefw==
X-Received: by 2002:a50:d982:: with SMTP id w2mr1785965edj.338.1626988862843;
        Thu, 22 Jul 2021 14:21:02 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id ah19sm9912082ejc.36.2021.07.22.14.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 14:21:02 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Kristof Provost <Kristof@provost-engineering.be>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v3 4/5] Makefile: the "cscope" target always creates a
 "cscope.out"
Date:   Thu, 22 Jul 2021 23:20:25 +0200
References: <cover-0.5-0000000000-20210629T110837Z-avarab@gmail.com>
 <cover-0.5-00000000000-20210721T231900Z-avarab@gmail.com>
 <patch-4.5-f8d151f1f6a-20210721T231900Z-avarab@gmail.com>
 <xmqqk0li9tks.fsf@gitster.g> <YPmxsCatUIByQnig@nand.local>
 <xmqqfsw69o8m.fsf@gitster.g>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <xmqqfsw69o8m.fsf@gitster.g>
Message-ID: <87k0lit57x.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 22 2021, Junio C Hamano wrote:

> Taylor Blau <me@ttaylorr.com> writes:
>
>>> >  cscope.out: $(FOUND_SOURCE_FILES)
>>> > -	$(QUIET_GEN)$(RM) cscope* && \
>>> > -	echo $(FOUND_SOURCE_FILES) | xargs cscope -b
>>> > +	$(QUIET_GEN)$(RM) cscope.out && \
>>> > +	echo $(FOUND_SOURCE_FILES) | xargs cscope -f$@ -b
>>
>> But that alone is a good change in my mind at least. Then it's clear
>> that that target is responsible for generating cscope.out and nothing
>> else.
>
> Probably.  The preparatory $(RM) is close enough to the invocation
> of cscope that anybody adding other options like '-q' should be
> careful enough to notice that the line needs to be touched, too, so
> I can be talked into thinking that $(RM) change here is a good one.
> I do not know about "-f$@", which is "Meh" to me.  Is there a good
> reason to suspect that they might want to change the default output
> filename?
>
>> So I'd be in favor of rewording the patch message and only retaining
>> this hunk (and dropping the other two).
>
> Yup.  I do not mind dropping one half of this hunk, too, but again,
> I do not mind keeping -f$@, either [*1*].
>
>
> [Footnote]
>
> *1* if the patch to add cscope support anew were done with -f$@, I
>    wouldn't have insisted removing it, out of the principle "any Meh
>    change is not worth applying once the code was written and
>    working".

As long as we have no user of a -q flag ever, what's the point of
forever carrying the "rm foo*" when we know it's foo.out, just because a
future Makefile change might add foo.blah?

Doesn't seem like something we'd trip over, and the .gitignore/rm rule
is just misleading now...
