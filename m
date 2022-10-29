Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1CAC38A02
	for <git@archiver.kernel.org>; Sat, 29 Oct 2022 18:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJ2SGZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Oct 2022 14:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJ2SGX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2022 14:06:23 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A364033368
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 11:06:22 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id p141so6980825iod.6
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 11:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cPh4h9hiMm4F8KspYcMx5KxoADCpVzteVUJUcu4T5r0=;
        b=amdAwkeoHrYHsCgGQN7lKIIUWF9VNcl/k3UNsINd0XlDixKS+Pllh82qkewz98qSTM
         RQ1tIC6deXqrlyhlTx9ybAUeIWXmlPrvGPwuDa6ZW8q/O2LmFFv+j7iyMswaI5mf3wjB
         9khCIqGwRGKKn0epOonG31sSqkM09iewgI+W7MpIYIm2CgyZ+kcTZBJg4H1nWpVivQIQ
         hSi9pc8R6Q80kFsw8kvS52aWhrx979VBVnk6uB2A/B8CAW+X1y56uuorR9Fqp5ywYXkT
         9dB6mBiafcXbP85WXes+RNWEG5YwzjB1DY+2fzAAD47L+xzKqoiAwyD0vx1iZ54lWiqa
         dTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPh4h9hiMm4F8KspYcMx5KxoADCpVzteVUJUcu4T5r0=;
        b=cCwnpnadzyyZYLl29nt76yADUN5Th+tZ+EWm4ofEWLjUAOgN/MUokS3lo7Ly81NG5C
         R+Kj9wubeDI4v2O/5117iQhro03zmFXMj9kp2F4cohAEBpPzi7QY68DkO79BkWs6ev8G
         Y4PyCP6cCpEVhhcCzsPwhV/sAl7LTtP2Q0rnK+oxu/X0G/pOE9COp+/n8OczOrIk2d4s
         SgoL/H3PV5BGDXeCyUDfLDnBkrw/5v5h06eMuH+F51q8GeTL2VhVGszgFQk5eVvtv0zL
         Kxn+sFcL1ZVg1Z3GvsNBm7Xhhjw7wXib3ArF/EVkyfGiVWQ8zrqKUyBDeAwVtwu4Ypo5
         G9+A==
X-Gm-Message-State: ACrzQf3Z29XvPqilJ35uBemshqD7+3PuNkH90vJdwtQeYrqP0WWhF6LY
        gzm1vjjCgWH6Sk7uE3rW1h4muQ==
X-Google-Smtp-Source: AMsMyM4i95nIW60BmW1pLjeAYBS646vH2b+u9NysWlg2Yo7RW9PM4bSR5MUovl7qSO3AuAYHLwEQQw==
X-Received: by 2002:a05:6602:154f:b0:6bc:f701:cb37 with SMTP id h15-20020a056602154f00b006bcf701cb37mr2658139iow.136.1667066781975;
        Sat, 29 Oct 2022 11:06:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b96-20020a0295e9000000b003747336e3c2sm834452jai.129.2022.10.29.11.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 11:06:21 -0700 (PDT)
Date:   Sat, 29 Oct 2022 14:06:20 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Siddharth Asthana <siddharthasthana31@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
        johncai86@gmail.com
Subject: Re: [PATCH] doc/cat-file: allow --use-mailmap for --batch options
Message-ID: <Y11rnKwuR0q47ngq@nand.local>
References: <20220923193543.58635-1-siddharthasthana31@gmail.com>
 <20221029092513.73982-1-siddharthasthana31@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221029092513.73982-1-siddharthasthana31@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Siddharth,

On Sat, Oct 29, 2022 at 02:55:13PM +0530, Siddharth Asthana wrote:
> This patch was previously sent as the first patch of a 3 patch series for
> adding the mailmap support in git cat-file options:
> https://lore.kernel.org/git/20220916205946.178925-2-siddharthasthana31@gmail.com/

Why was this split off from the original series? I don't have a problem
queueing the two topics independently, but an explanation of how the two
interact would be appreciated.

E.g., does one depend on the other? Are they independent and can be
merged at will? Should the integrator expect merge conflicts?

Thanks,
Taylor
