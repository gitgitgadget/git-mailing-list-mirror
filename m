Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35F6C433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 21:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236926AbiDMV2T (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 17:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233663AbiDMV2S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 17:28:18 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94B77DA86
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 14:25:55 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id a5so2629218qvx.1
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 14:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JvU7uHm59H3as89kFqSQ/jkrhcKQVCsQYTb1uv0t5OU=;
        b=fN4mO/1MBjpALTQbmsRx6EuY8PQJck/YgxM8gbGl1Wz+UmL9WiZSBm68h2uoNaSd+A
         iv1Umob4OHwqS01c5mkziNB8NLqtCWot+oVtiFTJyVYZHMsGcUpPd8Nx284PClHXR/M4
         BYNMSjQtveSqxLNDX6bV9j3SBzL89nqJO1mAfBZ6xf5qtKWB7gxs9MRJ6ZqxmA6T2aI3
         q/Ig3nHsaupNY+tWBpNGir3JAXQXQL9dRmhMq6qy2rS1SPdl1VkZBw0F8D9bSZG79FBN
         g4OMq76tq6vEmwxZz0SnYRIPDqM/1VDLmwYoqqU9jPb4duUODNKZlejMY0r8iBwDuHpX
         c//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JvU7uHm59H3as89kFqSQ/jkrhcKQVCsQYTb1uv0t5OU=;
        b=OxvITTfRDtYbjf4pHa6fQdMcAnLoA5X8S9/IC0iB+qQyW5uwaBKW4EpSbFlBG5Z3kZ
         rf5qy5ftj4dvPltw2OkdKx36CUxsdc08Zg0rkmI6Z0qWTfoxu2PT9H0ArU7ZxpczcAMn
         wZ3N36qNbqUBj17yFdPt4iMZRFuMP8tybnTyNDAeWCQATW5yto7ClA2ZcajBk0WPbAun
         l1JbQhINhm7wocCz9srI6huI/XyzO1nZQ4RIozOo8uAC7gNjBYwJymjnyWc7e3BbMw5i
         iT2ANxOoYQ/Zc4OxOaddH9/liasT8EA8dL4rdIgrei5VlpGEtxrlnFEkpBw58lVE9l7G
         qHPQ==
X-Gm-Message-State: AOAM533VV8Vqt/QRjfQyDIm74y5UB2pqKyw9UDpVMr5e4m6h+swicRj7
        1tgcjVro0j16RvdGXTFADoQ4kkTvmHArCr6z
X-Google-Smtp-Source: ABdhPJyqALQjB3rBDtf2gtR4OVOva7nBSgAaZbGcaY1PEp3WpBJVbmB0nBKS9ZPC440lZfvZJDBxiw==
X-Received: by 2002:a05:6214:27cb:b0:444:4217:2656 with SMTP id ge11-20020a05621427cb00b0044442172656mr646134qvb.41.1649885154982;
        Wed, 13 Apr 2022 14:25:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q17-20020a05622a031100b002f1d478c218sm58475qtw.62.2022.04.13.14.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 14:25:54 -0700 (PDT)
Date:   Wed, 13 Apr 2022 17:25:53 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, johannes.schindelin@gmx.de
Subject: Re: [PATCH 0/3] Updates to the safe.directory config option
Message-ID: <Ylc/4Spmtw/f5Nwr@nand.local>
References: <pull.1215.git.1649863951.gitgitgadget@gmail.com>
 <xmqq35iharig.fsf@gitster.g>
 <e8383303-e82c-dc23-9f28-6ff566021e82@github.com>
 <xmqqee219bly.fsf@gitster.g>
 <xmqqmtgo7mqu.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmtgo7mqu.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 13, 2022 at 01:27:05PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Derrick Stolee <derrickstolee@github.com> writes:
> >
> >> I tried to do my due diligence here, but I will admit to some amount
> >> of haste being applied due to the many distinct sources that have
> >> motivated the change.
> >
> > OK.  Thanks for a fast response to a brown-paper-bag bug or two.
>
> Here is a draft release notes to 2.30.4.txt; I may tag this later
> tonight (i.e. in 4 hours or so) or perhaps tomorrow morning, together
> with the result of merging the fixes into newer maintenance releases.
>
> Thanks, everybody, for working on the issue.

Thanks; this all looks good to me. I took a careful look at Stolee's new
patches as well as the (elided) release notes from you below, and both
look good to me.

Don't worry about applying my Reviewed-by, but I did want to acknowledge
having looked at these.

Thanks,
Taylor
