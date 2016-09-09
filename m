Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20E4E1F859
	for <e@80x24.org>; Fri,  9 Sep 2016 10:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753193AbcIIKc5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 06:32:57 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:36684 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbcIIKcw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 06:32:52 -0400
Received: by mail-oi0-f42.google.com with SMTP id q188so17267551oia.3
        for <git@vger.kernel.org>; Fri, 09 Sep 2016 03:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kNAMeptkS21X1UipKNqSno2MtUEkslVr0VJPk38JguM=;
        b=RTRWAH3Nwkp1WR2lHNJ2eBIRqzlQsrj25tmeH+8h1gxowkBAhTyfg3HNnIaGJeyHY7
         bq9/roRZ1MTAAdTS9/nwbwBYCouUyxm9auSD+ncusrPFqfoU2hBm67Xx2fUUTqUwFQs/
         88YsRIuhRE3S1dxkSU4idHI5GDn6Xi6P8bCP5fGcCCv//P6YQC1osQCTbwFwLnr0YOss
         K24BIvyQrSvgd1hC5R90r5AgE8PHjJElg6vlIE/Zxu/Rq+On4mep1wl8BZrjprngI2uc
         LU7ks8LfoaxxMLrD0E92PXg+RBEDmwnwuZ2XIt8aLTH6oZEM0YJwBOMEx4FyEEi1SBhe
         XPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kNAMeptkS21X1UipKNqSno2MtUEkslVr0VJPk38JguM=;
        b=UMZoDEFHNzYTsjOBrZ8N6D/K9e06mDocPFuF5PZ2hj41YPoga0m9mLYRDF1LR7z8kD
         1xsBfK98Bqb7a0r1+iRG768+hDkLvEa9lBUmKOPfxewgBY/gyLC/f+aKm93fnv7wa3rk
         P64ggCtDbvPmU1Zu4RW/er3DYVIB5DqaVVTNHNBwt4ETD/YdcYPd4UaTb14sZ6BE26QD
         jMad68LVHMWvYUaMO0vATFOQwRd1fGve/2ZUM7yef4qmtP9VgiYDIBY/5kIfB/wHWSsj
         BBjMeU+RmwTffWf2+V3Ux7aKzFU6xeA4W5T9tR5UgS8Sn2QTIVfs3uumNfLx8yJGz+rP
         mcEQ==
X-Gm-Message-State: AE9vXwMJz2OWDrUXqdRqEKz9KyUKK6VqUvr1Dz5DGMHFGUJChIp3z8mWUaVU8GvxP+sQqB6mUfDNvwjsk5I6jw==
X-Received: by 10.202.223.215 with SMTP id w206mr4696858oig.78.1473417171786;
 Fri, 09 Sep 2016 03:32:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.54.40 with HTTP; Fri, 9 Sep 2016 03:32:21 -0700 (PDT)
In-Reply-To: <20160908200202.gmvpqrwwjavxmojb@sigill.intra.peff.net>
References: <CACsJy8CZf0O+uyQaeJ4gcx4XN8ivfFyni+3586WX_R2QM4XgVw@mail.gmail.com>
 <20160908134719.27955-1-pclouds@gmail.com> <20160908134719.27955-3-pclouds@gmail.com>
 <20160908200202.gmvpqrwwjavxmojb@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 9 Sep 2016 17:32:21 +0700
Message-ID: <CACsJy8DmbdGODY+qT38OSkaegSpdO7yAt6e67sHB=_BT8Y7=_Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] t0001: work around the bug that reads config file
 before repo setup
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Max Nordlund <max.nordlund@sqore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 9, 2016 at 3:02 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Sep 08, 2016 at 08:47:18PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
>
>> git-init somehow reads '.git/config' at current directory and sets
>> log_all_ref_updates based on this file. Because log_all_ref_updates is
>> not unspecified (-1) any more. It will not be written to the new repo's
>> config file (see create_default_files() function).
>>
>> This will affect our tests in the next patch as we will compare the
>> config file and expect that core.logallrefupdates is already set to true
>> by "git init main-worktree".
>
> This is a bug for more than worktrees, and is something I'm working on
> fixing

Great! test_expect_failure it is. But I'll make a separate patch,
independent from this series though.
--=20
Duy
