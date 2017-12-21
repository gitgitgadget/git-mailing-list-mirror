Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E19E51F424
	for <e@80x24.org>; Thu, 21 Dec 2017 19:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754695AbdLUTgk (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Dec 2017 14:36:40 -0500
Received: from mail-ua0-f196.google.com ([209.85.217.196]:46734 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752732AbdLUTgj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Dec 2017 14:36:39 -0500
Received: by mail-ua0-f196.google.com with SMTP id n9so9714799ual.13
        for <git@vger.kernel.org>; Thu, 21 Dec 2017 11:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HJ8aR+SGbClXh5kUUeQj2GZFzslD6FXQ3eST2fVCccA=;
        b=sRgiJeVruKJ14gpTZwu/h57lvuYJJpXkIrTwzeJ3bUQoPfmyBL8AdBqfHlSOe8nsb4
         JZUKV1z6OzgcZwAXpXX0xrkcd5/JlY5/c92dTpDIKixTXQ0wQju8NkxRFlzWQb4+a0Ew
         wmg9BXsCavjOsJdjgpS1ogaE4vDTG5J9X3PUweoyfPNwci15lT8ZwhTBr59lGIk2p1br
         e+mGCpC2yPPpeTiZOE1RboeqiLjoWeNZgOToBP5ESHhhisekFvM3+gCzHkDNOsOh6pli
         k/2zF7GD8UQRhuAI22WsuDgnX7uG76S6mAzJgcLzKC0bmlo6fkK/MpJUj7y+P54WnxQx
         gKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HJ8aR+SGbClXh5kUUeQj2GZFzslD6FXQ3eST2fVCccA=;
        b=GOwDaFJ+TmIQAc6tLx8TexeycqDv5Hw7giF0G3Ts7vzbU01gk6esBDD2ya/yVV00Z2
         fqgSE5Xu/xHTRWO0KH1xLikgJp+tObUzn+BCFAzrSfal+nnPq1QbxOUgk+16Krc23xwM
         41GoBogB34ZNqIG562yRLxctF3/2U/xyDFljr1OI79zB0s87MMiGokd2zE0VRM8WIp96
         +Ia3PPS5oKwSEoFvCI2XrES/XHNbJQbJudNpjD6GxRuMNcSwDmoNjInCWyS83y3zIe1v
         8AwzsrLpPm3Tp0bc1ckPy0XNxNjrnyflepLBStpTeNmsUO/5s2BaoW947LaDW7RjiUVb
         ePzQ==
X-Gm-Message-State: AKGB3mIHtVh5Z/1amxDTC/X+17M0zz4EL6xEp9KsgIGpJM/TsLCrOBJy
        dIMbnD4k8T3jLEt9Pdpgb4iXDNrzPRfLaKkncfU=
X-Google-Smtp-Source: ACJfBouFuufb4CmYuG+Ef20jM6G4FCvcrlcg1Z29iZQqGnouom9y3RfbrGN6dsr8MMxhVQ9Let6/Lgxbo6Xf94kVTlk=
X-Received: by 10.176.65.135 with SMTP id 7mr1802185uap.127.1513884998722;
 Thu, 21 Dec 2017 11:36:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.82.5 with HTTP; Thu, 21 Dec 2017 11:36:38 -0800 (PST)
In-Reply-To: <20171221191907.4251-2-newren@gmail.com>
References: <CABPp-BGy3_RyVQfCm+9O_AAfKA0_CZ5ajJE7NuLbToERWyWmqQ@mail.gmail.com>
 <20171221191907.4251-1-newren@gmail.com> <20171221191907.4251-2-newren@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 21 Dec 2017 11:36:38 -0800
Message-ID: <CABPp-BGwZq2m4fexVKThGHwSFM3i3xxy2x9cZhtQvSHZ07unYg@mail.gmail.com>
Subject: Re: [PATCH 2/3] move index_has_changes() from builtin/am.c to merge.c
 for reuse
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Andreas Krey <a.krey@gmx.de>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 21, 2017 at 11:19 AM, Elijah Newren <newren@gmail.com> wrote:
> index_has_changes() is a function we want to reuse outside of just am,
> making it also available for merge-recursive and merge-ort.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---

Note: These patches built on master, and merge cleanly with next and
pu.  However, this patch has a minor conflict with maint.  If you'd
prefer a version that applies on top of maint, let me know and I'll
resubmit.
