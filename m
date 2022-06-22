Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AB5CCA47D
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 16:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359010AbiFVQa0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 12:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358957AbiFVQaV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 12:30:21 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08460344E3
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 09:30:18 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id b133so1101418qkc.6
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 09:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sNFwp1/y14R4OHE4E8xX93ijs0pE1UD2mij66T2yCbg=;
        b=fdk0X2o9Sb5nXO5aicfsDrUu3cdyaJCMF5y5RjJoUhoNTAOGjY2VRKFdfREnPdd0dS
         nBeu6iPlCpqKYWEJHWDZBqCmztjNZAppSycjkK6dbfdRbeTjlwYuSUWG1RK89Hg0lneV
         NqxOQurgPzsBdPryYZcCQ6aaK6p13rIRlRv4P4okEhx/BuDRhzWElf5cVqK6u5vC+2N4
         1AGmb02U0XrHQKMP260ld3s5sUk1ZX1tL/ll+VuWFIbZal23Fa7EzdZ0M0xO1OkK0KyB
         BMlDKtoM8UK1AelnoTwu0QLQdqRRbaULzZXe2WYz/sZAwB3z4Kv0yMkgfywO8r7O2ZBU
         WFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sNFwp1/y14R4OHE4E8xX93ijs0pE1UD2mij66T2yCbg=;
        b=wej8E+sPoBq55mblelaT08fqPIcyvZEu5f0M/kOeqyqyjacjWxjA2oNSKg06+D+vL2
         50a/Mddh9JyaFwU12wm6tOyykHMAq0w2QIPYcOlUJBhVaPjdAK3KwrkIVla39SxYswhe
         bLshwGtP5Vb7uiWf+ZSKcbwewYOqYomuExugTzTt+axATlF2AuUxjuS0nryLC5fUi4kw
         UFpNbR40GBBTgibO6xS8Scn0b9Azxh6qUqi+6OFyJmSpiJDftgSlfmubasStNYimLn2H
         cqHP876Z+GK1tHU4RX44zC8s8AMLwH7HQ0LzyidBlUQd5pQ5GICfgNcxhTai6VhbX58a
         IKqQ==
X-Gm-Message-State: AJIora+pTNYaJXfz/gZDXPLpVijUcO/IQ74qeudeMrlhtv7/sUUMxnJM
        JH+Hgiw4TmU4AZv1Xj78OY0EPg==
X-Google-Smtp-Source: AGRyM1tAC3T1ygnz3aeudmx0GLjFPCQ3qBf0SO2Y8wMLBH9W7JR1OX0gDrllk++LGi9syjxdUaDMLA==
X-Received: by 2002:a05:620a:1903:b0:67d:243b:a8ae with SMTP id bj3-20020a05620a190300b0067d243ba8aemr3109014qkb.142.1655915417108;
        Wed, 22 Jun 2022 09:30:17 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ff19-20020a05622a4d9300b00307c79b1569sm12671462qtb.75.2022.06.22.09.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 09:30:16 -0700 (PDT)
Date:   Wed, 22 Jun 2022 12:30:16 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH 1/6] Documentation/technical: describe bitmap lookup
 table extension
Message-ID: <YrNDmHrvVlI5cFJC@nand.local>
References: <25e03c86-5a47-2100-2da7-a635673a8e38@github.com>
 <20220621100800.21767-1-chakrabortyabhradeep79@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220621100800.21767-1-chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 21, 2022 at 03:38:00PM +0530, Abhradeep Chakraborty wrote:
> Derrick Stolee <derrickstolee@github.com> wrote:
>
> > I think you mean 0x10 (b_1_0000) instead of 0xf (b_1111).
> >
> > I noticed when looking at the constant in patch 2.
>
> Yes, you're right. It's kind of embarrassment for me :)

It happens ;). Let's use 0x10 instead.

Thanks,
Taylor
