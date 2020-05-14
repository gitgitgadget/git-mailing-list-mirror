Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F121C433DF
	for <git@archiver.kernel.org>; Thu, 14 May 2020 21:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FD1020709
	for <git@archiver.kernel.org>; Thu, 14 May 2020 21:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589492649;
	bh=+CcYoYdOldWY58kzRBLt2sPGyn1lrMObIl7FqUQBbNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XzPaK7ChyHTBdgiCfnDOc1ssjyQialQ3WG+dodR/DX0rCOQ+rxsG5wJKqrRFUClPE
	 eE/cMtW8vqiUeHlIN555fwlwmixpqe9KkNZ1RMcYVTKQwE63kuawsQ8gjkLot9yrM6
	 6Jnvziwb6Y1reLvJEbIvZYkZjeHcYj3FzTW/uGIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgENVoI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 17:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgENVoI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 May 2020 17:44:08 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D3BC061A0C
        for <git@vger.kernel.org>; Thu, 14 May 2020 14:44:08 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id c24so215855qtw.7
        for <git@vger.kernel.org>; Thu, 14 May 2020 14:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=hK6oT78mwvvhsz42Fb4+39nSuM4JQG2VukH+ACxjVNc=;
        b=NlNNHyl6wypqNjO5mJnDAiAne2TZrvh3Sy8tMVNEB9YMaANMuMaBWnqVL9QzHqerKU
         TAGbB/u6fyQzOkkIQ0H0gC0GtdvWbl6vf3UKT5OyHjsSHuPzS0aKMkWW8uMIG42twKX/
         LrJ62n3Os9zrZ0Tzm382oAJRgLE8femy5T5Es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=hK6oT78mwvvhsz42Fb4+39nSuM4JQG2VukH+ACxjVNc=;
        b=OdlfCfkwsp6TfIvkVGdm4k8ThjzO29MVKPD8Ft0vmc4qmkkF7hl1mDSBe8hnq3/A7G
         DXxIf30Bh9UojVrrogoZbiKFiTyhCdGnziRLd4aIRtyv5uZ79gwFtAlTLA/qwMRFW5kG
         guXS+tTvj53Wapb1b6KSDrbZmDBTydP9cLyLMvx2kwjrSq1tPA9ll75e9df+Jy9LoCsM
         BM395gukGGUQITtvGiLJQy6+bia5fMSnIzWkWRF28Na/tg22z1ge9Uurnrp4EQGHivjH
         /b+Ir0AMNbyF1MaNhY+DTa1va9y4S7D8xnQo6KIS0qrx7DwVzYphAniu9RzdQJl5jd4p
         NI7A==
X-Gm-Message-State: AOAM5321/rvJKHDkfaEbeuKKXBhcM+Llbmf2E2Bnpmbd3xMKQKy1e/he
        l6UKoeoR+gLli661ip5UewbTUg==
X-Google-Smtp-Source: ABdhPJyOYW3DfT5X+9uhPE6P/ROr3VHG0futO6yZxmkRYgzsaOlYLhDKKdN7BSfSlcdXv0YBNG+b6g==
X-Received: by 2002:ac8:70d:: with SMTP id g13mr258340qth.91.1589492647253;
        Thu, 14 May 2020 14:44:07 -0700 (PDT)
Received: from i7.mricon.com (107-179-243-71.cpe.teksavvy.com. [107.179.243.71])
        by smtp.gmail.com with ESMTPSA id d63sm120047qkb.52.2020.05.14.14.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 14:44:06 -0700 (PDT)
Received: by i7.mricon.com (sSMTP sendmail emulation); Thu, 14 May 2020 17:44:04 -0400
Date:   Thu, 14 May 2020 17:44:04 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, Caleb Gray <hey@calebgray.com>,
        git@vger.kernel.org
Subject: Re: Add a "Flattened Cache" to `git --clone`?
Message-ID: <20200514214404.bcbjskgi52bwedlh@chatter.i7.local>
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Caleb Gray <hey@calebgray.com>,
        git@vger.kernel.org
References: <CAGjfG9a-MSg7v6+wynR1gL0zoe+Kv8HZfR8oxe+a3r59cGhEeg@mail.gmail.com>
 <20200514203326.2aqxolq5u75jx64q@chatter.i7.local>
 <20200514210501.GY1596452@mit.edu>
 <20200514211040.a7hrirdzgkphx3la@chatter.i7.local>
 <xmqqr1vmp5wf.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr1vmp5wf.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 14, 2020 at 02:23:44PM -0700, Junio C Hamano wrote:
> > I think something like git-caching-proxy would be a neat project, 
> > because it would significantly improve mirroring for CI deployments 
> > without requiring that each individual job implements clone.bundle 
> > prefetching.
> 
> What are we improving with such a proxy, though?
> 
> Not bandwidth to the client, apparently. 

Well, if it sits in front of the CI subnet, then it *does* save 
bandwidth.

Here's an example with the exact situation we have:

- the Gerrit server is on the US West Coast
- the CI builder is on the East Coast
- each CI job does a full transfer of the multi-MB repo across the 
  continent, even when cloning shallow

We solve this by having a local mirror of the repository, but this 
requires active mirroring to be pre-setup. A caching proxy that could:

- receive a request for a repository
- stream the response back to the client
- cache objects locally
- use local cache to construct future requests, so only missing objects 
  are fetched from the remote repo regardless of the haves on the actual 
  client...

..now, that would be kinda neat, but I'm not sure how sane or fragile 
that setup would be. :)

> I thought that with the
> reachability bitmap on the server side with reusing packed object,
> it was more or less a solved problem that the server end spends way
> too much time enumerating, deltifying and compressing the object
> data?

Indeed, it's not really solving anything for this case.

-K
