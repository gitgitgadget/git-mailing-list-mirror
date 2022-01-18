Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9CDC433EF
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 21:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349609AbiARVnt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 16:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349623AbiARVnT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 16:43:19 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD54CC061401
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 13:43:18 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id f21so1385666eds.11
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 13:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a3TN3Xn/1c4SB0hgAT1hJIZ53/Ica+EV2sN0S5kLgZU=;
        b=SitKlGon42XxXNTWSfrxGo9CSSbe+lTW5XM7zCHCNrXzhZI68J/yY6GASQZUaTlvPJ
         ZoQNUeLnfQsXUKYWYPu+ZvaTmwzd5FfXWyJuWOyY15ZaYuVOYEMv6eZN6koO5/lYNu4w
         T6+eOOC939AEsFuBAbWq5ElXe3XrURleMkrO29tMxBB/7tKueG62A4Xk1sDJq/FOTOmT
         KZnyvxSEogFJwPKslk+vg38k46/GnHbIpn2bpGqcWXoCL8QeSu0+55M7zKbmOHGBlFGs
         LYjIke0MvEgTSHDp7SyjTl6PJJMa2PSpP0OV0weDsgChHNbH26o8ThVo9Dt02naOQFWe
         ujZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a3TN3Xn/1c4SB0hgAT1hJIZ53/Ica+EV2sN0S5kLgZU=;
        b=xBSYuBnUEZSIxoA1euUPBc8bjmzJFtV6o0yyyDqBz5R+zYQY5VwYIGZM7V654K0fjL
         wRWhemSB0bOnWYqMG8//ZRzQOwk1uaYOXOK3gohsS5p29t+P2x6rFaE8i+rkA3+nLEBY
         qVVRPMRFF3NRNm5xkpIRAIaCqe09N/AyZHrHR3167EjJwUmlKQWGVw3GzbBsaO7aGKpz
         XKGoQXOPl4e7pRGPdcgo99wbOvloa8dUggN0t6El51YQ9hx/JupJhSHgvwrOyNBlGeD7
         zzdgFDBiE5XowzUgXNuLq1Fl6HhtKuOgX74zlTqB3cFvGOKwk5CcXlr8qBCqoZmyReGu
         y4oQ==
X-Gm-Message-State: AOAM531dzKUWuIwbeKM78Uag1GDvNKLfc+sOKzvzA3vf8So2U0gxrtah
        hLFZLoht9FrUfiZUceLpQbH+Mn8o8Y3CYlwL33pux/ugx2Q=
X-Google-Smtp-Source: ABdhPJzfzfzeM0TYQ8oNUuybaaN0WbKGiK8uxG+ZZF/nhayReWWPbGGOTYGJc1QyaosktwiU25YdC5ma8ptYrW4Pqqc=
X-Received: by 2002:a17:906:dc8e:: with SMTP id cs14mr21400627ejc.269.1642542197251;
 Tue, 18 Jan 2022 13:43:17 -0800 (PST)
MIME-Version: 1.0
References: <pull.1108.v2.git.1640892413.gitgitgadget@gmail.com>
 <pull.1108.v3.git.1641841193.gitgitgadget@gmail.com> <256e5f034c6072b6e3621adfa96c5c6319752fae.1641841193.git.gitgitgadget@gmail.com>
 <20220115095725.GA1738@szeder.dev> <CABPp-BGR+UrW5ej-8+XXHPkjMfFgURycd9rWC+2awUvYcr_PXA@mail.gmail.com>
 <xmqqv8yjz5us.fsf@gitster.g> <CABPp-BErg-RtyycXaRXYfQHEQXA4q-FU9Q6nYkSHJsqL-04oXw@mail.gmail.com>
 <20220118210205.GA2632@szeder.dev>
In-Reply-To: <20220118210205.GA2632@szeder.dev>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 18 Jan 2022 13:43:05 -0800
Message-ID: <CABPp-BE=UTRnhSDugE46XqsEwMd9UWivAL76VTMzJygy4a3N6Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] sparse-checkout: custom tab completion
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        johannes.schindelin@gmail.com,
        Lessley Dennington <lessleydennington@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 18, 2022 at 1:02 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> On Mon, Jan 17, 2022 at 10:14:58AM -0800, Elijah Newren wrote:
> > the
> > documentation never explicitly states files are acceptable to
> > sparse-checkout {set,add}.  It always mentions "directories" and
> > "patterns".
>
> The "Full Pattern Set" section of the manpage does in fact explicitly
> states that files are supported.

Not sure it matters since Junio has stated his position pretty
strongly, making it irrelevant at this point, but.... I'm not sure I'm
following you.  Is this the quote you're referring to?

"""
While $GIT_DIR/info/sparse-checkout is usually used to specify what
files are included,
"""

If so,
    /foo[A-M]*/pref?x_*.c
could be an entry in the file "used to specify what files are
included", but it's not a file.  The two example lines immediately
following aren't filenames either (though the '!'-prefixed line is
close).  Or are you referring to something else?
