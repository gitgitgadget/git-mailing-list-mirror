Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB08CCA480
	for <git@archiver.kernel.org>; Sun, 17 Jul 2022 22:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbiGQWZa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jul 2022 18:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbiGQWZ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jul 2022 18:25:28 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117EE1275F
        for <git@vger.kernel.org>; Sun, 17 Jul 2022 15:25:28 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id w29so6943487qtv.9
        for <git@vger.kernel.org>; Sun, 17 Jul 2022 15:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yw8FQXwMzHzBWh5jKNlrXYuGGn/hS/SLNjCf0r7ET0k=;
        b=MZF+0WTr9l8eSzOcGjYAluxzN8DByUnusYc62TzU3XidGaoPNwUP2WIpZ3f940nECF
         WwEqMdYOMkZV/+RsH/aqm/LVoNK20UQQn3kdbZnDVtQlPtqU8tQaDGm5TbWAkCU9gaay
         zi5cSTo7tMlVtxObsOFCYeS8GiIJaL5rr/hT4eIN3c6YONpiVWVrTudgyr6LcZ+UGX2G
         jRx7URW/wmUvcw/GQnz4YkyuMtevXCqsA9SzMuq6F9okoYQzBOt/tpmQioeAh+8sEIeM
         u25WcgGIfr00SfyrME3aLkccQ1dG480d7N+rmCZEC5yOeNLT1xcwcBylqlDcQeof7srF
         8SaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yw8FQXwMzHzBWh5jKNlrXYuGGn/hS/SLNjCf0r7ET0k=;
        b=AihEfd4VvTXeBWt4P3AeRNhtUiiTQ3/5+VddRu8XslzmBRaJfQ3v9zSzuC3g+ncSHA
         nxEeGVYZxoKy5IdYaQmfJ7k/ZYcQ+w00m5yqGmxNDzwbQxJzOzg7dewTFPPH921s0CbF
         /Nl5VcSDuu4BfYfR5f1hJXyI5M2zYDef2ixCx0Y2FlTCoWtIB0aOJNn3H5BDVjaPLRS0
         dzp153If7fkQAoVCJhW3AWbUCdnEtLB/SqeVgbPcW2We0ofPOxcP8Yr8uJNnHJ6G6Cir
         CeJzfaSSzEZdNbvkX7geskP/1igUblm3cwkULtkyvP+/QteQpMcUzx6cHPXuwNkoA4M4
         F5hA==
X-Gm-Message-State: AJIora/uHqZ0j1E790iephAiUId9CbzsnGW9kEKwLG+qOJQiqs/j5i2+
        ZoZgM6V7MesoNm6uB3WhALDBqw==
X-Google-Smtp-Source: AGRyM1tHhLhqX6zF6/4DaJvXD+0rS9ZAV9QdN6Jqe9jvVq+P0PfpJDZdY9huPRkhmFf6lwyudNu+Hw==
X-Received: by 2002:a05:622a:1651:b0:31d:3248:ad77 with SMTP id y17-20020a05622a165100b0031d3248ad77mr19765535qtj.213.1658096727150;
        Sun, 17 Jul 2022 15:25:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f8-20020a05620a280800b006a6ce613c7csm3800227qkp.89.2022.07.17.15.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 15:25:26 -0700 (PDT)
Date:   Sun, 17 Jul 2022 18:25:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        =?utf-8?B?VL3AjENWVL3AjENWdmFy?= Arnfjjjrrr Bjarmason 
        <avarab@gmail.com>, git <git@vger.kernel.org>
Subject: Re: Can I use CRoaring library in Git?
Message-ID: <YtSMVcc59LP1j+Ys@nand.local>
References: <CAPOJW5x4McofC5fxBvsRAzum28wmeDJCMTMRmY_0oy=32JjKqQ@mail.gmail.com>
 <220716.86y1wtxhok.gmgdl@evledraar.gmail.com>
 <CAPOJW5zNsETYwD=MXCFLn91qaemgooPN-JB1sx7KagkKxOXTnQ@mail.gmail.com>
 <e574ac20-c287-c395-5bc3-b481d81764c7@gmail.com>
 <xmqqzgh7v1q3.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzgh7v1q3.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 17, 2022 at 03:00:36PM -0700, Junio C Hamano wrote:
> Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:
>
> > The EWAH case is a bit different. The original EWAH implementation
> > [ewah-cpp] was in C++. It was then ported to C [ewah-c] by Git
> > contributors [ewah-git]. The ported version has been relicensed under
> > GPLv2 with Deniel Lemire's permission.
> >
> > The case with CRoaring is that the implementation already exists in C
> > [croaring] and that is the one which is licensed under Apache V2. I'm
> > not sure how relicensing works for already existing code.
>
> As long as the author says they are willing to relicense, that would
> "work".  It is entirely up to them.

Yes, using an existing library would be my vast preference. Not only
because it reduces the amount of work needed to prove out this new
concept (that Roaring+Run provides a speed or space advantage when
compared to EWAH), but because:

  - the existing implementation is widely-used, and would give us
    confidence in adopting a "battle-tested" implementation

  - there is a standard serialization format that is understood in the
    various language re-implementations of CRoaring

The latter point is important for users like libgit2 and JGit who would
also be able to adopt an "off the shelf" solution and have the bitmaps
be read according to the standard format.

> Assuming that we can clear the licensing issues (or we can write our
> own implementation from spec), how would the transition plan look
> like?  Does our bitmap format carry enough metadata to allow
> existing clients who never saw anything but ewah bitmaps to say "ah,
> this bitmap file uses encoding I do not understand" and gracefully
> fall back to not using the bitmap?

Yes, the version field alone does this, since the existing readers know
to ignore a bitmap whose version they do not understand.

I assume that Abhradeep will want to pursue some format redesign as part
of the transition, though, at least to see if changing the format beyond
a version bump and new compression scheme is worthwhile.

Thanks,
Taylor
