Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 964221F453
	for <e@80x24.org>; Wed, 23 Jan 2019 21:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfAWVIo (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 16:08:44 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35086 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfAWVIo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 16:08:44 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so4170119wrb.2
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 13:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=aNK0/591lTqHl2WbNM/b83IVmIIX/Kqb8lhbyPn4za0=;
        b=BJzJLZ9AN4ZGZ9qvoVxLnIRE8AImc8pWKkxSCOi4uZsCp9davUUk8UIP2LVCD6u3o/
         jAbkUAFyao4t51OMYUQTNKf7THzAT+F+q3QorSZSjF/AS0QolpKrMBJL4RB6dYoweRdi
         TxJ3gUtOH7/JgHTxCwbTTeA/fl9KVAbZJ15VwR8eLzCueLpddanKBG1P7mFUBSt6eZZ6
         eQhcE6CRPKJ13xl0HyZipHlCvD1DmjOpArauKOrCAcCjRNIImSFZK49YeY6/zjEddbzL
         jyXj/L45zAAj8iSwly0P8VHKsqrAToP517IGdLpR1iBUARwVROD5xdMelJPoB6F4t1K2
         o3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=aNK0/591lTqHl2WbNM/b83IVmIIX/Kqb8lhbyPn4za0=;
        b=RTQ2YI2sCTmRsCLK0B/3fyUuZj5NBGPA127ZukdqGtSy9fMDgHLfyvvAf5EFjmoEoE
         LV0l6GARKKzVYOnUYVXxoKeABiFawJ52dKTDSUTpj6AEgaWRdSDf3KJJiK9httzMdnuy
         K4gqETyulZcUXQS0BzhQ5IwMhgH+UZhrQQdpJYOKYfxuabRjUX4W0nszASVAfoUXmRVj
         e/n7gcs4Uggre3glEAtwNdVas2aUSoKB7b4LXRnjEoDqQhtxquucp+Lav3sKy2+s8+I2
         oI1p74B7Nt/u5GA7ioxQDzgcKnTJWxpCQAxpuMLYcGZQiJWyDoEA8fwQQycJD3jPUdU/
         0ZCw==
X-Gm-Message-State: AJcUukfNp9x45V4b/q+z5YFwrbKAwvpjbueWQVrSfHKE8SXepLy1fSqw
        rearJEEwdrehGKepugzyMxk=
X-Google-Smtp-Source: ALg8bN5BfEO1mlfpKTO8OGNJA2hwjm2SiWuuJ+CgPRBw6ZSibDkpWxajwMh3AZB9fW6WVnRhmc2JTw==
X-Received: by 2002:adf:9d85:: with SMTP id p5mr4173225wre.41.1548277722224;
        Wed, 23 Jan 2019 13:08:42 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g9sm56687499wmg.44.2019.01.23.13.08.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 13:08:41 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 7/8] checkout: introduce --{,no-}overlay option
References: <20181220134820.21810-1-t.gummerer@gmail.com>
        <20190108215225.3077-1-t.gummerer@gmail.com>
        <20190108215225.3077-8-t.gummerer@gmail.com>
        <20190122235313.GA199923@google.com>
        <20190123202156.GA11293@hank.intra.tgummerer.com>
Date:   Wed, 23 Jan 2019 13:08:41 -0800
Message-ID: <xmqqzhrr9j52.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

>> I had no idea what --overlay would mean and am still not clear on it.
>> Is this analogous to "git add --ignore-removal"?  If so, can we just
>> call it --ignore-removal?
>
> Yes, it seems like they are very similar.

Hmm, I am not sure if the word "removal" makes sense in the context
of "checkout", as "removal" is an _action_ just like "checking out"
itself is, and not a _state_.  You'd check out a state out of a tree
to the index and the working tree, so "checking out absence of a
path" may make sense, though, as "absence of a path" is a state
recorded in that source tree object.

The word "removal" makes little sense in "git add --ignore-removal",
but it and "git add --no-all" outlived their usefulness already, so
it may not be worth _fixing_ it.  But I am mildly opposed to spread
the earlier mistake to a new option.
