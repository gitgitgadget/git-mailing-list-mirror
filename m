Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE5DC433F5
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 19:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE24860295
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 19:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbhKATUA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 15:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhKATT7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 15:19:59 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FDEC061714
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 12:17:26 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id a132so16460517qkg.0
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 12:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I4qm2EF3GDlxXerlqItOcpnB2bwMWZxM9cINrbVZjV4=;
        b=Si8X3IeMTzl4MPMI6sWLZZX4JNO7ORnfT1dxAcSoQI2p3iB9OyAtMS1jUOosEO0IJl
         oguKEZBW9mwMK9Fdybo3vO91KdBf9dWJmb5J6ao4ghfVDbzf3FtxlN949jvFvdkeRTuc
         5q++KAfWZlfEPlU57FAsNJcqx9YoTBYre5+aM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I4qm2EF3GDlxXerlqItOcpnB2bwMWZxM9cINrbVZjV4=;
        b=bR3IZh9ZbxOxYAOJNPWM0Otw+KhuHzUwpfbkCFoWu8YV9sLpQWQzV8aMxgOTI53VTK
         A6sERvMaE+q30K3pr8Lo8CbmxJ+LJyF4WC/UIgQcnxbZpN7ho2p1NVb2RtAbgmU2LidZ
         dy9fzk9g10rEbHEUFa/a4piAqZesL0IxXmid9koZ3mqtqy7Q4BZPUhwkXX7eb86cB95c
         +PY5vU4/x3wlIKZmnsm0kIDCqgO+HItNtu8sR0P8Yg4sDNkzX0QnRKMMyAx4lzqdeeMD
         QZ1oGBioGlwclSxghz/7yPAG0H/UEZSvf7XasdWJpUhhkyIgS81R0UwPPArh/r44VM2e
         PDQg==
X-Gm-Message-State: AOAM530MQkmokNdQdPNr4KNJOlePsK1fiRJsfvp0NzLkxGvkDwcODwfO
        9Ao6TP34Pe+djhlupzun7uSiEFrPiAVHRA==
X-Google-Smtp-Source: ABdhPJwRmSitez2DRbdWleVZJ40mVHvCTZjDZ5fCSZ7zfrX6InUilTsQUPqJqMIvrH/F5iDVTvPe4g==
X-Received: by 2002:a05:620a:2943:: with SMTP id n3mr24621129qkp.199.1635794245328;
        Mon, 01 Nov 2021 12:17:25 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-181.dsl.bell.ca. [216.209.220.181])
        by smtp.gmail.com with ESMTPSA id bp11sm4864764qkb.24.2021.11.01.12.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 12:17:25 -0700 (PDT)
Date:   Mon, 1 Nov 2021 15:17:23 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Eric Wong <e@80x24.org>
Cc:     users@linux.kernel.org, tools@linux.kernel.org, git@vger.kernel.org
Subject: Re: b4: unicode control characters -- warn or remove?
Message-ID: <20211101191723.vnsqrsx2jcw2nd2q@meerkat.local>
References: <20211101175020.5r4cwmy4qppi7dis@meerkat.local>
 <20211101190905.M853114@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211101190905.M853114@dcvr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 01, 2021 at 07:09:05PM +0000, Eric Wong wrote:
> > Per exhibit a, what should we do in the situation where we discover unicode
> > control characters in an email?
> > 
> > 1. Warn and strip these chars out, because they are extremely unlikely to be
> >    doing anything legitimate in the context of a patch (unless someone is
> >    sending patches for docs actually written in RTL languages)
> > 2. Warn and error out, refusing to produce an mbox
> > 3. Just warn and produce an mbox anyway
> > 
> > I'd normally do #3, but with many people piping things to git-am, I'm not sure
> > if it's the safest choice.
> > 
> > Exibit a: https://lwn.net/Articles/874546/
> 
> +Cc: git@vger
> 
> IMHO, defense for this belongs in git-am (which already checks
> things like whitespace).

I agree, but even if that is implemented in git, we'll still probably want to
catch this on the b4 side of things until everyone uses the git client where
that's handled natively.

-K
