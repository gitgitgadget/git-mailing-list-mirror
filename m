Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FE531F404
	for <e@80x24.org>; Mon, 13 Aug 2018 16:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbeHMTiJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 15:38:09 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:32894 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbeHMTiJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 15:38:09 -0400
Received: by mail-wr1-f54.google.com with SMTP id g6-v6so14894831wrp.0
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 09:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5V8ic7jeYDsdIyk1xaSwhVLDl6kWdVnG263hZ7r2MrE=;
        b=vfFXMvzGVaRh0vLMBfHSrtFt4yn90MaMBSMSQRmHd2Nwh114Lhr7KYeoZ7b9pPCVU4
         gKsfnIweA5Y7OVdlnzn5CEqtRaqsuL4BEVs5I+aPESb6CnWhj4cvkpjuAQOOUsDmxnW1
         NiTzU/FgSKk/u8p8gkcajldtut+gm1hAD/1xN5mWoigxW5cgl47Thc6OMo1sYkM3cYHb
         /Z8o36DCoR7S+sT1HYNS0c9p6056pmS4nyU+dsLsGEyjbephIS380SL+TeSrAF1Gy9x/
         sykG1x23y7ji6IHrxapvDnFUSB0P5k4P1+3uDp0uOMMhsFps4funUEOZmj9SDQe0sy6T
         p18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5V8ic7jeYDsdIyk1xaSwhVLDl6kWdVnG263hZ7r2MrE=;
        b=fic1DVu2xf7kupuN0K+i++1Cw+/RVp36kCUrBTarYknsREGGjJ6DAF0duY1EVn/JNz
         cZA+Xf9830IXQwSs6+n27MTrCGBoB3k/G2ws7xIUTeSkngKR3TfB5EjpFlhPqahv9A03
         S4RCnkQx267MYhmLqe6FVW2C7nED7ymPpubg2vD4EjkgYspRrs2pLGzlV+oX3szZYK1m
         IJukG+ELkuFAhAfB5DLu9sJJiEI3pGB+2dvBLGS/aCcX7xvFf8DWZmi/tSKsg1wBraEf
         +feVWLriMYgWiyhfEGKe79uNskw5pMd+p+2791Zc/JlEAKUWye0MXhD1P6JIBYnnHK4H
         oPPA==
X-Gm-Message-State: AOUpUlFNYysHd+53mZsBhKk64OEzmPbg+XnCeruqd0tELkGA2bAFIgfb
        cdsExhhV2mJ9S5Be/YqC89g=
X-Google-Smtp-Source: AA+uWPyTdfwWlJExAGwvznm2MURZDsP1fVB4zLtn+nTO3WVX8ZcuXZfz5n2LwixbSIn037pxFO+kXQ==
X-Received: by 2002:a5d:62c7:: with SMTP id o7-v6mr12139370wrv.83.1534179305456;
        Mon, 13 Aug 2018 09:55:05 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d18-v6sm7021342wmb.33.2018.08.13.09.55.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 09:55:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?Q?Pawe=C5=82?= Paruzel <pawelparuzel95@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Torsten =?utf-8?Q?B=C3=B6gersha?= =?utf-8?Q?usen?= 
        <tboegi@web.de>
Subject: Re: [PATCH v3 1/1] clone: report duplicate entries on case-insensitive filesystems
References: <20180807190110.16216-1-pclouds@gmail.com>
        <20180810153608.30051-1-pclouds@gmail.com>
        <20180810153608.30051-2-pclouds@gmail.com>
        <20180811100905.1511-1-szeder.dev@gmail.com>
        <CACsJy8BeRYVvWvTQU+bj+hSQ3DFw0mHtSjtOg9zVSsXznpU=Xw@mail.gmail.com>
Date:   Mon, 13 Aug 2018 09:55:03 -0700
In-Reply-To: <CACsJy8BeRYVvWvTQU+bj+hSQ3DFw0mHtSjtOg9zVSsXznpU=Xw@mail.gmail.com>
        (Duy Nguyen's message of "Sat, 11 Aug 2018 15:16:12 +0200")
Message-ID: <xmqq8t5a6wbc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> I was careless and checked the wrong variable (should have checked
> nr_duplicates not state.nr_duplicates; the second is a pointer). So we
> always get this warning (and with no following list of files)

Heh, does that bug go away if you got rid of the pointer-ness of the
field and store the value directly in there?

>>     I also notice that this patch doesn't add any tests... :)
>
> This is platform specific and I was to be frank a bit lazy. Will
> consider adding a test with CASE_INSENSITIVE_FS after this.
