Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD11C433E0
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 19:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1F0A20657
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 19:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=atlassian-com.20150623.gappssmtp.com header.i=@atlassian-com.20150623.gappssmtp.com header.b="gjm2jQk3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbgGPTrB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 15:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729490AbgGPTrA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 15:47:00 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECC9C061755
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 12:47:00 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id p15so6093506ilh.13
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 12:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=21Y1xu8UelctpJ+skrAmbYAZhI06l9ieQgCA2aSKsVA=;
        b=gjm2jQk3e9GQd63l5NIqngeLXTYQ7ZofsO+Acl7KDDVS7Tg3KybOGBdi+qBCN/ZNWX
         MKvAB1WsczibXU2WR+CqlMlF2wc4m6MVwTjmk0HDxDARifl9C1QTwszXSk02pRg98LmW
         HlS1DVP+Fn9kU8Vx6tdhT6P2M2CLWfaXC/gqmCxey8kLJNjpPvmcVz3TdyMYEmC3GJUL
         EtmoUIumGvXmUCpf7h7o1HiTl9bvXWxl+hn4kMZUj4hu1LxZqqfCX43Xy47XV/03KprN
         VjT+MOfMMNbn8Q/qFIXoCh/rgzSxE9KJqN7jqP2LgatLUJJhVyTUJonky5q7ljV0VKh9
         B1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=21Y1xu8UelctpJ+skrAmbYAZhI06l9ieQgCA2aSKsVA=;
        b=Pp0AWORimRGbAU4Ug+g4OA1PO+/5qvMBSUfBHKl3rGVij5NjXFsiqMlXlop2z2Rh4Y
         bXWFlUmqF5/o8iiLzajkw0WWJ5McIuo+Pq/jtKkCb3RSGYjK49ZspDnlPxQvqgmawUDi
         3RMasEJ1j16DIvGH1eU5S7GRK/X0kFiPR15wPaQ0SHMdBFUJGoXPgWi4n21lCU0Asufu
         8gfuvkcvmKI6yJvK29L7Z0jgKAC03MdJIsh7w0voq/AdX7ZyV8FiVJI/Xsm/zdUoLEug
         fA3ee8YzXF4P1a8I0icZ/t1RizpqLRMOY8aZtwG7qEkb+TysBTa1RlIRGgMxGn5dQgXv
         MlMQ==
X-Gm-Message-State: AOAM533Q4PPYJEmIpcApOQy5YRMIrMVznvVMNrflvQea1VGs7K1ZL+4C
        Atun9K0kK7+bjqRTC/rfynsYAJrdQr5KT2kObAiIHA==
X-Google-Smtp-Source: ABdhPJyDD9SSLBxyidOju7pVbRRFmBqcBaZvsyQvNBFbDxl9SUetl6gh8DsrqNt9rcwIWQMvjTWbMhK3Ankqg05dqeo=
X-Received: by 2002:a92:4913:: with SMTP id w19mr5794517ila.185.1594928819458;
 Thu, 16 Jul 2020 12:46:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200710135935.6416-1-johannes.schindelin@gmx.de>
In-Reply-To: <20200710135935.6416-1-johannes.schindelin@gmx.de>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Thu, 16 Jul 2020 12:46:48 -0700
Message-ID: <CAGyf7-EAQ0D_fqaRNa5YdQGoTO535=45g+Hyn9Fo5JAxPMkE6A@mail.gmail.com>
Subject: Re: [git-for-windows] [ANNOUNCE] Git for Windows 2.28.0-rc0
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git-for-windows <git-for-windows@googlegroups.com>,
        Git Users <git@vger.kernel.org>, git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 10, 2020 at 6:59 AM Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
>
> Dear Git users,
>
> I hereby announce that Git for Windows 2.28.0-rc0 is available from:
>
>     https://github.com/git-for-windows/git/releases/tag/v2.28.0-rc0.windows.1

We've added 2.28.0-rc0 to Bitbucket Server's test matrix for both
Linux and Windows, with all tests green. We've also done a manual test
pass on macOS, also without issues.

Thanks again for these early RCs!

Best regards,
Bryan Turner
