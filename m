Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B02DC433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 01:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbiKCBAG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 21:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiKCBAF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 21:00:05 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A0212616
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 18:00:04 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id m15so345106ilq.2
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 18:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lL//hgPofa8yKspVeVWBbKTIxsICQKZd4O4uW+xkA1c=;
        b=2GhTHeRtk/0BagHaUDJiAYv4WepTYUJc76KVex3564eKS6eDlG8V7zAAlItrD/bYwl
         Sl/TRggWrqxRPr29aGIG8kS/p+o+gpMONJNftjkB7Jq6FU/N/wtVIvpNutu/juIefkO7
         bzIgI0cP6OibjM5O8F6IVmEIJIh/nZ1RaJ+8gPDw73Ax6KuTaDBxPtEoT5y3IhKIvadw
         65V39DnQWfK0kwS91xBr1RAvKsI4SNOlm7HjAIwc/aHZ8+1sxNR6OS1XnHKZSTBLqAhk
         G1HROnuA7d1CrlaIrL8qnA+Ai9zH6UP2tCd+qX6jd2jF3A70akOGRcxJfyOJRVM2+/cp
         ViRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lL//hgPofa8yKspVeVWBbKTIxsICQKZd4O4uW+xkA1c=;
        b=0G9SjjNmDQkFn1eLbx8P4L9M6fMjwxrYUEjFRmbN+1pSuAs2Rx9TLYw3cvIcPzICGK
         F9g5S7mT0rWHMVwVPH1+Jc0tLb9aKeyxkAlCa7diCktSEQTFfrqoXZqXrOVR2Ttc8gyb
         DY7e52XC/j+japSDKTwuAolm+PwQF5Sm4ShVT2cdmC2ZJ9Qtpf8/B04I/t7J/MAZbVSM
         TndQQTuCkWOTF9dLbTUw6qwoH/VXveps+Lq44NBgeC/nxk7gqmM6w/fdXYnfuKt8syhk
         Ec0aS26UCKCCzdulA7dpurZn/E1pVEvNygpM1QfOi9raMljhnFbHyRHRxQkKb3nbgq4S
         CD7Q==
X-Gm-Message-State: ACrzQf1KT+dk2CO2KxSkBRMYXdLS6m0U+2bD9oAVHAYsWUhq9mDTD1Lk
        qdBa5QaGkx1YhwS+WorWdStwAg==
X-Google-Smtp-Source: AMsMyM7YSUJyAiHh26DSERb792fdS3pfyoz/ZDeiGghxA/+TOjLU60wu3ep07KC7vammJ0EERKb0+g==
X-Received: by 2002:a05:6e02:f13:b0:300:b29d:d3f3 with SMTP id x19-20020a056e020f1300b00300b29dd3f3mr10680072ilj.310.1667437203835;
        Wed, 02 Nov 2022 18:00:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bi13-20020a05663819cd00b00371a4b02effsm5434364jab.69.2022.11.02.18.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 18:00:03 -0700 (PDT)
Date:   Wed, 2 Nov 2022 21:00:02 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     me@ttaylorr.com, avarab@gmail.com, derrickstolee@github.com,
        git@vger.kernel.org, gitster@pobox.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH 0/1] pack-bitmap.c: avoid exposing absolute paths
Message-ID: <Y2MSkttIGVVVInKy@nand.local>
References: <Y1mp23NHB0qzKsPR@nand.local>
 <20221031131356.67007-1-dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221031131356.67007-1-dyroneteng@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 31, 2022 at 09:13:56PM +0800, Teng Long wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > --- >8 ---
>
> What does ">8" means?
>
> It's like a Github internal patch between the ">8"
> and "<8" marks, right?

They are scissor marks. Tools like 'git am -c' will trim everything
before a scissors line when applying patches.

I used them to deliniate between the patch contents (which can be
applied) and the rest of my mail here (which can't).

> > For the general case of what ships in git.git, I *do* find this warning
> > ...
>
> "ships in git.git" means as the git developers, right?

Kind of, but not entirely. I meant "what is in Junio's tree": so, what
gets bundled by package maintainer, as well as the source that Git
developer build from.

Thanks,
Taylor
