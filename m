Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E540C4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 00:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbiLTAdi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 19:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiLTAdh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 19:33:37 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B764EDF3F
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 16:33:35 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id c11so1960114qtn.11
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 16:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=webstech-net.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RPBQya04SAsXSUkIRLlTlMIH6VNLXcL+AKjWHJtv8xA=;
        b=yJzL6bQ+LtyCu/iJWtR2i/+bdH2EPwxey90qb8IhfM/dYxD92IAv1xfusiLuxCHx5J
         E1Ony0NQszPvLfOOmgUhMA2GV/xpMnoYivOjxSptor0IytTt4fqwIEhUJKT41iEy6emN
         IPI4i6Ovsm6W+yqzxHQOcD9iWoirYVQpy1EBU91br/xJ3r5nDfNFnKxG1FNaUxRZuAf9
         9so/dArC2Q2UcQUc07wYLQVZJ10OCtq8yuJBeAVzRbmG1tC9knU9vrm2jxWoTNviEyYG
         gAMWlh9nyxI14AfJYqaWTA6kK/uG9ueKi6M39jr/dA7Sj/FvFgM4My/cxt5g3bUpwqWr
         ldCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RPBQya04SAsXSUkIRLlTlMIH6VNLXcL+AKjWHJtv8xA=;
        b=1GeZIj0dlCv+4gEx65yhdITZD8gCiJHGaHsmVJbMOroj+VFI7ciBdX8B1AkKUAMmd+
         bu/HbUrs62F1Zi7IbtnwkZ4eePVsq3kW3p1/Grd4eze1qtuNG/578YMLLb5hOg5TVGDn
         UPnqNd4e3A78W3GtwUJg9rZvq1Bwnlqs3PfOEKN6q9zb4seNuPhRkPNZHYhycPsjTKG2
         FOPWS+QXUuGGBXb83a90OXCC9snTk6iFj7UXpQ2bZvOuCAwKKa3SNlxQfTFRTmo4lXXI
         5HQgJxx0ZOoTmQmzirOWi3Zyt8BKaUeOypoXCl5rLZT/15nzI5cTLOPDVBT4/tZK35lg
         LS4A==
X-Gm-Message-State: AFqh2kr2SP10d94XqzJmIU2yTRext1rESgzEmChTuJFptspaExpPy5tf
        2WZzuAXKNIDzFt/CW3WumHV6nTnXIsX6GVrTuHWQ7rDalaYiU8VzV98=
X-Google-Smtp-Source: AMrXdXtSm0D4z56doMN12TDWzc7Ppy/xuVaIuL/O8ja5d+DlKNaq2CQxemlD/TafakYJyLHex+faAoUgL2ct8xC3r6A=
X-Received: by 2002:a05:622a:1c0b:b0:3a9:8eb8:c3a9 with SMTP id
 bq11-20020a05622a1c0b00b003a98eb8c3a9mr183625qtb.401.1671496414842; Mon, 19
 Dec 2022 16:33:34 -0800 (PST)
MIME-Version: 1.0
References: <pull.1444.git.1671179520.gitgitgadget@gmail.com>
 <cdc2b1aae81f8c37b4e71cb3e0e382cf82de2272.1671179520.git.gitgitgadget@gmail.com>
 <xmqqh6xvmzb8.fsf@gitster.g>
In-Reply-To: <xmqqh6xvmzb8.fsf@gitster.g>
From:   Chris Webster <chris@webstech.net>
Date:   Mon, 19 Dec 2022 16:33:22 -0800
Message-ID: <CAGT1KpXET2kkwKCEpi5Ay=xHsEWLgXzFj9G0cTBFNYvCgAaUfQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] Improve check-whitespace output
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 16, 2022 at 2:13 AM Junio C Hamano <gitster@pobox.com> wrote:
> It's a bit curious to see two "1." and not "1." followed by "2."
> here.  Is this meant to be processed by markdown or something so we
> do not have to do the numbering ourselves, or something?

Yes, GITHUB_STEP_SUMMARY is treated as markdown.

Thanks for the feedback,
...chris.
