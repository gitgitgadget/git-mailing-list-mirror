Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5148B209FD
	for <e@80x24.org>; Sun,  4 Jun 2017 01:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751176AbdFDB7u (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Jun 2017 21:59:50 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35389 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbdFDB7t (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jun 2017 21:59:49 -0400
Received: by mail-pf0-f181.google.com with SMTP id n23so67695707pfb.2
        for <git@vger.kernel.org>; Sat, 03 Jun 2017 18:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=PiqWHt0O/opYyIzBmehINQgfh7RDVALFCUDbUri530A=;
        b=mYqJopdWF0sx80GBm7Q3oFB3HwJhPCvBehRbbBYqOYIi+td8HoA5/IWaX5p3zfyT0R
         8Yj4P8m6zO/c6WFiRXavwEOR9NgFCvj4UXC0zmg/467dgbtzIEEZelsrHgIi6TWt7Kg7
         UXsAV707No/XHjMqR26ZUAFjcxm5BntrX4Q6FQQgqKYAf4duNh3GfwYqiGIR7Va/rd2q
         WiuEEwKTeYKocvDNhoGDbmxFdM6C7FNB9q93Hd61bzG20/9IovjpkCR6rvt/bYHRfBWl
         yeR06J/KBTKmETAd9yJq7zlLqlyYZSe0u0/BemX0Tc/zDEA0vcjn4Zc/7yIwOFicTldq
         A71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=PiqWHt0O/opYyIzBmehINQgfh7RDVALFCUDbUri530A=;
        b=rfd4iBznAzubJKxeKFcIAo9KYEzrJ2a9SV03jw2uIoQTlzFArlnydXBVg7BeEW9s1K
         UBqWXG4FoInBAfLddvYcuvaHjkH7qhFC5xnlZMxdLtHgrM7Pkqy3Y7R1sZjE4lVgw1Ht
         fPyx08lf2zXJMC4tUdmGTXM6dgj46FzDHE0pMrJDSRl+EAeX5+TUvERCPDLTrBXRsyGB
         VvexGWtxUxkYjynLIz3XEQ2RiUZQJ5Rb56muUvHFw+QxLG7D6g1bNwJyteatT9cb9YAT
         2ewidJ4dlFPD6Ba3PA5xz2CBR7Zfgkpc+TQk4PUdL8B9Ou+7R1iZCDhpLvt13ysA8cuA
         xV7Q==
X-Gm-Message-State: AODbwcBlPeEehCVDHzwjgC5vGl/2MvWm8w48EiQIh5xVXv+EK73WUe09
        jUilQAjTS2mZaA==
X-Received: by 10.84.231.15 with SMTP id f15mr7677142plk.131.1496541589269;
        Sat, 03 Jun 2017 18:59:49 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:e94b:f1cf:5772:ec43])
        by smtp.gmail.com with ESMTPSA id u20sm10961289pfa.17.2017.06.03.18.59.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 03 Jun 2017 18:59:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Ben Peart <peartben@gmail.com>,
        =?utf-8?B?Tmd1?= =?utf-8?B?eeG7hW4gVGjDoWkgTmfhu41j?= Duy 
        <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David Turner <David.Turner@twosigma.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [WIP/PATCH 7/6] perf: add a performance test for core.fsmonitor
References: <4c3fed40-774b-8ae6-fa1b-50efe6ef552f@gmail.com>
        <20170602102853.23073-1-avarab@gmail.com>
Date:   Sun, 04 Jun 2017 10:59:41 +0900
In-Reply-To: <20170602102853.23073-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 2 Jun 2017 10:28:53 +0000")
Message-ID: <xmqq1sr0wm0i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> This is WIP code for the reasons explained in the setup comments,
> unfortunately the perf code doesn't easily allow you to run different
> setup code for different versions you're testing. This test will stop
> working if the fsmonitor is merged into the master branch.
> ...
> +
> +	# Relies on core.fsmonitor not being merged into master. Needs
> +	# better per-test ways to disable it if it gets merged.
> +	git config core.fsmonitor true &&

Will stop working and relies on not merged can be read but I cannot
read "why" explained, and I cannot quite guess what the reason is.

If the code to read the configuration is not there, setting this
would not have any effect.  If the code is there, setting this would
have effect (either talking fsmonitor helps or it hurts).

And I do not think we'd ever see a version of Git that always relies
on talking to fsmonitor, i.e. "git config core.fsmonitor false" is not
a way to disable it, so...

Puzzled.


