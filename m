Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFA881F403
	for <e@80x24.org>; Tue,  5 Jun 2018 20:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752365AbeFEUUN (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 16:20:13 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34500 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752144AbeFEUUM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 16:20:12 -0400
Received: by mail-pl0-f66.google.com with SMTP id g20-v6so2240005plq.1
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 13:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0G39u9tG/rVDSga0/Gx6NxIKy7VxTt6OUS5RQjixTX0=;
        b=IJvDLBdMD60bNwEPM89o730yArRaXBraLYNlZuVZAEzSpDHsdW8RrgKbHessB7rRIA
         mwAe/Wzsye6T1n1CYyl3fTONwm/vgOKIy0D8DJeb9+raN1CFbgsmyp+OtOCZn29O3KC+
         ZktvEvb9xbMxG/XPRakjDDqz131mDrubP4x4ti4SwcBYGX6XjBsTxQc1qp+satJ+YO9S
         M5Qtb2r2TIAYyUe/zmm5cDmyBAG02qHvwuuC0uxtemnakmsgGCk/AuCGsVg5RooIQwHw
         OYKQoM+Rh9Mob8OfgXx4lq/b8YOeKebBHsV8arLHqDjjLGp/AXczGO/QnFXSjvABo0i8
         nYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0G39u9tG/rVDSga0/Gx6NxIKy7VxTt6OUS5RQjixTX0=;
        b=loHlkkl+hjEDUa3mDCY9hOQSHMTSiIw24Aa+d8nA06FUoj0yQKkWUDfraHdA0sBkLV
         ZwC1HuzV1QtkHBaaY+GkKZg5benjzLyB6CFxIelBUVaCkEqSRWF5Heq6Yp/aeNDN4ojE
         wzI3SF7hHA/j0kmu9odqujx0Ra2gYL0QhYvoEJ6upft6UklU9NjdEnE51EXgel01Hoo+
         qRtEzvC7n873454xGamEGQLQsk+U+w7ariej2/ih33seZo7bSo+bhb6/iZWEGLKn2/0N
         rvwLHcS+oGNQG9LsIYCMiNoSoe8TIccxv5T9aOfxkirk5i41bbwnEkOWyI2XlDx9TQ1m
         6z6A==
X-Gm-Message-State: APt69E3qPkP233P+oYRixdg5uGDiuQ8uxTRp8v3hiGEOpjpCj/ssVRuJ
        p6lgtWPZnbTiqHkdRy3KTqeCDUz29qsDuI8RVJoqCA==
X-Google-Smtp-Source: ADUXVKIilLQZ4dlDLNZRVVMimV7+Cxx9mQ2oJAewBVyl69Hotoxn2gcscky5fqgyfVN5q/JCSG5bPNWfoQDG9kxa7H8=
X-Received: by 2002:a17:902:b81:: with SMTP id 1-v6mr86588plr.321.1528230012309;
 Tue, 05 Jun 2018 13:20:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:760e:0:0:0:0 with HTTP; Tue, 5 Jun 2018 13:20:11
 -0700 (PDT)
In-Reply-To: <20180605195816.GC158365@google.com>
References: <20180605162939.GA158365@google.com> <20180605195440.8505-1-avarab@gmail.com>
 <20180605195816.GC158365@google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 5 Jun 2018 22:20:11 +0200
Message-ID: <CAN0heSqsxzTmGSaLLOn0FiWhjt9kBuRAtfxua7iVGoXeLxobww@mail.gmail.com>
Subject: Re: [PATCH 0/3] refspec: refactor & fix free() behavior
To:     Brandon Williams <bmwill@google.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5 June 2018 at 21:58, Brandon Williams <bmwill@google.com> wrote:
> On 06/05, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Since Martin & Brandon both liked this direction I've fixed it
>> up.
>>
>> Martin: I didn't want to be the author of the actual fix for the bug
>> you found, so I rewrote your commit in 3/3. The diff is different, and
>> I slightly modified the 3rd paragraph of the commit message & added my
>> sign-off, but otherwise it's the same.
>
> Thanks for writing up a proper patch series for this fix.  I liked
> breaking up your diff into two different patches to make it clear that
> all callers of refpsec_item_init relying on dieing.

Me too.

>> Martin =C3=85gren (1):
>>   refspec: initalize `refspec_item` in `valid_fetch_refspec()`

I was a bit surprised at first that this wasn't a "while at it" in the
second patch, but on second thought, it does make sense to keep this
separate. Thanks for picking this up and polishing it.

Just noticed: s/initalize/initialize/. That would be my fault...

Martin
