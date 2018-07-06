Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19B4C1F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 19:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933909AbeGFT6S (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 15:58:18 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40312 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933738AbeGFT6R (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 15:58:17 -0400
Received: by mail-wm0-f65.google.com with SMTP id z13-v6so15436259wma.5
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 12:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zWiHpmuGoRvqzWc5zuEp4IP+ZtLBB6hkzmfas3OsFG0=;
        b=XCqYr7x18/VU5I2bYeB/QjoR0Vzqsze30gC9IxdOBn2qRywEOIHPJZdwwtnu1lcsYH
         oj09lEgpBiGDkM4keMTDWEwkuhll+NJ/YHnDTQfCiEZuaCZshtW3aNWrE15MGikxsyhk
         3We1QRGk2Axn9/B0qI/r9rkj/qHJK+SCy8CQ8hzFykqoMPkq9PcIN7IbrL23IQPpy1kG
         vqQzwqIWiC010AgRCOuVAgX+TuTZ7JT8nJxqaMTN7iEksMjOkpGNo2AvpyQZ46CqXY/2
         wefI+6N4A2KWINuvvfpbG2iarddR+3aFHaUn/F0EPEO5C6QzyKlf6nliKPtuYTAfrYaU
         mSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zWiHpmuGoRvqzWc5zuEp4IP+ZtLBB6hkzmfas3OsFG0=;
        b=IHel092t9cvxSsRo+jZhiS/IlqozS7B0AYKX8CFJkdqV+f0wZ+Qu/nR1O344bsUjlS
         6OgtXpRsPXYxzMRKOM2742DZHQjmyUedhdU6qrVBwM5FAiRwUXzpsLrAUMP0ugCspxRs
         9tWTcc4JTJgHFvDnAeVoMawh3Wgd5GxqD++pjEl5vbh0ugdZfZ57UTbx9J5/6U0inOTO
         +mSvkgsfrlL6IAR7M76YMtkSFD5fnUhdJwFGKjln58vvIy7q6TIVptOjYgbr/CO1UEwA
         K26MldHZzMOUnFCxlEOep3Vv2gP9iZNEbypILpuGU+gqyyasLZfPOfQJa7JBgGodGywv
         HPaQ==
X-Gm-Message-State: APt69E3hmTcGWqItJVFM4w2mtlSg86FWsnN328ggUzv+PrxbP3lW9ua2
        ESQafe7Ma+xIxiSg7jhtwxw=
X-Google-Smtp-Source: AAOMgpcxLon9tQw6HnPfvUothCt7NmiWhIPwRGtvCyE1fKoP8oojr+s8XflNA3NJYawZ5iZGYrbx6A==
X-Received: by 2002:a1c:b354:: with SMTP id c81-v6mr7781231wmf.149.1530907096093;
        Fri, 06 Jul 2018 12:58:16 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r140-v6sm17738472wmd.27.2018.07.06.12.58.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 12:58:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Henning Schild <henning.schild@siemens.com>, git@vger.kernel.org,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/8] gpg-interface: add new config to select how to sign a commit
References: <cover.1530616446.git.henning.schild@siemens.com>
        <9bb55c019c3bc025d77d9d491818e442233bf8d3.1530616446.git.henning.schild@siemens.com>
        <20180706010148.GA7697@genre.crustytoothpaste.net>
Date:   Fri, 06 Jul 2018 12:58:14 -0700
In-Reply-To: <20180706010148.GA7697@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Fri, 6 Jul 2018 01:01:48 +0000")
Message-ID: <xmqqo9fkjfvt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Tue, Jul 03, 2018 at 02:38:15PM +0200, Henning Schild wrote:
>> Add "gpg.format" where the user can specify which type of signature to
>> use for commits. At the moment only "PGP" is supported and the value is
>> not even used. This commit prepares for a new types of signatures.
>
> We typically prefer to have option values specified in lower case.  I
> also think "openpgp" might be better than "PGP", since that's the name
> of the specification and it would avoid any potential unhappiness about
> compatibility with PGP or trademarks.

I do not know about trademarks, but the suggested "'openpgp' in
lowercase" sounds sensible.  Some people might even favor doing
strcasecmp() on the value; I do not have a strong opinion on that
yet.
