Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3F2C83028
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 16:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2F8B60FDC
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 16:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346342AbhIBQyn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 12:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346217AbhIBQym (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 12:54:42 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894C9C061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 09:53:43 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id c8so5741142lfi.3
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 09:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hMA/kH1k1qCiD//Aiv2eMu8iSQBgWzG/UDQfw/qVgwA=;
        b=nbOijApXynek6AMUKF/KyYXPWY6iK39gbjbvMZGedtTSBkCGThCI5rwduT95xLFm+5
         uJw+7r3pFi34uNe5XJ9KKMLYpCDXR35qj+Nzo+SonAybL+VbvKjoJdrnt+tBx/fQA0Aq
         8ZoL7kvRQfifiizP544P9M0sBrF63gUmx7wkR3Yzhz3kgIp0ZCgCQDDFgmmqxNf251mK
         6wtdhBU7zVJCdtJ9njEbz/h3Ldazgm1qh616wBzlfQfz0sFWFbBDVn3lpFnb7mSkkVPe
         pnBkc05o1zQ9RsCkpAP6OaOX5leUwNRGTbTdA66julTA8bIf+IdleWY9LbvdTxIWaEKe
         h1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hMA/kH1k1qCiD//Aiv2eMu8iSQBgWzG/UDQfw/qVgwA=;
        b=ff00ckoSKavQNUat7Gzoj7VhPobyjzBXDSN9/+KIUyVzI004DBCe8SY9StcPHUyc1W
         U13eP7bQjxfqCcOQFk8i3SQzQdwNpejRscs7Gkyyhfk6nltfSQxgUThVmIDYN0QT3Epe
         3BCmCqwAz6c5VTJH/Py+2nDHZf3SbWI/SP0diESKJAZLURnfyq/dAXBsWWmLQV5Dh+7t
         4WNwqXFBE1rQvf6CoBEmlymGs7GCz35nUhkPQQk/LkRIClN5VxrQY868NN3ldOzuC9Zd
         GSwu95UQM87BVPbaIPLjezQvJCmdTGW/JvgNKRtiIDNU88AWsFCcvLzRsPEfYEyzO8rk
         APyw==
X-Gm-Message-State: AOAM5306AoiLU8udhcphFRRahFlq46EXVEkofT/oWBNFk9WhNcSqrStR
        AnrAmFY668vitFbZM/lDjUARnWnxOw7CUVhQeYrjfKdoz1LtUA==
X-Google-Smtp-Source: ABdhPJxhpIcR+o94kffd88CV1jQhcD6C7hA4lWNs/otkUJ4YVqL9gXZqJriw9NcrcudWcKMCN6Nr15Q61TUw+J7LOfI=
X-Received: by 2002:a19:5609:: with SMTP id k9mr3305435lfb.393.1630601621841;
 Thu, 02 Sep 2021 09:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover-0.9-00000000000-20210902T155758Z-avarab@gmail.com>
In-Reply-To: <cover-0.9-00000000000-20210902T155758Z-avarab@gmail.com>
From:   Peter Baumann <peter.baumann@gmail.com>
Date:   Thu, 2 Sep 2021 18:53:31 +0200
Message-ID: <CAJm9OHfN9iXDt-rzu-wb=67y4PPpmCUgMfmZPy1JMBJkHG256g@mail.gmail.com>
Subject: Re: [PATCH 0/9] remove dead shell code
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>, Prathamesh Chavan <pc44800@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 2, 2021 at 6:04 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> Remove dead shell code in git-sh-setup, inspired by parallel
> discussion on another topic (but the two don't conflict):
> https://lore.kernel.org/git/87lf4f9gre.fsf@evledraar.gmail.com/
>
> The last two patches were picked from a dropped series of mine
> submitted earlier this year, it was dropped because of other more
> complex patches that I haven't included here:
> https://lore.kernel.org/git/20210311001447.28254-1-avarab@gmail.com/
>
[...]

Hm, I have scripts here, implementing some porcelain commands which
follow the same approach as
the git porcelain scripts, e.g.

  #!/bin/bash
  SUBDIRECTORY_OK=3DYes
  . git-sh-setup
  require_work_tree
  require_clean_work_tree
  cd_to_toplevel || die "Can't find top level for the git repo"
  set_reflog_action my-special-script                          # this
will be broken by the patch series

I was under the impression that this is how it should be done when one
needs to write some custom git scripts.
If that is the case, then removing these functions might break some
other users scripts out there.
At least  I have a quite an old self written script here which uses
`set_reflog_action`.
Obviously I can manage and adapt the script, but the more generic
question comes to mind if sourcing git-sh-setup
by end users is the correct approach to write porcelain scripts!

-Peter
