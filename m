Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCEC7202A0
	for <e@80x24.org>; Mon, 23 Oct 2017 23:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751216AbdJWXQ3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 19:16:29 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:46920 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751116AbdJWXQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 19:16:28 -0400
Received: by mail-it0-f65.google.com with SMTP id f187so7897397itb.1
        for <git@vger.kernel.org>; Mon, 23 Oct 2017 16:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Tuhp7jrHmWzYi/kxrLyIQq6PdFCapTSq6Lyz7O4n+cc=;
        b=tMeC+jtGcypOrX++IYCLXlaRL2EzrYJedrlQ/kpQynQb/+rjfH88bosRaqYMEZAdhO
         jjxYdmpvJJ77QabDeSOEU9V9N/B4gL1B+qf9BwO1CVGEDTI3je6Uc+cEzWRXNWYPbmwC
         /f4jdFP0YAQXcFniHD02bEgl0X63EVDMcIt0BKj6B5po55GXFQDv4oc+MQ4t2/KmSESg
         JLTWl/N42Quk27IPseKvCIXeZ7UWTGnZbOAnUFqLqic2BMYcVQsBccrt5OGmxMWuOnS5
         3Wk22kRjOGMc/8AsZSZtaX2SdMVHoXwfzaFU9MaY/XTr5L40Kc0m8PcSjOs06mQ7Vn5e
         8z0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Tuhp7jrHmWzYi/kxrLyIQq6PdFCapTSq6Lyz7O4n+cc=;
        b=HtTkxa4AQ0yRjVj5sXF7NwUZ7wbV/xOdvbk/PLyOVbmB/QBHzgP8nXIBfOf/Mz8ayo
         dUynVQcqh6i0GMsJ/B9oPQ6d6Rujj3uH7yUoafvS8JqYMi6xvxvSvUNNYrA3n18/X2tP
         CtTicvKxZIzlNYRbfEdGSbAb7RbBfHDkarMEOHVF0EI/nUByIgO1Mo+AT7DNjKjTXOO4
         tdJ7zT77lVAXK1ZRzZkAPMoCbJLNYxjEOkXX8CaAji8uunA9MJgm1rtrqGhUw7tDtqzv
         kN1zhR7VGw/Tz4UJEo/MsaD7+ASoS5j41W37sawxj2WxT0X3A8VfaLwBfOfhuSrOab0j
         28Vg==
X-Gm-Message-State: AMCzsaXh/bNVTUBnm6CKpPdd4P+kXEjMoijBtnrUIKlNYwg63h66iN31
        ybJNf5refxsbWExrMc50TxU=
X-Google-Smtp-Source: ABhQp+STkNH9NlKwjGlhS2YleUvzqnz7XYvbDX0o628mN3UjL+qui8tyIi3+Jj//26xW/pJ6cjDo1A==
X-Received: by 10.36.47.84 with SMTP id j81mr10441218itj.37.1508800588104;
        Mon, 23 Oct 2017 16:16:28 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id z65sm1528235ioe.52.2017.10.23.16.16.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Oct 2017 16:16:27 -0700 (PDT)
Date:   Mon, 23 Oct 2017 16:16:25 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net, sbeller@google.com,
        William Yan <wyan@google.com>
Subject: [PATCH v2 0/5] Coping with unrecognized ssh wrapper scripts in
 GIT_SSH
Message-ID: <20171023231625.6mhcyqti7vdg6yot@aiede.mtv.corp.google.com>
References: <20171003201507.3589-1-bmwill@google.com>
 <20171003201507.3589-11-bmwill@google.com>
 <20171003214206.GY19555@aiede.mtv.corp.google.com>
 <20171016171812.GA4487@google.com>
 <20171023212740.qodxzsq5w7rn2r6y@aiede.mtv.corp.google.com>
 <20171023213159.eitrjrqrh277advm@aiede.mtv.corp.google.com>
 <20171023151929.67165aea67353e5c24a15229@google.com>
 <20171023224310.o7ftwmbr7n74vvc6@aiede.mtv.corp.google.com>
 <20171023225106.GA73667@google.com>
 <20171023155713.5055125d7467d8daaee42e32@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171023155713.5055125d7467d8daaee42e32@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan wrote:
>> On 10/23, Jonathan Nieder wrote:

>>> If this looks good, I can reroll in a moment.
>
> Yes, this looks good.

Thanks.  Here goes.

The interdiff is upthread.  Thanks, all, for the quick review.

Jonathan Nieder (5):
  connect: split git:// setup into a separate function
  connect: split ssh command line options into separate function
  ssh: 'auto' variant to select between 'ssh' and 'simple'
  ssh: 'simple' variant does not support -4/-6
  ssh: 'simple' variant does not support --port

 Documentation/config.txt |  24 ++--
 connect.c                | 285 +++++++++++++++++++++++++++++------------------
 t/t5601-clone.sh         |  40 +++++--
 t/t5603-clone-dirname.sh |   2 +
 4 files changed, 229 insertions(+), 122 deletions(-)
