Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6E4EB64DD
	for <git@archiver.kernel.org>; Tue, 25 Jul 2023 21:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjGYVR5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 17:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGYVR4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 17:17:56 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04593E70
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 14:17:55 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-686be3cbea0so178783b3a.0
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 14:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690319874; x=1690924674;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aj0qPmaK5HIkcpm7hwtALF3lDpCazFAWI3EGU4bYEN4=;
        b=HZrLUTxHXpsjc/nWSuffkVQV02+/jnBvEJithNrDJziriIQYhP+qiNuxAFXJ3Py8xe
         6yn6m1NP92USiTJnEm36ucRkhx1OyjMePI/0tUurfT+BCbJNdDTT2ZL+nPUe+BLNkq1F
         8eABvgjVv+YjG6wVtpYoFNYzWC70aotMUU0sOQtJmSZJLCNZ1TlFlNieXVUNl9kXq52i
         iy2/m3onCfaMqKiAHrhpxMXJ+aGOFPK9xm7lg2hUtohpo5dklPLUzcKqI82LOrR7Wc7V
         EPJrzwMvmpNAKh0t92CqivXJr9boC9c6b4C+CIgLTnV/mpHhPBaw77gU1fWpvyhp46z8
         Nwkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690319874; x=1690924674;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aj0qPmaK5HIkcpm7hwtALF3lDpCazFAWI3EGU4bYEN4=;
        b=E61VaB+LvlOXuKjPIO2Lpeo9pDNj2tf05tZqIT+6xl7kEi3TLnWJs2RMp5CuXybFgE
         qmup0wo/yc9ObcnTTyCAV76Y7k3RLNtvdWzV1ZWSCoSMBlq6dra/iB5wxtggB3+sb9Ct
         pKDUv5SiwyuBm2c133/9BhsHachkF2aEgXJ8i4qPIDlCrmytPaf59NuOCq24nsmPkLPX
         i+8SzUg9Z98LDH0+diQat9N8kBLEm0Ea8IGyJEu6V5k2Df6EkFnf7lj8OmCqJeGWmDzh
         hJONruDJI/sP/rWJzcvG2nWaFQweejnCGKK2CwXNtyI/Cjg13j8k5XgtmWL71Tm+9tta
         cWiA==
X-Gm-Message-State: ABy/qLaadfTVHXj+dHJrsFda/8/vlhefXiQw5Zv6IFan/yrEXTF6vvd6
        mo3LnWmS7mFhlFDcwVcxvqSybwy2HgBxnQ==
X-Google-Smtp-Source: APBJJlEobtribaf6OjPr0bpQt3oe0k6A1V9j/O2UvuEUszGZgeBehSCkUs11Y72CCDIIRtJ8rvmzIw==
X-Received: by 2002:a05:6a20:2444:b0:136:5e98:3113 with SMTP id t4-20020a056a20244400b001365e983113mr314788pzc.28.1690319874334;
        Tue, 25 Jul 2023 14:17:54 -0700 (PDT)
Received: from five231003 ([49.37.158.194])
        by smtp.gmail.com with ESMTPSA id b12-20020aa7810c000000b006765cb3255asm10043117pfi.68.2023.07.25.14.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 14:17:54 -0700 (PDT)
Date:   Wed, 26 Jul 2023 02:47:39 +0530
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2023, #05; Tue, 25)
Message-ID: <ZMA78xwfCE1-paE-@five231003>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqedkvk8u4.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:

> [New Topics]

> * ks/ref-filter-describe (2023-07-24) 2 commits
>  - ref-filter: add new "describe" atom
>  - ref-filter: add multiple-option parsing functions
> 
>  "git branch --list --format=<format>" and friends are taught
>  a new "%(describe)" placeholder.
> 
>  Will merge to 'next'.
>  source: <20230723162717.68123-1-five231003@gmail.com>

Hi,

Could you merge the version (v5) that I sent out just now to 'next'
instead of these? They address a minor change.

The patches are at

	https://lore.kernel.org/git/20230725205924.40585-1-five231003@gmail.com/

Thanks
