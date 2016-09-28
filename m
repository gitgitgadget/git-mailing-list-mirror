Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C9F4207EC
	for <e@80x24.org>; Wed, 28 Sep 2016 06:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750719AbcI1Gp0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 02:45:26 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:36024 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750749AbcI1GpX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 02:45:23 -0400
Received: by mail-qk0-f169.google.com with SMTP id z190so38567053qkc.3
        for <git@vger.kernel.org>; Tue, 27 Sep 2016 23:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3RU/J+2oO/HoXzLwr7urZFADtP0wGGYBXLmUwJP50lo=;
        b=tHANkYmhbf9WNi6PrA/TMsUnezcUIjw/O4nJy28uQ0f8MI24F5Nbz45kmVed3tOb1S
         J0mp8WnhV4n1092HxFyGfvjhyWT8rLgmZMt+nEfJsl39B7kk7Q2gV8jOVr5a/P2a1VNx
         IASlQEm/8E8QVtZlTcqQuGW/xc44vN+gocgzCS7XzTSmWPy0ABVR413eb1hheK2Gfw/1
         8EyZ1sqtoboc7gqACQPYxz9qZtVnQRkw293LnZv32KlUmQ1dNuNiJBieO8x5/lVV1EWN
         CC9VbJEHVjZlVAAP6G35oyvK0SEfsvxpasZ1NskzteuJwcCSkL8XIiGKR6Ed9KQ43stV
         To5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3RU/J+2oO/HoXzLwr7urZFADtP0wGGYBXLmUwJP50lo=;
        b=cWdSAlywhY6ZFrPXqVxLvSxaOJrUgbHd12UXgGTpLdkohdyBtzwX+USJ9a9jnMZgVj
         GoPmk+L6+QLUMpkY2nYaL4aKtUX2J87gKlPcgKfqAUM92VXfnJ8+Rp9wyQSElgTJONIc
         gekeg5TaWBTneprrfAfJvP3AP/WIo99BQmIjjhgolNdC4C9OEG08fkU0T9w+SHeYDPbG
         m9mH+qdFwCux1AarN6KSUJW9tiKxhimwWIuSBZ/X+2f603DIq2ZAjp3z8mkJj95rOlT/
         J0dntre4F/I+JM1XB7iZzc6VJp2lTVqVpW7HpMfjVcw5OuYREVPtaCAMJB0sOvB9s4Jd
         0I5Q==
X-Gm-Message-State: AA6/9Rk8lhJqr3g9scQ/70m6KZqKp2oJLQjVt7uDR9h6QJQ84lPpTHhQ1aZ+36epgDmAsw==
X-Received: by 10.233.216.194 with SMTP id u185mr32827697qkf.173.1475045122844;
        Tue, 27 Sep 2016 23:45:22 -0700 (PDT)
Received: from kwern-HP-Pavilion-dv5-Notebook-PC (ool-457850cc.dyn.optonline.net. [69.120.80.204])
        by smtp.gmail.com with ESMTPSA id z186sm3225308qkb.13.2016.09.27.23.45.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Sep 2016 23:45:22 -0700 (PDT)
From:   Kevin Wern <kevin.m.wern@gmail.com>
X-Google-Original-From: Kevin Wern <kwern@kwern-HP-Pavilion-dv5-Notebook-PC>
Date:   Wed, 28 Sep 2016 02:45:20 -0400
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Kevin Wern <kevin.m.wern@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 04/11] Resumable clone: add prime-clone to remote-curl
Message-ID: <20160928064520.GH3762@kwern-HP-Pavilion-dv5-Notebook-PC>
References: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com>
 <1473984742-12516-5-git-send-email-kevin.m.wern@gmail.com>
 <CACsJy8C+0M8o15E+iVX+f=izO2CtK7U642NC=XXaG-g41wYAUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8C+0M8o15E+iVX+f=izO2CtK7U642NC=XXaG-g41wYAUg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 19, 2016 at 08:52:34PM +0700, Duy Nguyen wrote:
> 
> A brief overview for this service in
> Documentation/technical/http-protocol.txt (and maybe
> Documentation/gitremote-helpers.txt as well) would be great help. It's
> a bit hard to follow because at this point I don't know anything about
> the server side (and on top of that I was confused between http
> send/receive vs transport send/receive, but this is my fault).
> 

I figured I would miss something in this vein. So many things to cover!

Thanks again for reading.

- Kevin
