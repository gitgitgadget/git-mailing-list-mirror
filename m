Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83788208E9
	for <e@80x24.org>; Sun, 22 Jul 2018 09:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbeGVKB1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jul 2018 06:01:27 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:53171 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbeGVKB1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jul 2018 06:01:27 -0400
Received: by mail-it0-f65.google.com with SMTP id p4-v6so20109260itf.2
        for <git@vger.kernel.org>; Sun, 22 Jul 2018 02:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DhXfB4pM9cDNVpGcpSbzZBpKTRcUYQ/dN0XAEOnASOY=;
        b=m1hIMXMnHqJc+fZ5PA0byNIPSHnXwTOJpy1WbpXgV9qDqLYL5raah8ceEXoqAugE0o
         WS/4VtqU+dXg1xlamA/BHpL9TyHjjfAIgYz1M/4P3HEge0bjhl48l9Km9DfJdW1qXXP7
         KosOpzwuORRfjMpN+mXJPSsLCgk+blE0NYTDbo0CCYFGBXRHkYwqkASg28PDsXdNPBwa
         KCjOAFIhlPfs7jAR9T/OaroXdgg2aaO1e3Ycz+1MIMvRFjoFiBCUQZGhhdWpF2Jy/fHM
         L4K1m5IeVX34d60FzWMX75qbnz8nPUHoNdwTnUkIJvzlaGF/aWT2HWNnDuR5+R3Twyiy
         BYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DhXfB4pM9cDNVpGcpSbzZBpKTRcUYQ/dN0XAEOnASOY=;
        b=LpH8gdseE1PnIHRHGiZoS3igyO2XwIj8N9LPOPiCAL7ZMHzBp37piZHANpHQMGsd+L
         O3i/+g2SkzJsUlhO/ycBWjedUjTK+6WA5Xi0XOG1q11mwf+KXt8Xy6y8u95LuFZHILlO
         QNbQbPyPZzQHo/l9YtBfvNdnuv5XoIib1lWUfhpjilOoiI/9LMQI0uPELG808ZOroiQu
         +ubn5717kCEVmobUA1QvIWX8zNnmcrdlMJxWD6V8sKP3Za0MjutNUvgFxwQS77jeLOnn
         RW6cS2+uZquPJDbSJI0yWgN4piImXW0+vjjJm6CZk40Tg64Z+DS9rGNzmCp1cQrWeVaj
         vvbw==
X-Gm-Message-State: AOUpUlFpIIvE2MyeSNZ7+squ0F8av2v+Dt06xWRoMgnd8SoGenkFambu
        liVxVezXkUS+SakkT8gYUI862nGpROf4w5jDAm4=
X-Google-Smtp-Source: AAOMgpflUNcJcROD8aiQ21hdYvcc6seZNhYk1gOCRUacQ5q+P2xE/Jb9oj72h3DFmbLNurxSvRDOSbAkfbuOa5j0lWE=
X-Received: by 2002:a24:b101:: with SMTP id o1-v6mr6624233itf.121.1532250327202;
 Sun, 22 Jul 2018 02:05:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180713174959.16748-1-chriscool@tuxfamily.org> <20180713174959.16748-7-chriscool@tuxfamily.org>
In-Reply-To: <20180713174959.16748-7-chriscool@tuxfamily.org>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 22 Jul 2018 11:05:01 +0200
Message-ID: <CACsJy8B+NBgKFZbrN2etgkecv6yH4NGWogVqzK0K=01MSO2naQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] Use remote_odb_get_direct() and has_remote_odb()
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 13, 2018 at 7:50 PM Christian Couder
<christian.couder@gmail.com> wrote:
> @@ -477,8 +478,8 @@ static int batch_objects(struct batch_options *opt)
>
>                 for_each_loose_object(batch_loose_object, &sa, 0);
>                 for_each_packed_object(batch_packed_object, &sa, 0);
> -               if (repository_format_partial_clone)
> -                       warning("This repository has extensions.partialClone set. Some objects may not be loaded.");
> +               if (has_remote_odb())
> +                       warning("This repository uses an odb. Some objects may not be loaded.");

I can see the string is not marked for translation before, but since
you're updating it, please consider _() if needed. Maybe also say
"remote object database" instead of odb
-- 
Duy
