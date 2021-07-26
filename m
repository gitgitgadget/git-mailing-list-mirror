Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B40EC4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 04:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B6E060551
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 04:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbhGZD0a (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Jul 2021 23:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbhGZD0a (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jul 2021 23:26:30 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2D8C061757
        for <git@vger.kernel.org>; Sun, 25 Jul 2021 21:06:59 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id a26so13035561lfr.11
        for <git@vger.kernel.org>; Sun, 25 Jul 2021 21:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3pgObEJ0wzr/WY5zrRry1ir8X7Vd9CpLctCPXaOwz0M=;
        b=SzGAYG/+UTdr9Jo8ZMP7fsdqKwd/rAGeCgYIRI0wsCC62n6zlw/tCHCn0cjP9y9sAT
         vfWIhcg3YuSjn7zhlcK9rAq9rMJyDKprzJMw/1tjEikhtGUIi1mJqKtUlW9w0UDKxSM2
         ttpxYykM+Bnknqx2XzlGbdMbd2wZxYqYTxPKh0PUxfOIHMpMEWaAxHPizLTsbVCYarud
         FJXG97Q9HFYbIS4tynmxakNnSxNqTFA6N7muOTba+T3ZU2nw4CWKm8xCZ8zZteKbr6TO
         2EnLJnkyzmrA97fneg2kyW52hpAOy0RTpBH1/dsAYwY6x+ADghRkLAnunkwxwvQgLsBW
         YbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3pgObEJ0wzr/WY5zrRry1ir8X7Vd9CpLctCPXaOwz0M=;
        b=aK73chHS1yFKfoKx8o+zmmVdCYrPP5/tTOgXM8+vFBZpmGq8n74BcJP4n9i5brNNoK
         GxJR3qzXFoyH2VLw5cG1H9N1XSfCL1JREhKFNlodMkWZqbNewg8oue1h5avtiRVR1jhh
         bUO0HJEe3nd5R+GAwXDzwGXWbCjT8DX2hnG6vFxZ5+cqAqUHeWe4W+jpOXbnjoo4WIyA
         kcG+gHzLk8hWb7k6TJm6RTX+CYYgEblqR0NSzIfXtdncutEPNamfDGKlLFfm5pZ7TNJh
         F/FGH0ugxDb0bUJvFUMj/tnXECyz4b3G9gncCXPh0gVORdKo2TG+Uv97rpXGrCSvUhxW
         hTFw==
X-Gm-Message-State: AOAM530M9gHkcvwlcqtxMUNx2TCvFYh8rnGZfEhPl1u+271ojyYiTkFa
        QVRVIitSfu4BGvQ2JzA98ao91Lp7UW+cbfHWsIE=
X-Google-Smtp-Source: ABdhPJz1FtezZcMPf9cSIhKt4obSnIEz/hb13Z0lWAI9OG1iUTsSVZlsk8sZTatUEQI9Ylj5G7KUdyFQKVk/Pj8w024=
X-Received: by 2002:a05:6512:321c:: with SMTP id d28mr11386248lfe.203.1627272417568;
 Sun, 25 Jul 2021 21:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210721134650.1866387-1-felipe.contreras@gmail.com>
 <CAHk-=whf-9kNV3y5G-VVA2K5EZCnvv94paAEj6p=i2R4RM2emQ@mail.gmail.com> <xmqqeebregns.fsf@gitster.g>
In-Reply-To: <xmqqeebregns.fsf@gitster.g>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Sun, 25 Jul 2021 22:06:46 -0600
Message-ID: <CAMMLpeTL92cDmMHsE3iuhHQrVjwLFWHxE0CwD+uDBoPGAQCrkg@mail.gmail.com>
Subject: Re: [PATCH v2] pull: introduce --merge option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Git List Mailing <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 21, 2021 at 11:11 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> The "--no-rebase" option, which is documented as a synonym for
> "--rebase=false", has been there, but the implementation is buggy in
> some corner cases, which has been worked on recently in a separate
> thread.  I do not think it is too bad to add "--merge" as yet
> another synonym for "--rebase=false".

It's convenient to have the one-letter option `git pull -r` to
override the configuration and do a rebase. I'd really like to have a
similar one-letter option `git pull -m` to override the configuration
and do a merge. That would also alleviate a lot of the desire for a
separate `git update` (i.e. "fetch and rebase") command.

Junio, would you be willing to accept adding -m without adding --merge also?

-Alex
