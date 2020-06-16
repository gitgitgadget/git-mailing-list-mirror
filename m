Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FC5C433DF
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 12:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33D1220B1F
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 12:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592312062;
	bh=MPHV/qYozFHobJuZ8gvaaBDF2VE9YtQvJh3ZtxbS0xA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Vuo95fP+4rVuAYFWi8BVevoWqOFmeu5T5qK2/VJduXc2KWHNorRNcQHjs2IzKzhHn
	 qC4Z0e57oBAno4gRYBAxE6xNbM2aTVAfyLrm8FqBI3Ku0X13pJ230+Mv0XIb97QW/L
	 1Y1RQjQYTyyphfCrrVOOPBlcc2eFoUCpA4r4JmcE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbgFPMyV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728549AbgFPMyU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 08:54:20 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A50C08C5DC
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 05:54:19 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 205so18956900qkg.3
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 05:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8Ptb0SicKqYVkJ3ZdnHwM4W9ej1qZ/A/ggCsnCLiT9s=;
        b=RD98PG/kfYKwe8s9FCDxaMRC9bbw6riBhaRkmuPrVDRk/OLffNVtTUCdpmsqGFgMx7
         MIJufooD5xOfUa6BEX+onkSwJWAb8w7j+wlANUNzncjc5esVV81wvhrsDYsISt0xh0Gs
         4FhJbgSiaesMkihtqJwHPXz262AuxxkESiHF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=8Ptb0SicKqYVkJ3ZdnHwM4W9ej1qZ/A/ggCsnCLiT9s=;
        b=N5SZbA8kFUIYnSbTDVEGqlrgY1aClP2EaxxG7pOCfQJFWyzDBoTqycr04fNN4ypkaO
         gBGXQTPSTFrwnXWLDknyzqkvCQ/j+4ZI7mN63cXamr4v0jK97nhFMHNHSMvptrejoydf
         1GYAI9Bjufyul5WiGpeZR7oaJV+i3xZ5AQbPn43OCAIbcGFrBBOzkyG2JIHa5wNO781U
         OG+2tZTHVZcC2KVuDTRvf7aupDTYIvd8Pew6UKXF2aMrH8WY147RWqKfh1kZE1rpxPvc
         a0NFM66pyOBuJRWIfRMjfrfIZg/orkX/Z/EPJt3gKtO6q0TVMh0JDtPn1gk86ftTTp/o
         PjXA==
X-Gm-Message-State: AOAM532vMH53LAKIDssFZSGEM3asXKy7ppWYnRV5aprUAepJcRnNjCNO
        atP9nHFtjCjnJkD/BwuyJN1mjQ==
X-Google-Smtp-Source: ABdhPJzIfaiY9sQmWwKGe6BSqX8YWSlJ3uKMDchgGeHwKaX+EE3zxrhg7GzzfvjJi9uQT6UuDUIq8g==
X-Received: by 2002:a37:aa87:: with SMTP id t129mr20260961qke.197.1592312057930;
        Tue, 16 Jun 2020 05:54:17 -0700 (PDT)
Received: from i7.mricon.com (107-179-243-71.cpe.teksavvy.com. [107.179.243.71])
        by smtp.gmail.com with ESMTPSA id h77sm14474029qke.37.2020.06.16.05.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 05:54:17 -0700 (PDT)
Received: by i7.mricon.com (sSMTP sendmail emulation); Tue, 16 Jun 2020 08:54:15 -0400
Date:   Tue, 16 Jun 2020 08:54:15 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Abram Wiebe <ethanpet113@gmail.com>, simon@bocoup.com,
        git@vger.kernel.org
Subject: Re: Rename offensive terminology (master)
Message-ID: <20200616125415.xnnxp5jnlkszorum@chatter.i7.local>
Mail-Followup-To: Jonathan Nieder <jrnieder@gmail.com>,
        Abram Wiebe <ethanpet113@gmail.com>, simon@bocoup.com,
        git@vger.kernel.org
References: <F17A9CF6-E020-45BA-863B-D85F098691B1@gmail.com>
 <20200616002313.GC164606@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200616002313.GC164606@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 15, 2020 at 05:23:13PM -0700, Jonathan Nieder wrote:
> > We run into this kind of issue in software all the time, which is
> > why you see packages like PHP deprecate interfaces… but then still
> > need to keep them around for decades, simply out of fear of how much
> > would break if they actually took them out.
> 
> You might be comforted to find that the series at [1] allows
> requesting the previous behavior by running
> 
> 	git config --global core.mainBranch master
> 
> If that does not work in your setup, we want to know.  This same
> setting also allows tooling authors to experiment with the new default
> early.  Hopefully this can be useful.

In fact, distros and images can set this in /etc/gitconfig to set a 
distro-wide default.

-K
