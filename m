Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2880C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 04:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FA7A61250
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 04:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbhHWEGe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 00:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhHWEGd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 00:06:33 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059B6C061575
        for <git@vger.kernel.org>; Sun, 22 Aug 2021 21:05:52 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id b4so6255297ilr.11
        for <git@vger.kernel.org>; Sun, 22 Aug 2021 21:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PCj0Jr9c59k4V5wzqLUxAnrC5EuJtI46edfSATTvJc8=;
        b=wsJhKzbpal75xK2DnDiNVpIX1xCkqegleWkTpO2qPoCjTuSJEtCOXEZ+kbDzA3NLEj
         HxP7B4DpqtOyQwuLeLTELI4ypy9ukjM6KOXivZ54AF+x33gGLcA3m5INlNF3Iud40zdl
         yUEy8je3ZFR1vrWGwZbGZ4h+PhkFBmgzhMXpFTGWQZXHKAbAXmxQGhBflXeBmykml15P
         UzA14gdd7WeUjl1k3l9M0laU+Y19Qa0roHwerTQQdh5Kb+6B2Pd0k256OQVbFn2woqMO
         9Ny+vaAbBpecs1gi+RZppFldMRbNemUPbikz4LhqwZPSF+9yT2G0wMskW7sR2WxL4ZfX
         A8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PCj0Jr9c59k4V5wzqLUxAnrC5EuJtI46edfSATTvJc8=;
        b=Rn5ap0k8WwieMAwBGq/br2bq79nF5cp9VhNl7ILvKzqpOHXjITgFc9IUe9VQBJN9l+
         cAq6EWWlG+yy7NpueZNyySKWAnOcH0Qu0SjpEl5xDo+wSq7lDyF9/7WXAhU3duNG0Wqg
         qtX/K7DCqh7NQrXu1qn62f+MCjsm/1l/Cmqwe6rX9bJNXBoKKEVLP7KVmOSrX0Kv79Q0
         GSh5v0ZrtBk4VikOlHhNwSTMGZKsPXAktvbQQ/c68AJwTuO++cBEd+vyJW6+TXyBLtOU
         tiNPFZrMfqrjB03S2J/QRFvzcAnxeFIP3XwkOaWwz++DDKxam/KKDwyvxfCiX8xPIYSD
         6V1A==
X-Gm-Message-State: AOAM531j1RFzX5ZQVCwJwU4S3JLdipT9gzejenhUKS/wL5nrDfsNfh3n
        CKQLE68A81mVeH0S1ricxxxJJg==
X-Google-Smtp-Source: ABdhPJwN+GnYkLsd/6XrFXKfwIhjXyV5ekAhTrKxGznHqZuc31V1tIAp06e7CwlfNd5SwMV3BRGPPA==
X-Received: by 2002:a05:6e02:2145:: with SMTP id d5mr21331803ilv.23.1629691551226;
        Sun, 22 Aug 2021 21:05:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d8sm7131946ilv.55.2021.08.22.21.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 21:05:50 -0700 (PDT)
Date:   Mon, 23 Aug 2021 00:05:50 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>, git@vger.kernel.org,
        bup-list@googlegroups.com
Subject: Re: [RFC PATCH] multi-pack-index: allow operating without pack files
Message-ID: <YSMenndGYr14okwv@nand.local>
References: <20210820195558.44275-1-johannes@sipsolutions.net>
 <edb9c412-70c8-4fc6-04ab-417eca05ee15@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <edb9c412-70c8-4fc6-04ab-417eca05ee15@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 22, 2021 at 08:34:43PM -0400, Derrick Stolee wrote:
> On 8/20/2021 3:55 PM, Johannes Berg wrote:
> > Technically, multi-pack-index doesn't need pack files to exist,
> > but add_packed_git() today checks whether it exists or not.
>
> Having a multi-pack-index is supposed to indicate that we have
> these objects in the objects/pack directory within the specified
> pack-files.
>
> I understand your goal to relax a condition of the multi-pack-index
> file, but it's triggered by a flag during write and that choice
> isn't persisted into the file. There is no way for a later Git
> process to understand that the multi-pack-index doesn't actually
> guarantee object existence.

We're going to run into problems much earlier than that, though: the
MIDX needs to load information about objects from packs in order to
break ties when multiple copies of the same object exist in multiple
packs (according to that pack's mtime).

So I'm not sure how we would even write a MIDX without physical packs on
disk that we can open and stat, let along how we would teach Git to
handle a situation where packs that did exist when writing a MIDX went
away when we tried to read from the same MIDX later on.

Thanks,
Taylor
