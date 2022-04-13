Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71D1C433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 20:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbiDMUJM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 16:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiDMUJJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 16:09:09 -0400
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8217B10B
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:06:47 -0700 (PDT)
Received: by mail-pf1-f177.google.com with SMTP id w7so2921681pfu.11
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:06:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RLNmvB0rpWAcnVz79IyBMkrGNLL6lSvdZeetIIbJAfY=;
        b=DC0IT8n7rbIVdm0gfDFIO0Oo8hPvxx9vx/qccfCnG3GrAs6PoEDsNS+TyX1e6IGUnq
         9tMa+02Y1L4sgIBu398Ih35HlDrmnH6ZxDyOgOC2NNm6qAXn4dU+HU3QUi1VkaJWGrhO
         Xj9CjQemnoju0fJussaXdyxmvpmkXbzD19PfoCZ8f46X0SwbSGWtQWd5kRtH8V0jjGpQ
         8BQ1O09EasQGQpFv3YTDwE59dywS89rIo1ppYS/YLX630HP1VBsS/FC86b1Bbu9u3lVe
         pu5ohJdzaodNKcHxsxxGHVRRoJTYXCJ2W/tHzjJgMhvYzRR9VqAJJgBPtS0Qo27UwCFi
         35Yg==
X-Gm-Message-State: AOAM533VcFqu8kQ9HA5tOloYbt03FJ8AdDNmSW1r6Uml+r9sv1OH5msM
        Veab8V0KYH/HbEEbiI/YJXgBJY54XmN0t7X8ASc=
X-Google-Smtp-Source: ABdhPJypCgoZDDJUTUuP2iKuTl+37HCT6zw8vYAuWf8HYsYL+8t/Zbi6uOwwqUTtHkDgA1mA7b5cM+Osem/oPE+SFdQ=
X-Received: by 2002:a05:6a00:23d2:b0:4fa:f262:719 with SMTP id
 g18-20020a056a0023d200b004faf2620719mr502803pfc.4.1649880406487; Wed, 13 Apr
 2022 13:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220413164336.101390-1-eantoranz@gmail.com> <xmqqlew898n3.fsf@gitster.g>
In-Reply-To: <xmqqlew898n3.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 13 Apr 2022 16:06:35 -0400
Message-ID: <CAPig+cRztjLPNOr0Fqm2NnRAGQ8kJDK5-WNWAMYhzG23uHp99Q@mail.gmail.com>
Subject: Re: [RFC] introducing git replay
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 13, 2022 at 3:27 PM Junio C Hamano <gitster@pobox.com> wrote:
> Edmundo Carmona Antoranz <eantoranz@gmail.com> writes:
> > +static unsigned int replay_indexof(struct commit *commit,
> > +                                struct commit_list *list)
> > +{
> > +     int res;
> > +     if (list == NULL)
> > +             return -1;
>
> We encourage to have a blank line between the end of the decls and
> the beginning of the statements.  Add one after the line that
> declares the variable "res".
>
> In an existing code that consistently uses the abbreviation, it is a
> different story, but "result" is not too long to spell out, and
> because you do not use the variable that often anyway, you would
> avoid unnecessary friction on the readers not to abbreviate it to
> "res" here.

One other minor point... in Git source code, comparison against NULL is spelled:

    if (!list)
        ...

(And the inverse case of `if (list != NULL)` would just be `if (list)`.)
