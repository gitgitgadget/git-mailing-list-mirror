Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78E7F20A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 02:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbeLNCLg (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 21:11:36 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36561 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727901AbeLNCLg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 21:11:36 -0500
Received: by mail-wm1-f68.google.com with SMTP id a18so4328434wmj.1
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 18:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6+8T/izfHa2cjQ+NWmPXNsGZQvY+ie+MhOfCrvwDfzw=;
        b=aeR7HKvVEC/EC84nBsJTQF573tjxMlzXWms6q9DpbRNmyD0s8A82lG02FCZVxrHLKK
         vBp3rdmYCOBgGjU69VNAnf/qMQj8I2cambas/4lOP/tR297FhguVse1Jq+KCGyPqTUSB
         oWGxJwt7f3lXmf215Dfc2dcjaa/iYOPDsGn+BQhnag2XuRl/xfRnUGUZQdcEZrF8zuf3
         gjGxcKaR/8v0lh4juYc9ciAukTOm2Zfw6P6ajXwei2QDhmGS2j16Qd08QNiLUfdZUtkE
         ePXJ9r0lFq4jTCwTbAyeTSaMOHUMGJWVrSJRkx1VyXunYJ6woUDnKropUtl2O9pW5tG4
         kR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6+8T/izfHa2cjQ+NWmPXNsGZQvY+ie+MhOfCrvwDfzw=;
        b=iLMWYjhX5DNZA2D6DQCbZjr7rSsf/wXGQ4ewwS88DLmDsM9RWyK0PJp/VH3apq5dlW
         zjbOckNzxLU9JeCoKz3MhIqYT3zMgqIaobaOdx5b+8xWa0/jHZ9vQMk7R4JSoxJ02yzY
         XfG7x1cj7KS5V06fZjZoM6rB4FIPcMLIH8RzfiFA0mOU1kTgxFP9BzzbFawodmbSBfxf
         i3sMThG9gEvcUgaVi5uefj4/lNG924hYIczwM6l5nYnz4rcMJHQzGyI5431xluQM65sY
         vJZYTrsuK2DhwCIfMNWdKUFJFw/tiCoJE5ZsnGSIogoly39v6gBvrecG8u2i6lUsoKyt
         eEtg==
X-Gm-Message-State: AA+aEWaguPXUlwd1RaNXP3FlkSENHQgVI13IQeNozM7Kgl/H6K1Zp0c/
        DH4iHuS3MDIwg2TN/rDZQ6I=
X-Google-Smtp-Source: AFSGD/Wo9Wj1Cc7v/n/0sJyzX7Bfd+VZRT59LbxesFm2SOmpWUZhHDVtVuKMjGNB3uwEZEhc1fWtnw==
X-Received: by 2002:a1c:70b:: with SMTP id 11mr1638079wmh.74.1544753494092;
        Thu, 13 Dec 2018 18:11:34 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r12sm4407433wrq.3.2018.12.13.18.11.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 18:11:33 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 2/3] parse_hide_refs_config: handle NULL section
References: <20181211104236.GA6899@sigill.intra.peff.net>
        <20181211104358.GB7233@sigill.intra.peff.net>
Date:   Fri, 14 Dec 2018 11:11:32 +0900
In-Reply-To: <20181211104358.GB7233@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 11 Dec 2018 05:43:58 -0500")
Message-ID: <xmqqk1kceu23.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This helper function looks for config in two places: transfer.hiderefs,
> or $section.hiderefs, where $section is passed in by the caller (and is
> "uploadpack" or "receive", depending on the context).
>
> In preparation for callers which do not even have that context (namely
> the "git-serve" command), let's handle a NULL by looking only at
> transfer.hiderefs (as opposed to segfaulting).

Makes sense, and I too wonder if we want to keep the "serve" thing
in the longer term, at least in the current form.

