Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7137DC32771
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 01:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B9652467E
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 01:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbXCEsiI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgA1BbT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 20:31:19 -0500
Received: from mail-vs1-f53.google.com ([209.85.217.53]:33270 "EHLO
        mail-vs1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbgA1BbS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 20:31:18 -0500
Received: by mail-vs1-f53.google.com with SMTP id n27so7080691vsa.0
        for <git@vger.kernel.org>; Mon, 27 Jan 2020 17:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eXrR0tQwf1lbFd5qQOq8KwrwvoZEYlpS529L+gS33JI=;
        b=WbXCEsiITKb+fHsQYqKrbo7QA2sXN+aJPAtylfwIAPUneCJHbab0idGEzx37uh6NBz
         RnfYcMpvTRwGGl2hmlg9WgJXmcucRiq3wjyoPlGk+gP80bfkPK9Hb6gYqoHdroJBwMkv
         jv9/IPgXBihzwvKw0fTEBRYSff32HvAKcOQ9K3KoKe3stMl11zUCa8BW3jqfTzmTA5iN
         heM0SUuJC2JvHPTUKYFEgkmTgoPqEusg6INnOSGlbMQGLTziN1huonW53VkwitDXmTyH
         Lx4rjJCI248005lCljpJGPpKLJKzh2a1Y/YrMmF8pQ45ApIlbBIZEV1b3v3DqPBfMc5M
         yxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eXrR0tQwf1lbFd5qQOq8KwrwvoZEYlpS529L+gS33JI=;
        b=bbEQR5Nig5p0d9HJPH5DOTn1MBZRRD34eYyBHTObPN6j+Mw8btqZG7WVh5Dbupj/fD
         blNGoxu7YLGRqYq+FmTvCazRdxxU7Ur6nyEu6/wy0EsXTcTkXR00Mq9ahxPmMpwmsJbq
         IqF+Q0Gz5NxXDOcuX+hFF/1XGHJR/KIz29Fr6AyzbvaxIbsCOfSV0ZTDAwZEiBv+U2NT
         vdHzjMLbPerC1xcPEgPKuJ6uX5vHHyOHYLFmuW/A1du5EWdNGm3ocByOGyf7kBOGqqwD
         m+Ki/3XP8bgj5NfZQ4p+u5PtSENa0QT+7vHrXoltsjSbwHRv12gKs5fuuZnQKjM1o5s4
         wb1Q==
X-Gm-Message-State: APjAAAX4wEefuA22SK27vhSPz+aJr8nSzNKOrkrWeeq+ItIEDvFwxWxH
        cZhY/+6Z/5bkIYSjFpOmWG0+aF3B70CSff2UNDI=
X-Google-Smtp-Source: APXvYqyk6K4LllT6L6bu6tpjifoN2oOHwmIlCiT0q1QwHGzX5vnvwH1xcP+IX7HE1/quxxNfTV2TNYBLwBZEUJN8jEg=
X-Received: by 2002:a67:fc09:: with SMTP id o9mr12257631vsq.75.1580175077473;
 Mon, 27 Jan 2020 17:31:17 -0800 (PST)
MIME-Version: 1.0
References: <pull.478.v4.git.1579825267.gitgitgadget@gmail.com>
 <pull.478.v5.git.1579912764.gitgitgadget@gmail.com> <2e979d9fa5066f61eb89e3c1a1a34ac813d71700.1579912764.git.gitgitgadget@gmail.com>
 <xmqq7e1ca3ze.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq7e1ca3ze.fsf@gitster-ct.c.googlers.com>
From:   Matt Rogers <mattr94@gmail.com>
Date:   Mon, 27 Jan 2020 20:31:05 -0500
Message-ID: <CAOjrSZs9xdS9sLVA912UtWOz_dRnOjAn4UZ7SCyAJi95-0A4dA@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] config: add '--show-scope' to print the scope of a
 config value
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
> There is a trailing SP on this line.  I think I fixed it up when I
> queued the last round on 'pu'.  Please double check.
>
> > +     const char *scope = scope_to_string(current_config_scope());
>
> ???  Are we using scope_to_string() back again?
>
> I thought I queued a fix-up patch when I queued the last round on
> 'pu' to unblock the other topic that wanted to build on top.  Please
> double check.
>
> Thanks.

I think I messed up when I pulled those changes...

I can get it all sorted out tomorrow after work

-- 
Matthew Rogers
