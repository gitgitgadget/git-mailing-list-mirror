Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 054131F453
	for <e@80x24.org>; Wed,  3 Oct 2018 16:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbeJCXNb (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 19:13:31 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39188 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbeJCXNa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 19:13:30 -0400
Received: by mail-pg1-f194.google.com with SMTP id r9-v6so1801630pgv.6
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 09:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p/3u7GzC5Nrg7Ja9dek6cEeaywRp3BL88sJMNMj4W98=;
        b=UfClN3LTJOjpfMyFxiEfrYuXz1v4iOQShVCNWWrva+DIh+Et3AVt2Fu3W91ggF6/Mg
         zCItP1nm5XtvftGXrYoMsciCxSBs0WovUv3evU3EiIPH6uJ3Gal7JZHXKhg++7WZEv7l
         ViCNWYu7+bz1f6tCZPKt2urletkzBpTPCjBN6dm9utUQ1hVEBnZggWbnL7cESORo5qqs
         jpj9G+VeU5WFHYFyQr7OJY+S0Urv61jrJdcLUDcVBMwYhaNScOgYhkiRfZbPi5rZUhWC
         Lb6JUdWJRGfhiQ1oEsf9xkeJa/mfZvkhWcq0v9G8BYBW+TA32e7sjS16Fhr+KmGGHhIJ
         As/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p/3u7GzC5Nrg7Ja9dek6cEeaywRp3BL88sJMNMj4W98=;
        b=un+Li5yA2DQp0e75+qrfeHOXqpUPMACZI9T6YM6s5RpUgzslYDPVSWeBaOVe8XLLfO
         9hdfJ0NUmeudv9RJHYVItfkyW+vnrI0x7oOTav7IGq8/RE2yS/PhdFCt7FbTK7zTEJ0j
         Z8OE114IDuWZDZMr/iBpQz68UUGs65du0qjiUvximSF8/LdlvpBSEVvzMiZIYKLKp4lf
         2LY2R2QaSc0lvNFxA7q1ktTw5i3IggMCzmebMxaRjg6h2PJezCecK2c0JMaYiM4/BLf5
         YIXeFFVKsg6BlYbLyIz2AX4ZAmcIrf9vcF/F0pXG/SgqbSBviADWNHWQp/FCLEFIpnQv
         fWuw==
X-Gm-Message-State: ABuFfog9oYo4lGulz3892ntq8GNq3DgJhTu1DPFw3cJ7Uzoa8BpgITic
        KDGgvLy6isx1N7PoKpZneErephmSr7CsHCAKPRXjvQ==
X-Google-Smtp-Source: ACcGV61h8h7FmRUMfiFUz+B7BD+wQt0tttasaBe5Ys8fbzvtOfxt1exkU7lqQhxUZ+d7vCwBG2/pNk4l4U/gO1FOxaA=
X-Received: by 2002:a63:6507:: with SMTP id z7-v6mr2019191pgb.200.1538583864949;
 Wed, 03 Oct 2018 09:24:24 -0700 (PDT)
MIME-Version: 1.0
References: <1686b309-e0af-5518-0fa5-4635b2f481b9@gmail.com>
 <cover.1538579441.git.martin.agren@gmail.com> <07aa3628-f651-3a8f-21b4-b66099de864c@gmail.com>
In-Reply-To: <07aa3628-f651-3a8f-21b4-b66099de864c@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 3 Oct 2018 18:24:12 +0200
Message-ID: <CAN0heSoBGAbUDq0PwWpwhcSQ3_h4zMJHoKcBePDu4Y_vXns8Mg@mail.gmail.com>
Subject: Re: [PATCH 0/2] commit-graph: more leak fixes
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        gitgitgadget@gmail.com, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 3 Oct 2018 at 18:19, Derrick Stolee <stolee@gmail.com> wrote:
> I'm fine with squashing it in with both our sign-offs. It is the same
> idea, it just requires a different set of arguments to hit it. I'll
> adjust the commit message as necessary.

> I'll add your PATCH 2/2 to my v2. Thanks!

Cool, thanks a lot.

Martin
