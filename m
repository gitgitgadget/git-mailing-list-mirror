Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B68D1F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 01:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfAOBZL (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 20:25:11 -0500
Received: from mail-pl1-f171.google.com ([209.85.214.171]:35434 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbfAOBZK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 20:25:10 -0500
Received: by mail-pl1-f171.google.com with SMTP id p8so481557plo.2
        for <git@vger.kernel.org>; Mon, 14 Jan 2019 17:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mBHhH2f+evrqrBplFTfVV5h49ZOirXAdySkbEKU9vfY=;
        b=PG5k86MosOKZIDiephqzuBwACC6K4F/fGyQ1+1XTTvuZ3I0naHBy+Z6PyM4Lm4awM/
         st9KL4IZ6Q0k3HYi4hMGwkYmhbSZadmJMWZhP2Rd9y95D+G1TpBy2dyY/vDxzBWGW1X6
         vqmKOxxfI3H0waGyCoDRiGv5XY1oHhA7o5F4MycdWHpHkSB1gpY/GVoBpiPVmRco6P5v
         6xYqjE8lk+LjHwCRdok6IqlY4iiRzO9Dxzb4R/jOe45+VDfzy4sd7w7vtRTUfhy0GsrE
         LCFCPl5BtpVEoZgkhyFOQy4CfUM99dXoiKaBqUODzsHD3AAevKszFjGb7ScK/b4wOF1H
         W3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mBHhH2f+evrqrBplFTfVV5h49ZOirXAdySkbEKU9vfY=;
        b=UGJJxNGYWZN6SH8DxyGag5Hn2hkgppKn6cn74Vx5JakjG5U1p602WlauvIKpxy3aNY
         6inBr6u/+a7v83WA8t2/kBHmgDus3FGbitJkzzGpmcgWjXPb1Qbitfn+on0GnbKt/ygS
         1Holb4lGbP1/ZhozzcuGzjjfyiQeMB1dv5cWjQwrB3ZlXx1ELtROPEMBsksVXR4dVxEG
         88lm+4QkaN/w9ok9Hu6uhWPFUFsfKOCs4M/2G1uplx2gclkhW2F+rxEuEUyrzZZA1iUh
         rbnOPpUqltYo9Ag0os42i6D21yxNJ6fR4isL3Fa8bMPwn4qPexpBOnlE+WRADBzc5ddt
         sy5w==
X-Gm-Message-State: AJcUukfOpbw4rZjg1Xxr9JPJQIu8FFleiTDojHeazXKBsJYiSk5K3bZf
        CQwLT1b+6WH0PZ6JRJdmrupcO65C
X-Google-Smtp-Source: ALg8bN7JHZfQ1IZLWX6QpwfMHNwFeWCEzN47BWKIgPe4YXifhpY0anvA0yHGo1Qbw1vRH7I2/gJJmw==
X-Received: by 2002:a17:902:2c03:: with SMTP id m3mr1452005plb.125.1547515509684;
        Mon, 14 Jan 2019 17:25:09 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id 202sm1965247pfy.87.2019.01.14.17.25.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 17:25:09 -0800 (PST)
Date:   Mon, 14 Jan 2019 17:25:07 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Brandon Williams <bwilliams.eng@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Aaron Schrab <aaron@schrab.com>
Subject: Re: [RFC] submodule: munge paths to submodule git directories
Message-ID: <20190115012507.GK162110@google.com>
References: <20180807230637.247200-1-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807230637.247200-1-bmwill@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

In August, 2018, Brandon Williams wrote:

> Commit 0383bbb901 (submodule-config: verify submodule names as paths,
> 2018-04-30) introduced some checks to ensure that submodule names don't
> include directory traversal components (e.g. "../").
>
> This addresses the vulnerability identified in 0383bbb901 but the root
> cause is that we use submodule names to construct paths to the
> submodule's git directory.  What we really should do is munge the
> submodule name before using it to construct a path.

Thanks again for this.  I liked the proposal enough to run Git with
patches implementing it for a while.  That said, there were some
unaddressed comments in the review.

I've put a summary in https://crbug.com/git/28 to make this easier to
pick up where we left off.  Summary from there of the upstream review:

1. Using urlencoding to escape the slashes is fine, but what if we
   want to escape some other character (for example to handle
   case-insensitive filesystems)?

   Proposal: Store the escaping mapping in config[1] so it can be
   modified it in the future:

	[submodule "plugin/hooks"]
		gitdirname = plugins%2fhooks

2. The urlencoded name could conflict with a submodule that has % in
   its name in an existing clone created by an older version of Git.

   Proposal: Put submodules in a new .git/submodules/ directory
   instead of .git/modules/.

3. These gitdirname settings can clutter up .git/config.

   Proposal: For the "easy" cases (e.g. submodule name consisting of
   [a-z]*), allow omitting the gitdirname setting.

Is that a fair summary?  Are there concerns from the review that I
forgot, or would a new version of the series that addresses those
three problems put us in good shape?

Thanks,
Jonathan

[1] https://public-inbox.org/git/20180816181940.46114-1-bmwill@google.com/
