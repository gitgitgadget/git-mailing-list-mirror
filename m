Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECE0E1F516
	for <e@80x24.org>; Fri, 22 Jun 2018 18:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934255AbeFVSb3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 14:31:29 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37284 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933869AbeFVSb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 14:31:27 -0400
Received: by mail-wm0-f51.google.com with SMTP id r125-v6so3639252wmg.2
        for <git@vger.kernel.org>; Fri, 22 Jun 2018 11:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dxq9KjQnSeeA+dBmarGAkXLn1lX2DIl7AqydVIABwM8=;
        b=brxyuwEDpzouyRXkmoaHjRatQIn9czdYanrCruSOV6F5kMrmMphSf25l431hCAHso3
         IuHwzfBnaFvr3das1xfp/8V4wlZXzy18T1QTjsXcRbjIWXK2GRKIeA7EHKehMXT7hBMs
         IroMejXwgFn3Y9jLaOli45+Xwg8cxgnF3GkhApKzASWVLfgjQ7j4IHBwKDuJ+MqP5TV9
         n2nCgUwOfmUOdPlVexEqk6VUgeLYHOlCt/CYDhjD54nKv4Dmv8bSPhRGlC3kPcWjEKkD
         prsEFQVQCNxnG/6sxTJeN/Sv9WLhlDKTK2zS05dh2WTfIDCd1WWDvNSceUlx9rQnV4Uy
         pWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dxq9KjQnSeeA+dBmarGAkXLn1lX2DIl7AqydVIABwM8=;
        b=oxTsqCYDjr4BVGFQhB8VPyBZlNWFgNadfprnhaJ+VzcI4M5SQKzor7eG7gUDRywlik
         YcN3IBFsGevM8Bc5L/q0yNE7+/Uo9jnCOfYeFq+JGD112knOy6LO3cNyUKggocCTMgdU
         GWTaVkgNQIp6fvrDz3BAm+JTdaCFTvw13Wy2wWU2yLhg89HQ1j3erjLfiNWYPFhqBWP9
         K36bo0Z/9Hjztoc+Rebf+2iRMlQbchEaZ61OyCSyEfE8Ys6crjdnWp/wVm+GbvDmkOhn
         HM5JUmPkLjXqQjuMlKxqMW1ZDKgtlfFjSPVaC3hdFKHMWL1qKBv8iDnNtsFyAS9eFgZG
         Ug8g==
X-Gm-Message-State: APt69E3ayxfeif2kBCMP8kqRFzqMEuSXt1ES8Q+MXXyrllBE23hecI1A
        MEeqBQL8NRwYPzuVzIEhfvc=
X-Google-Smtp-Source: ADUXVKLAwsFekaSUTtEY1XWSWxQ5aYdYRGJHr8hQbdKPIpevuJdn0icjiaDtwF46SERKGAQ+svwg5g==
X-Received: by 2002:a1c:d388:: with SMTP id k130-v6mr2430042wmg.66.1529692285869;
        Fri, 22 Jun 2018 11:31:25 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w24-v6sm1782513wmc.15.2018.06.22.11.31.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 11:31:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Martin Fick <mfick@codeaurora.org>
Subject: Re: [PATCH 09/23] midx: write pack names in chunk
References: <20180607140338.32440-1-dstolee@microsoft.com>
        <20180607140338.32440-10-dstolee@microsoft.com>
        <CACsJy8ARDLeWaWq1_npZq5ARCVgcETpS--YUVLqZkZA52E7Msw@mail.gmail.com>
        <4082c785-9fb2-7b15-b646-3c658b54abbe@gmail.com>
        <xmqqfu1gt4ye.fsf@gitster-ct.c.googlers.com>
        <08667213-02fa-6104-d8de-20ee92b6bdce@gmail.com>
Date:   Fri, 22 Jun 2018 11:31:24 -0700
In-Reply-To: <08667213-02fa-6104-d8de-20ee92b6bdce@gmail.com> (Derrick
        Stolee's message of "Fri, 22 Jun 2018 14:25:26 -0400")
Message-ID: <xmqqzhzmptab.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> The index extension documentation doesn't appear to be clear about
> which extensions are optional or required, but it seems the
> split-index is the only "required" one and uses lowercase for its
> extension id.

read-cache.c::

    /* Index extensions.
     *
     * The first letter should be 'A'..'Z' for extensions that are not
     * necessary for a correct operation (i.e. optimization data).
     * When new extensions are added that _needs_ to be understood in
     * order to correctly interpret the index file, pick character that
     * is outside the range, to cause the reader to abort.
     */

