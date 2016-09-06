Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 751611F6BF
	for <e@80x24.org>; Tue,  6 Sep 2016 18:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934306AbcIFSyx (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 14:54:53 -0400
Received: from mail-yb0-f181.google.com ([209.85.213.181]:35019 "EHLO
        mail-yb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932874AbcIFSyg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 14:54:36 -0400
Received: by mail-yb0-f181.google.com with SMTP id g5so32960293yba.2
        for <git@vger.kernel.org>; Tue, 06 Sep 2016 11:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XV3l2p3Vc+eWhYTuhAOamFZk874VMfw0Qsd0G2xDk28=;
        b=NuGOISmJbwXnDLadfCTxyRKupLIIEdYZ+pfQWOaFYmcKThAj8nU/gP9xifmlvk3X7M
         VbwaPz50A2nzzUjGKl6smETCVTVt4dNZW9ElryeVR9gVgoRlsWh6xj73/noQLPoiPfEq
         VD8AAOGnYjclI1GKwOMDVjY0uB+w+qM8G+Z7YGT19TNZ071nBNfXWItEUGmmqA4828IE
         HU9xj8MD56X6KAVO0r4JAUZZMn9N6geAlRHeBKVwsZPOVUduCqYnP3WGYLweRCZcsDHj
         VEMWoH7BOVDVMer9jIWFJuGR8i0MxUDSQHSmneqoHno6/RKCeCw+o6wZ9Qq+dUe1GV+w
         T6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XV3l2p3Vc+eWhYTuhAOamFZk874VMfw0Qsd0G2xDk28=;
        b=iq+huWjg3KkDUwfdJT5fATspHmXVkl2AjJsjUCC3oaNIm4/uuEuf5+6gYgJaiXzKzK
         84zjFVLZJK8eesOGQqwIpWNEDtxNS8c+oZI/4Q29uKc7S47Zp83HTuA63pkGDufRCSLy
         WZOTC6WvMtwzHPnDExw3mKpXOQ+hiGczZci98ITtX1bZAQAlJoW8Ai8ZPztEpGJmZJOu
         FopvWvg9oaVnkjGTLYOt9jFluqIQ7DA6YAiKCDfWlEM0KGkhFKSr98LdwRaUkM0/qF28
         uBAXc5Iau1rA4EEFOyqp+QmOaBltv6dDsS+G/ReL/PBs8dFLolbVtOpgEQj4EJVPq59L
         JK1Q==
X-Gm-Message-State: AE9vXwNI4AHAdwo3fSmRsCsuekbgLCwfXc8ObFGw9oHawk7JXpJinpVbuVKOxSvOaKEwBD7XPBgtxvXjYUQOEPTo
X-Received: by 10.36.53.14 with SMTP id k14mr317864ita.58.1473188075581; Tue,
 06 Sep 2016 11:54:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Tue, 6 Sep 2016 11:54:35 -0700 (PDT)
In-Reply-To: <20160904201833.21676-1-chriscool@tuxfamily.org>
References: <20160904201833.21676-1-chriscool@tuxfamily.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 6 Sep 2016 11:54:35 -0700
Message-ID: <CAGZ79kY0YfAJjy-2u4UJxHtd+02_ZcVg8n1yVD9oZydmW6q6cw@mail.gmail.com>
Subject: Re: [PATCH v14 00/41] libify apply and use lib in am, part 2
To:     Christian Couder <christian.couder@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Karsten Blees <karsten.blees@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 4, 2016 at 1:17 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> Goal
> ~~~~
>
> This is a patch series about libifying `git apply` functionality, and
> using this libified functionality in `git am`, so that no 'git apply'
> process is spawn anymore. This makes `git am` significantly faster, so
> `git rebase`, when it uses the am backend, is also significantly
> faster.
>

I reviewed this v14 and all patches look good to me.

Thanks,
Stefan
