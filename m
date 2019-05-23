Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 896F21F462
	for <e@80x24.org>; Thu, 23 May 2019 20:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387994AbfEWUeT (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 May 2019 16:34:19 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35558 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387533AbfEWUeS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 May 2019 16:34:18 -0400
Received: by mail-pg1-f193.google.com with SMTP id t1so3730657pgc.2
        for <git@vger.kernel.org>; Thu, 23 May 2019 13:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dty76yb/D980iJkj2rcrKiqBnB3ku6FsBMcaN5quaNI=;
        b=TWuH9N4n8FWCsanxiqwhMAl+6IXOIeGyjeR233KzQIU3UKoINSL6UIFOl0y4KlAnRQ
         eJQxbwfos3Z4O7tcrYhnOffbljSdLL0n6Ixx9Qhg8XJ1wyybtwzuWtBc7FcF3RyCvRMY
         ODhK6ubii1UXoToyt8Z93hAg6Th+uCTergb9EZGaQ/ycdP4Q2LdUO7/92XR2xJJFdDwF
         pftBAQ65/CgB4L6tU3FdixlgKBr7vOEebTa+m9YFEgpYDktDgAXHH+peQy2UiWzUREgt
         +4reHr69pJvhE1e/DlV3vcxfAiiD5L0lh7kFx810aOOvVDd/BPoQvaUVFSw2UinBWonQ
         e17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dty76yb/D980iJkj2rcrKiqBnB3ku6FsBMcaN5quaNI=;
        b=roYo2yCNC+VPept0gI37wbuGqPRn0hklklSgyeNKQo9Ru43GV7NTrXlN0nsxwy20iP
         91gc2LVFg1Pk3lRhrtSt8PevcQNSILYkFrV/vj+qzR8jhu8kasd/v/Lu76q+KUzCaa6Q
         JhfBs7N4Zlu2+Jjsx/CQCSOPd1ac07sYxJ0qyADMcZIq63H77bBjfSqXzkHnN/I+fLzI
         0KpmBp98ZVCMzqXj42yT6/G6f8k6HbYGaxGAPvxSqQOdSkW50LOTeDCfH1NKr/0Jq+s2
         ZshnmdaGNby48usc3HEBxQMktSyAjDddg3MoNVI4wAhQsKBkK6u8aLERF+FASsoFy+PT
         rQXQ==
X-Gm-Message-State: APjAAAVDi2qlq/d8CZRHq6QMiUA1iLikn25vJbM5kNMbCawaOnRitHX2
        ebK6wSyeBB73rvathBV1vkXXCIGb
X-Google-Smtp-Source: APXvYqwo6wjWZX3KNgr1SBdg8SoUdq6QJjwXJPdz+7TsW5RcjpCKmi3DhPw03Sv/+qn32zTaoazmUQ==
X-Received: by 2002:a17:90a:de08:: with SMTP id m8mr4065579pjv.18.1558643657930;
        Thu, 23 May 2019 13:34:17 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id f4sm297096pfn.118.2019.05.23.13.34.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 23 May 2019 13:34:17 -0700 (PDT)
Date:   Thu, 23 May 2019 13:34:15 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] grep: fail if call could output and name is null
Message-ID: <20190523203415.GB70860@google.com>
References: <20190522003402.77767-1-emilyshaffer@google.com>
 <20190523202355.152742-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523202355.152742-1-emilyshaffer@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer wrote:

> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Since v3, only the commit message has changed. Reworked based on
> Jonathan Nieder's suggestions (with some modifications for readability).
>
>  grep.c | 4 ++++
>  1 file changed, 4 insertions(+)

This is indeed
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for your patient work.
