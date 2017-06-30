Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2523E201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 20:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752347AbdF3ULV (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 16:11:21 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:34078 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751919AbdF3ULU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 16:11:20 -0400
Received: by mail-pg0-f51.google.com with SMTP id t186so68658120pgb.1
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 13:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KmH/rUgwgrFXS81DWtRJcKDeAzvG5PIxR9ZM2UXIBT4=;
        b=d73gV2JRH+30c/wuIqkxcL+dYCB4xmluv11HYk8sN29kslbj+62JI7Y4GK2m3PpkBy
         IKw+/8+CCYq9jWHVcB164qqbca8x6+Dd36+W7LRSYLzHhD1RFl70FzJFkFVy+Na9rR3V
         /dqKRqpGOJJjFDCuywmqjMYPOsIFFDQ7Y6IpXxUmRh26zQPyNr7D2PW2CZB3hlZ3sfzH
         m3OCLpcAN1AbD708l8eSM08A73+PhIz+FINLZo98DVaRMd1b/I0LrhB48JRAi8aTLaeW
         MyQaUoV2KG9EBantAX2ZwIDaAd3sMIuZcfuE/51DC1+5r4VnjVNWQTGDVHDvlAFrP7Bp
         r0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KmH/rUgwgrFXS81DWtRJcKDeAzvG5PIxR9ZM2UXIBT4=;
        b=K6MJC93u8Jde/lMeK9wBhhJeIfKIMa68Ra2sz7FQ+hSxmDi1qACW6WPTtIwVu/3Nys
         Zb4hf39DhEegZXqpgIjd9jSdfNB10sCTgjl050FtHqX0rRYwv6m6z4XMXEpdW7TI7m5L
         tkMEzu8K1rzGO1XhhZY4msvdMyidMBUcEXXZ1mnrslMtyHKwyQeuDv9rtJp+tYsfTgNs
         b+aEWRkz+sOlRls1lPfGKjmvxRUSJDcn6Mnv0KtCqYUhzCDBYYD7Gwe9i5gKZ/5Xsd34
         qO+Ot73P5vZxfiUVEtVyj9Q788MpRnSsA3HuykP/WomWvCvkxg32ZdPr56gR4NSs3qdg
         gr9Q==
X-Gm-Message-State: AKS2vOySStHRNyV/fyN0i90zETS4UnhRGbrIwZifNCH812EwaxJkdZye
        pHOr+7jFCmlykpqZ6jCeL8XHwyJ6gwb1
X-Received: by 10.98.49.2 with SMTP id x2mr23866976pfx.48.1498853479643; Fri,
 30 Jun 2017 13:11:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Fri, 30 Jun 2017 13:11:19 -0700 (PDT)
In-Reply-To: <20170630194727.29787-5-pc44800@gmail.com>
References: <CAME+mvUrr8EA-6jbCZdpB7dMZ5CN3RyY7yoRoUBoiZw=sH6Ysw@mail.gmail.com>
 <20170630194727.29787-1-pc44800@gmail.com> <20170630194727.29787-5-pc44800@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 30 Jun 2017 13:11:19 -0700
Message-ID: <CAGZ79kbiKd1GB8Gsyo8ABG1RBzhpXYrsySxcC6XRZv88Xx94Qw@mail.gmail.com>
Subject: Re: [GSoC][PATCH 5/5 v3] submodule: port submodule subcommand 'sync'
 from shell to C
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 30, 2017 at 12:47 PM, Prathamesh Chavan <pc44800@gmail.com> wrote:
> Port the submodule subcommand 'sync' from shell to C using the same
> mechanism as that used for porting submodule subcommand 'status'.
> Hence, here the function cmd_sync() is ported from shell to C.
> This is done by introducing three functions: module_sync(),
> sync_submodule() and print_default_remote().
>
> The function print_default_remote() is introduced for getting
> the default remote as stdout.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
> ---

All these patches are also
Reviewed-by: Stefan Beller <sbeller@google.com>

Thanks for upstreaming the early parts.

Thanks,
Stefan
