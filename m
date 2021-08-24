Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_40,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3C9C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 04:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BFA66120A
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 04:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhHXEwY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 00:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbhHXEwX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 00:52:23 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B009DC061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 21:51:39 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z4so13669282wrr.6
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 21:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=7zPquDCtZyzOA5PY0kmGl8Aq5WV/QI7GoaYVVezsWQc=;
        b=vKZ5JLPekKiPjanW7SWpQXBgDkWlYEgJrCaJC+SHNgnFt0TbX9aZgj3m+fQ4vMTFeH
         qp+ZMwM2FqHqoZMsahYwvLNM59yzXRIKZyADzTKOvCZRasnS9zUQuS0DDMqe0pptjHVL
         J8EJ458QnjBiERofIOwoRC4G7i5RsHK41AqNhIhNqdTEmMlKQUDXWO7DaKgJvgojO1FT
         JHci4wqr7OgU1L4yQSkIAk7dM8kqgCUcZcCpQSMQzr5re4jksvm6AjTh7X/kb0ELrdl3
         tCCXzjR84n7MhUaqg1+PwsCKoYYwOjrzvGRm/XjaXJlFwDkPvt0iO/VlSyxO2gbTtNRN
         09AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=7zPquDCtZyzOA5PY0kmGl8Aq5WV/QI7GoaYVVezsWQc=;
        b=uitlpwRbrvBz2VzASEkfSnUQivhRerSYDuXcvuojgwVetEcnx72ypIrP4wrbtWPrZM
         EJCxTWJhH0k5nAUa6huAuaRRxT+C3PHaiKav/kTRqds8om6SMfb1CF9ekBFagJk2Su2Q
         lWgOuYpV2hbIkhcviyugxS/Yfuk6QjrscwsquXMjsYbvRws6EhVIh1pLv/iU0LbWhyVF
         fV8DS3pmKbtfJ81s0GV1E+b+ID3du2fVHuZQeDRp8+hlOeCncNnb0tW4ElznHUwBJb/M
         kt5T98j0+BAaOmgWUsYzRic7Sk2JySYmuUdHHR8XyAnA/KmvMu58i01c4BryO1MYRaTO
         rqfg==
X-Gm-Message-State: AOAM530EIWjQOLJL2fn/1poC1zjLvuM0ZgOW7qTNIRzNTe5TeklGu5n8
        0dgUhp/V68SNgXACK5iNPZmKesWEPQZRp4vZOEiAYthjTA==
X-Google-Smtp-Source: ABdhPJxjEg5YI34r0383tmLoZ3Ich48cd5K/vr+Q7l1Xq0PPFblQ364FTS80FCjhbt4MbPChrqHw0vdGWBO0DBxh30k=
X-Received: by 2002:a05:6000:184a:: with SMTP id c10mr17473375wri.26.1629780698294;
 Mon, 23 Aug 2021 21:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <CANXojcyX2uqAp5gLtfH8ffQFQBKkMoPqSzpDUnbFe0QBd5nJqg@mail.gmail.com>
In-Reply-To: <CANXojcyX2uqAp5gLtfH8ffQFQBKkMoPqSzpDUnbFe0QBd5nJqg@mail.gmail.com>
From:   Stef Bon <stefbon@gmail.com>
Date:   Tue, 24 Aug 2021 06:51:18 +0200
Message-ID: <CANXojcx=_Zvr3Und=as-Qeous5LRKnBEJ1zqjGYPFP0DyXNLHA@mail.gmail.com>
Subject: Re: Get tree of remote repository using custom ssh library.
To:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ping
