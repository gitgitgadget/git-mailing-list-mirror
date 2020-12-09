Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD7AC4167B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 08:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 075F723609
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 08:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgLIIxu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 03:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgLIIxu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 03:53:50 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACC4C0613CF
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 00:53:09 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id i9so821526wrc.4
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 00:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hZKbbks1qBxPHsSHA1EbQoBV4OtXvL2bEd9XjQifoLQ=;
        b=o8HYJvb0/l34syKtkL3Ksi77fezovCzr9zSl9ZwsKRZLdjJI9wIGloxboakN6uI4d6
         6gC691FFJLEWlVMLg5BE1fLvnpO34KZfLx9GoAIbmhZVDw0phYLxCWjPn5ThNOSuBvcn
         7qBaukJ0uUn23kGN7bayYk4xZLNlSe+RjrxJkR5qJIkCXFmZ1xE0B0tZawQx89blj8P3
         mJLFQHo+kMacrdTa+HaxMLspoGGYDmfiayzddgzaF78VVUD6vv4ZsB8bTlSeBqGPaMrT
         q4WMQAHrRLQeTRpM4/myyBqKPd+qVSW6ZNZsHTwoRa3XdOo5PtfzAb/T/Ryot1qKePlK
         RAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hZKbbks1qBxPHsSHA1EbQoBV4OtXvL2bEd9XjQifoLQ=;
        b=IiyWKHqz7eXcUNivh2+HDp1gIxPQGfSLpGwKoMokG7S2VJ+9tN6KEMipC6bTV8/6un
         1mkb9Kn/CA12+QobJ/6VG8izz84MEps/m0vY87wHUXpC7H7ejI1CDS1v/wIsZiqs2h3q
         QTV1PSrk1sINqywG6RIt0vHTnE75i+B1GcBDWjHXHcGg6mPfHzRmONtIYPHkbYrSURJH
         CAoq3K79paiFziItHNbNJhHm2KcOPUaxal48/sUv3/VPn7SP4L7NV1Ey0zfEzHufSDFl
         /CA510dGeUKiRYq8xqXYoZvfJSkc9d1yAanSDcwVi8EqgWHnOhXp5wEyqY1hqt4t4Cf6
         /JUQ==
X-Gm-Message-State: AOAM531bQJU4KoF6Q0t3RUhPN/WbLb9lYesdjPV06VsK3xsTstGd1gkp
        dwXGWxFFvLFEFmhL8ScQmNCVF2UEcsXBneBh4L0=
X-Google-Smtp-Source: ABdhPJxwku/hUyI0iY+3LD8FVSkBBnwsA+CBKvGUccTOy8xcwE4QIxU/WEfQ0ak7Ru+yzctj4C8FTvMM9G6YoAKKREA=
X-Received: by 2002:a5d:52c1:: with SMTP id r1mr1425747wrv.255.1607503988334;
 Wed, 09 Dec 2020 00:53:08 -0800 (PST)
MIME-Version: 1.0
References: <20201209002619.25468-1-felipe.contreras@gmail.com>
 <X9A1On3v35nEjL7i@camp.crustytoothpaste.net> <CAMP44s0W3En0ZuNfBOOZhfeFUeFRvEFs7khAFRraocuDaFpbNA@mail.gmail.com>
 <xmqqlfe731vh.fsf@gitster.c.googlers.com> <CAMP44s2xo=n4z6m7FhuPiZ66yPWvmdQuAodvh2XNpdVAfo6R8g@mail.gmail.com>
 <xmqqh7ov2y97.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqh7ov2y97.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Wed, 9 Dec 2020 02:52:57 -0600
Message-ID: <CAMP44s1vJj6QJjS8ApM_wiVunPo6093_4M-ghJB_PTqZhnmm0A@mail.gmail.com>
Subject: Re: [PATCH] Add project-wide .vimrc configuration
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 9, 2020 at 2:13 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
> >> *2* In other words, I doubt these graphs are depicting "how widely
> >> is an editor used by developers".  It is just showing how often it
> >> is installed, and I know the primary workstation I use daily has vim
> >> and nano installed without me choosing to have them, as opposed to
> >> emacs I had to manually install, and I only use vim once every month
> >> and nano once every quarter.
> >
> > Yes, but in Arch Linux at least no editor is installed by default.
>
> I thought everybody has nano not because it is adequate and usable
> for them, but because it comes by default with distros, and distro
> in turn choose nano not because it is particularly popular but is
> small enough not to matter if left behind unused when the user
> chooses a real editor.
>
> But you are essentially usaying that 80% of Arch users install nano
> by choice.  I find it doubly surprising.

I double checked. The installation instructions [1] do tell you to
pick an editor, and they don't suggest any.

I am half-surprised. The StackOverflow question "How do I exit the Vim
editor?" has 2.2 million views [2], there's countless memes about that
ordeal [3], and the SO team even found it wise to write a blog post
about it [4]. I don't know how to exit emacs (Ctrl-X Ctrl-e?), and I
suspect many emacs users don't know how to exit vim.

Nano doesn't have this problem. Which means for somebody entering the
world of Linux, that's a plus.

Cheers.

[1] https://wiki.archlinux.org/index.php/Installation_guide#Install_essential_packages
[2] https://stackoverflow.com/questions/11828270/how-do-i-exit-the-vim-editor
[3] https://twitter.com/iamdevloper/status/993821761648103425
[4] https://stackoverflow.blog/2017/05/23/stack-overflow-helping-one-million-developers-exit-vim/


--
Felipe Contreras
