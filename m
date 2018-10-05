Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA3A91F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 16:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbeJEXrj (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 19:47:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46325 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728387AbeJEXri (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 19:47:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id a2-v6so7157604wrc.13
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 09:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=sm51A9o7CW+LjakV/jcCOTADGDnHnkcxMP2ilTQd3zU=;
        b=e2hu9t/d+n/fq5aIMYbb/ui4Y3CMBop+OfECIXkxgtHW2l26QZDRbwDpHSU5cH7dcN
         KpVIUETG52JEcEszKb+dFjJM2BBaKdgd4cGnmMzhBlBnIv2fu6y8SOLgEX+kDG5A18P8
         JPNqcwT2Fm1jKc+11IRmgNaf+fexOjPGB9T3lrBJcrSjNNvSex6g4lBmN5U9Ztk8N9zH
         vmYgmqwlvzHMKtidZZHPw9P4akGQJiyowo0hCCAWCZn64+pmPAXp3danH2hAaZwJMvcv
         JCoqDQqkIv/oeXKDHyNRzx3sPvoS91mK4EBLBDs9EJDq+vaaelvzc23194t8N3qPYho8
         FvFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=sm51A9o7CW+LjakV/jcCOTADGDnHnkcxMP2ilTQd3zU=;
        b=SS/ZQK7mNMIBQe2jXURS5Qfcvbf+oWbD1x+RyQrSZgF4Jv6GyG/1KktyrNvYPa6yOV
         nJG6f0VuN8vTQMP8CE/cYVSUcy4DQZoivVWWyx40ON02hdTB3v2NYs3eUmB+Hed+vnJa
         b3bylSwjjcuYc0CPkjy42sWGupRvq9jfq5SeMSnkcfvpXQ/soIGepTIhZWQ3mIzsW5p5
         fF2BNrNgYYjKk/VUUDgJKX3Ze62lTyWtZcxDrIdmziERYIG5L2gpKxkM58wvf9T9RWub
         UFN/nBNEyvrKlU/jrtmsisM5rbViwWCphCUMLpT/jURGb2/1Suz7l02ddZJ3NF3LajS/
         raBg==
X-Gm-Message-State: ABuFfoiu8runMI/0ZO6tTDQYJPVBqBrpkgLthHnKzDH4ygT656NsSA7M
        4Reb5PfiH4kaKQr3dF8fWpQ=
X-Google-Smtp-Source: ACcGV63LGKeAjRQzuOKZaAcmY230+EqKVRzVLFbpaY+BPO47f4JJY1f2+aEHDOQhz23ne6ItrZ8PDw==
X-Received: by 2002:adf:fb0e:: with SMTP id c14-v6mr8641557wrr.117.1538758085555;
        Fri, 05 Oct 2018 09:48:05 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j46-v6sm12671849wre.91.2018.10.05.09.48.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 09:48:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com,
        jrn@google.com, sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: Re: [PATCH v4 5/7] tests: don't swallow Git errors upstream of pipes
References: <cover.1536969438.git.matvore@google.com>
        <cover.1538581868.git.matvore@google.com>
        <8c0821f68570551675901f4bfdd3149884286c48.1538581868.git.matvore@google.com>
Date:   Fri, 05 Oct 2018 09:48:03 -0700
Message-ID: <xmqqd0sowda4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@google.com> writes:

> Some pipes in tests lose the exit code of git processes, which can mask
> unexpected behavior like crashes. Split these pipes up so that git
> commands are only at the end of pipes rather than the beginning or
> middle.
>
> The violations fixed in this patch were found in the process of fixing
> pipe placement in a prior patch.

Hopefully this is not a blind mechanical patch, as introduction of
unexpected temporary files in the working tree could interfere with
later tests (e.g. they may expect exact set of untracked files, and
these new temporary files would b unexpected additions).

Thanks.
