Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11179C433E2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 20:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9DD4206BE
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 20:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=diamand.org header.i=@diamand.org header.b="Kdu5LMhi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgIPUt4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 16:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbgIPQ4e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 12:56:34 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0F0C0A889F
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 06:00:11 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id z4so6844725wrr.4
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 06:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sqzfs7/9ckqpeGxEnjLM1NpUwlRRxi0Q8OFmU9cpZlE=;
        b=Kdu5LMhifc8PSFNfwx9PzJzhx9KCW60/wsAuXTH2W+a5lCneIcgadQ6XcKiQtIkiHl
         uf9dT4g/N7IwRv53lIN294vyq5t97Yc+3hByWQg2io7JuQaevBVouxtc86N+8d8HmJm4
         nbut405KLXTkWkmjskoExQAejvJ0uxsU8146w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sqzfs7/9ckqpeGxEnjLM1NpUwlRRxi0Q8OFmU9cpZlE=;
        b=eqAFKqw4E8ZtscyqI2BSDBazMtT0z/5RncE1iLnEwW7J4smPiT49uPl6nLDlo5Wq4M
         CwBK1v/wP/F2yNW+9BFgdie72OdnhB4ZC5q5uuYeZB+9u5yppRXViaKzp8j3/c6LdmB+
         nDIc7H1aJgM1VfGfz6cDicDEOvvtd7p2A9C+wHvDUdY3gK4I/R5sMqJxP012eY4W7lh3
         gjxWMIaWZYSwxGHJLdNdBjAIKZRGrC5HGPY3ufAhQ+fmAIzioFjes5Xp13opQpA3Arnx
         FbmMT2zHkU2EzPOZzAEGrqI7XekcUBzc+obixl2eJV1Bi8bgACQ3J0Fx+kcUk9hUMzH0
         U/hg==
X-Gm-Message-State: AOAM533QsiLIR6QEZpXuljRkyPTEa5kAwenFRmwJ8jsY2i609BO1wUre
        pTRcfYAisSgBTccP9fh7vvHcEAEDJZNdS2Mp7a1erQ==
X-Google-Smtp-Source: ABdhPJwnZc+ie1E2HSVu6SJMK8w9+u3iYLhDSvJxEEUQRV7Ld7uabMqa0X0MG6hQ1LhEMrJzaeTVemMbYAIRU2gyA+k=
X-Received: by 2002:adf:dfc3:: with SMTP id q3mr25622844wrn.238.1600261210497;
 Wed, 16 Sep 2020 06:00:10 -0700 (PDT)
MIME-Version: 1.0
References: <DM6PR12MB3194C9B3A462968FA5A05B4CFA200@DM6PR12MB3194.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3194C9B3A462968FA5A05B4CFA200@DM6PR12MB3194.namprd12.prod.outlook.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Wed, 16 Sep 2020 13:59:59 +0100
Message-ID: <CAE5ih79z8z+rmg-ncT6=RLaySr8GjxS5B33+yDh6bNC4TkUQDA@mail.gmail.com>
Subject: Re: Bug Report: git-p4 unshelve failed
To:     "Liu, Xuhui (Jackson)" <Xuhui.Liu@amd.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 15 Sep 2020 at 02:09, Liu, Xuhui (Jackson) <Xuhui.Liu@amd.com> wrote:
>
> Hi Git,
>             When I use "git p4 unshelve 4495953", it failed.
>         I have fixed this issue locally. You can check the attached for details.
>
> What have I done to fix this:
>             It's because the line#4240 in function "findLastP4Revision" of git-p4.py:
>                         log = extractLogMessageFromGitCommit("{0}^{1}".format(starting_point, parent))
> I think it should be:
>             log = extractLogMessageFromGitCommit("{0}~{1}".format(starting_point, parent))
>
> Best Regards,
> Jackson(Xuhui) Liu

This is indeed a bug. I will see if I can put together a patch.

Thanks
Luke
