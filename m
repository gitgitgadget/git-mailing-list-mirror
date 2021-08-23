Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DA5C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 13:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0267661373
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 13:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237188AbhHWNF7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 09:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237098AbhHWNFx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 09:05:53 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F451C061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 06:05:11 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id n27so4922414eja.5
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 06:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=e1TTc4mej7+g+FkaJlOyXcw+4FQuI+dwz0gJgSpQjTk=;
        b=py18YAl4i2g/LGrJo+ARwOf3cjBW3jdKFBAzvS7wh8EOYg5REy+28y9YLi5ENZ4+bq
         EgDud8c7hgv7NqKAHIkwSjK9OOHBchadWoTvEItksYtioANi+Q0Akskvgw7x/phlkuxn
         1uGdeL3yhRQUVF9UyjNJYA9+Xmv2khcDgjqeW7YzlQJuHvqkEJXl5Cr/fDiqhn9eZx7m
         PJF5mChzxnnCsq5rLllnIjwxqu8QJC6LWU/U1wU1iyxM58NCRl609d/Jz6xv6urtaRo+
         Q+0xlG0+nbHkEs/JmPSDDs3WzOmQQaFqDZaWASFo3OnWA5FAU3zQq8G3P1E8O4WF0LcT
         pyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=e1TTc4mej7+g+FkaJlOyXcw+4FQuI+dwz0gJgSpQjTk=;
        b=hjD6moIEGG9yzsnwqg0QR7nrU5EheNoNgMyC4aOcE2ypYOoCdRWt8nsdYBO8tWEL+F
         +y1zqIzC/txgVnK4Tr59kep3VM1CaGsMFDcqqiQSTwuEJTDFJEuq1etqvheuRpxgZIa8
         vItzVmkyjhqauiv/JGgYmcN1mq6GyWCBfwajauIT7Q58Y995iTwULpmEheDX/zy6HFh+
         Z8wtYEspimjv/et9EFpPDw8PWMkOurtQmOFY6A+sIQQWhkYqKqQ0gpVJ0Cpj1vqeDnis
         2ov7bOdrDU653sjkektJjPhTktlAAXI80m6YgrYocsKonC9ZJEFvDVMux+DL8kWUdxpQ
         q04A==
X-Gm-Message-State: AOAM530IkzhM8K0bNEiaRb3gYr4o/EWUB6eIUesvKUrf5JXLmZ255vmw
        OWb/ghu2nR+VUC0JqRQFIUo=
X-Google-Smtp-Source: ABdhPJz5tUZKoRW1HUzvMc3qIRYQ8aoROWvg9SqfvkqdlkQkfvL3eI2HqrL5bJKi/GnfRpLLGFZ++A==
X-Received: by 2002:a17:907:1199:: with SMTP id uz25mr35682943ejb.448.1629723909422;
        Mon, 23 Aug 2021 06:05:09 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id sa21sm7383921ejb.108.2021.08.23.06.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 06:05:08 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2021, #07; Fri, 20)
Date:   Mon, 23 Aug 2021 15:03:36 +0200
References: <xmqqh7fkuhyx.fsf@gitster.g> <87v93wflm0.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <87v93wflm0.fsf@evledraar.gmail.com>
Message-ID: <87pmu4fh17.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 23 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Fri, Aug 20 2021, Junio C Hamano wrote:
>
> Updates on my topics:

I've got these two trivial patches that weren't picked up, presumably
due to not being spotted or it being too close to the v2.33 release:

https://lore.kernel.org/git/patch-1.1-f1da49de63-20210727T000203Z-avarab@gm=
ail.com/
https://lore.kernel.org/git/patch-1.1-ad71faa6da-20210727T000657Z-avarab@gm=
ail.com/

It would be great if you could pick them up, but are rather trivial
fixes, especially the latter one doing s/error/error_errno/g.
