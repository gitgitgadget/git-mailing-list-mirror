Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261B8C433FE
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 02:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbiKJCir (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 21:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbiKJCiq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 21:38:46 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716867672
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 18:38:44 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id z9so391142ilu.10
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 18:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/YT0q5dUg88Wll23f6hnNrEZfTP6z8IsOmVknAH7Loc=;
        b=sRMBEC95luZS0VLQMK58GdtBou9nbjsU7eSo9cnZcpjjFEkMeeKxCqCj4KMBiw8I5s
         AHTFOkkbT0snQtN7xRuzdojs8YquxMBNh7b68extVSJ/Xo4cdXXmqgncmONBjEXdDYq8
         KuPE0NWw1h3zFdVLp/KfWhrg89G9eOl+VmBJqeoBpUWOlU9r5c7vbSD06mSeKJLj5q7K
         gBlsY2JqGuaLncKeIE9dqGgc7Y1sI4ha2CbxLw+EkcUjE+cVFPWiRL1rInGZFWkEzV5u
         PhkjGeflnfVt8kb+U3tHojibp3vjoLuNuxkgeCCjbtozcngXlzSWAO2zWg2pzbLKfFUb
         wAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/YT0q5dUg88Wll23f6hnNrEZfTP6z8IsOmVknAH7Loc=;
        b=gwalHKVwDlnN8aARv24OUPCqTH5zKxNBMYELatsWeFe5oZHwkn87C0zfIsszWBjEoH
         pW0zCj4F8lt8ynLiuw6WYIoK4L9pxRquoRYzZ3fBAkNhMqPu/O7uYAADttUsaz0lwo0y
         IpIdpXC+FKFRsgSGXvLxPLkYuXcZL2lOh8a2KdcQyLZ39s/+jfcl1XtB63NwLTvWCwIq
         Q6PnOr9bI8bE0ek25X9LqiKDjvB1qZ06Ib3YXPBmf1aN6asMpP2aUGpeENHV2DAtNtmH
         +lxbHHp4jyePL6RjU9qQ8m/vdjj+DbER42imoxA7Hk+FwTERj6QAJ0npShRy9eHK2t6C
         kwaQ==
X-Gm-Message-State: ACrzQf3TVX/OJCbANfWZ+b/5crJRxlk5XE8wCLO8jFp7Mi6IWeUsUiHU
        N4hbYytxtONiiIkvlCoYXcXgFXynteXmzA==
X-Google-Smtp-Source: AMsMyM4ai4J9DMBS+amqU+NgbKdRngsmlRnvHQ1T74saTfcdLyRf654kM9ZGEoumIgkocJYPHfQeBg==
X-Received: by 2002:a05:6e02:214f:b0:2fb:cffb:3182 with SMTP id d15-20020a056e02214f00b002fbcffb3182mr34684906ilv.161.1668047923757;
        Wed, 09 Nov 2022 18:38:43 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m10-20020a056e021c2a00b002fd00a8f8fcsm5552533ilh.47.2022.11.09.18.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 18:38:43 -0800 (PST)
Date:   Wed, 9 Nov 2022 21:38:42 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Ronan Pigott <ronan@rjp.ie>, git@vger.kernel.org, me@ttaylor.com
Subject: Re: [PATCH v2 2/2] maintenance: add option to register in a specific
 config
Message-ID: <Y2xkMnQQ4w8rhSwD@nand.local>
References: <20221108194930.25805-1-ronan@rjp.ie>
 <20221108194930.25805-3-ronan@rjp.ie>
 <df1d3485-3913-c132-83b5-09ca2408000b@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <df1d3485-3913-c132-83b5-09ca2408000b@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 09, 2022 at 10:05:32AM -0500, Derrick Stolee wrote:
> On 11/8/2022 2:49 PM, Ronan Pigott wrote:
> > maintenance register currently records the maintenance repo exclusively
> > within the user's global configuration, but other configuration files
> > may be relevant when running maintenance if they are included from the
> > global config. This option allows the user to choose where maintenance
> > repos are recorded.
>
> > +	Initialize Git config values so any scheduled maintenance will start
> > +	running on this repository. This adds the repository to the
> > +	`maintenance.repo` config variable in the current user's global config,
> > +	or the config specified by --config option, and enables some
>
> This still says --config...

Thanks for spotting. I graduated this topic too early, it seems. Let's
hold it in 'next' while we wait for a patch or two on top, or I can see
about reverting what's in 'next' and replacing it with a new round.

Thanks,
Taylor
