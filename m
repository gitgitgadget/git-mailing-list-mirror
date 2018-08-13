Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D90001F404
	for <e@80x24.org>; Mon, 13 Aug 2018 18:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbeHMVeE (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 17:34:04 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54784 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729984AbeHMVeD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 17:34:03 -0400
Received: by mail-wm0-f66.google.com with SMTP id c14-v6so9882359wmb.4
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 11:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=dww6ugu4IPQjecwoFY5RBPir7o7NfPswc5ACg4sN6oU=;
        b=nin/t1J7u2Cg7JsZUC5tPcfUrgurgK1+OJAWOGLh7Au7gYDn1WHlbrgs8o6Nx3cWhI
         g2wddh243g+kYK4F4+6SiF4WaMrRKLs37dNAlQWR1EnBeIbL7gdbXneByqw4BiDy0OQM
         5ef/kMs3UaMQFULlmOgtxZ0k8jTlONtF0co/3qrv/O2RHhV3ZJi1pTkC0apoYjFp8Mxl
         CVCJeQD+LWLh4q6MUNq23LNhXNGaD7J9/UJJfpqyCJtdlyLt6EH9/nr2L4vitZlLBRQx
         qTveN2SmVR/0MQUy6wsQnHA+0Rn46NOLePjXmCHAqgos1dgVAYcRplctMn3OP0dkuktJ
         WUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=dww6ugu4IPQjecwoFY5RBPir7o7NfPswc5ACg4sN6oU=;
        b=LXsC7DCchh5C0jPPY98SywSu5juQRT3lmTnwprf/MuStAZ2vcnd61wWfFjx2mBFJbc
         FwDtYX+hluB+8MmrWWNAdz+jbNyacvr5OxOgnr2C3NXkfNcndJW+0yRHv0m2DGmBK4z7
         5+NdOPinz38OrqvXE12lj2BNE2ff9jgyD7OOFvj8yZMa9ECWcbytxAC6Teh8hcX8wmBH
         02pE2fRO5UT3Q+hpyTy9Qf4xI0DvA2FSUiKJ7jIkhcUP5djNWWxZvtvUWuq8Fic5dMsC
         l7chjJp3Umd+2AImffLyEeI/a3ZphYW7CHCAhVSfkXi6OzFISF135gd/knYRcgd3ytne
         sIJA==
X-Gm-Message-State: AOUpUlGt6ezCyIBUyxOkRhWju7WrTq2JRaFj2dA1zyb0sgryxF+NA8Mm
        w2INtLximQQHuyNqBYjXKXE=
X-Google-Smtp-Source: AA+uWPzQBRO2eTB979iGdVjaM+ZpjSYBIokRmmQgxFNi+Sf6zeD8oeCITIYmnd3n9xEKlZVSxJVyIg==
X-Received: by 2002:a1c:a703:: with SMTP id q3-v6mr9049151wme.28.1534186235337;
        Mon, 13 Aug 2018 11:50:35 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 9-v6sm47660077wrb.48.2018.08.13.11.50.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 11:50:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Adam <thomas@xteddy.org>
Cc:     pclouds@gmail.com, Ben.Peart@microsoft.com,
        Git Users <git@vger.kernel.org>, peartben@gmail.com,
        peff@peff.net, newren@gmail.com
Subject: Re: [PATCH v4 2/5] unpack-trees: add performance tracing
References: <20180804053723.4695-1-pclouds@gmail.com>
        <20180812081551.27927-1-pclouds@gmail.com>
        <20180812081551.27927-3-pclouds@gmail.com>
        <CAOhcEPZphaKASyMAmZ5erdn-fygdVrvtPScTL_zZmAAgCYYKqQ@mail.gmail.com>
Date:   Mon, 13 Aug 2018 11:50:34 -0700
In-Reply-To: <CAOhcEPZphaKASyMAmZ5erdn-fygdVrvtPScTL_zZmAAgCYYKqQ@mail.gmail.com>
        (Thomas Adam's message of "Sun, 12 Aug 2018 11:05:37 +0100")
Message-ID: <xmqqin4e5ced.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Adam <thomas@xteddy.org> writes:

> On Sun, 12 Aug 2018 at 09:19, Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
>
> Hi,
>
>> +       trace_performance_leave("cache_tree_update");
>
> I would suggest trace_performance_leave() calls use __func__ instead.
> That way, there's no ambiguity if the function name ever changes.

Please don't, unless you are certain that everybody has __func__ in
the first place.
