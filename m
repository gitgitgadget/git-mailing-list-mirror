Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FC3F20A10
	for <e@80x24.org>; Fri, 29 Sep 2017 04:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750927AbdI2EVv (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 00:21:51 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:55647 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750890AbdI2EVu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 00:21:50 -0400
Received: by mail-pf0-f173.google.com with SMTP id r71so110547pfe.12
        for <git@vger.kernel.org>; Thu, 28 Sep 2017 21:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=McJXr/WHXES5XRcnXij1OdFjXfrLq/pxDFabgcMPIf4=;
        b=WVTu5V5s7eKID0JqSSYMFOnwhEhCr3RzHRzZhE7avE16ypSVhoeQ72e0zcTdIsMHEf
         t1djIMrq59M/AO0dJf6+v+KRs2EJPZijW4cbiv8VaycavTohGrM60XaBmw7w6TKxnobr
         Mogj4cyYh8VRmGXLccz46/itV7GiDmC/duUqPh+7jwh3hEKGMVN+sanAxfb3LI3kNcxq
         nVnIEWYy7Bp6hBv6YYKFm5SgMXTHLAGmR3pxYFcd9clnFXHUVObqR+q96SMBEDm9Lq7d
         C8jVur1LI0EQv+Mt7M9J5burNHe9+5Syei4EAlR7nPC+Tu6ZS1zhh842ngMSdgDxoU7C
         PToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=McJXr/WHXES5XRcnXij1OdFjXfrLq/pxDFabgcMPIf4=;
        b=ifjJbNd17v2Pfu21sWNWEV9/zsfb0KBO4HJGpW/s1YmF+6jCx/43ap3Im+UplecKYH
         wtCWrr00g2C4UWjpqnXRfUyk2/MnJVMphnohlIMUSaPqUqrijZeuVv8ox5O4NRy6UlXj
         Ws8ayoPiGSeLIUGPi+UtWo1FpPRZcXG9y/qAI4lse07HMlspmiEtkQD4nbHCco0SlpIO
         TZRQ4ja1ifaotsKuEmWMAOeUzRN+baozjVYq0BLH3fagPuAFKqZy4X7/3KAS832kpvSd
         c8ugr6V9yvr2C/GfJZwSisYuWepm/5ZRVO0hV6LJVVmYYyKkVy19NLkIkdUtD9PRYlhS
         CtHA==
X-Gm-Message-State: AHPjjUjLc51TFSben9BHAHDPAg1/7It9PXOpb8/Xr5eI57WrKa/DAL4r
        o3wQeHrSj+9iDUkepSVAm7o=
X-Google-Smtp-Source: AOwi7QBZ0gMtemLPwQxlyn92eW4PyPUKciU/nMXgJRbLmiZ8Mrh3bxLI3sWJdw/sam2r8Z+vFbWEJw==
X-Received: by 10.98.242.3 with SMTP id m3mr6169113pfh.306.1506658909547;
        Thu, 28 Sep 2017 21:21:49 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:c47c:760e:a02b:2eef])
        by smtp.gmail.com with ESMTPSA id y1sm4926229pgp.15.2017.09.28.21.21.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 28 Sep 2017 21:21:48 -0700 (PDT)
Date:   Thu, 28 Sep 2017 21:21:29 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Dridi Boukelmoune <dridi.boukelmoune@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] git-sh: Avoid sourcing scripts with git --exec-path
Message-ID: <20170929042129.GA34269@aiede.mtv.corp.google.com>
References: <20170928223134.GA30744@varnish>
 <20170929034856.GB28303@aiede.mtv.corp.google.com>
 <xmqqtvzmxij5.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtvzmxij5.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> This has been broken for a while, but better late than never to
>> address it.
>
> I am not sure if this is broken in the first place.  We do want to
> make sure that the scripted porcelains will source the shell helper
> library from matching Git release.  The proposed patch goes directly
> against that and I do not see how it could be an improvement.

It used to be that git allowed setting a colon-separated list of paths
in GIT_EXEC_PATH.  (Very long ago, I relied on that feature.)  If we
can restore that functionality without too much cost, then I think
it's worthwhile.

But the cost in this patch for that is pretty high.  And

	$ git log -S'$(git --exec-path)/'

tells me that colon-separated paths in GIT_EXEC_PATH did not work for
some use cases as far back as 2006.  Since 2008 the documentation has
encouraged using "git --exec-path" in a way that does not work with
colon-separated paths, too.  I hadn't realized it was so long.  Given
that it hasn't been supported for more than ten years, I was wrong to
read this as a bug report --- instead, it's a feature request.

In that context, this cost is likely not worth paying.

I wonder if there's another way to achieve this patch's goal.  E.g.
what if there were a way to specify some paths git could search for
custom commands, separate from "git --exec-path"?

Putting the custom commands on the $PATH seems nicer unless you're
trying to override the implementation of an existing git command.
And we already discourage overriding the implementation of an existing
git command (as it's open source, you can patch them instead), so...

Another possible motivation (the one that led me to use this mechnism
long ago) is avoiding providing the dashed form git-$cmd in $PATH.  I
think time has shown that having git-$cmd in $PATH is not too painful.

Thanks and hope that helps,
Jonathan
