Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45C5C433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 08:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiJNIif (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 04:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiJNIi3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 04:38:29 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE9E1C2EBA
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 01:38:28 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id g27so5859830edf.11
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 01:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TAPpnnu6+xmnrVcIBSr38h6gRWLo0MU/oIExvAIQcHA=;
        b=Bq1vVhWjbeqSPQ5mtQrW5lqcUTgiDJpaktlkUQVL09++/7ZKBlWCxUtWfpZf7o9JcA
         hWOcTY1MeZwP8hATQEBLgNvcFi3Wp5WYOns5VOhL/k01o60m6gJ9sr+fntrTBJOmsUVB
         NC6/TYX0ZOtmFUpDTayrODfGS71ma1FOHWaMrXePaJlXmIjYQ5KGKfTXxqpWeV97kKqH
         27yqRz+dZdtoqmVCzP1FZ5yGRPkTyIz2Ta9Maquc8wEBgaGiVSNpNuHkoLoDfz9PXqpq
         7GHAHYBjWRZjS6XyFxRhkO4S6yRCV/VZExKyAjNWBU8jvbTZMRKSu2HVJq7hzdfmdDBo
         PC4A==
X-Gm-Message-State: ACrzQf3PzdZEouKX8npa829snPD4OnomKC/6jzEMJQGoBfmLR0KSgBII
        aL6OABc+bYePKs81EzkIjGu725DzZEwmE4+YniU=
X-Google-Smtp-Source: AMsMyM4OUMlnpOMF4LudUdYcotzpirXjk0aFhE4oCgSELRcGS7F71WKrDyczI2eZFmDuo8KJxL/kwsb3K1gtVM0lqDo=
X-Received: by 2002:a05:6402:557:b0:458:7488:8958 with SMTP id
 i23-20020a056402055700b0045874888958mr3293612edx.242.1665736706796; Fri, 14
 Oct 2022 01:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpogcnwJDUazw82OB0DvdgvNS6hpUN9Qs69ppTFb1QFbLSg@mail.gmail.com>
 <220930.86r0ztufwd.gmgdl@evledraar.gmail.com> <YznhYzWztkPc9pJk@tapette.crustytoothpaste.net>
 <CAPMMpojy8OMxYT0WuZCOZjwvufmVucvoHPtvLHatopXvuk9K5Q@mail.gmail.com>
 <20221014045140.7ibix3632w4uset5@tb-raspi4> <CAPMMpogoX+R7eHkTZQKkx6HiS4ksk_sjryyuAufD_xuLfCVD+A@mail.gmail.com>
In-Reply-To: <CAPMMpogoX+R7eHkTZQKkx6HiS4ksk_sjryyuAufD_xuLfCVD+A@mail.gmail.com>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Fri, 14 Oct 2022 10:37:51 +0200
Message-ID: <CA+JQ7M9tfey7oUJuWORXUw2=WGZ=++Q7bUfmt1x9M8HuCXDNTA@mail.gmail.com>
Subject: Re: icase pathspec magic support in ls-tree
To:     Tao Klerks <tao@klerks.biz>
Cc:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 14, 2022 at 10:32 AM Tao Klerks <tao@klerks.biz> wrote:
>
> I need to use ls-tree rather than ls-files because this is indeed a
> command to run in an update hook, and there is no working tree - no
> (relevant) index, in a server-side update hook.

I believe
  git diff --name-only
doesn't need a working tree
