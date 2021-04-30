Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D592C433ED
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 20:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 132C36144F
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 20:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbhD3URo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 16:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbhD3URm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 16:17:42 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3F6C06174A
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 13:16:53 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 92-20020a9d02e50000b029028fcc3d2c9eso43019524otl.0
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 13:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=Ydu9rQEvPbTK/rYjFYLI9bmkyY5tnpJ2FwcOgjf3r90=;
        b=BcSpS/7opqUHdcECE1HQ2ItWfeQAHZ4B0/RDyLaqCxD40j7ZV7mHp6H7A5uCOwvg5w
         ja3rD4SJTP/EwFNrEzYw3N0Bw9jXBfh/Ta+AQNYDECknpdmW51ZVOPk9GK/JZ2qkPHSx
         LS/om9EyobJ9BU19C4+8I9Kue1qThWwuqOiQ7xO/46YsQMR9xLDHtRj4NpXd1vOHsTfx
         KYtly2SoDtlyJxTPohZdlkr+Jm6EUhB4pZ/OL/6eadNBxRNA22eTz6fku/DA22USyLNu
         fHmJhWaXAzALmaSd3dl6UQyCdqLV0hZVPoD/eiu896CNjc9yGQ75Oqnzx1l7j2H2ruri
         VljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=Ydu9rQEvPbTK/rYjFYLI9bmkyY5tnpJ2FwcOgjf3r90=;
        b=WuGdLvGsDl1f30hoowVTMB3t7fRo/7meYmOyN2zJXB0SAsO9IIXf2IgzE3jJ2EP7/I
         X0CLQXvIgBp5VYgVPXVGAfD1yXTJvr2Kob1OyVJ96lA03w9UmruFM0jMaLa18ftt+F1J
         tNe4Sj0eScmWHO5HK1ECsobx5f2GWrk6XOlfl3tRHSdlS8wJXzoiABqtcUCqMXZ6tKLd
         BXbS02xqALycuFtoEJZTFXQcdT2M/BFATPtUeKGa2PWO6dyHcfS3fPdhIXRzaugn4gAP
         BsbElb5ES5olra/yNvrqQoHmfhPOhxnLx69TcaA5o1SNe3tk0Kis+nBsMrjNIoFVULpK
         0pmw==
X-Gm-Message-State: AOAM532Et/oB/yA4yYwbM0BH4wbWZA48t4U8nGBUtWeqemp8RG10Vx7P
        VOJKxAD11l2cfG8sy986DjI=
X-Google-Smtp-Source: ABdhPJxI1blgi20TktVzp4lFxoS8ZpK4tYwikbe3xN5ac07Fq0akIBaSRtpJm9j0fBFPdVOOgfSPvg==
X-Received: by 2002:a9d:4f03:: with SMTP id d3mr4618630otl.361.1619813813370;
        Fri, 30 Apr 2021 13:16:53 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id k26sm1011566oop.30.2021.04.30.13.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 13:16:52 -0700 (PDT)
Date:   Fri, 30 Apr 2021 15:16:51 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Eric Wong <e@80x24.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Raxel Gutierrez <raxelgutierrez09@gmail.com>,
        mricon@kernel.org, patchwork@lists.ozlabs.org,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>
Message-ID: <608c65b36c122_2cb2087f@natae.notmuch>
In-Reply-To: <20210428075927.GC13114@dcvr>
References: <YHaIBvl6Mf7ztJB3@google.com>
 <YIYfsMsz0Uz48GaI@camp.crustytoothpaste.net>
 <20210428075927.GC13114@dcvr>
Subject: Re: Pain points in Git's patch flow
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong wrote:
> I've also heard good things about notmuch, but I archive old
> mail to gzipped mboxrd right now[1], and that only supports
> Maildir...  I learned to use Xapian by reading code in notmuch.

For what it's worth I've been using notmuch for several years now and
it's much superior to anything I've seen. I can find all kinds of emails
instantly and using my prefered text-editor (vim).

But yeah, the only problem is getting the mail in the right format in my
machine in the first place. But once I have it, it's blazingly fast to
deal with email.

-- 
Felipe Contreras
