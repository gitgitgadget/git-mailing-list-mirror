Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688D1C433E9
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 19:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C6DC2313E
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 19:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbhAFTtT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 14:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbhAFTtT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 14:49:19 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B450C06134D
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 11:48:39 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id p72so1029365oop.4
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 11:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZIqULcuVhkqK62rurCcuZ9NZMfSw8EQGaF5dW/iMhEw=;
        b=Ruu3MlmIP7hz3Csw/TYgj9+dzTcuP2M++ojI7oYo6dGaPPgCSNya1mnYawu3r9CQLC
         LJBlMqKgvCgB/dll4mQXIG9Qw/O42BGbk5Jr5oMEEWLZCczGuwJHC4vQEUNp7NkTR0N2
         +NQ8XRPlk8M4NDsTwAhlUyhwxwWgcvKv5mtvnwRk95cLMELF+lnw9umXSg2G9VssWtc4
         4CqiLdf6nYJp/G/7Y2tCPbI4L9EgVu4Vj1sj5KDFo5s5DkdrF8otGjlmYbbyknsVFGFo
         +Zt1KAXRaiTmEoWTfEVkB6PysPDl5Zv9pWPbwLPmLuaUFjqiglld9PfUhpvjhBp6B2TS
         0DsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZIqULcuVhkqK62rurCcuZ9NZMfSw8EQGaF5dW/iMhEw=;
        b=HbbeNsAOsKsDs+Hl0W8zNaCf60xYkb2GyTo/E9BJM1Dsjj7j1wQlEO3sPK0vc2UkkR
         fgriPRCXIni+/G7Fa91h81hrXKcKCgyvVJnikagufVfv/rsCexkoxIBBuGxdcSAwLesx
         Tg8vZaULkt9UdblHzMOES2V9Gg3F+Skx6qTGr+I1geoUU6l9THYTQLZVNMflkSZaMysk
         q42SLxBTwKQLS067QoOaBXI7AAqwazy2HHGhcAmS/qI+u2nAQ0yzNDxag06nuiCKUEpz
         VT2/DjxyPIl3WFNxf7ucPmQXgUumfJEcweb+kEsq6ZX0xdSKzzgd69owu/qy0KiF6Hws
         m3Yw==
X-Gm-Message-State: AOAM5325vIm9TFqL6WhLEgLKb5/KqhqdeC0zlKNd/WWaJF6n7KLfzOVG
        38YtSe6C3D1NcDAH8NXW/xUXIHsT7/HZLrNLg3+9zRn4
X-Google-Smtp-Source: ABdhPJykeBg6i4QpArpIDaEEsP1HbnNHm+hr/zk0Dm6QLL1pAIpHwiRDVYzGFWjqWHvvpMjh8Nv6pIIZZ69ztrZFUlM=
X-Received: by 2002:a4a:b2c6:: with SMTP id l6mr3847737ooo.7.1609962518155;
 Wed, 06 Jan 2021 11:48:38 -0800 (PST)
MIME-Version: 1.0
References: <jwvwnwqrqwd.fsf-monnier+gmane.comp.version-control.git@gnu.org> <CAEE75_1fnvzOid-xfNOtd0eZfh_y8QizfLGAP_ceOeTQdJy2tg@mail.gmail.com>
In-Reply-To: <CAEE75_1fnvzOid-xfNOtd0eZfh_y8QizfLGAP_ceOeTQdJy2tg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 6 Jan 2021 11:48:27 -0800
Message-ID: <CABPp-BHzPkZu=s=ssmcW=jxg3bOmbL2CkbiQn6N7-Dor8H0BaA@mail.gmail.com>
Subject: Re: New orphan worktree?
To:     Jim Hill <gjthill@gmail.com>
Cc:     Stefan Monnier <monnier@iro.umontreal.ca>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 6, 2021 at 9:05 AM Jim Hill <gjthill@gmail.com> wrote:
>
> On Wed, Jan 6, 2021 at 8:18 AM Stefan Monnier <monnier@iro.umontreal.ca> wrote:
> > create a new orphan branch with a new matching worktree
>
> There's a much shorter sequence
>
>     git worktree add -b new new $(git commit-tree `git mktree <&-` <&-)
>     rm .git/refs/heads/new

The rm command presumes the file-backend for refs.  That might not
work in the future with reftable.
