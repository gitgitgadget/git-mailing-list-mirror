Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA32320A28
	for <e@80x24.org>; Wed, 20 Sep 2017 16:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751715AbdITQ4R convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 20 Sep 2017 12:56:17 -0400
Received: from mail5.fer.hr ([161.53.72.235]:52983 "EHLO mail.fer.hr"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751718AbdITQ4P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 12:56:15 -0400
Received: from POSTAR.fer.hr (2001:b68:16:250::72:237) by MAIL5.fer.hr
 (2001:b68:16:250::72:235) with Microsoft SMTP Server (TLS) id 14.3.361.1;
 Wed, 20 Sep 2017 18:56:12 +0200
Received: from mail-yw0-f174.google.com (209.85.161.174) by POSTAR.fer.hr
 (161.53.72.237) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 20 Sep
 2017 18:56:12 +0200
Received: by mail-yw0-f174.google.com with SMTP id x131so2323473ywa.10
        for <git@vger.kernel.org>; Wed, 20 Sep 2017 09:56:12 -0700 (PDT)
X-Gm-Message-State: AHPjjUj3Vir8Sm1p9EjuTyaVeZvsxUeShGtteG3fZG7ltiIpy1yAn/qt
        U3KCA+VSmx/JTNGZz8ErilJ9hkIC6w20HaPAMRU=
X-Google-Smtp-Source: AOwi7QCvjGOskOPyoE5yMFHF3NjqDXWTcLojIDOg/FDFD81pxrDHdNm8t6rPQjkccbatrk+KSbv9y1ckTn3/fx3n1R4=
X-Received: by 10.13.235.197 with SMTP id u188mr4280337ywe.349.1505926570950;
 Wed, 20 Sep 2017 09:56:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.170.138 with HTTP; Wed, 20 Sep 2017 09:55:30 -0700 (PDT)
In-Reply-To: <CAEPqvoyVJFe2EOvhnZD4vdF=1-VuoZrMP92TeGJ2WAE0X+B5Tw@mail.gmail.com>
References: <CAEPqvoyVJFe2EOvhnZD4vdF=1-VuoZrMP92TeGJ2WAE0X+B5Tw@mail.gmail.com>
From:   =?UTF-8?B?SnVyYWogT3LFoXVsacSH?= <juraj.orsulic@fer.hr>
Date:   Wed, 20 Sep 2017 18:55:30 +0200
X-Gmail-Original-Message-ID: <CAEPqvowWEdFdJoyqsmBt7KRU8xWyuLnFwV7CJ7zH2QRa2AQCtg@mail.gmail.com>
Message-ID: <CAEPqvowWEdFdJoyqsmBt7KRU8xWyuLnFwV7CJ7zH2QRa2AQCtg@mail.gmail.com>
Subject: Re: git fast-export/import bug with -M -C
To:     <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [209.85.161.174]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, did anyone manage to take a look at this bug? Friendly ping.

Juraj

On Fri, Sep 15, 2017 at 12:01 AM, Juraj Oršulić <juraj.orsulic@fer.hr> wrote:
> The commands should be self explanatory. 0.2.0~20 is the first commit
> where the reconstructed repository diverges, that commit had a
> simultaneous copy and edit of one file. It seems that copy/rename
> detection, enabled with -M -C is confused by this. I reproduced it
> with git 2.14 next @ 8fa685d.
>
> git clone https://github.com/googlecartographer/cartographer_ros
> mkdir copy && cd copy && git init
> (cd ../cartographer_ros; git fast-export --all --date-order -M -C) |
> git fast-import
> git rev-parse 0.2.0~20 #2237e1d0a974977fbcb0737dd1fb5876a2b8e29d
> git rev-parse 0.2.0~21 #cd1276a99ccffcc491d0b2e50296ec04347ba5f2
> cd ../cartographer_ros
> git rev-parse 0.2.0~20 #9d5b221ed41783b15c84bc90b71527194b8d9a49
> git rev-parse 0.2.0~21 #cd1276a99ccffcc491d0b2e50296ec04347ba5f2
