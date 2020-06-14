Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CEFC433E0
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 18:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76A572071A
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 18:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592158751;
	bh=rMTbIVlXVIxiGutvBIhIGgpkYwzjghxX3NwgQvyS/Sc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jK9dycr59ijqwmRYrenCqL55H5/d37kGBd5Hsdcou0cgpRxUL3eTEqgqlAo7Z+qGX
	 zPEOPDiu7gGvKgk0uUwxC57oMv9hWi3yPPr3Yqoj19O/6pVrf9r0Mq2UGTfCIhWZr0
	 Vv61L9vaLDUiQMGQShQBf4ZXFcil1RT8sCgMXKbg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgFNSTK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 14:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgFNSTK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 14:19:10 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3208C05BD43
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 11:19:09 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id n11so13705132qkn.8
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 11:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8t7REWkLSb/k/7KsK3GRoSzg7QzPeFhfK1aeJFbvzrs=;
        b=UblrJFomkf0orhEjXmlcz4NKWUka5TQZpazuuR3suOAXgaGMeO6E85BsnSq8DlPXTW
         LW8IIjEZaiziqJaZ9EREMqD+SZafUM1dT6RaH5RZ87hRk+qvGNx2jFksFD481U7dMmXF
         13Je5GrorO28pb4Oy/YZYfyon3vC+A1L5h6pw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=8t7REWkLSb/k/7KsK3GRoSzg7QzPeFhfK1aeJFbvzrs=;
        b=Qx3VUduh//l30lXcDlNItOiM93xn6dw/fOLFJSy4ygFIXk2CfJnO7tzTW5J+11XCXh
         QH1aij1g/kpHvSpb38miFY4LjpNdcK0o4Z8YpAHevcNejlSC81WEcDVxnISWIpBmhqSb
         BjNYHapZHrIA3nZpBVLc3zc9aHspG5raScQ3NlqmCnwdQj6x/Na7RFqe3r4uUj3Npa6x
         M/zgkgEUCOzU+xapbskK6JaaUdkgToSyRo58Q2J1v2fRv8UbYycZFC9vc6/Dc3lqSvk9
         VSgg90svOy6FMkyMo4BjekcwENeQLvBJQKJf0OV/3Gz5IrkS0PxdqTDhcV5Iu43gdlSl
         pknA==
X-Gm-Message-State: AOAM533lVQe47SLwfectXEg9bXUqtOcReu5lKsMQrcEbIxeOfGCxojzG
        c3R1BcCGavIxZdeGoRFWEEC9jQ==
X-Google-Smtp-Source: ABdhPJwNAtSOovY0El7oDOaPZYiUhTvKp3A+GASL4cHrA3aC+eYVCYg3D0VxAgmDtrjygDjEo1XL+w==
X-Received: by 2002:a37:a152:: with SMTP id k79mr12766307qke.144.1592158749045;
        Sun, 14 Jun 2020 11:19:09 -0700 (PDT)
Received: from i7.mricon.com (107-179-243-71.cpe.teksavvy.com. [107.179.243.71])
        by smtp.gmail.com with ESMTPSA id o144sm9227628qke.126.2020.06.14.11.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 11:19:08 -0700 (PDT)
Received: by i7.mricon.com (sSMTP sendmail emulation); Sun, 14 Jun 2020 14:19:06 -0400
Date:   Sun, 14 Jun 2020 14:19:06 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     =?utf-8?Q?S=C3=A9rgio?= Augusto Vianna <sergio.a.vianna@gmail.com>
Cc:     philipoakley@iee.email, Johannes.Schindelin@gmx.de,
        don@goodman-wilson.com, git@vger.kernel.org, msuchanek@suse.de,
        newren@gmail.com, sandals@crustytoothpaste.net, simon@bocoup.com,
        stolee@gmail.com
Subject: Re: Rename offensive terminology (master)
Message-ID: <20200614181906.u42tuny3eipvhd46@chatter.i7.local>
Mail-Followup-To: =?utf-8?Q?S=C3=A9rgio?= Augusto Vianna <sergio.a.vianna@gmail.com>,
        philipoakley@iee.email, Johannes.Schindelin@gmx.de,
        don@goodman-wilson.com, git@vger.kernel.org, msuchanek@suse.de,
        newren@gmail.com, sandals@crustytoothpaste.net, simon@bocoup.com,
        stolee@gmail.com
References: <9d3d3888-55e5-61f0-1541-9854a70fb233@iee.email>
 <d020d05f-5e36-2959-3eae-d7e21bf51178@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d020d05f-5e36-2959-3eae-d7e21bf51178@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 14, 2020 at 09:20:20AM -0300, Sérgio Augusto Vianna wrote:
> There's nothing to be resolved because there is no problem. If someone reads
> "master" and gets triggered because all they can think of is racism, that
> person needs therapy.

Well, to be honest, if the software was written in German and used 
perfectly innocuous German words for "leader/worker" (fuhrer/arbeiter), 
I'm sure a lot more Europeans would get "triggered," as you say. We are 
not some kind of emotionless species, so historical connotations behind 
words do matter -- so it is not a "waste of effort" to have these 
discussions.

I support moving away from "master" for the default branch name -- and 
that is regardless of the negative connotations behind the word.  
Frankly, the word "master" is not very descriptive for the default 
branch name:

- most English-as-a-second-language speakers don't know the meaning of 
  "master copy," so even if we stick to this interpretation of the word 
  "master", then it's obscure and arbitrary to most new users of Git
- having a branch named "master" is already not required, so any 
  existing software that expects there to always be a "master" branch is 
  already broken and wouldn't get any more broken by the move away 
  towards more descriptive terminology
- as it stands, the "master" branch does not have any special meaning 
  anyway. It may or may not exist, and even if it exists, its contents 
  can be arbitrarily stale. You almost always have to check which branch 
  you want for your needs, so the implication of "master copy" is 
  largely meaningless in many workflows anyway.

Grosso modo, I see having a more descriptive branch name than "master" 
for the "default branch" as an improvement for the project in general.  
Making this configurable should assure full backwards compatibility to 
existing workflows.

-K
