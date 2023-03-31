Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B76C76196
	for <git@archiver.kernel.org>; Fri, 31 Mar 2023 10:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjCaKhi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 06:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjCaKhT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 06:37:19 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8661D1C1C5
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 03:37:14 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id bi9so28255051lfb.12
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 03:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680259032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2G4b5SnJPsale2mFDWSgo1mdJsJfjAb4xYDOm7u4bQ=;
        b=lOqNTyqUw+3O5C38T6hI8k/mpNaLnoorK4p2EiyjKYZzaL9PhPrIrpudxPHR3I6sni
         Cz0CR2cg/Fle6vIRopfwWPCwyUhzXMAPBtur2wrroLMlZU/NKZmHGsFbeakNlXuU7u6p
         JBzCECBHip5uCqFEI6GgyJdX4hY61dikpETqFEBlOA2nOX0dx5qdAkw43kx3uDe4KQy+
         0Hh8Co8yCY/Nuv/dh9HUDrXsmDeIaoyBu30IM8+ZMwbEN2OnqY27LTXncE/0/yARH+iH
         n6MYGWYxfuSAD+9GTAoypzGdRUD/7dMen4nGzXTXoIvvdpP4YDJszfOfa/FIH1qY3AdD
         9LgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680259032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D2G4b5SnJPsale2mFDWSgo1mdJsJfjAb4xYDOm7u4bQ=;
        b=z1/hc9xfrh94FKemhC9ZGCJGoQ+5GDLL578CfAcqPK28mrXHVtmo26W/DnbLqIEasw
         MJHMPRSzL6uxC6+7q0qYhTvlZm23vUiW+JAn0Y+Jhgzn4MeseSVaa8b3HZ1XFaUTzZwu
         V5V5rPxbrJuo01VWDzcxAnuRZzutYoHl7EnMmD3MIK34KJmGbkZ36Aho9iWwlRSWM51d
         xDMK6l0DoR+KpHd8gk7fyVr4a1SGaEZLiB7WvE7sT2Xe6uq6SL7qwiQQhTeLLeKJhTJo
         vAZmvkmBujZvHh+1XPf/fGN5U7oRsQjYI0/IH0ppSBwL4pHb/+g2PwQ/CIx8vjJ9GCBl
         LjQg==
X-Gm-Message-State: AAQBX9dgfB0sckSvOi0ey69ssii3MI2+y7Izfcp+pYuAclbTnGp9CBOo
        CoJiUmmc4qJlz9epvYJUFfBgr9zgouQ=
X-Google-Smtp-Source: AKy350azhg/U2+s7qCJYgW5pGBHoQaSmWCQcGhEU7KH46+e2cfsf8hMaHRcwR/l95Ypa3qCfkdxitA==
X-Received: by 2002:ac2:43dc:0:b0:4eb:982:ad3 with SMTP id u28-20020ac243dc000000b004eb09820ad3mr7309759lfl.24.1680259032411;
        Fri, 31 Mar 2023 03:37:12 -0700 (PDT)
Received: from localhost.localdomain ([2001:4641:9d1:0:9c74:f016:4c88:53bb])
        by smtp.gmail.com with ESMTPSA id c17-20020a197611000000b004d575f56227sm326021lff.114.2023.03.31.03.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 03:37:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, oystwa@gmail.com
Subject: Re: [PATCH 1/2] ref-filter: remove unused ref_format member
Date:   Fri, 31 Mar 2023 12:37:08 +0200
Message-Id: <20230331103708.18945-1-oystwa@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <xmqqjzyy2rdl.fsf@gitster.g>
References: <xmqqjzyy2rdl.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 30 Mar 2023 at 17:25, Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Øystein Walle <oystwa@gmail.com> writes:
> >
> >> use_rest was added in b9dee075eb (ref-filter: add %(rest) atom,
> >> 2021-07-26) but was never used. As far as I can tell it was used in a
> >> later patch that was submitted to the mailing list but never applied.
> >>
> >> Signed-off-by: Øystein Walle <oystwa@gmail.com>
> >> ---
> >> Would be nice to have a link to the email thread here, but I don't know
> >> how.
> >
> >
> > Here is a link to the patch that led to that commit you cited:
> >
> > https://lore.kernel.org/git/207cc5129649e767036d8467ea7c884c3f664cc7.1627270010.git.gitgitgadget@gmail.com/
> >
> > It indeed is cumbersome to add, as the Message-Ids for patches from
> > GitGitGadget tend to be ultra long.
> >
> > But b9dee075eb was the last one in the 5-patch series; I do
> > not see any "later patch there in the thread.
>
> I think there was a follow-up RFC series that was written to use the
> value of the member, cf.
>
> https://lore.kernel.org/git/9c5fddf6885875ccd3ce3f047bb938c77d9bbca2.1628842990.git.gitgitgadget@gmail.com/
>
> but it seems there was no review on the series.

The follow-up series you link to seems to be a superset of the first series,
which is what confused me. This is why I thought perhaps a subset of the latter
series was accepted. But I see now that the dates match that of the first
series, and you even applied it very soon after. Strange choice to include the
first five patches in the follow-up series, then...

Looked through the git.git log and see that it's not uncommon to reference
patches from lore.kernel.org, so I can do the same. Perhaps in the "footnote
style" to make it easier to digest. That is, if we want to apply this in the
first place... It is a very minor cleanup of something that does no harm. On
the other hand this particlar line of development seems abandoned.

Øsse
