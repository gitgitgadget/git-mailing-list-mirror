Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6312BEDE987
	for <git@archiver.kernel.org>; Thu, 14 Sep 2023 06:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235189AbjINGTV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Sep 2023 02:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjINGTU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2023 02:19:20 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D673DF7
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 23:19:15 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-591138c0978so8878397b3.1
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 23:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694672355; x=1695277155; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yRTHc1ZbbYGkf9kh2fvPXwZeChq8ODw9EVZ8mrq3ab0=;
        b=rZWn58nSJGvTsWL/zGSGmHEZ2IPQdemtxjMXj9TDEetAlHwBO/0Pb9xoVF/cKaP6An
         jIzD5DHKxWNNUqbijmZ9rU1+DYv6eN7wavAGerQjqmAZV7EAUkNzeu50hTHWyL/JgL3H
         Fv6o2vcZymWGPtGSfTTN9hPqe/nZgrGlm3K9Bkw34qHkPLQwtP6ZrCaGIABpCh1tFHIL
         4WxQLSq17E9wPcmaShkdQZnFjyy92lwbkvGfojSdy0HeR9qch7jsiRIsWB82Jzpn3SXZ
         eVd1rdbInBSb4oRo0VkkKN6D/wYY2N+fU/2/GC9TR99SFI7QlOAO1WUri7weCumHU4OD
         Ecbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694672355; x=1695277155;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yRTHc1ZbbYGkf9kh2fvPXwZeChq8ODw9EVZ8mrq3ab0=;
        b=WVCDemrxOp0zuaZ4cuZdBWkEuDeLVoYTVBlPxHJY4y/ClvzqCjrpalFm3tWjPT1MdT
         TXRHIJ8rHY4iJmFX/VHxSriiA+rVqV4ivyCa+lOOYEAt9pIB+hdFALfVYeS6vTSaA1Nd
         enSYIoZGMTcayQWN69Q19iZN75zRnaGvFcvFqKs9BJqVD9vKoLTefRDOIXI0UoRFk3cG
         cH9RKmHTZdo5N0YMoGtzL+FMgQxjQ9+x54F5ohwQ44h0ux3N1ktHIyJArCU83q/lGj3u
         U2JOzcKfbI4D/ltGP0QnoeepjyCnoRPZRxSKWJPP6bC5/k4BELZS9z4JzDb90bClIqNL
         baWw==
X-Gm-Message-State: AOJu0YwO4GojHdtxVp1avMkhBLhm8l9xT6lAIVPvtvjUnc0LHETM48Qq
        pkDCq+lxWLBns+hYDAlwx8V08HZ9rLA=
X-Google-Smtp-Source: AGHT+IH0icrIeRFt0Mgo9+efhY8kndfYRyPQ85zc5CBRFde7NEud5hTRJ3EuFWUbXBXD8uShQKDgSq15BY4=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a81:b71e:0:b0:583:4f82:b9d9 with SMTP id
 v30-20020a81b71e000000b005834f82b9d9mr128941ywh.5.1694672355072; Wed, 13 Sep
 2023 23:19:15 -0700 (PDT)
Date:   Wed, 13 Sep 2023 23:19:13 -0700
In-Reply-To: <20230912193235.776292-1-gitster@pobox.com>
Mime-Version: 1.0
References: <20230818233729.2766281-1-gitster@pobox.com> <20230912193235.776292-1-gitster@pobox.com>
Message-ID: <owlypm2ljmzi.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v3 0/3] "update-index --show-index-version"
From:   Linus Arver <linusa@google.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>
> This iteration takes suggestions by Linus Arver; the tests added by
> [2/3] have been clarified.
>

This version LGTM, thanks!
