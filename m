Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2115BC11F65
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 18:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED59661449
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 18:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbhF3SDW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 14:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhF3SDR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 14:03:17 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FF4C061756
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 11:00:47 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id bg14so5671697ejb.9
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 11:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=z1ehih1QNMRz766m3j56Luk2Y9HPwTjzzR1ejh1WSJk=;
        b=KFj6D1zbTDu7warajh90hvBB8YwG9woypoL53bIzNXe23eGKqG1/8j0RKz4lOstzQI
         eh42iBmzArkXuTTtJO4ewlpnMN9JLqdq5kZUYRyWFZeQ8nB9wm7K+oQXRE28lK5o9ckr
         331YxBKPGRx6Uxnhc5gbE+2CBVdRvoQSqj1gTM0KPJlF5XJTHlpevHSU18xDRbjLJfXO
         MZqjMyajHzx7+PJtYzeiBBKEi9WQTltKAcXUFoOa6JhhrvSHka2AJFDhTCZuFtZnTUfW
         5V2MHjlN4097E48GtUJuwE8NYEOfk5K5vRKQBhhipOaqKFiUN7XympwVe316ylIxz8Ea
         zp8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=z1ehih1QNMRz766m3j56Luk2Y9HPwTjzzR1ejh1WSJk=;
        b=Hn4dLM1q4zKnpb3u2nVzLyUgtcTajsljz+8Ss4n50BBnM1Is5SWAe7EAbfjoNWLYDk
         2Upi1fXDA2teo1gR88H1HTbCS54aK4xMaFQ1pLXdIxXYk3ryX/fm87vp55qdJBtVngfG
         gQ3M2VNp5zknEm+RqPPmYEHBYU80LB9Puj07g8DfWT2doXhADJ9xDn3pJTqNfyBScG1Z
         a8Ws85LEH9GQbdzwmFU+NYjzjcFHCzHM+c0GOaJl+fbyMEV0Xj9nwbCqfVAFwXYogNAK
         WJFk3Xsgq+VKNg1cb7fyS+AGOv4LCXGqgi2WJWOSkc/qoLI9ljt62RZ4WB5PB+cn3wOG
         hWDA==
X-Gm-Message-State: AOAM532cDKoNgqC+cMta45XcGy8dN5Zq1pEZRyHgCBjDRykektSm3/80
        Qon9orT/N+jb5oHjPZY6TzqN2ay0sWxsow==
X-Google-Smtp-Source: ABdhPJxW76oXw5MzLRxniS0TJ5RLhl31ERhuNHPitgIvfbbjwQ+ziZP73jDtM0WS8Z2QPMKe2IKW+g==
X-Received: by 2002:a17:906:c108:: with SMTP id do8mr37150885ejc.74.1625076045786;
        Wed, 30 Jun 2021 11:00:45 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id d22sm10174345ejj.47.2021.06.30.11.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 11:00:45 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v3 0/3]
Date:   Wed, 30 Jun 2021 20:00:05 +0200
References: <cover-0.3-00000000000-20210621T151357Z-avarab@gmail.com>
 <cover-0.3-00000000000-20210630T140339Z-avarab@gmail.com>
 <YNyrDxUO1PlGJvCn@coredump.intra.peff.net>
 <YNytp0JAIaQih0Y4@coredump.intra.peff.net>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YNytp0JAIaQih0Y4@coredump.intra.peff.net>
Message-ID: <87y2ardygj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 30 2021, Jeff King wrote:

> On Wed, Jun 30, 2021 at 01:34:07PM -0400, Jeff King wrote:
>
>> As an aside, having to have a separate bundle_header_init() and
>> BUNDLE_HEADER_INIT is annoying (because they both must be kept up to
>> date with each other), but quite common in our code base. I wonder if
>> writing:
>> 
>>   void bundle_header_init(struct bundle_header *header)
>>   {
>> 	struct bundle_header blank = BUNDLE_HEADER_INIT;
>> 	memcpy(header, &blank, sizeof(*header));
>>   }
>> 
>> would let a smart enough compiler just init "header" in place without
>> the extra copy (the performance of a single bundle_header almost
>> certainly doesn't matter, but it might for other types).
>> 
>> Just musing. ;)
>
> For my own curiosity, the answer is yes: https://godbolt.org/z/s54dc6ss9
>
> With "gcc -O2" the memcpy goes away and we init "header" directly.
>
> If we want to start using this technique widely, I don't think it should
> be part of your series, though. This probably applies to quite a few
> data structures, so it would make more sense to have a series which
> converts several.

That's cool, yeah that would make quite a lot of code better. Thanks!
