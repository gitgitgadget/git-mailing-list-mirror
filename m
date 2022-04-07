Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA775C433EF
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 14:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242219AbiDGOSJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 10:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbiDGOSI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 10:18:08 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C56182DA1
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 07:16:08 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id nt14-20020a17090b248e00b001ca601046a4so9053393pjb.0
        for <git@vger.kernel.org>; Thu, 07 Apr 2022 07:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hj7huX7K91uuch6I63aP8ceMcaKJXgLUOQInS1yofVA=;
        b=ANvVYr/31wLEW6i9VurHcx4xRFG6gwaYEjp2fa370vNzPEzZLtOW6x4vPNONpppP6I
         ccCig/JPCI06KkUjz7VfjH7FGxA/GiLWWdfKafAElC4e0hgy5M6wNM50WwVgNk+iXihs
         Z3tPvJCR4IOVeldPi1Xp8lyIGEdLoH8Jrs5bn8aJuQXwyPBjUMM/epvTEShZqV9NlOGN
         p05qVCieClPB9c+4hdrYjWCcjlXYEMiy61yyJ6p0nizD9q9vTnmaAjCXO6CnU/DzSggz
         K57HEhQQS6CExa/63SUbwNpQZIqW7wIIcCNSuCBBdMhmoEdr2k2SupVUaxw1Zpq6oLNi
         ySUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hj7huX7K91uuch6I63aP8ceMcaKJXgLUOQInS1yofVA=;
        b=SPLNROvXV+gFp8hBV/Yhd0zr+yVdrOZ0GsQMWqLJJR/NsO0uAlk95fgEPOnfXiAQxB
         9xtMM9w25XKw3YvZ+AlPSfP8Oi4MXnb1JrdQfFRD9bePTmUwAm/VIW6R5IQMKwl8MajT
         6aC+9smR+K0SBpj8kcbF20PnDkOmH/uIQwjY3mw47s7reUXOh6EGv4VcKUlkCld8p6He
         PALqttWvyi0P2ydqppY1keNkQwEMHax9JvPJYfz2KjX+8LRTeKYI3VArobhnEqul/f10
         nIcafjoXkarjkEocdDq91rEdfai7h+z4156uf6C3UE4Aqkr2EVUvyZ7rtraDWshSD1Us
         Fy5w==
X-Gm-Message-State: AOAM532qDle7a1O3QtK1Pbc36M/HnBpQeb2EwfiB45pB/fzCcE9Fzg+6
        +XZ9H+3mlxYSDP8wkXi+qpl+IFbCZaaeaN81Bvh+In+g
X-Google-Smtp-Source: ABdhPJxwd2fWWVb1K2Tkz3K46zJJEd/vuoOCVeMZ5wLjWlniSsheuauWbz8d7PQZc7j19j17HMQPN9/lrqg2haTcHeE=
X-Received: by 2002:a17:902:ab57:b0:156:c63e:9d1a with SMTP id
 ij23-20020a170902ab5700b00156c63e9d1amr14263826plb.49.1649340967888; Thu, 07
 Apr 2022 07:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1150.git.1645441854.gitgitgadget@gmail.com>
In-Reply-To: <pull.1150.git.1645441854.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 7 Apr 2022 16:15:56 +0200
Message-ID: <CAP8UFD1B53KDP=XoYzd6XmdKK-BN9Of7C2yxPxG_atPhNtZHGQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] rebase: make reflog messages independent of the backend
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 22, 2022 at 6:04 AM Phillip Wood via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This is a series of rebase reflog related patches with the aim of unifying
> the reflog messages from the two rebase backends.

I took a look but might have been lost or confused in the middle, so I
didn't look much at the last patches. I think this has a worthwhile
goal though.
