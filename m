Return-Path: <SRS0=kUNO=A7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCD3C433E1
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 18:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DA4822482
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 18:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQlaxlq6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730631AbgGTSvk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jul 2020 14:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgGTSvj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jul 2020 14:51:39 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58342C061794
        for <git@vger.kernel.org>; Mon, 20 Jul 2020 11:51:39 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id q15so5395947uap.4
        for <git@vger.kernel.org>; Mon, 20 Jul 2020 11:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H9a5fzeoFb3pObvicl/UUahcEQWo62Vx/e3UW8y3qqk=;
        b=UQlaxlq6cJSdTZOgryw/6/1t/XXwqIfn2s8iGcwVv0MFlcAdthUbaTOWp2vUkkdJLi
         A6ijz3YMvlOvMPbtvBZKZXmcSfsq+isKA00Q9vbzrx2XyhSH1hz5ZWBpf7wxC3XOPT6R
         sCZN4AZC9dZ4iO8mW6kv6FnYDNL2DmCgE3ucD0n0khpoe+kH3mgmN/ACbOioEaLGnrhh
         m7bWhnG68VDnDf5c7dgihjRVYg14rTkWtWFc1NNGuM5XKZjWHeCJkKejFlE2V+xXbMfJ
         GvvtnR422YQKbTRgHmM9KbgY4/necBgibwyyT36kU2RNUQKINnHHVPHlA1OzRDvXySUs
         SVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H9a5fzeoFb3pObvicl/UUahcEQWo62Vx/e3UW8y3qqk=;
        b=sigg0zJZisK7wz+tEWfSoUYOG6F7y68nq/+xSRriYohEvfZtBmCIuvk+pi7RvjYCST
         Nm7Psdh0MUEto/8wKqbVd8joXgwzZZ87iFpTjrxW8+KkYucHp/308H67MPk3AErkWWF2
         Hxc6Da7qfTdoyO3NaezWetDOrO2gowVrGaVmipyzn2Of9gGz9t4zEPQ0sjupQFkEjhvP
         JJrGhzL27AuPeY3rP/KKrhbS1b0so35bZuR/WiBMqcd0NpmFOBckEhzvaTF1wGzG3y21
         Fl26Td8nd3iktoUPzvLuky8sxIlAySssI3r0+aprCdPyhyaF2EAOt6KIYdkIhUWYA9Ic
         0aTw==
X-Gm-Message-State: AOAM530lq8P8lh+nEwqmP0UUoXC54G31EhB6sCg7dA8aYlOMNbisokOM
        JVLrxVcQne/8OzysjATv5mb+zwL9mnZGq43lRNE=
X-Google-Smtp-Source: ABdhPJxx1X/mon+C2HR1idOe1vWDKU2R+E0zJq9InoYvRKkhHTD2BQsUi3TTQ+Qe7xEp7JkXnD/sUE9j1wsAwIVycTg=
X-Received: by 2002:ab0:4e98:: with SMTP id l24mr17330609uah.15.1595271098561;
 Mon, 20 Jul 2020 11:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <CABPp-BH6xYb8a5hkV_68vbXhH4kApCxw0WG9oveXOk5zzU==1A@mail.gmail.com>
 <20200720184529.22449-1-martin.agren@gmail.com> <CABPp-BESf35g2zyCUZgBdbz4RacbToX+g7N4kwSQUCLq0h0ACQ@mail.gmail.com>
In-Reply-To: <CABPp-BESf35g2zyCUZgBdbz4RacbToX+g7N4kwSQUCLq0h0ACQ@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 20 Jul 2020 20:51:26 +0200
Message-ID: <CAN0heSo25utsXJj1qQgqz2ByB45xu_5O4uSVOV=TZq=3WU+iPQ@mail.gmail.com>
Subject: Re: [PATCH] dir: check pathspecs before returning `path_excluded`
To:     Elijah Newren <newren@gmail.com>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Martin Melka <martin.melka@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 20 Jul 2020 at 20:49, Elijah Newren <newren@gmail.com> wrote:
>
> On Mon, Jul 20, 2020 at 11:46 AM Martin =C3=85gren <martin.agren@gmail.co=
m> wrote:
>
> Looks good other than a minor typo in the new commit message.
>
> > But in doing so, we added a slightly-to-early return for the "excluded"
>
> s/to/too/

Thanks!

Martin
