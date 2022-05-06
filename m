Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90684C433F5
	for <git@archiver.kernel.org>; Fri,  6 May 2022 11:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390083AbiEFLbS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 07:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234029AbiEFLbR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 07:31:17 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C4E13F7F
        for <git@vger.kernel.org>; Fri,  6 May 2022 04:27:34 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id cx11-20020a17090afd8b00b001d9fe5965b3so10554837pjb.3
        for <git@vger.kernel.org>; Fri, 06 May 2022 04:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2ID0dnci1upLdYU8lx35gRVkS53XAkMj2NlmNEnMhNI=;
        b=io6E5HHtNYreCB6/pTy0+bUleK6YMvoWhPs3fMBDf8HSEZ+5CdZp2yZXINXkRlBLz7
         IjRvyGsJGx4X0PFmVpubzdeFG8KMFSDjManD5Qwwq0gWbh8zttcojx1Rc2KzNULiMMjU
         oBH/V4y6fD61GTbKdjT8YM3ZcPMgbfBrw3muM1JWYxuLUJvIQkBlPQpYaOcS0dZ7L4Ho
         7rtkAd+9hGS0HzUsL03LccqslrugcNEwLv8BWdQlwDnLYFEKXMQ/+H+OZMq7CjfAYE8W
         x1QQo8S5sgYwYMIMuzwIGr8fzXzi4GlTP39eb8QAhcPrs7i21aFG9LQ44dLp1sPHyUQW
         ddew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ID0dnci1upLdYU8lx35gRVkS53XAkMj2NlmNEnMhNI=;
        b=jez/EuGPJfrMrKOmqWS3SujauUSkPLOuaRk4/u5Qo//IC0y/aLSOKgoVaPyXSCr6+g
         oGz+VnBnqBGroc4VCYX76/YZH2DxjxLFiy9CPkYF+ZoPvXRg0K6od1LjpAPS6JyOJ6CO
         DRETqKch+CADv0gt6tq0IUCNFQseFE5+toqOlpYOO4WZzzXyVFTLfWgo1Cr5EPwpDsKf
         KH9M8O+GjAlY3t/aYFcr9YAAvqFB0uqyw4FG9GE+OMCZhupiIwXeBAl05HfGj9g6tx9a
         N95ZyVWFg9kU5t61icaaCsfzTsrlLXefS2vYjdlsXN3Y0zG/XAzAdJWdcr2NiWkW6sNG
         2r1w==
X-Gm-Message-State: AOAM531WT3hoBp4OiiLy2PrbAhCKu9FLtWaYLzcM1pS5MG1H9i2B7B52
        UDf4Vjbto+TLYxjgIBQHy6Y=
X-Google-Smtp-Source: ABdhPJyMs1bFCtmSJ/85ld8JCckzlfMA8jaXGmpuOHkdVRtBcUFs54B53KZviTkX3DfSjBYiUcNXzQ==
X-Received: by 2002:a17:90b:1895:b0:1dc:76e9:e9a0 with SMTP id mn21-20020a17090b189500b001dc76e9e9a0mr3653121pjb.68.1651836454423;
        Fri, 06 May 2022 04:27:34 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.54])
        by smtp.gmail.com with ESMTPSA id p1-20020a622901000000b0050dc7628191sm3160679pfp.107.2022.05.06.04.27.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 May 2022 04:27:33 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     avarab@gmail.com
Cc:     derrickstolee@github.com, dyroneteng@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v2 4/5] bitmap: add trace2 outputs during open "bitmap" file
Date:   Fri,  6 May 2022 19:27:22 +0800
Message-Id: <20220506112722.33760-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.582.g1a169d7b5e
In-Reply-To: <220421.86k0bi77mb.gmgdl@evledraar.gmail.com>
References: <220421.86k0bi77mb.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 21 Apr 2022 17:51:30 +0200, Ævar Arnfjörð Bjarmason wrote:

> It's really helpful to have these full examples in the commit
> message. Thanks.

From the previous contribution process, I think it is necessary
to provide sufficient information in patch, which can help to save
reviewer's time and find problems faster.

> Hrm, so re my comment on 5/5 are you trying to use the "try to open" as
> a timer to see what our start time is?
> 
> I think probably not, in which case this whole variable flip-around is
> something we won't need.
> 
> But if we do actually need it perhaps a sub-region for the timing?

Yes, I looked back on it and found it's redundant and unnecessary now.
Will delete the two related references in the code in next patch.


> Nit: I think these "goto" patterns are best if your "int ret = N" picks
> an "N" which is the default that you'll "goto", i.e. if you pick "ret =
> 0" you'll just need "goto done" here....
> 
> > +	       goto done;
> > +	       }
> > +	       ret = open_pack_bitmap(r, bitmap_git);
> 
> ...which we may then override here.
> 
> Just saves you the assignment and the {}, but it tends to add up in
> longer functions

Make sense.

> > +done:
> > +	trace2_region_leave("pack-bitmap", "open_bitmap", r);
> > +	return ret;
> >  }
> 
> Looks good, aside from the 5/5 comments that much of the data string
> logging looks like it becomes redundant in the end due to error() giving
> us the same thing.

Oops, I will read the comments and reply them in 5/5. 

> I haven't tested but part of this test change looks like it'll break
> under bisect, i.e. you changed 1/2 of these strings in 3/5. Did you try
> with "git rebase -i -x 'make test T=t*bitmap*" or similar?

Yes, they should be in the same commit in 3/5, but now I the new warning
text seems like is much verbose which suggested by Taylor Blau, and I will
roll back the new warning message and fix the broken test under bisect.

Thanks. 
