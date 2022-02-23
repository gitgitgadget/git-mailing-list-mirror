Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A829DC433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 00:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236304AbiBWAGY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 19:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbiBWAGX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 19:06:23 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85188DF5
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 16:05:57 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id c23so17696579ioi.4
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 16:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GBLaBnpyo/DEq0IgzWXMQPW3OIymjwcFLopvAS2bknY=;
        b=e/3nVHV+fpuPqvRaeEdbStdAIbMu6e++v59UckuPnv+LgKPRRPvgBlT8dnr5PpGAPA
         mZv4RHZikdZtneD27cBmFg12rQhWCcSCOndsWw9MZIs6D3jAPU3mFjKYtX3eobA4DRQk
         yTkqeZpIh1RHnepxJm11ETxo15i4qTsvfE7RaYhzNbEHMDcUf9z9BeiMjBLTb2GOQI6c
         O1tY+46MGvBcMbKXlGlgtHFRRH7WYCe5i/VxLp6G/Kut7GJvYmC34hwVac8TMcQqoLiT
         Kj/Y8MGIAf+ke70MslGTrP/GKoDv3luTdnK6D5Dd+pP4gSRWQI5FaMOBAm+ssB/rmJJu
         MBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GBLaBnpyo/DEq0IgzWXMQPW3OIymjwcFLopvAS2bknY=;
        b=Ha7YeihMdJY9opjF9eCoLA+6jcNCNdvpTTEswqZcuaxnCmmV+YW9WEYJ9dJk3h+oyX
         YYl6CYwURzvFS6Iw2jVYhlrtenGzgHYeijg/RxMWjiIu/pth6mfFEoPOVQVFqmwfRlbn
         My2zzDw3Eg89DwM/rBGGwwATfvk8w9mEauNPRYn3zCfA+aW7HzPYNdeFVVdIIOa+2hx6
         fkyYW4AHFAQmojfNhHCxpIzmGnKIHp/8HMW6+8BgAtsiYPutG+4uy98UjUtY84zMuL1o
         tXKXXT8btPsCxEB2w6sYI+F8zxViC5RIDVel4p8ytcqFZvXDx0QPB3/z3hLiHs0NOshP
         tm/Q==
X-Gm-Message-State: AOAM532wK6blMBcuu40+4em1W6BuvI1za+D5sX0jFlu9/JbAUyR1h+RM
        NZlo3Yd21efm6jmdHzJDXZIaDg==
X-Google-Smtp-Source: ABdhPJyBJraqSCwPcG1IzAd8Wu4u/38qbUQlVxDTuZWKc3SkTvZZ/M2hqbcdGy5oTitVqGzmxF9hag==
X-Received: by 2002:a05:6602:491:b0:60f:ac3a:f3c3 with SMTP id y17-20020a056602049100b0060fac3af3c3mr20754876iov.210.1645574756890;
        Tue, 22 Feb 2022 16:05:56 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m22sm604739iol.19.2022.02.22.16.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 16:05:56 -0800 (PST)
Date:   Tue, 22 Feb 2022 19:05:56 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sunshine@sunshineco.com, gitster@pobox.com,
        newren@gmail.com, jn.avila@free.fr
Subject: Re: [PATCH v2 08/11] worktree: use 'worktree' over 'working tree'
Message-ID: <YhV6ZBaIvL5P95VY@nand.local>
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
 <pull.1154.v2.git.1645489080.gitgitgadget@gmail.com>
 <65a0cd527118578c98a6862460caa86ecb49735a.1645489080.git.gitgitgadget@gmail.com>
 <YhU+V+k/tp5B+NEP@nand.local>
 <a55c22f9-fe74-c154-af79-91c87ae5ac8c@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a55c22f9-fe74-c154-af79-91c87ae5ac8c@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 22, 2022 at 04:24:08PM -0500, Derrick Stolee wrote:
> On 2/22/2022 2:49 PM, Taylor Blau wrote:
> > On Tue, Feb 22, 2022 at 12:17:57AM +0000, Derrick Stolee via GitGitGadget wrote:
> >> Helped-by: Taylor Blau <m3@ttaylorr.com>
> >
> > One more small fixup, this should be: s/m3/me.
>
> !!!
>
> I don't know what was going on with me when making these updates
> that I introduced so many typos. Sorry for that.

:-) no problem. I think these sorts of mostly find-and-replace kind of
patches are for whatever reason the most prone to introducing typos!

Thanks,
Taylor
