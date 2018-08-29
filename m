Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B4A81F404
	for <e@80x24.org>; Wed, 29 Aug 2018 21:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbeH3BQt (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 21:16:49 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40754 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbeH3BQt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 21:16:49 -0400
Received: by mail-pf1-f195.google.com with SMTP id s13-v6so2836442pfi.7
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 14:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=00Vk/bKli9dWEf/fJppsxkgeOgHExsAJTvKqB3jxvp4=;
        b=fKMgcQlVYkjfJz1gTxMSyEO7+hoZwE4b70oG0bMF52i3Ed1Qwo3KVbSsF77UITCMFD
         MBlBj2Y/WoWin6y88SvGWp6PYteUJhwfyap/EhaPk1BfsgLZFYepKD0paQGmFcjdgD/3
         Hdy3HHPjVr968KZj/jvL/GwwZOQxRM0ABi+DCm+S2NXSwaymF+F4q655Hcb4BBzKa2wP
         BDX4Xf+7jbQt4rBBAO3BWu68Kzi7kUvhO/5sU21Fl0zqHgSiDnVAYOmxDGaP5j7r1XW0
         OfuDWHZYpsMcRM0pn8dMzHb0MZL99PUHCqk+adfc8/c3C/zJh5+d1I4Zx/Awq/VFxb6x
         mQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=00Vk/bKli9dWEf/fJppsxkgeOgHExsAJTvKqB3jxvp4=;
        b=cWHviEsQO8rKNIkyzcKw9kfeqr+nLbBK1Wtd6/h99Aj6xxX965Ncqp2yLNAmQywkLD
         y9v9z0q2Fw9igonYy6CWmu72Y4tYGHljunQ0zKrKyBZhIHkFzbGZZXpTjs8t1xc2DvyC
         uz3tbd66pQHfzujwpC/ywnEXrwHld4Ke9aJ0lWaCEqJSaLRXDBvSJjXwlqsSybUQXJdE
         oKn0Wnoy4yuB5TTBxjUdqZVwxlKmn2KBunG5iHHTuZ5nG4lzt+jIGO+bgQWV2ILSR/8S
         a89wz5yD+0tm8O6GBh5QMaoK7FqOIaNoskV0vhUS8iufXu3xy3PVhELD0ZpJubCFYDH8
         BZSQ==
X-Gm-Message-State: APzg51Daoaz8KaTLU7UrdvJum/5lFi84n2b/bNNu/G/9LGShIjWPAoIZ
        kKDIc1KV95KnvmoTK4C18/A=
X-Google-Smtp-Source: ANB0VdaUWhPzj2KhHmOvvw47AebHyUxC7pbaGk9PmiiKqxt0ExRhDg4ZL4JkwxRF/2v1MFWTaRGTqQ==
X-Received: by 2002:a62:f40a:: with SMTP id r10-v6mr7503355pff.47.1535577484878;
        Wed, 29 Aug 2018 14:18:04 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id s85-v6sm8177537pfa.116.2018.08.29.14.18.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 14:18:04 -0700 (PDT)
Date:   Wed, 29 Aug 2018 14:18:02 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff King <peff@peff.net>, Brandon Williams <bmwill@google.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] submodule: munge paths to submodule git directories
Message-ID: <20180829211802.GG7547@aiede.svl.corp.google.com>
References: <20180807230637.247200-1-bmwill@google.com>
 <20180808223323.79989-1-bmwill@google.com>
 <20180808223323.79989-3-bmwill@google.com>
 <20180809212602.GA11342@sigill.intra.peff.net>
 <20180814180406.GA86804@google.com>
 <CAGZ79kaLXcTeeM9AKvXi7X8WMd+vcyCM5n-Nz2igHkGJdXbSfg@mail.gmail.com>
 <20180829052519.GA17253@sigill.intra.peff.net>
 <CAGZ79kZv4BjRq=kq_1UeT2Kn38OZwYFgnMsTe6X_WP41=hBtSQ@mail.gmail.com>
 <20180829210348.GA29880@sigill.intra.peff.net>
 <CAGZ79kYJTWROYSGjEbdVBsEAkWkNE4QVCiPVfuMf75d13fXN6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kYJTWROYSGjEbdVBsEAkWkNE4QVCiPVfuMf75d13fXN6A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:

>> Yes, that makes even the capitalized "CON" issues go away. It's not a
>> one-to-one mapping, though ("foo-" and "foo_" map to the same entity).
>
> foo_ would map to foo__, and foo- would map to something else.
> (foo- as we do not rewrite dashes, yet?)
>
>> If we want that, too, I think something like url-encoding is fine, with
>> the caveat that we simply urlencode _more_ things (i.e., anything not in
>> [a-z_]).
>
> Yeah I think we need more than url encoding now.

Can you say more?  Perhaps my expectations have been poisoned by tools
like dpkg-buildpackage that use urlencode.  As far as I can tell, it
works fine.

Moreover, urlencode has some attributes that make it a good potential
fit: it's intuitive, it's unambiguous (yes, it's one-to-many, but at
least it's not many-to-many), and people know how to deal with it from
their lives using browsers.  Can you spell out for me what problem
we're solving with something more custom?

Stepping back, I am very worried about any design that doesn't give us
the ability to tweak things later.  See [1] and [2] for more on that
subject.

Thanks,
Jonathan

[1] https://public-inbox.org/git/20180816023446.GA127655@aiede.svl.corp.google.com/
[2] https://public-inbox.org/git/20180829210913.GF7547@aiede.svl.corp.google.com/
