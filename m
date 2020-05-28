Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658EDC433E0
	for <git@archiver.kernel.org>; Thu, 28 May 2020 08:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39A332088E
	for <git@archiver.kernel.org>; Thu, 28 May 2020 08:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WehfuKVR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgE1Ix2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 04:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbgE1Ix1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 04:53:27 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EDEC05BD1E
        for <git@vger.kernel.org>; Thu, 28 May 2020 01:53:27 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id r10so2930211vsa.12
        for <git@vger.kernel.org>; Thu, 28 May 2020 01:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XtXsIA2C/pjrV8CGoJU83Ii5yelU14EzH7YgVc+dh00=;
        b=WehfuKVRnqARjLMvRZjU82plXVFMMQGUIhajgMZfw3QwbwezyPCfShSN5PP5ise15c
         r6gALIxGpTCLLMd/YXkTgjTExBlrSfdM/qN0RihyKmeR4M9UFKOqy3Dx6Kp9Y76bREQu
         rEc3bxAkTP4tK6FDh295wDtOqkhq7NGlZoO8Dh2k1/iWKe12p29EXIA36S28JsJR+4Pm
         G9pWpw5VoUMl2K2FIHAamslvpMrnpeh7iaHM5yIh4br0fE36A+uE+w4C9wan2K/d/FOo
         VRcwoY3hZRm7q2bl2o/j+Qq62Z34wxJW+bJx/1jgBYtpfz4REMI6VuBLiJ5PiFWIL7ke
         +OnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XtXsIA2C/pjrV8CGoJU83Ii5yelU14EzH7YgVc+dh00=;
        b=gPtrTnjOUuIRY/+bLyBYTXziLoy+zckWIypQDkc/8IS77T7IsY6PLE7cfk16wQnfhp
         hxp5K8c2PxRB807xYIBeBgZCDqGpSzZV9jt5OF6b49tEt5aSXVozHba30ueoGrg4nF4S
         UQQhvW0ZmhkAaXbFLVtNGZlsq/xD4bQCUr1SIiw9oFdL6HFAB1y2C/LFeHwRDHsMz5Pd
         TEYIpswCWaqiycNt9/nYa3M36+zV8PaZm8vw4gWf9jN5L5g+1C5UDrh6IzOkFXkJjzCA
         f12nGl5/suXwiz+LEbHBM48lg5PeXP3Gpzy8fMsU3gzOb16+oWA/DQU6fFp+SmkKrO9o
         hZ1A==
X-Gm-Message-State: AOAM531FouHxz6hYilN79iR/YbwRmn3QBNFa+8b37YlOaUS8+vhebRm9
        n6hXOOmHeWtHZWjM+lLjgj/Tn/6/7ZoC9+XzChGS2Mby
X-Google-Smtp-Source: ABdhPJzENN50xkWykVUwjUgmP0dRdYPJcEjxXDoFiwL0vQ8Tq3yCjc+Yj5Qr6T+mlBSWfHzlpDVpGh/ub93PmIjsPRU=
X-Received: by 2002:a67:c299:: with SMTP id k25mr1228354vsj.153.1590656006841;
 Thu, 28 May 2020 01:53:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200527113831.3294409-1-jacob.e.keller@intel.com>
 <20200527113831.3294409-3-jacob.e.keller@intel.com> <xmqqimghl0ft.fsf@gitster.c.googlers.com>
 <CA+P7+xoTJzsV=NbWeWs+fbdgETXwqUs0T9MToBbrGJ0EA-bFcA@mail.gmail.com>
In-Reply-To: <CA+P7+xoTJzsV=NbWeWs+fbdgETXwqUs0T9MToBbrGJ0EA-bFcA@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 28 May 2020 01:53:17 -0700
Message-ID: <CA+P7+xrxt5oybijmRWFd-fMYxKSB8cnuX188g9x9UkRcmwigVw@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] completion: improve handling of DWIM mode for switch/checkout
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 27, 2020 at 12:41 PM Jacob Keller <jacob.keller@gmail.com> wrote:
> >
> > and without getting any answer to them.  Perhaps the proposed log
> > message for [1/9] can be made a bit more robust to cover it?
> >
>
> Sure, I'll look at what I can do to make this more logical.
>
> > Thanks.
> >

I'll have a v3 which splits most of the tests into their own patch
with a better description of the reasoning of the problem with output
and the new expected behavior. The commit descriptions for the
improvements will then focus primarily on the reasons for the
particular method of implementing that output. It's a few more
patches, but hopefully it will read more logically, and we can help
settle some of the open questions:

particular to interest me is: what sort of words should we complete
when completing a new branch name for --orphan, -c/-C and -b/-B? I
think all of these ought to remain as consistent as possible, but I'm
not sure what other folks think.

Thanks,
Jake
