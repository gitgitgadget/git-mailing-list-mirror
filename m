Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2844C433FE
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 06:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B1DE23B81
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 06:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbgLIG26 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 01:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgLIG26 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 01:28:58 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E883FC0613CF
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 22:28:17 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id c1so430943wrq.6
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 22:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=AU6ShUQ7EcOQYwsupXDvZnsLQe5fucIlFWmpW7mZcss=;
        b=q+CjnfHW3dG6YfUCEvtFTCZIjhKm9OPa8h6Xj6pYMEKugdSWwF3XAL4YDS/ouTtAKT
         AqyiJvpEQAqSEKFTm4CEJnw2+ZJxgSXmzXLrda+HFCsFACCeqhCAgalljpYKYJMbbzwh
         8HPqClOdOPyzhpb+5X8MdfNYldPqa+xheizNDtfqxknidP/0wMYPR3Aoja7UqZBUXtHh
         gISL1y2h+Iv+NGOWGoyN/tsq3nLHh9/yqeX3fpxA9skff89qVDK9IZxIpkYKdfVJ4FAH
         CdCW5QmgI2ye2t8CWu2cIP4mCEJYpm9CHnRGnsZoMp0u/553ax64og3uFyhcbHyAxjSn
         VYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=AU6ShUQ7EcOQYwsupXDvZnsLQe5fucIlFWmpW7mZcss=;
        b=AAa3IE55n5/lDG5qua/7Oi0dmO9o4J8kkAFe0i/KKqvXQMdLbe6gepgHMMWNmlhgnR
         BE3VmJlCcPUKDDW92rXHi5GSmteY4C1ugsBnR+0wDszO6U0kaIa9exr6KEOXF/VicNEf
         OR/xpWisRBOHP4PiuxyHKjCo3ATGD0hAuERJX3v/AXEHPb1A1wGnFoJT4LhtziKTi4DK
         h7KwFsBsDFyq4KoqwGzMx3Mdbzzo05qViDHCffWJmK7G6EEfD7C2b638+UIurCl0UZ6n
         bBlt4dfD5ybW+b6LN8v1O6ELN5uaIu8VLZvwVq3Bhp0+HLuq/S2AulnfFFY9lI80h/cb
         Z89g==
X-Gm-Message-State: AOAM532MNXh05FYFK1sCsmpE7sjNhC9UNYkh6N9LYvmL2Bdw9ahGvHD2
        XHvnM9EENlGB9uI56DZny+eNgGaFDYC00kYpqq31lblLDjydCQ==
X-Google-Smtp-Source: ABdhPJwAfIZpdZYMDpVWBYsi6akh7Xif2f/eKxeBypt5ttghQ3zqGOzPwoat7HbdPejYzKSP35fxYFuFC1YjZKLk2OQ=
X-Received: by 2002:a5d:52c1:: with SMTP id r1mr810896wrv.255.1607495296742;
 Tue, 08 Dec 2020 22:28:16 -0800 (PST)
MIME-Version: 1.0
References: <20201209002619.25468-1-felipe.contreras@gmail.com> <X9Al3u9/jw3QWN7q@pug.qqx.org>
In-Reply-To: <X9Al3u9/jw3QWN7q@pug.qqx.org>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Wed, 9 Dec 2020 00:28:05 -0600
Message-ID: <CAMP44s3-38WJXxzFJhhxvB-PVNzRuu+oaC3aVb=VF+P42S8WOw@mail.gmail.com>
Subject: Re: [PATCH] Add project-wide .vimrc configuration
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 8, 2020 at 7:18 PM Aaron Schrab <aaron@schrab.com> wrote:
>
> At 18:26 -0600 08 Dec 2020, Felipe Contreras <felipe.contreras@gmail.com> wrote:
> >By default it's ignored, you need the following in your ~/.vimrc
> >
> >  set exrc
>
> Running `:help 'exrc'` in vim includes the text:
>
>          Setting this option is a potential security leak.  E.g., consider
>          unpacking a package or fetching files from github, a .vimrc in there
>          might be a trojan horse.  BETTER NOT SET THIS OPTION!
>          Instead, define an autocommand in your .vimrc to set options for a
>          matching directory.

Yeah, but if they *really* didn't want people to set this option they
would remove it.

Yes, it's dangerous, but that's why it's an option.

Anyway, I wrote a simple loader that should take care of this security
risk, in the same way other local vimrc loaders do.

> So I don't think it's a good idea to encourage people to do that by
> using a name that invites it. Also I think that the file would be more
> discoverable for people to incorporate into their own configuration if
> not named as a hidden file.

Perhaps. There's already an .editorconfig so we would be following
similar steps, and also this is what other vimrc loaders already use.

Since I'm adding a contrib/vim directory maye a README file would make sense.

Check v2 and let me know what you think.

-- 
Felipe Contreras
