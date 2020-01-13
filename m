Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C25EC33CA9
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 00:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10D2F21556
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 00:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jgb+D18a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387535AbgAMAml (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jan 2020 19:42:41 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:37999 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387514AbgAMAmk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jan 2020 19:42:40 -0500
Received: by mail-wr1-f43.google.com with SMTP id y17so6914325wrh.5
        for <git@vger.kernel.org>; Sun, 12 Jan 2020 16:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YxUvATGQmd5UlxqTkyyeErsmqtYcbiOrGvwLdA9vHPk=;
        b=Jgb+D18aUdUz5kDx1yz6ph4Niy5QTG+N4L1BiTxzmgm+9xWrQ+dWvZ/D3F4MyZXdqy
         cXM/VZwHphKGTfe05qsPrLWv1h5OBGm5ZoQoeg/sI3X1MJKTpFd9twD3aEyrRjFuhDw7
         OTtjC+gn37kXJflJ+KnOCgNBobb5EoqFSMxJDBAelG3GdDZfIK62XMvjuOgpbNdpXBJY
         hlGEogQ0TRGxOdUZRtne1I7dMJsIdo2uVLj/1WZINaeURItqY5IvO+/mVOhHp5T3k+8Y
         UFvZOQKparIofTjC4b7ccg/vhmiMgBrfpNwiiXqVHA1/IqapM2gWSpGg8e7cia5KIQT8
         Rt0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YxUvATGQmd5UlxqTkyyeErsmqtYcbiOrGvwLdA9vHPk=;
        b=Agsn/4kh7OjziKicCqhAM6Ws1nHw4ei4mOHwItbBRI0V8bBdXVKxNssURcMPHKFTII
         YEbzM9bHr+z6sCaz+t48YzBAjYlao4iuLxO/MWT2ninPbrfsgNleX4K3r+33BzYdlohe
         0nfCi5MOqP9HicWlXQdzpwN7I4RXK3eIzcuACsKNralTH5yGwkcHS/6RVcxNI4I5UDWS
         JcjNoNO2TC/Ni65oFA//2amaOsqj6MX3CblJdjdwCyuNKu5HfmYbwcb+v2flReqQ3fwF
         2BpPJz7sfZCxIgJFIuqlF4wamQvNgCdGwWV17698H6U+rWOQYd8NK44W4BgoEgaNvKUy
         wpqQ==
X-Gm-Message-State: APjAAAWNCzuRUXV1CJK9N9lWsPxx6eERsFgdLX0vPLx1FUt/LlpZAgt0
        yiB+qkoN+Ura/LjGtD/BJ6sdffe5
X-Google-Smtp-Source: APXvYqx9qR/DGuCQz20DpyfsuQsiMy/fpVokLb/WA9kR8xBf7/qCf0eYYwRNkUOzFoMfV+aNDVX8Fw==
X-Received: by 2002:a5d:6388:: with SMTP id p8mr1747817wru.299.1578876158845;
        Sun, 12 Jan 2020 16:42:38 -0800 (PST)
Received: from szeder.dev (x4dbd0e19.dyn.telefonica.de. [77.189.14.25])
        by smtp.gmail.com with ESMTPSA id b21sm12138644wmd.37.2020.01.12.16.42.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jan 2020 16:42:38 -0800 (PST)
Date:   Mon, 13 Jan 2020 01:42:35 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jude Guan Wang <guan@clicktherapeutics.com>, git@vger.kernel.org
Subject: Re: Fwd: Issue with Git Branch
Message-ID: <20200113004235.GI32750@szeder.dev>
References: <56F9DC91-740F-47C7-9C2A-B6B1EC3A12B6@clicktherapeutics.com>
 <29742805-4992-47E6-9889-F55F5EFBBFF1@clicktherapeutics.com>
 <20200113001143.GA13099@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200113001143.GA13099@syl.local>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 12, 2020 at 04:11:43PM -0800, Taylor Blau wrote:
> On Sun, Jan 12, 2020 at 07:01:04PM -0500, Jude Guan Wang wrote:
> > 	I noticed something weird with my git command. In my local
> > 	environment I seem to have a branch named `-D`:
> >
> > 	And I don’t remember how I was able to create a branch like that.

> If you do find a reproducible way to create branches named '-D' or
> similar, please do let us know, as these are not intended to be valid
> branch names in general.

  $ git update-ref refs/heads/-D master
  $ git branch |head -n1
    -D

