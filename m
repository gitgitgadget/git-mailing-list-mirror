Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA58C2035F
	for <e@80x24.org>; Fri, 28 Oct 2016 22:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030559AbcJ1WIr (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 18:08:47 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:35624 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942390AbcJ1WIp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 18:08:45 -0400
Received: by mail-qk0-f173.google.com with SMTP id z190so102845180qkc.2
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 15:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=31/GtQEYROLkEL38kasM/aJu1Uer465EbGQ1MVSwX3I=;
        b=L0rhR+J1iskYc7TzBeFQhfSnxqXKWQGl+4sFllUxik1k01qrtaaehMYRngKPq9DZy4
         lrHeeAqdyL8/qDnuj6ymQEIo3NDngjXaVGt39xPWjBMGhr2Uj42l7DHjhko63JTIuxaw
         Z/mm8KHsCy2ay5b7p6MyaEo/4zYrmqu+GniRAchBc82XiHPsaVW4gpDUo7vBsa82TkAu
         p14dha0VoTnjFZtHRm+I0lW+Mjv3V/1tHEy5OvmX+ZjPyF8eLBabPEoUCb4xDu6YYGO4
         yEY10s+SwtWLexg/uNFItAgUEP43rbFpoTn63mJoF1V401b9u3y+xfF6FEeTdzNFDU2w
         w6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=31/GtQEYROLkEL38kasM/aJu1Uer465EbGQ1MVSwX3I=;
        b=QfnXmzT/RW9Z0pcGBR12uteKrvWQwzRiqwyexGu0IR0nC1V8vAjybBShJsfbF/IZmb
         x+m59rOZmRxNhhzxjM6cQvNAUiAKgMlRfzKrEhwx7duuwiIw3GT8wOn3F/3eUEKrMtzr
         E2pgJvyIw1bSoB51Oo3NDlAB34UTrRWCGPCw16jjVmmBv9r9cQNUny7CXtxeLMNop3+I
         hDIxXsRdBMhDLh9Kuwi+VeLIXOED6qxNN3s2Gy8h8ClVU4HK9jfLqDHs4WJpO90KlRq7
         pRkSJdWyBEC1PR/GSZTbuYLHTe4oilav/6C64Jx3CpCpiFRlAmd6Vf0Lt5j7jSY2xZm0
         WP5w==
X-Gm-Message-State: ABUngvd6JP54CvafbFHmdK1goqWh3rcU+cZvD/IiyFDoY5Xc42C4llUwr88SW1TctcyncP+tfSkYIo6Odk8fub0D
X-Received: by 10.55.20.164 with SMTP id 36mr12256225qku.86.1477692524884;
 Fri, 28 Oct 2016 15:08:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.134.34 with HTTP; Fri, 28 Oct 2016 15:08:44 -0700 (PDT)
In-Reply-To: <xmqqinscxh5g.fsf@gitster.mtv.corp.google.com>
References: <20161028185502.8789-1-sbeller@google.com> <20161028185502.8789-28-sbeller@google.com>
 <xmqqinscxh5g.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 28 Oct 2016 15:08:44 -0700
Message-ID: <CAGZ79kayzZOXpRgwREahKAAj+W6M-c2m6dYf5gL3RCxE5+5zJw@mail.gmail.com>
Subject: Re: [PATCHv2 27/36] attr: convert to new threadsafe API
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Brandon Williams <bmwill@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 28, 2016 at 3:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Probably this needs to be squashed in, now the MinGW discussion has
> settled.

I was about to propose this (and resend it non-rebased).

So I do not resend, but rather ask you to squash this patch?

Thanks,
Stefan
