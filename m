Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F374CC433DF
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 19:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B81FB2071A
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 19:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592161445;
	bh=EBjoRxHR1RCu4Cj1Byj5nZXM8e7rXvuvBeG3plFmGNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v6IWuMK1nYWJ/qEFFcZ27lDTg9XSSqQQKMYIh794a7aZlNzV7r6tzu5bQvqcvD01h
	 EhDXuhTXVvj22PePqaHA7AG3Y5PgIyYu+j25lyzspYbOuKm3QQM9ua2WRV2nZmvwr0
	 JLZ+53/diMauptk2IarOd3GbC9Nnm+m/CXvLDVhM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgFNTEE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 15:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgFNTEE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 15:04:04 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E19CC08C5C2
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 12:04:04 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id g62so10989628qtd.5
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 12:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=E/xvbACT699S5qrPyDzzUyGZSot3hnkgkc1RnFxhEsI=;
        b=JoAvQV7RuSSSZ72SX9tBf0h4HN1eZ9ntfQIYcTkKibZ1e6EfRI/0Dkt15nMFPaRnCI
         WTxb47VgLJ/8Pbj0/ZcUXviIRFEoxbXivouZXXsIj0o57Rv7FSe67eFdPX8chqkbcWql
         3KUEb918sVvNPaSSAN/Iys4DKgorrxTaHf3hU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=E/xvbACT699S5qrPyDzzUyGZSot3hnkgkc1RnFxhEsI=;
        b=JlDcVIOAygSzrf975Fcm4mjvPXgRLZ3+J5Y9q9iwKoHbWoq/R4KaxHyqX+TCxVtKnJ
         O94+Kj+hQphovDZg/KIC4nilLWwA8fUAq6uLrjeWWjJlZgRYaum1WQEjPnHO1peNWNnO
         AxOLfZvM+iaP9z0HWeMyk5bzsbwpot3wM4SdW8r3xo0ZHsbms4v/rbbuhINmBHH7yI76
         veKLPwd5FHZjzAJDEWy4MBbyOHxyy1sKE0zduJgMdj1jCw2kViMkwzm+RLUwTWsHW2Pv
         EFo7vJWFAMojFAA/xmWngQWglhNg0DlhS4s4EmRZdFg9SGqilRO4jqogFsvNoZxAhXoX
         WtWQ==
X-Gm-Message-State: AOAM5320pT9+A5JJgFYWEyaJoGa0l3MWTZHRk5jSGvKKxSv9pKTiqImX
        hzhuW4vR3YA4RGbLDoPag5tWxg==
X-Google-Smtp-Source: ABdhPJybiI0QynmmMazHTNUAVHL9Gc+Rjj1qQHq9DWdabPgP7EZWnbq6/O+gJGSk4j00FAurBFxuDg==
X-Received: by 2002:ac8:9c:: with SMTP id c28mr12430570qtg.3.1592161443111;
        Sun, 14 Jun 2020 12:04:03 -0700 (PDT)
Received: from i7.mricon.com (107-179-243-71.cpe.teksavvy.com. [107.179.243.71])
        by smtp.gmail.com with ESMTPSA id k34sm8647299qtf.35.2020.06.14.12.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 12:04:02 -0700 (PDT)
Received: by i7.mricon.com (sSMTP sendmail emulation); Sun, 14 Jun 2020 15:04:00 -0400
Date:   Sun, 14 Jun 2020 15:04:00 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     =?utf-8?Q?S=C3=A9rgio?= Augusto Vianna <sergio.a.vianna@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, don@goodman-wilson.com,
        git@vger.kernel.org, msuchanek@suse.de, newren@gmail.com,
        philipoakley@iee.email, sandals@crustytoothpaste.net,
        simon@bocoup.com, stolee@gmail.com
Subject: Re: Rename offensive terminology (master)
Message-ID: <20200614190400.bk22inkkz2w6f2sg@chatter.i7.local>
Mail-Followup-To: =?utf-8?Q?S=C3=A9rgio?= Augusto Vianna <sergio.a.vianna@gmail.com>,
        Johannes.Schindelin@gmx.de, don@goodman-wilson.com,
        git@vger.kernel.org, msuchanek@suse.de, newren@gmail.com,
        philipoakley@iee.email, sandals@crustytoothpaste.net,
        simon@bocoup.com, stolee@gmail.com
References: <20200614181906.u42tuny3eipvhd46@chatter.i7.local>
 <b82bdf57-840d-f9c2-0e42-95a93d9336b7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b82bdf57-840d-f9c2-0e42-95a93d9336b7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 14, 2020 at 03:23:29PM -0300, Sérgio Augusto Vianna wrote:
> Ok, can you show me a single instance where "master" was confusing or not
> descriptive enough? 

I just did. "Master" is not descriptive enough because it implies that a 
branch with this name carries some special status over all other 
branches, whereas in reality it doesn't. It can contain junk or be 
missing entirely. Therefore, having "master" as the default name is 
misleading.

> Mind you, this all comes at the expense of a lot of
> friction in the LITERAL WHOLE WORLD. Bugs, stuff breaking, incompatibility
> issues, you name it. And let's not forget that people already have all the
> tools they need to NOT have a master branch if they don't want to. 

Well, then nothing really changes then, does it? I don't see why you're 
so upset over a change that, as you say, will literally impact nothing.

> I think
> half dozen people can spare a few seconds instead of wasting literally
> everybody else's time fixing their respective software.

Nobody should have to fix anything. If you already have an existing 
repository, then literally nothing changes for you. If you create a new 
repository and you don't like the new default branch name, it will take 
you no effort to change it to whatever naming convention you prefer. We 
are giving the community more choice instead of dictating the default.

> Also, literally no
> one cared until americans went hysterical with the death of that guy in
> Minneapolis.

False. Efforts to remove the usage of "master" traces back over half a 
decade, with many projects having done so many years back (Python, for 
example).

(I am deliberately ignoring your inciteful tone, but I would greatly 
appreciate if you don't use it again. I have all but run out of cringe.)

-K
