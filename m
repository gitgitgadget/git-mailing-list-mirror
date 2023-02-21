Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0746C636D7
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 20:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjBUUQr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 15:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjBUUQq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 15:16:46 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E668A303CD
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 12:16:44 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id s20so6986015lfb.11
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 12:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=10i+epYl27jmDHsMdqybGekkYQQA7MJZVfgAwwM/uBo=;
        b=gJ+9a9mvUVFXC/ivFkOCUBPhTivzllt5mu4pC3PqAY09GwhCiuEF/RlWKaWBgodklO
         21aUaiYGyvEt0Ei/7ShWJ7Pf9e9+5iEn360GovlosH4KzWXKYylDI2MsC+D/2jLlnCU4
         qX+EB32nMUl4HGxqkRxRuCakU7zNAjtdg25mD15vtNDla9oVcZ8aWDo5JSc4ja+Tlq6d
         kX29sde5VIcTad9D12uxK/TXH4sjt+VZxRcijXLdnu+ZJ6MrDmPldczNdoiSkzppcs/4
         huff2bUSezsu076jgM74Z41H8Qshho/pCxl8HB/1cYC1egPWAKIDAUYwOpC5Wsn8/r4C
         E/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=10i+epYl27jmDHsMdqybGekkYQQA7MJZVfgAwwM/uBo=;
        b=p0taXA42jWguxynB4XtRBtQx8GbCnPJKKpUHLFnD20DCjEWhgvAb9QDJQR+b/A6xQB
         8Qo6mBXoWbEiIAYXkLgyhYW8eCMlX1gIpp/2oBHZWrv9mjW8NfnB+mTXqfwbnzX8mvS4
         cRwsDmu8ylXwJQnYPo7MkbjFy24LvzeRWoYYXAvTZz9vdaOTwWpn5Gwb6qPIQC0sZwb2
         eOy/oSCN812ScFtKDam1sseK9tFHHlk5H4h6A2UFlzRLwDQJwAzdHhDnTYh9EZ1zBdQu
         Dio28SBnrKQoiShYsVtpHvm3r1zJW35A4eX2e0aFhJNrVWdHwJId0cD6nlTooeE1IjKR
         U/aQ==
X-Gm-Message-State: AO0yUKUNW67LJbFsoQ2HsLKQ1HEJ410QMKDxr/DsDH56/Bp5b0rIpNId
        6La7PFR57z6OsFuvFNPr0eOpfDz4uGT0bKwjkCs=
X-Google-Smtp-Source: AK7set/T0sOXzcYSHd0uijJqiqWx2cxtTxgjllYCiNBbRqoUiHmTE/QFsxBONRJUxjm8l538oHTUWwjm+rVs0iMTXqY=
X-Received: by 2002:a19:a40c:0:b0:4db:257b:f605 with SMTP id
 q12-20020a19a40c000000b004db257bf605mr2006476lfc.2.1677010602911; Tue, 21 Feb
 2023 12:16:42 -0800 (PST)
MIME-Version: 1.0
References: <pull.1452.v3.git.git.1676665285.gitgitgadget@gmail.com>
 <pull.1452.v4.git.git.1676927082.gitgitgadget@gmail.com> <xmqq5ybuhqhc.fsf@gitster.g>
 <CABPp-BEAB6jKXeo=DHiimQUDj=5i7U5MQPXTEsAagLVAuk7FOQ@mail.gmail.com>
 <xmqq1qmig8c4.fsf@gitster.g> <3F1016EE-07BD-4F7C-9C75-6995A1EB211F@gmail.com>
In-Reply-To: <3F1016EE-07BD-4F7C-9C75-6995A1EB211F@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 21 Feb 2023 12:16:30 -0800
Message-ID: <CABPp-BHp3wxJYkWV9i7Qwp4idseRehgf_hXRHdAkuoozi5Zh0A@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Teach diff to honor diff algorithms set through
 git attributes
To:     John Cai <johncai86@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 21, 2023 at 11:36 AM John Cai <johncai86@gmail.com> wrote:
>
> On 21 Feb 2023, at 13:51, Junio C Hamano wrote:
>
> > Elijah Newren <newren@gmail.com> writes:
> >
> >> I'll leave that up to you and John, but are we risking merging code
> >> that could go unused or that we need to fundamentally change?  I don't
> >> see how to handle the issues over at
> >> https://lore.kernel.org/git/647D3D49-B85B-4B66-A857-695CFF9685EE@gmail.com/
> >
> > If this is useful enough for desktop users already, then that is a
> > good enough reason to take it, I would say.
> >
> > GitLab can easily add WebUI that says "You can define what diff
> > algorithm is used for files with which suffix" to allow you to
> > configure a table like this:
> >
> >       json | histogram
> >       c    | patience
> >       *    | myers
> >
> > and populate the server-side equivalent of .git/info/attributes and
> > .git/config based on that, and without anything further than the
> > posted patches, the result should just work, no?
>
> Yes, that is my thinking too. The goal was to make this user friendly for
> everyone on the Git command line, and then GitLab can hook into this accordingly
> to make it ussable with the GitLab UI.

Ok, sounds good.  Merge away.  :-)
