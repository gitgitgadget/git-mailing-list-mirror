Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92C061F597
	for <e@80x24.org>; Fri, 20 Jul 2018 05:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbeGTGHV (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 02:07:21 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:45759 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbeGTGHV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 02:07:21 -0400
Received: by mail-ua0-f193.google.com with SMTP id k8-v6so6717454uaq.12
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 22:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nanocritical.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hAnIvmyB5PvFdjsEdSuoNAjdFIOU8OU21RqNtQxzWcU=;
        b=VpMDHDSTdNPkrxzav0bE2vECJ0fOqhaFubb+ww1jR4DLpNNYxHlfXv5b3JH2VyuVFa
         63AC8RLoYaeSS/LBQ/xI0+Z7rw8mo+sHJ3Ce+UBVadREXeN4Kch3agcCU1Hjb625GQYU
         jweA7ssOJGa1Mypqt7wi9aMJoTJGRuhfASLc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hAnIvmyB5PvFdjsEdSuoNAjdFIOU8OU21RqNtQxzWcU=;
        b=WNyZLgJre3gE2CThp/JfeP4EJ/GjkaNMPCdl/vP/6v8fOxuMxJApA7Iv7a53mrRQZB
         inNYOmnIkz9gKCd3GRUk1/SaJ5n5DkwzlsS6/48d2jQuQvZjAjOZwbhvbSnQ6dGRtsuJ
         beDNjOLpY5W84GBKtWA3Ewim9kSLwW0i4sd4pNOxyJ2eeX5XykHrYeaf8pg+Vqe39vRp
         tpKbAHbmGxz+My3rSh/vQjEtjGQX8lIlTdjEk06ks7gYDqRhkyIxqhA457fwLkrfTA3D
         gKjh5CgNwHRLRcQB2VzdXJFQ4VTYM3HEsbxxMnHbWNvoeUJXgtpdmV0uyRcGU5L00Gau
         GRJA==
X-Gm-Message-State: AOUpUlE55ONJGMpUrALJJ/ESkTLH5fCwSqhRYVF2umpLkwJSdFfZqp2S
        GBI/WET5EsMkk3cREzC+OLnQhcgppiEd++/LYS4L6uqQlMI=
X-Google-Smtp-Source: AAOMgpfxKjBIWTBjSR3M8AfJOIgr/lDUghyK2XH67IF0JX5p6xetUSsExe0P0f61Tzi4QEMiwSwExS1l3mfWHKkbdms=
X-Received: by 2002:a9f:2633:: with SMTP id 48-v6mr349530uag.182.1532064053255;
 Thu, 19 Jul 2018 22:20:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2b46:0:0:0:0:0 with HTTP; Thu, 19 Jul 2018 22:20:32
 -0700 (PDT)
In-Reply-To: <20180719222641.12152-1-szeder.dev@gmail.com>
References: <20180719222641.12152-1-szeder.dev@gmail.com>
From:   Eric Rannaud <e@nanocritical.com>
Date:   Thu, 19 Jul 2018 22:20:32 -0700
Message-ID: <CAH_=xoYyRhwQJhr_8hf_4dWs9DikZh8vSkQSDXbqOPjZVw5qfg@mail.gmail.com>
Subject: Re: [PATCH] t9300: wait for background fast-import process to die
 after killing it
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 19, 2018 at 3:26 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
> But how do some of these messages end up on the test script's stderr,
> why don't we get them from all five tests, and why do they come from
> different file/line locations?

Thanks for the detailed explanation.

Signed-off-by: Eric Rannaud <e@nanocritical.com>
