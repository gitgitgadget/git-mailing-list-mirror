Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75464211B3
	for <e@80x24.org>; Wed, 12 Dec 2018 09:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbeLLJnn (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 04:43:43 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:38479 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbeLLJnm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 04:43:42 -0500
Received: by mail-wm1-f49.google.com with SMTP id m22so5190201wml.3
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 01:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1SDa3L6m7j0KpcN8ykBeA+q6uKaymexOUnmAj4e4Lus=;
        b=hgMk1OQB7c+skKalCSZxpS+j9qEmIjFaNZwpOwLPeDaHjYXGHKXV2fGxs1O8XtEriD
         A45uxMsSagFDf3e1R5FnfMes98f6vma6bgY7ct2Ahk1wOcMOxcwHwBuyjTMvk7l1e8YW
         0n5FsNFnTtAfE/Wn+M3mBwAlW3cZCcLLc1Avn9nESklEfxPIVDEjWTn2tFi5T2dz5W0T
         ZDZI68HX6ExdmZaKKbuNLBxfVwhfwfjhK/y0au/EagMNsDjbUeCEDy8zs67XJS0Dj8Ub
         JuYw1d7tFAo314FOS/4UIOxAwAUjQyqMyvpAEbLSv8DUvsXSIe3fBdEjIlMFDdETmTAo
         1Xfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1SDa3L6m7j0KpcN8ykBeA+q6uKaymexOUnmAj4e4Lus=;
        b=CS5LPUWL+fRYZBD3uNdY/BQa6ZGbZpR3NDnB0sUCmHAiBbenw4OcABgIufXpbcKvsf
         ORMcer8kLa9EJDDbiCuouBdXurJh+Rngkdk3jIeRH0BFw6l//HJTLpAWMiOWqIQSRyxs
         MT6y19jF8sn/i8+L+TPfoRB3SgI69MyR9cnpUAY/v7ngNy20MaAhx2+/OZhYHBCTSu8Y
         9VmT9Zzoedoev+7FJskoT7kC1bYHLABkMH8kJJVcbCPuihBJoKG+yXo5Fg1o1YW+LTr/
         B4ED4tgak5R9uj/Hh/0vcPET/LNBI6eqraaX3YT1EEhZvI6obKa/7I3blYOcgEIkQoGK
         UMqA==
X-Gm-Message-State: AA+aEWbattq8mqewxq9McTe/OgUAcsMHRXYNYD+oURBQpFPdk3vJ9oig
        iGjhc81vzRTekKEwAGdaMjtimhVikN0=
X-Google-Smtp-Source: AFSGD/Ws/7NewR9ZqNmj5riqgDjhKv2KrzyVWOtTN4Bg0cp2UWMtgoZpY+FBF39pi07ufdz+8107mg==
X-Received: by 2002:a1c:5746:: with SMTP id l67mr5759210wmb.118.1544607820821;
        Wed, 12 Dec 2018 01:43:40 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u204sm1756244wmu.30.2018.12.12.01.43.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 01:43:39 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] help -a: handle aliases with long names gracefully
References: <pull.97.git.gitgitgadget@gmail.com>
        <850cd5d15abe5b8a4356efe86ba81bc032278dce.1544540287.git.gitgitgadget@gmail.com>
Date:   Wed, 12 Dec 2018 18:43:38 +0900
In-Reply-To: <850cd5d15abe5b8a4356efe86ba81bc032278dce.1544540287.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Tue, 11 Dec 2018
        06:58:11 -0800 (PST)")
Message-ID: <xmqqlg4vhygl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> We take pains to determine the longest command beforehand, so that we
> can align the category column after printing the command names.
>
> However, then we re-use that value when printing the aliases. If any
> alias name is longer than the longest command name, we consequently try
> to add a negative number of spaces (but `mput_char()` does not expect
> any negative values and simply decrements until the value is 0, i.e.
> it tries to add close to 2**31 spaces).

Thanks.  Let's take this and a few other topics that fix 2.20 brown
paper bag breakages and prepare for 2.20.1 soonish.

