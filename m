Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 053771F404
	for <e@80x24.org>; Thu,  8 Feb 2018 22:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751094AbeBHWca (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 17:32:30 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37555 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbeBHWca (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 17:32:30 -0500
Received: by mail-wm0-f66.google.com with SMTP id v71so12870947wmv.2
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 14:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xaKR/sQ8kydegA2zL0ZdsugRDcIOLWQ+LlD1vSZxmr4=;
        b=u9E8LIWbmor8fI6tiZP/WBdTXm44QNdEWMvUsPtfIf/oBdVDIK6QvNYjhUYlNo+rD1
         hVsvotLvNsi+l7Y4aHehROpRtDzbyE10F8AHWM3mj5XxVvuQZ72orvxZBffux4A1MxWz
         GiDsPoMn6CIt+fWUVmRLUfocX1qbVg8zu7fzeaxajvAmu2O3/b5Ue7GiLMoCUdUoGXdK
         10mL6alqEpandUepDGA7efZQmZ2Uf9UphRi6Hn2SYlCMOPowv9be14J13ctqujV/XSSK
         5g2NU1bH8y4zImduS5wr7LWfTtRaKz75CKju9WLqfeyCJB60FBmkFnCv0yjuQHSvqtFI
         jVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=xaKR/sQ8kydegA2zL0ZdsugRDcIOLWQ+LlD1vSZxmr4=;
        b=ciE7TF+E2Ht1YzdyMAqfZYCWtiLaR/0nZyGUsSJooLzh4DXA4aHfn1K373aJjXTJbn
         IjPEO2XGI1uCMDh0G1JfM/xGYIauftQuChRffHihqaXiCzucaMXrPs5cAKcjvCw2Q21r
         hzF3VWO5xLKH2RMs4gi3wztbIOAX49iGJkZ5C7nYIZJv3KSGndiDqbwKq7wCg9LOcIX1
         eujnTahCoQ2JorNFc4+SP8qMvsHGMzaXc95ktOIT0VqGrHobE0wDII3j4gHXGxe2AVrM
         C3bkNNv9b0+I9NI6S97Kuo6AaZXR6T211l+mjYt5JaGlycelkauJqV3KYZoV95pwewsF
         oFUw==
X-Gm-Message-State: APf1xPA3IKY4sJHTptFUSs4coStm+CU4jLaiOuNzXuhol5wJVK6LSJlu
        /3jTFORokLXlKw8em6zpYVc=
X-Google-Smtp-Source: AH8x227ruRHbup0Bb5DsxrXcAPoEppoIf3yXRj2DQWP/FMeK8q1D0M3e3RwXw96HlL0nC+XPLy18ug==
X-Received: by 10.28.111.219 with SMTP id c88mr437244wmi.41.1518129148397;
        Thu, 08 Feb 2018 14:32:28 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 78sm1074869wmm.22.2018.02.08.14.32.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Feb 2018 14:32:27 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     gregory.herrero@oracle.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] rebase -p: fix incorrect commit message when calling `git merge`.
References: <20180208204241.19324-1-gregory.herrero@oracle.com>
Date:   Thu, 08 Feb 2018 14:32:26 -0800
In-Reply-To: <20180208204241.19324-1-gregory.herrero@oracle.com> (gregory
        herrero's message of "Thu, 8 Feb 2018 21:42:41 +0100")
Message-ID: <xmqqd11f6rk5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

gregory.herrero@oracle.com writes:

> Since commit dd6fb0053 ("rebase -p: fix quoting when calling `git
> merge`"), commit message of the merge commit being rebased is passed to
> the merge command using a subshell executing 'git rev-parse --sq-quote'.
>
> Double quotes are needed around this subshell so that, newlines are
> kept for the git merge command.

Thanks for a fix.  Queued.

