Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2FE61F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 05:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932265AbeGFFUl (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 01:20:41 -0400
Received: from mail-yw0-f172.google.com ([209.85.161.172]:45865 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932097AbeGFFUk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 01:20:40 -0400
Received: by mail-yw0-f172.google.com with SMTP id 139-v6so3768493ywg.12
        for <git@vger.kernel.org>; Thu, 05 Jul 2018 22:20:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N3KGQjz2pswsTJJobPOXv6JWJ7zsc/9tOaIAN5gFROk=;
        b=ZQtITgIzVvGI7uOM/KPFXh2rVOgTKuMQI7Z8EsyZm3lXIPKrtDC+2M9d5msHSJ1g9E
         BbRiQAK1UciewHzZm/rKYw/j4r/erkQZtWnuufx7GGIkI9KzK3KT0VR54maqy7rDqRAn
         kf9tl741uKD5tyx31dL2agBJxCZJpjdABLFDVfNEMXdftRgSOLpAE2s7mfSezyS/z+Qg
         XaOdAYDluoygmfcDZJK1wtAt/O7rFiVn2Vj3yYoiTp3zohqKZPcveTraD6AX0x7W1A4Q
         EI16lPTivx/ge/G7hy0BzASuO0GDOY9lCb3Y2mlCXwFrpPWax7kC9OQIvBhdcKyu/YuI
         ZtTg==
X-Gm-Message-State: APt69E2QT2lrZJRzSysosOZPfVvyQXlihEtnCOCibpCziZTOGOLpZncN
        H0S2RnyHvali/W/Z3ZdxZ2z4gJ0ND9saUMxpqwE=
X-Google-Smtp-Source: AAOMgpdS6Pzlp7kQNtXACleJScX4PLPZWuRONlfUct+MKzj4Bz9CD84XkrtaxmRNE1GZ6MiZX9JsX9Lgoua1WYK0iCQ=
X-Received: by 2002:a81:1001:: with SMTP id 1-v6mr4248002ywq.120.1530854439748;
 Thu, 05 Jul 2018 22:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180625143434.89044-1-dstolee@microsoft.com> <20180706005321.124643-1-dstolee@microsoft.com>
 <20180706005321.124643-8-dstolee@microsoft.com> <CAPig+cTO=UPuCRUAAWfBwaNhRD+=dgSwpgEB2fQJuWyFEd7Aew@mail.gmail.com>
In-Reply-To: <CAPig+cTO=UPuCRUAAWfBwaNhRD+=dgSwpgEB2fQJuWyFEd7Aew@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 6 Jul 2018 01:20:29 -0400
Message-ID: <CAPig+cRFgLtw-DV4ESnY=Qs6PSqDa2bJozBUOVedS_17KPs-HQ@mail.gmail.com>
Subject: Re: [PATCH v3 07/24] multi-pack-index: expand test data
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 6, 2018 at 12:36 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Thu, Jul 5, 2018 at 8:54 PM Derrick Stolee <stolee@gmail.com> wrote:
> > +test_expect_success 'write midx with one v1 pack' '
> > +       pack=$(git pack-objects --index-version=1 pack/test <obj-list) &&
> > +       test_when_finished rm pack/test-$pack.pack pack/test-$pack.idx pack/multi-pack-index &&
> > +       git multi-pack-index --object-dir=. write &&
> > +       midx_read_expect
> > +'
>
> It's odd to see all these tests ending by creating an 'expect' file
> but not actually doing anything with that file.

Ignore this comment. As mentioned in my follow-up to 6/24, I missed
the fact that midx_read_expect() is doing more than just creating the
'expect' file.
