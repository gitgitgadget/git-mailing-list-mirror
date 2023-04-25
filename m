Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12113C77B61
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 15:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbjDYPqM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 11:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234183AbjDYPqK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 11:46:10 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D1F2D54
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 08:46:09 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-63b733fd00bso4817980b3a.0
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 08:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682437568; x=1685029568;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7v4elOKgedY1SqP7W4mj1R63LNo8EYx+/wp2iaRN5J4=;
        b=goE8TXAPJuGbGeYZ099yhuzs5Rm4FUFO0yNw7EbOPLazwhIQ9ltMVQ57tQKhz6BIow
         EgMmXNB75/VDXDjfHzBLsrJFGJ4BXQNGi3JB63KyZlG0z3KObLssMtK21RFwRvPCtEV7
         uf+4vsZrfNARkqRzgKCr5CnP/EBgykwOr2fvm3ZYjrLiV2ZmAF4eY5VQbBYU3slHBGfT
         PKIIQ5mVryrMuCrS9TaeeG4QOXH5iu5d5eFKSWBTc/0GxiX3+5E4aM4xWhWoNHxW/WSn
         0/BeJfiGra+vlOXImvjojbuKh4Tug1ekaRoZvUJMlKxibFVmI0aaqIe89DKlHgGloSQ5
         WyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682437568; x=1685029568;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7v4elOKgedY1SqP7W4mj1R63LNo8EYx+/wp2iaRN5J4=;
        b=Id5EQG0utwZso5A+ssBM4hjBx+RcxcYnjte4APQQr8YEHPfmhP9Ed1215ga/MfHEMY
         1AqJkXHOgwYCWL7esy/7jWi55VQirdEVh4gDzTegRtAeqqCGz4o5GmJjec5fmzWXdGtn
         LRWT5oMIVCkwr4g2jU9DcITqVF7GYe4HR+aVXUGiKmK3N/v//+7T2O6JERsMb2JWl6PP
         dAAALGT5l2Wj1858TkTLfh1EGhM3IWea1zaU0TY5ea/s18N14azU+XpUZEwK1wWVM/Xc
         8YUO6o/147K4IMGbXzmI85QxjbustmZF9ChVyem0nq/LCZb1pT+sX7n4yE2HOjCOmTZJ
         +44g==
X-Gm-Message-State: AAQBX9d+b7sP/Wz4ZUC8sbEAkdhaVV2oiTDluYS2s7/SQt5lSJXUDva2
        FMmPZKkq7arr8RXSaf5UN9Y=
X-Google-Smtp-Source: AKy350ZqrzB+7zogVEMhMNY3OzEIAeetbBXVGdu5um41wQ7q/C78HKpGdCMalHfOb6ZnyAJ9DyAUPg==
X-Received: by 2002:a17:902:ce88:b0:19d:1834:92b9 with SMTP id f8-20020a170902ce8800b0019d183492b9mr21219857plg.56.1682437568319;
        Tue, 25 Apr 2023 08:46:08 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c20600b0019a773419a6sm8485020pll.170.2023.04.25.08.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 08:46:07 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Blyxyas <blyxyas@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: Inconsistent names in `git shortlog`
References: <CAGeanHfxL9e_OHPFzBjLjgVU=QLvwYS9QVCGHC1JHSkApRAwgQ@mail.gmail.com>
        <20230425065242.GE4061254@coredump.intra.peff.net>
Date:   Tue, 25 Apr 2023 08:46:07 -0700
In-Reply-To: <20230425065242.GE4061254@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 25 Apr 2023 02:52:42 -0400")
Message-ID: <xmqq8reg55j4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Apr 25, 2023 at 02:00:27AM +0200, Blyxyas wrote:
>
>> This isn't a big deal on its own, but there are some external tools
>> (like thanks.rust-lang.org) that use the output of `git shortlog` to
>> thank contributors, and it has some cases of people going just by
>> their first name (no surnames), or people appearing multiple times,
>> once with their username and one with their real name.
>
> I agree with everything brian said elsewhere, but I wanted to add one
> thing: for this "multiple times" problem, it can be solved with a
> mailmap file, which associates names such that ones you don't like can
> be rewritten to ones that you do. See "git help mailmap" for details and
> examples.

And another, potentially more effective, tool is to have a project
convention.  Teach the participant of your project to be consistent
in the first place.

