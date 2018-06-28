Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC4011F597
	for <e@80x24.org>; Thu, 28 Jun 2018 08:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934808AbeF1IO0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 04:14:26 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:37919 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934404AbeF1IOY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 04:14:24 -0400
Received: by mail-it0-f66.google.com with SMTP id v83-v6so11247789itc.3
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 01:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qqu8RJAwofyMBw77v97J8NIPjLaf5C1BEBq5juI/V64=;
        b=sEULlqnBYmNyzq+QSLsolQEEolcCXfu9T2R+haLEDxzHgmHUGCJhMCOWPGAX07fVEH
         eV/Kf+aDt0ODLTLy5yvQDF7MR4dC3pR87bYlLZb/uwOIw1mjpJziOBE/uiQfdQXPwfGH
         i7dGJGo7ZsXxMKGqcCAE+7OtbgoyehxSuK1s61rXpceHx/xqwASF6+ktyY3mALFENXYk
         rPQjV4c07J0w0QTNWtOHjuaGlC+2G/uxvSefEMWVVfohTBp0EChO3MwhirvyovcOU0Sm
         zn6pNSO6s6CFXmPAy0rp8J4bz1/y/0P1kxNVHtiX+GXf55JK80OglMBJb5x9V5Xy8/E4
         CgHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qqu8RJAwofyMBw77v97J8NIPjLaf5C1BEBq5juI/V64=;
        b=Wr7guOvv7nS+cIrfa12vVJ9/L0NRJwCE0ilW73ROhCZo+Iv+a+qJEowslWWZul05ta
         IBaoRQ4nDQJDzA1mZ7IHsnFs+j1i3FvEDUHQwvc9We3AegwzErsTEKoE0SqmjZB2dvnc
         goBA1NPBABodkRJlUGRzaMfxZE31ZYCmn2jUtrpIU0TtmDxhRc+gGxGWzs/h8d/N7g+f
         NCW+Ee71CSXUcPcw2kolaWD0JsDoHQ4+SDcY7lw/gwvEXBdnU54xazbB8VbXTTuWWTnZ
         +RpazPicM8PPx3o7reyqpHGQYxp1wQ7Xxow/9Jon0AugOluIbiXL6YecAcjiGsIECece
         73Cg==
X-Gm-Message-State: APt69E1PGjNfFS/q33tfiC8xMVK3zW4op2BmwPBjRPqIyUjScnT/VPD/
        tSykR7lMnbRiMDt9X0qRsCfEgRO6QDxkwwAFE9A=
X-Google-Smtp-Source: ADUXVKIEV3LHZAyjCgh68ThSB7Xqhe3C9z7KyaK4YHoNte8G1rYD0WRwMOMIHQMGTY5GvKEsYOw7VPAvxfxIW8dDv10=
X-Received: by 2002:a24:2908:: with SMTP id p8-v6mr7215308itp.96.1530173663296;
 Thu, 28 Jun 2018 01:14:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:2293:0:0:0:0:0 with HTTP; Thu, 28 Jun 2018 01:14:22
 -0700 (PDT)
In-Reply-To: <20180628074655.5756-5-predatoramigo@gmail.com>
References: <20180628074655.5756-1-predatoramigo@gmail.com> <20180628074655.5756-5-predatoramigo@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 28 Jun 2018 10:14:22 +0200
Message-ID: <CAP8UFD06HO_j5-4wt=efB1Wr-52OcnZyn=bXAVra=ZpdxKXusA@mail.gmail.com>
Subject: Re: [PATCH 4/5] sequencer: refactor the code to detach HEAD to checkout.c
To:     Pratik Karki <predatoramigo@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Alban Gruin <alban.gruin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 28, 2018 at 9:46 AM, Pratik Karki <predatoramigo@gmail.com> wrote:
> The motivation behind this commit is to extract the core part of
> do_reset() from sequencer.c and move it to a new detach_head_to()
> function in checkout.c.

If this is independent from your other patches and if this can be used
by Alban's work, then it might be a good idea to send this patch
separately (and then to state in this patch series that it depends on
the separate patch) or at least to move this patch to the beginning of
the patch series.
