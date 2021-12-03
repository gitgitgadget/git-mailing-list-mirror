Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8878FC433EF
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 21:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353908AbhLCV5P (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 16:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353907AbhLCV5O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 16:57:14 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2ACC061353
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 13:53:49 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id f20so4801894qtb.4
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 13:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x8rmdkWGaNSAAKS1Rht2YAiWK6qZfOhVMnyURYJPtE4=;
        b=UFuHw15Nojl/asUxnbJykyfxrKhfszABB0LjI/1BhP2WF+q8bAJja6VsbKL8L1tiO7
         YSfNTVTp1t+3oilaDxXTP8usJoy+uPu2WqcajzoQC2Z6eGf8PQZagQzQhlPFgkFCNuew
         ZDjVKp6+xxaQDB7+uX8bx5fcltB2eB9cz5wAyS8g2vvc4y6EbT+JIUUw9qKu+xQ52B6s
         Gr+6KqQlkgPoc3aiq9rsGfrjyaW/OgXmb51Z0nwasqh9vOlzuLus/9MzPj41CVHMl/dr
         6meJMLAm301+CQjcnPaBlZoPJQ2X9Nj/vwBBSF2wdQzelkEN4VPjMsU5oEJ05UuTSeFt
         ll7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x8rmdkWGaNSAAKS1Rht2YAiWK6qZfOhVMnyURYJPtE4=;
        b=ZsvoG0rAz0J9keZThb3z68LpHe9m24I0+9jftef+j2LGgAKxKT4LuMg4Q2ZsyNBRuw
         WY3Koh+EuQASHn2MvJX7JIv5nsfYYyOCSgbX/XZUv+aFf5hQpg1xZrCNbOebdnBYct+o
         8SsGnjBTtl5C1AOOWZpzSyc8baEILC2Szpb6LSSnObFSFmFNBMJX+s63paLSsYY0+SEG
         hsI69Eq4cA6nK2ttsou3ouxSVx65UM2KvkaU5O1TbeccjqYLdzY+9bNuOskBIq2qWpO7
         kvmLhGIn1KwA7T4UJKLWel+/tk1+p5fWbOepSw4mOZkBQHgCqPgCbuGfAep6DLhcWqLd
         fJ5w==
X-Gm-Message-State: AOAM531wV0c/TPNbp4/lSJjNqaOJ1wWCQkZSpMKuFmnWtzTPk64BEoNS
        W5drcrUYouhs625q1h3d7XYnbg==
X-Google-Smtp-Source: ABdhPJz2atUBKDt2XWGv+sGLHRkW7w8cjxkE8ZT/jRvQufHi+UE/+RH+UZ1rLgJThL+TCVRPnOo23Q==
X-Received: by 2002:a05:622a:1114:: with SMTP id e20mr23720901qty.279.1638568428762;
        Fri, 03 Dec 2021 13:53:48 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d13sm2837509qkn.100.2021.12.03.13.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 13:53:48 -0800 (PST)
Date:   Fri, 3 Dec 2021 16:53:47 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, larsxschneider@gmail.com,
        peff@peff.net, tytso@mit.edu
Subject: Re: [PATCH 01/17] Documentation/technical: add cruft-packs.txt
Message-ID: <YaqR64y0ddWOhHjP@nand.local>
References: <cover.1638224692.git.me@ttaylorr.com>
 <a9f7c738e0ffbc5cdedc26768a0623446c98d239.1638224692.git.me@ttaylorr.com>
 <df8990d5-98da-a05c-31cf-d3f5ce33f498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <df8990d5-98da-a05c-31cf-d3f5ce33f498@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 02, 2021 at 09:33:51AM -0500, Derrick Stolee wrote:
> On 11/29/2021 5:25 PM, Taylor Blau wrote:
> > +Notable alternatives to this design include:
> > +
> > +  - The location of the per-object mtime data, and
> > +  - Whether cruft packs should be incremental or not.
>
> It was not obvious from this sentence that "incremental" meant that
> we could store a number of cruft packs and use the mtime of each pack
> as the time for all contained objects.

Yes, I think I meant "incremental" in the sense of "incremental commit-
graphs". But it's clearer to say "storing unreachable objects in
multiple cruft packs" (and then giving an example later on). Thanks!

> I think what is hidden underneath "significantly more complicated to
> construct" are situations such as "this object was in an old cruft
> pack, but then became reachable, but now is unreachable again". I'll
> try to remember to come back to this after seeing the situations you
> cover in your tests.

Yeah, I'm being deliberately vague here, since the aim of this paragraph
is to illustrate "this is much more complicated than what we implement
here, and the trade-offs are..."

Thanks,
Taylor
