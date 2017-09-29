Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D127F20A10
	for <e@80x24.org>; Fri, 29 Sep 2017 05:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751667AbdI2Fkv (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 01:40:51 -0400
Received: from mail-ua0-f181.google.com ([209.85.217.181]:53960 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750996AbdI2Fku (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 01:40:50 -0400
Received: by mail-ua0-f181.google.com with SMTP id t36so139540uah.10
        for <git@vger.kernel.org>; Thu, 28 Sep 2017 22:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nanocritical.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HlJ/Ac84KtWspEfOPlohFy/y5sVA7nFGfCPtH8Q5BAs=;
        b=dSBaA3rpDXeHEUCDkCimZcnEpOUed9XKhrUfv5b2lfComMIxz0JRXufWo4uc9nEhkt
         3vJj9qkkz0fanSEOPeeN1e714EGO4/uHY2KCZthrBq3iTpdwpRehXTnO2rfdNVbZEmD+
         ciQ0x4xHy8foyLmhz+G1hzty/nKyrazTqgi2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HlJ/Ac84KtWspEfOPlohFy/y5sVA7nFGfCPtH8Q5BAs=;
        b=P5mmgsIyaWrum0VQEsgx1QJMsP8ziAKGVQ6VLPd7pvilCWJPIRbqPE1xDDA2Z8w/RS
         yYndUZIfey4vRuGlkEVHBbwRlMqvzDColJaj2a9mi6kpr0QScPm6UBGiU1m2frVHY5Oy
         X2HoX8RrTqjZzFrkL2Emaaz5tWpchCTTiIrUkQ/1Gjp/Xs4vPQHyHPZ5uLvw2fPXEqt4
         O/76Q81ee3+TrBboiSvNbqK4UlWjqnghyXaq3CSYzn/2F30JkrRfcAr+yE5RJlUEklQz
         v3yLVARGz4KBlsnQn2jGTe3Rszu/2DncpyM+7DtL5wSoi5KXbiEqrEN5DxwRgR9e4/tA
         b64w==
X-Gm-Message-State: AHPjjUgnq7uu9VSvOBxMktTn3BtmycR7G4tysXV8YRtgywIevO7obqIl
        fZ2LTqFQiJR6WMAZu1nt9Bdy1MoHf3xOeyYTpmfHdw==
X-Google-Smtp-Source: AOwi7QA/xHUGf9vXfHFCS20wxJYSwvHkWuz0l08Bl3WgOwEGy9UHSWTZfg1AgfyZdmlHjVDarUJzmn3HYhOA90fyMm8=
X-Received: by 10.159.32.36 with SMTP id 33mr4281776uam.41.1506663649871; Thu,
 28 Sep 2017 22:40:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.146.1 with HTTP; Thu, 28 Sep 2017 22:40:29 -0700 (PDT)
In-Reply-To: <xmqqy3oyxiuo.fsf@gitster.mtv.corp.google.com>
References: <xmqq3776z0jg.fsf@gitster.mtv.corp.google.com> <0cb786584bd2669763c303f80072baa3693efc33.1506654123.git.e@nanocritical.com>
 <xmqqy3oyxiuo.fsf@gitster.mtv.corp.google.com>
From:   Eric Rannaud <e@nanocritical.com>
Date:   Thu, 28 Sep 2017 22:40:29 -0700
Message-ID: <CAH_=xobLo+K74HJ3a+XK4A3ok-FZJkAkO-9griaETkH50Qtp-A@mail.gmail.com>
Subject: Re: [PATCH] fast-import: checkpoint: dump branches/tags/marks even if object_count==0
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Adam Dinwoodie <adam@dinwoodie.org>, git@vger.kernel.org,
        Jeremy SERROR <jeremy.serror@gmail.com>,
        "Shawn O . Pearce" <spearce@spearce.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 28, 2017 at 8:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I think that your patch the last round that feeds fd#8 in the
> foreground (i.e. fully trusting that the caller is sensibly giving
> input that produces no output) is already a good place to stop.
>
> Your patch this round that feeds fd#8 in the background, plus the
> attached patch (i.e. not trusting the caller as much and allowing it
> to use commands that outputs something, within reason), would also
> be a good place to stop.
>
> But I am not sure your patch this round alone is a good place to
> stop.  It somehow feels halfway either way.

I agree. If we're coding defensively against the caller, we do have to
include your patch to be effective, you're right. I reckon we likely
don't need to be quite so paranoid, at least until this has more
users.

Thanks.
