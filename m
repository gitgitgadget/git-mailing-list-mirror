Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2562620A40
	for <e@80x24.org>; Sat,  2 Dec 2017 17:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752050AbdLBRjk (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Dec 2017 12:39:40 -0500
Received: from mail-io0-f180.google.com ([209.85.223.180]:38256 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751978AbdLBRjj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Dec 2017 12:39:39 -0500
Received: by mail-io0-f180.google.com with SMTP id d14so14500183ioc.5
        for <git@vger.kernel.org>; Sat, 02 Dec 2017 09:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vUUGeIrPtavKaIQ/czyRwp2C9Lm87zAzQZZas0nV1DM=;
        b=bQXqT9bDaeNWy30d+sv4BpAIq+B71rEG6Yqea9aqZRiLkaVGVFmm0HtoI03zJjZ7Mo
         8/7trHsIghTkz/+aZHb6PRfLP7SwDtGV21QzI5iK+BCra5fH40U0RbBpM30dQAMguXsH
         4dJ/jeK2xfupCeiUZvqQWT4TEC+Q/sjMbVRuBD8GEBzq7CG3oV5uk6swa8q71lA8Hg9L
         8OEtm4l/PuAUwx/7zZU10N54RqQulUAc+fByUFYQJAgIuz3t8Wz6M80wwF+Cs07LeGzY
         R30CZAeVSZ1LtF756CoWfud5GH112fgKIRr2Up5ci7AGelw/jNf1LIJocU1AdZZyVz7J
         uYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vUUGeIrPtavKaIQ/czyRwp2C9Lm87zAzQZZas0nV1DM=;
        b=pkPV/a9wTXnjXXguMhsiflHhJonUffYtDLYbghyj6zfrI/fZbWvMjp1FawDuzjzHl5
         rYzG7nBTJ+gu42/ltmEM6YslB5n+YGz3Et1fGqz0tZdGzmiGl1tdLQWs4URHWaXBJVTf
         gVE2oFcLw96OmS95xFaU3hleMdZWS+17rYK9inRMDrVOQlo2LjfcSfdhH6YxpXPVPNcU
         XjyG53jT7JZENe+U76gGBK5N8l6GCZa1qgGljDB0TuB2yuq1hGolRK2+xS0WxhAnbvxr
         ClCJkKmW0zWg2LBIup/XTQqSB7xzfJHISENMuaSW8cfGS2p00Xg6GtWxiJDQy5xnFm6C
         e6NQ==
X-Gm-Message-State: AJaThX6A3bbh2nozVjTqu7Vm6bBRPQm/rVtBo4BgOPtf9djw3Qk2MB52
        GR4X4qjt8DtBshePH+JM96lcG8r3MFZugH49zU8=
X-Google-Smtp-Source: AGs4zMZmsf5468Tbs4lZ2PPkqZyw9xONv/pZjrVu80fqLDyibgU+sRUI+39HZdt1uEXfzPi3pysNumbkGvSRqoPGigM=
X-Received: by 10.107.47.234 with SMTP id v103mr16557909iov.96.1512236379070;
 Sat, 02 Dec 2017 09:39:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Sat, 2 Dec 2017 09:39:38 -0800 (PST)
In-Reply-To: <20171121210720.21376-11-git@jeffhostetler.com>
References: <20171121210720.21376-1-git@jeffhostetler.com> <20171121210720.21376-11-git@jeffhostetler.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 2 Dec 2017 18:39:38 +0100
Message-ID: <CAP8UFD10YsCQtiFtLtzQ-PKsY93QaDC4zsO+k1tfauBs8ntt1w@mail.gmail.com>
Subject: Re: [PATCH v5 10/10] gc: do not repack promisor packfiles
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 21, 2017 at 10:07 PM, Jeff Hostetler <git@jeffhostetler.com> wrote:
> From: Jonathan Tan <jonathantanmy@google.com>

>  pack_as_from_promisor () {
>         HASH=$(git -C repo pack-objects .git/objects/pack/pack) &&
>         >repo/.git/objects/pack/pack-$HASH.promisor
> +       echo $HASH
>  }

Now the exit code of the above function will always be the exit code
of "echo $HASH".
It seems to me that it would be better to add "&&" at the end of the
line above the "echo $HASH".
