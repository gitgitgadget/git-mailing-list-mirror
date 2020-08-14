Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D1DC433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 20:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA65A206C0
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 20:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUjW+LWi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgHNUdH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 16:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgHNUdH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 16:33:07 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1BAC061385
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 13:33:07 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id j7so2275708vkk.12
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 13:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=E4lVRtWHSOsXhcGtMTcD4/qVdz9qUzsWUoMPw1M/JcU=;
        b=UUjW+LWivyWwcJ9GMOoqC5oBcutib6gF0srAcwk7Rvo/oaPmnj6zybuuYT47j9C03h
         j+fKYZTlV7AXYsXyriLfTGz85H/MMjWfSvc43/0nnAiXzHjHf+7qFhqABYOGp1ZAz8gP
         u+bzyQNLyMcoRsQHASQP5Osf92EIjiKqlg5KYcuXwJ63L4tLYq7qC21yHlxYS67fetnD
         sNt7mcEaBJAcA5z1l1CHlnNg23rKn41IuCaxitNCDHc1VUMwrV2NSmG9Y7ULL/AZi9K/
         hvXRMjHoUvjFTIfc4n7mWfF39AFs9sN79BEGQIkRc7Qp48CzVauD5FMtX59uaSWcaWDa
         qudQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=E4lVRtWHSOsXhcGtMTcD4/qVdz9qUzsWUoMPw1M/JcU=;
        b=iD8ccB8lCOachmWjON4SP03Th0wlL92sRGcJEIdcakuLyZBBLqt7GstWwMMiXzalGL
         awgl6ob69eR9ZrO4vLV42AIZLSnz/dnFAiO6mGOfQCQHyxY1b6GCmEN9Nao/AxKYNyc7
         U+pt3LxcFx7cHhy4R3KmFMfD46PmitWHqlWM3PbJ5HTwiRYcQLstqwEgFTf0JcfbYE5q
         +KBozE2HkwOdMSJkjmJgCO652aR32BWk0NMOzJDM4AFx9Me97lHmoh+rBWnz8F99IXaT
         I+z2IhM4tsL1cWYSE5iCxrUwa6WimfLY2+zzSa2hhjM5odtFjm8+DgomSaLa8F7104PC
         kegA==
X-Gm-Message-State: AOAM532gzq4i5pmwjtmtHpFub2ChQfv8MOW9BwFcx9MZMAKaJSSCsE9a
        WLsmWTxAyBvtmrpAkc8AMHy1QePaWlzqtz3YwOY=
X-Google-Smtp-Source: ABdhPJy4nmbiKiRooZxnt7kY26QeSmQ7q40f1NFqPZ8M6X3fzSBHFbURuxnzDZd1M+t9F8SH7e5x81vNC/yY/gykjwc=
X-Received: by 2002:a1f:1d12:: with SMTP id d18mr2809212vkd.88.1597437185122;
 Fri, 14 Aug 2020 13:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200813224901.2652387-1-sandals@crustytoothpaste.net>
 <cover.1597406877.git.martin.agren@gmail.com> <5590a68c5ba7081cd7e64c708b5c25db23f5e95b.1597406877.git.martin.agren@gmail.com>
 <xmqqk0y1xhl0.fsf@gitster.c.googlers.com> <20200814202347.GN8085@camp.crustytoothpaste.net>
In-Reply-To: <20200814202347.GN8085@camp.crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 14 Aug 2020 22:32:51 +0200
Message-ID: <CAN0heSqBfvVT18C5nHcAtO1YCCnVC7xUfjrYtS2vH6gw7uX7kQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] http-protocol.txt: document SHA-256 "want"/"have" format
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 14 Aug 2020 at 22:23, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2020-08-14 at 17:28:27, Junio C Hamano wrote:
> > Martin =C3=85gren <martin.agren@gmail.com> writes:
> >
> > > Document that in SHA-1 repositories, we use SHA-1 for "want"s and
> > > "have"s, and in SHA-256 repositories, we use SHA-256.
> >
> > Ehh, doesn't this directly contradict the transition plan of "on the
> > wire everything will use SHA-1 version for now?"

Yes, the transition plan would probably need updating there. I'm just
trying to document what we have.

> SHA-256 repositories interoperate currently using SHA-256 object IDs.
> It was originally intended that we wouldn't update the protocol, but
> that leads to much of the testsuite failing since it's impossible to
> move objects from one place to another.
>
> If we wanted to be more pedantically correct and optimize for the
> future, we could say that the values use the format negotiated by the
> "object-format" protocol extension and SHA-1 otherwise.

Hmm, I didn't think of that. Would we ever regret that we've painted
such a "big" picture and wish to refine it somehow? Compared to
admittedly being fairly narrow as I am here, then loosen things later.
I'll think about it, but I think I could go either way.

Martin
