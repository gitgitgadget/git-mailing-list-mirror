Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD74F1F428
	for <e@80x24.org>; Sat, 28 Apr 2018 20:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751808AbeD1U4G (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Apr 2018 16:56:06 -0400
Received: from mail-ua0-f181.google.com ([209.85.217.181]:37735 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751612AbeD1U4F (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Apr 2018 16:56:05 -0400
Received: by mail-ua0-f181.google.com with SMTP id i3so3297919uad.4
        for <git@vger.kernel.org>; Sat, 28 Apr 2018 13:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Q0VXJEojrT772TdazLuU0GtR3QBwMcyG82TkKGgr+RE=;
        b=cSAfiFMQ7SOcPBHnqy2sLmQPmB7JYs8FljpvwyJWid6FzxlSBTaBn8b1/Cuj2/J9/2
         wwKsh3s0TGt293NAX62HlTv9pYL+Of2Ziw12EuPnExlQQtg5PvVCaa8OQcDj3EmRS+/s
         FAQ3WAvCt2kbJs+mwKXkG7UipHLmVzDMAe44lVy6ixJBjH/IonJZlPpZPkXqDzIBdp4Z
         JhUWxLMZwotiEIeDCM6TwCyDK+VWMIrENgxUUFFx5PvilZBk+Jgn+Ff7RMjvd6ZKIskV
         sqTdJCzF376Zc2Rg7U5JJIY+qe2ssWJIORJxXTEiFrIdsFuixKpxN3M42iRYpOr/oo6m
         dpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q0VXJEojrT772TdazLuU0GtR3QBwMcyG82TkKGgr+RE=;
        b=YujAdNxuWzNUYZKEOOtAkEA1aBroDoB4Ynzzj9bvEl6DWQGsZeM2dN1kq+sUI8Ab42
         a3ieRyRqJcrS+8R0geZ1iwsvGqAn/+VqoBiTx/AcoI99YWV46DskNo+fAedJI3hBAd4z
         nA8tJI7SPghSNUltKY1nejwlMLZxUXWjDCcYvKBvQ78QAMsleangDTTdEgzilAAzQ/2i
         ojdHwkLUd4h8L5zHjQ9wdotLeKZu2mIfHIAQAi+SQm+p2qKjCZ0i/cmBQWCwRRogKaVy
         gMQ1gWflSeVPd396vDe4Xj8cdkp5AxtnNd5bBYGL8lUsJN2ISd/HzFCRxEgW/AG8SKCy
         eFbQ==
X-Gm-Message-State: ALQs6tCHQGZTDpHnG4AbbGVBG/aXdLaTZTykZINRH4rWSxf4AMwDfwTy
        c66RGp6n3YUBm5UR7Kt7WI/DjSQm3H2rSBXZ1y8=
X-Google-Smtp-Source: AB8JxZr18UPuxOTQQehbCmsErZPOaAF4AMvW2VB1sDF2Vm5p2MMSye9m3koEEAlku++WUM22wOwkm5xxTabTU4CKKdc=
X-Received: by 10.176.30.139 with SMTP id o11mr4969891uak.154.1524948964641;
 Sat, 28 Apr 2018 13:56:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Sat, 28 Apr 2018 13:56:04 -0700 (PDT)
In-Reply-To: <20180428113257.25425-1-martin.agren@gmail.com>
References: <20180424162939.20956-1-newren@gmail.com> <20180428113257.25425-1-martin.agren@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 28 Apr 2018 13:56:04 -0700
Message-ID: <CABPp-BHEz4aLrGwd0OMDgMYLsRgtkgqGi-T1Bz5RYg7059MS+A@mail.gmail.com>
Subject: Re: [PATCH 2/2] unpack_trees_options: free messages when done
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <Ben.Peart@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Martin,

On Sat, Apr 28, 2018 at 4:32 AM, Martin =C3=85gren <martin.agren@gmail.com>=
 wrote:
> From: Elijah Newren <newren@gmail.com>
>
> Hi Elijah,
>
> [Since this is leaving the topic of rename-detection in favour of
> leak-plugging, I'm shortening the cc-list a bit.]
>
>> So, instead, I'd like to see something like the below
>> (built on top of my series):
>
> Thanks a lot. I now have the below patch in my tree as a preparatory
> part of a three-patch series on top of your series. Since the gist of
> this patch is entirely your creation, is it ok if I place your Author:
> and Signed-off-by: on it? Credit where credit is due.

Sure, I'm fine with either that or an Original-patch-by attribution.

Anyway, thanks for fleshing it out with the commit message and
handling the early return cases.  And for tackling the
setup_unpack_trees_porcelain() memory leak.
