Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9FCC207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 22:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S947921AbdDTWNB (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 18:13:01 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:32981 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S947885AbdDTWM7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 18:12:59 -0400
Received: by mail-io0-f172.google.com with SMTP id k87so89563446ioi.0
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 15:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iB9vhEdvrCTflMYhmVQGh+7zLG8so3Z45gyjUPkNPlw=;
        b=jEdsGkYMtPZDefI3ic0PkWrKXexIk1lHaRkxVIqZHA2jmBW1BLheR/z2sKLSaGqBCX
         I9AZuEEW2mWE8KIcY16QpGVhS19+efhXN1YJb5pqLd++orN7wKE5q8iNJhZhZo659ff9
         HABUKqIHxyfgvr7M652iv7HYN8cwHf+57yHdcEXcSFFaxWKPoniLDCD/eeztKgEHtYW+
         BsQUvwwe684X55CVDE8Rjha2d3r612is8pQDwiCfW0SEU5rh+GhBo+BlCbOvRgd4wE2P
         oMGUO1DfUtbR2n+6EL/TUg6GTQ4pTCcV/BMpdTfIokcUG1NxwH/ABs3YNk/C2Xa4fduD
         I75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iB9vhEdvrCTflMYhmVQGh+7zLG8so3Z45gyjUPkNPlw=;
        b=S7Q9UE6ZTYa9frxY2WZq2dyPE+DBYi2CWudNshAWIDETHaIjRmxfXPmXvATGpEz/20
         0nn97JamX8niUAuLvLDqzma4Oj5QSuv/KLS9TT3z0Qsd137iK6doXINHQxQCGI9gChk4
         oQ1slylrZGKUA1lR6KfczixfMKrxDXR66qbl4W9xoleZONcuiyBV7VjBIUG9dKmx5fuv
         DY27Zuft7M8ZFXSgpOpiVsV6iGuxgWniaMGoF5AWe5aaJfivSiuD5l0E14oRCSjU1B2w
         ijkh+P8apkHHIJuCMJUYJhKzyBfch1F5jC0VMAAk2XwxWv7FgPp4z9ZHCvO8QRiiNBD5
         PPOg==
X-Gm-Message-State: AN3rC/63u9U0585DCtxGYGLbZncqXIJxhFRpkI9CFVXwv1MEFW9Z5Ya9
        45othoobKExLey61
X-Received: by 10.99.164.2 with SMTP id c2mr9445394pgf.73.1492726377560;
        Thu, 20 Apr 2017 15:12:57 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:6c7e:3273:2d37:5651])
        by smtp.gmail.com with ESMTPSA id a184sm12169763pfb.118.2017.04.20.15.12.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 20 Apr 2017 15:12:56 -0700 (PDT)
Date:   Thu, 20 Apr 2017 15:12:55 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     maxime.viargues@serato.com, git@vger.kernel.org
Subject: Re: [PATCH 2/2] clone: remember references for submodules even when
 not recursing
Message-ID: <20170420221255.GI142567@google.com>
References: <20170411194616.4963-1-sbeller@google.com>
 <20170411194616.4963-3-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170411194616.4963-3-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/11, Stefan Beller wrote:
> The commit 31224cbdc7 (clone: recursive and reference option triggers
> submodule alternates, 2016-08-17) argued for any further `submodule update`
> to respect the initial setup. This is not the case if you only pass
> '--reference[-if-able]' to the initial clone without instructing to
> recurse into submodules.
> 
> If there are submodules however the user is likely to later run
> a 'submodule update --init' to obtain the submodules. In this case we
> also want to have the references available.
> 

So the idea is to keep the references around even if the user doesn't
want to recurse immediately?

-- 
Brandon Williams
