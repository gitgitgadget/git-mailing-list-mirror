Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 008E91F462
	for <e@80x24.org>; Tue, 21 May 2019 01:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfEUB5H (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 21:57:07 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:46842 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfEUB5G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 21:57:06 -0400
Received: by mail-pf1-f178.google.com with SMTP id y11so8144252pfm.13
        for <git@vger.kernel.org>; Mon, 20 May 2019 18:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6HkRfN2a34HgFNVcGKxl26gE6EFW3uIBoubwbxhnkqU=;
        b=AEovMzk5jmzsktCOmI7S9mlpMXVdF7jb+CwHEOgiEdPeP8nNZFdiCGkRKN9++2VXpm
         XKfRIcNll4LCaiMnbbx6KHMJG1L+wDM4n4EBKoYzy1KR62Y/excV0svs2OSPQeT94RpL
         xVZFOEXS+urQnt1NKPqHY7T/pD3NfkLI+kqusYjOf5+OZJiCzZWoBnxA1hvNuEcYMQbP
         FsQCf0UOf/7l83Tuk7MRs5PVo7ujrR2Qp2vkzAKPx7t8B3UAxlLYa1cfOz82pYPlghJM
         FHrTQatEuLt9SFVDDTD9+xp/HMsW6fXv4jPlD7w7A1UXZF/H/udUve9pu6AlQbeOcOZ6
         Mqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6HkRfN2a34HgFNVcGKxl26gE6EFW3uIBoubwbxhnkqU=;
        b=LXq/xgXXi0g1PsqOa7qZGFppWpYN59TPtrnsSmI6riqRtCeJV29Xl+atlCPdNhbn8w
         D12eEYqYr4KnMrUUQpVwqO30RraBiMDhxEpaW3cqDl0PN/4NxnVACgVDiA+0WKdbm69/
         QiZQs6TFEAvklset11R6Mhvz+uAG3fy/pWbgSw3nNL9hpksJeqaNW/E4o3wymzY+9Fxf
         zhQccU8bBpNTgi44WmhvhszMbvykmkcjOFQCzECmQ6OY7kXtyuFdEfDID1yM8r6ECOa7
         fozybJoS6gPHR+eYM/sRZnLynRXqadNwxXZF6UpL0B/9rcHj7EWvhHj2rDMBIdHxVgfb
         J/Bg==
X-Gm-Message-State: APjAAAX54PHulaYHbttPMUPNEb8MJDlLG84hwAshRVGxj3GfkofVpvjZ
        p/vXNSME4ZOuA69/pjAfyekFE2zR
X-Google-Smtp-Source: APXvYqzj+53pj1Z1vIk1D8+XN77/4/ZSesTyM8kblMK7eUPVWhXpnIlCjiR2wx1FQBqg3+ygBj3XNQ==
X-Received: by 2002:a63:7989:: with SMTP id u131mr70053853pgc.180.1558403825806;
        Mon, 20 May 2019 18:57:05 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id a18sm30704991pfr.22.2019.05.20.18.57.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 20 May 2019 18:57:05 -0700 (PDT)
Date:   Mon, 20 May 2019 18:57:03 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "Eric S. Raymond" <esr@thyrsus.com>
Cc:     git@vger.kernel.org
Subject: Re: RFC: Separate commit identification from Merkle hashing
Message-ID: <20190521015703.GB32230@google.com>
References: <20190521013250.3506B470485F@snark.thyrsus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521013250.3506B470485F@snark.thyrsus.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

Eric S. Raymond wrote:

> One reason I am sure of this is the SHA-1 to whatever transition.
> We can't count on the successor hash to survive attack forever.
> Accordingly, git's design needs to be stable against the possibility
> of having to accommodate multiple future hash algorithms in the
> future.

Have you read through Documentation/technical/hash-function-transition?  It
takes the case where the new hash function is found to be weak into account.

Hope that helps,
Jonathan
