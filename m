Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940D3C433FE
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 02:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbiKKCsv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 21:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbiKKCsb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 21:48:31 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1599E78317
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 18:42:13 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id c7so62637iof.13
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 18:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=79x6fSIFBKtvGPmnSwJzqJmbx4fjPp6t5FTsAEkJlBg=;
        b=efS9kN8t3f/RNX0hDQj/zvkaGdegHZOw3Qn6knkCmFtOJpYdtH+NGcNJrvAvCY18fq
         4zm8ufyGvzrhFHYmTy4LVsLeI8bYhf4hgaJuPeAH6QjqF0mIwRnTyzkF2tW5rdN7utRF
         UrApU2DjoA0FktHUWWtbyYSc/npb0Z2vZiJO84YbGgEiqPyRQu2z//RPMcmB6PrysjAn
         4ekSzQz8qMZWwuJ98F4/QoV01fHX8nQDzK5YoCyY7UEchN5JU6mJ5c3Y14ynnO0/VJdo
         rvp/Q8M3pMMIK2noAm6twilW5jHSIZaI6ZOjMN4/ZeDElj6cj+ShJmrXVMB0Q2mbP7Rg
         DzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79x6fSIFBKtvGPmnSwJzqJmbx4fjPp6t5FTsAEkJlBg=;
        b=n67vm+gbV/vV+zLt1o2gB/IOUd6F1YYw/xiizvzMsgrKszu2YvrcbJGmkKWPH6KA/v
         yQwGSiHWTVhKl3jARJf06bNPmKFSIYFf8Qv9YKsc7Gwuf4sYZuxJO4WURYILQxQDoi5N
         7y5tte2T9DEumBzfJqlA8PbHxwIHeV77NWTjqe85dLNXZBxWeRI6Tm7Zt9D26zHP9oAq
         GGLiWWeMRKB2hQbPNgKHByTO4K8Uw0q3ZqGbkm19B98iOmVj2d1BETvX5JgUshV/LEwu
         w2neDwiLA5qK8hG7cf9ThJvx2wPAveVhNv1F0fs3kdVBX0HhOLLbDB/j/y58o5lY6abJ
         TdyQ==
X-Gm-Message-State: ANoB5pkpEhrLjii+Z0J3H9JQeNxOXYaWVEnyLdGegYRTa46m7jgNJaeX
        NZJegTGDbz06BJB0AH/rttONuw==
X-Google-Smtp-Source: AA0mqf5bbFMTf9iOgvDU5wnEKO/1DiC+sT2Rf8pnitbYPPByXcTOjbGHsoZpUs2Yq7M7k9YpyJIg+w==
X-Received: by 2002:a05:6602:583:b0:6a3:a0cf:ea32 with SMTP id v3-20020a056602058300b006a3a0cfea32mr107921iox.155.1668134532328;
        Thu, 10 Nov 2022 18:42:12 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d14-20020a023f0e000000b003757ab96c08sm416926jaa.67.2022.11.10.18.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 18:42:11 -0800 (PST)
Date:   Thu, 10 Nov 2022 21:42:10 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2022, #02; Tue, 8)
Message-ID: <Y222gnPtcQCr9IWx@nand.local>
References: <Y2riRSL+NprJt278@nand.local>
 <Y21utWxpsmXEkeIS@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y21utWxpsmXEkeIS@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 10, 2022 at 04:35:49PM -0500, Jeff King wrote:
> On Tue, Nov 08, 2022 at 06:12:05PM -0500, Taylor Blau wrote:
>
> > * jk/ref-filter-parsing-bugs (2022-11-02) 2 commits
> >   (merged to 'next' on 2022-11-03 at 92c1a50548)
> >  + ref-filter: fix parsing of signatures with CRLF and no body
> >  + ref-filter: fix parsing of signatures without blank lines
> >
> >  Various tests exercising the transfer.credentialsInUrl configuration
> >  are taught to avoid making requests which require resolving localhost
> >  to reduce CI-flakiness.
> >  source: <Y2IeqOT5Ao1Qa0Zl@coredump.intra.peff.net>
>
> Hmm, this seems like the wrong description. It matches
> jk/avoid-localhost, which was merged earlier.
>
> Unfortunately, I think it has now been baked into the history via
> 15df8418a5 (Merge branch 'jk/ref-filter-parsing-bugs', 2022-11-08). But
> it might be worth trying to puzzle out how it happened (some problem
> invoking Junio's maintainer scripts, or good old fashioned human
> error?).

It is likely to be human error. When merging to 'next' for the first
time (with Meta/Reintegrate -e to add descriptions), I am often copying
and pasting from my personal notes on each topic.

So I probably searched for 'jk/' and landed on the wrong one without
looking too hard. Oops.

> > * tb/branch-delete-detached (2022-11-01) 1 commit
> >  - branch: gracefully handle '-d' on detached HEAD
> >
> >  'git branch -d' is taught to ignore failures to resolve HEAD when
> >  detached.
> >
> >  Expecting a reroll.
> >  source: <c68f4b140f2495a35c5f30bec4e2e56c246160f4.1667334672.git.me@ttaylorr.com>
>
> It looks like you picked up my re-roll here already, from:
>
>   https://lore.kernel.org/git/Y2H%2F1S3G+KeeEN%2Fl@coredump.intra.peff.net/

Thanks for the reminder. I hadn't picked it up, and I must have missed
it during triage that day. I'll pick it up and start merging it down.
Thanks.


Thanks,
Taylor
