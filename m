Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 042FB201CF
	for <e@80x24.org>; Thu, 18 May 2017 16:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932886AbdERQi5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 12:38:57 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:35180 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932516AbdERQi4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 12:38:56 -0400
Received: by mail-pg0-f51.google.com with SMTP id q125so25292778pgq.2
        for <git@vger.kernel.org>; Thu, 18 May 2017 09:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AnLwaQ+35JI1x4j7nQNla7kecSXOpOW7NMcgzvxh384=;
        b=dJd6VrMUqwPRYG1QCmwPam3swR+U8gsaCz643L3dCG/cNCWjVTkWrB8IpYyWOETNJN
         gso4OTViz4SXQ+WhN7kZ5shMm/phlz99WFD7s9zP59fM4nSgh4ENGBxKsDzuWscPd6QB
         seAbcr+LqdMr4VUV1nYxb5Qc3uBK9xuHdK63AliqAUdRSIPfCusWlSzkKvliPyjnp7VF
         4wYGZphjV7q7qwd7E2eIcN3WGBLWQdAjicOd1ZyFIqYA8BOJF0mXDcu82Q1CpkzJkFUK
         hvbSWmuT5+Uvhv7Wvx7Rfz6Z3D78bq0XKbOsiqCeteWBtkP0HiGE6vwBI0QfcrbvykT8
         lEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AnLwaQ+35JI1x4j7nQNla7kecSXOpOW7NMcgzvxh384=;
        b=EAtb/oFlf79iNDx1MVybYDLIwczlLd10vlBMkElzhSed4sEuE2K7t6wSLIflK19ShN
         HPhEKHBQrb6FNmNPbLJ3qJQuG1acBCqXiOoRjHDmlyhMM3RFHKYfTJdsnCDnw3TZC2bh
         gEWqsa/3KqzMPGA9J+FW1hiUdb/XwPIKv9eQjYFDhjYpeKUBw84N/srv1XltKic3OBzP
         y4iGCATAlkcURErT53C0BmrGfHYCrY4iscN43QHdxM7THc6ykei7imocWxIo/FL217X9
         YSu+Bvo1moO8SNFaY3BQCSQD929WmNw/+qeQFnE+U0YHq1Z74OLNhzy39mGTcTolcNQy
         C2Hg==
X-Gm-Message-State: AODbwcBwFAljBvg7zGoF0vo/8w1xFz1xqp91310mOEzAgvQqwpLQc1FY
        aCsqVhz4IH2GWcRpVyWvYeHjQfT7nNvx
X-Received: by 10.84.228.207 with SMTP id y15mr5941142pli.172.1495125535721;
 Thu, 18 May 2017 09:38:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Thu, 18 May 2017 09:38:55 -0700 (PDT)
In-Reply-To: <20170518153508.GA112091@google.com>
References: <20170517213135.20988-1-sbeller@google.com> <20170517213135.20988-2-sbeller@google.com>
 <20170518153508.GA112091@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 18 May 2017 09:38:55 -0700
Message-ID: <CAGZ79kZZF7L0Wv5kPO+LxM6_7tA=DrD2RSn9SM708yvnxPnW3A@mail.gmail.com>
Subject: Re: [PATCH 1/3] submodule.c: add has_submodules to check if we have
 any submodules
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> +static enum {
>> +     SUBMODULE_CONFIG_NOT_READ = 0,
>> +     SUBMODULE_CONFIG_NO_CONFIG,
>> +     SUBMODULE_CONFIG_EXISTS,
>> +} submodule_config_reading;
>
> Any way we can have this not be a global, but rather a parameter?  You
> could pass in a pointer to this value via the callback data parameter in
> the submodule_config function.

As said in the reply to Junio, this patch has been sitting on my hard drive
for a while and was written before you started the attempt to de-globalize
the state of git.

Ideally this setting would be part of the repository object. For example
the repository object would have a "submodule_config" pointer, initialized
to NULL, which can then be set to the read config or a static empty_config
if no such config exists.
