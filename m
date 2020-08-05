Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81DDC433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 21:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 856022076E
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 21:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgHEVQL convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 5 Aug 2020 17:16:11 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51328 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgHEVQK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 17:16:10 -0400
Received: by mail-wm1-f68.google.com with SMTP id p14so7030834wmg.1
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 14:16:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SeCjFiPzu1WZgk+B3woTQQtv2Y+CvoXfusvvPUyD8X8=;
        b=ohI1tKixDnL4aFQOSMhtCzCyHmmrlbKCLS3OdcpQTWT5bhEU9LDaqK5ihesQojOl5y
         AXV75a3pxTnkHIjDrSQ9uugJhhiHHG89TTPmwix9dV5yC7KJseOVpx/CJksi0SdWijGP
         TsEgv44l1/hkSldOPql22UOsaowSjubxtOz1NMPp+uX1JgNGD2PporwBMRO0HxyA4yGN
         V75JN+Q6PSMW1RRWn6pwDF4D60qckl35Bb6dqw7X3eta3qLIQz9m3zEDdqvxBiqu+71M
         c7wmmFL29Iv1rm18mvuqumf9DR1i6DzcenX446xLySjK6e9TZsbYM8a6rzUC6VOOFute
         LqOQ==
X-Gm-Message-State: AOAM531rSD/wyLlje4wNSster5IX8sItDInYiRYfuxQ/hR1hXJM6z0QR
        uG9suAuPkwUsuwG1oL0YMKS1w0Nyijddw/d+1FWYIGaAHWk=
X-Google-Smtp-Source: ABdhPJyEQj3oJsK/7jXWsbWvHDVYHCttdbX+atBczgGkJnciog6tiPpxFBNeinVXpXPcY///l9Zf5yb7TyWbNsfR4Kc=
X-Received: by 2002:a1c:740c:: with SMTP id p12mr4748241wmc.53.1596662168700;
 Wed, 05 Aug 2020 14:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <pull.693.git.1596634463.gitgitgadget@gmail.com> <37090d232221415b227c165bd44f6711d21f376b.1596634463.git.gitgitgadget@gmail.com>
In-Reply-To: <37090d232221415b227c165bd44f6711d21f376b.1596634463.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 5 Aug 2020 17:15:57 -0400
Message-ID: <CAPig+cSn7pGzr+PYBMAgbp9V0z+OVUGgW=SDWV33HbqjMiiKhA@mail.gmail.com>
Subject: Re: [PATCH 3/3] mergetool-lib: give kdiff3 prioirty in KDE environments
To:     =?UTF-8?Q?Marco_Trevisan_=28Trevi=C3=B1o=29_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Marco_Trevisan_=28Trevi=C3=B1o=29?= <mail@3v1n0.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 5, 2020 at 4:02 PM Marco Trevisan (Treviño) via
GitGitGadget <gitgitgadget@gmail.com> wrote:
> mergetool-lib: give kdiff3 prioirty in KDE environments

s/prioirty/priority/

> Signed-off-by: Marco Trevisan (Treviño) <mail@3v1n0.net>
> ---
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> @@ -288,12 +288,15 @@ list_merge_tool_candidates () {
> -               cross_desktop_tools="opendiff kdiff3 tkdiff xxdiff"
> +               cross_desktop_tools="opendiff tkdiff xxdiff"
>                 if is_desktop "GNOME"
>                 then
> -                       tools="meld $cross_desktop_tools $tools"
> +                       tools="meld $cross_desktop_tools kdiff3 $tools"
> +               elif is_desktop "KDE"
> +               then
> +                       tools="kdiff3 $cross_desktop_tools meld $tools"
>                 else
> -                       tools="$cross_desktop_tools meld $tools"
> +                       tools="$cross_desktop_tools kdiff3 meld $tools"
>                 fi

Wouldn't this change the behavior for people running old KDE which
doesn't have XDG_CURRENT_DESKTOP, giving "kdiff3" much lower priority
than it had before?

This change also illustrates why I wasn't convinced that patch 2/3 was
necessarily a good idea. When you touch 'cross_desktop_tools' here,
you end up having to touch all the other 'tools=' lines anyhow, so the
introduction of 'cross_desktop_tools' didn't buy much in terms of
reduced maintenance cost.
