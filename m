Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BA7C433FE
	for <git@archiver.kernel.org>; Sun, 13 Nov 2022 05:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbiKMFI2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Nov 2022 00:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiKMFI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Nov 2022 00:08:26 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0401623D
        for <git@vger.kernel.org>; Sat, 12 Nov 2022 21:08:24 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id r2so4320877ilg.8
        for <git@vger.kernel.org>; Sat, 12 Nov 2022 21:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BeJx2gAU70Mj3eG41VQ+qIeMHj+H1CZjR3h0FuRLYlQ=;
        b=huPVdXd+nwAFaroEV+7/5wEzYY0pOL/fS78sHXXkqLgYD5ZvtzDy8HeNLXKxOjbpGz
         usoCAoMTsnMUgYf0/5Mxrm6GJq3IBebQTuj3nxojDvUcyqJCXouKU0t3V+E2OlqqdFAD
         Omi3B3+j/LDGRceJBESB+DMLZQQsoprWrWXM9ARMST4Xj+fJc1+SIqKyqIhJHCkfs3ze
         tpBTq8DjLUnyxphjXXnqFXzPuED873ReFSOvFaXCeDEHXgUqP6sgKBQLELgDssWB5KPG
         9//l/qMpJD3hNYadlgEqUWsMJgpPBUcC+82+cwBItO60OSymXduqt+9cq7BYU1GZp6Qn
         LguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BeJx2gAU70Mj3eG41VQ+qIeMHj+H1CZjR3h0FuRLYlQ=;
        b=G8XsErcFvqWPEE+zxiZiLsB+5BXNfGzCT0fTgdIPHc1u3Im14SRTVaJCe3NFmcp98W
         IWTa3Li9qPSuAkSIKjbPJQl3hoZaPShEW4HKqiqwNfyzRlJ0owJQVncY0mhgIs/e6B6e
         aCdcCMvDRLy3GEkENni9pyxZgwlclK4fARrvVYk+DPdD9XJpQXxlakwrnPPdAoE5erae
         SE/TVyHQbwC4/izCKgXKyFzNMS5CV8DHMYiNhvGb5cVPdBP2qCdsLlS7j5mgk971/Syn
         86qbLWTsPAgTq4syZ5fgFgFm3NY4molDZnJUBacWwaKNeGH0dlAL+xO/lGXinUoj9R2o
         wX1Q==
X-Gm-Message-State: ANoB5plnTd/MK8/q1/vaQECatmMah8N/ZAwHlVnGQf6UYbnVd5oZqf59
        RO4CPui8zB1kU5ipTZOAOAOAzXZS8/U4Eg==
X-Google-Smtp-Source: AA0mqf4/hX4OW/ZRk+650SAesxnuhH6cwTWJeHYh13PwgPonu5n2mUKz30l60R45kiddOFi1Elty3w==
X-Received: by 2002:a05:6e02:5a6:b0:300:14d:8b06 with SMTP id k6-20020a056e0205a600b00300014d8b06mr4046537ils.68.1668316103368;
        Sat, 12 Nov 2022 21:08:23 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p191-20020a0229c8000000b003739e4d381esm2297983jap.141.2022.11.12.21.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 21:08:22 -0800 (PST)
Date:   Sun, 13 Nov 2022 00:08:21 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2022, #02; Tue, 8)
Message-ID: <Y3B7xf6UgO4aAQyy@nand.local>
References: <Y2riRSL+NprJt278@nand.local>
 <1675f68d-d3ae-6004-e2b1-a3bcec862264@iee.email>
 <Y3B7HYwAKpQgnZth@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y3B7HYwAKpQgnZth@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 13, 2022 at 12:05:33AM -0500, Taylor Blau wrote:
> > I spotted some left-over comments at the test locations that needed QZ
> > space conversion in the here-docs, which have now been removed and a v4
> > submitted.
>
> Right. In this case only the WC report is out-of-date, since I picked up
> v4 in po/pretty-hard-trunc and pushed that out. That matches what's in
> 'seen', too.

Scratch that -- I mistakenly thought you were referring to v3 from [1].
But I see the v4 you posted below, which I picked up.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/20221102120853.2013-1-philipoakley@iee.email/
