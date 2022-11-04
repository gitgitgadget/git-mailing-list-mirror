Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42ECC4332F
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 02:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiKDCKV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 22:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiKDCJt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 22:09:49 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9311C284
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 19:09:42 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id r81so2859455iod.2
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 19:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wWgba8h6uJ2zZ/4j/Sk8Bc28bwVBOftZ9z+VOVkeqjY=;
        b=OVtW+QN9a9OxMWMRXizX31nAsAeJYOHAKNwc+hLLqUhBzFaza8zSyc2a7O6rrrwlU/
         g/Ac55A218o2pH101LHnHTAn4aawZFe3dGJysBwvAgX+QOIXdhNQesIM90fQkGARsxVz
         vO91yGOLXDYjFsD/H23YvSN9H5DeuEAxzBRdPItWnAU2jIcCp28gqvafsZKh0mSIdtlI
         MdaDphVPm9TU7sBdsX/PvsAhKAc+AKE6IRMrWv3uGTannWcn4q4pBrfkMn2XE5I3wPD8
         CIrbeXm3FR16FpLJq3vT0g4FW9xhbRHrowV0UqVrn67hnPl1ziYpn8xa7clrn8suqK+y
         s3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWgba8h6uJ2zZ/4j/Sk8Bc28bwVBOftZ9z+VOVkeqjY=;
        b=hee0KIerE2dRSqtGbYpawvUwuRLyziebVguvHUrbRbldJKl/ohD2gY9BTVOjgktXch
         BV2ebopfyVN9nZsWv4yhQV073oqujXTk95DFym9GX/qYWGqzMF4doPBp4AluUWyqwjpS
         uEamEjeJ2FrAaE3ENtpfSpuvC708zb+UrGLFdSYWlLgLVjvuXfBHV13qup1Ivm6W2mbh
         cFb0lZSrbW5cWJuRC8WJODONKwP00wAKkzsa1fVI+Q3yEARhKxD1I89svOI/vdBQz/Sd
         nPnzSYHc0rgMiAP+vOejBiMdoblYr60z1M4BDhJEcv3fobOpGy5Cwg8azzp8+CF9Ni70
         1iwg==
X-Gm-Message-State: ACrzQf2wM7FKHd7Fr5hOn30336VthuusVmd4FP05ADOnT3Dqgi4zk2Y5
        B3WzNuvnz0pmj/+exHyWY7VgFWKIx3NouTTC
X-Google-Smtp-Source: AMsMyM64oO+UZOOXIK6ABHywA96DZsoxmSTEfeoSpCNJoVYAnK9TCXWmH4h7HEhpeDD7CmaEm2J3PA==
X-Received: by 2002:a02:662a:0:b0:36e:6349:17c0 with SMTP id k42-20020a02662a000000b0036e634917c0mr20480060jac.183.1667527780626;
        Thu, 03 Nov 2022 19:09:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u126-20020a022384000000b00363b8ef4bc5sm753741jau.71.2022.11.03.19.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 19:09:39 -0700 (PDT)
Date:   Thu, 3 Nov 2022 22:09:38 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: avoid unnecessary builds
Message-ID: <Y2R0YrQzKaUZzaPB@nand.local>
References: <pull.1404.git.1667482458622.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1404.git.1667482458622.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 03, 2022 at 01:34:18PM +0000, Johannes Schindelin via GitGitGadget wrote:
>  .github/workflows/check-whitespace.yml | 5 +++++
>  .github/workflows/l10n.yml             | 5 +++++
>  .github/workflows/main.yml             | 5 +++++
>  3 files changed, 15 insertions(+)

Very nice. For my own workflow, I'll often do something like:

  - work on a topic
  - decide that the topic is ready for submission, so push it to GitHub
  - while running `git rebase master -x 'make -j40 DEVELOPER=1 test'`, I
    notice that an earlier patch is broken, so fix it
  - push the (updated) topic out

...and before preparing the rest of the series for submission, I'll
cancel any in-progress runs, the results of which I no longer care
about.

It sounds like this does exactly that automatically, making older runs
obsolete by newer ones.

Thanks,
Taylor
