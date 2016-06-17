Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=5.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F79C20179
	for <e@80x24.org>; Fri, 17 Jun 2016 16:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754110AbcFQQJt (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 12:09:49 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:36842 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907AbcFQQJs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 12:09:48 -0400
Received: by mail-qk0-f172.google.com with SMTP id p10so89321343qke.3
        for <git@vger.kernel.org>; Fri, 17 Jun 2016 09:09:47 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sR9oCRprApf4hSxtWoQIaeNTUCSMSddhJycQh41A6NU=;
        b=a7OOf+0k+SljpWBFNLLcNA7+j4rPg5cPZ4PqzdBjWqAKN81c+LbCT6EXhA+2SzSFtd
         WxkV7+6pM94HbcLETvWtnbr7mK/apZDOidJk5zjhz/7r/7MaBZ01SwF2Om13N9oW5VJR
         bhKT1ZGzXMT9CIaqKXFEHU0WUHeNlHl1p5AzCswSA8B1tJLBWTKzx7kNpAQ14e9Z3H8f
         3dLjwf0a+snk6CHVzLxaa6DVFgA6KH42hz80oeLMmjyE0hTpJRtMFfkRGZsAWbWJ6NQL
         G6blEYwh75Y5IBO7R9XSTsxZN97Q7/xZAbg9JUVfFE2oHvNAVuBhPUlF2PEEoLETKHOX
         QIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sR9oCRprApf4hSxtWoQIaeNTUCSMSddhJycQh41A6NU=;
        b=l37+qpqrrAXAm5bx08vnLMK4Aog+WRoLJq4i38rWqBCsyoSVgWphtWA4YmtFBljPQF
         dHizeXNJGcC+RRT2u0tA+dqPK0ZsyasEEQ/0IgAjU9yE288l9/H0dJdL2lSSufNj+OG6
         gubszOzfX4z4C33/3fkCEpqKSdHSqvrQNsZQqIS9MQOnaQ/FhUyqYJnzNMM3/9jUc/rW
         Q0gp3x3gCeEvvzk18U5kQqm3//CL7goJfJYxAku95QdrrldKLe5SwpfeEU1GefFAjCxW
         Nv1tJ2Rvj152SvjRqh1eSyD5pErnS8ibTYMn2BtRgg39LZ40u8zEQLLMYn/UetvQpQUk
         d3dQ==
X-Gm-Message-State: ALyK8tJY25GMN1rUIjYqx49ogxMYkJ5tIMc1v5ovx8hlDfeChufoRaufUeMELGk/dy2ekGu4Z0OVvNSK0vCwvFTm
X-Received: by 10.200.39.142 with SMTP id w14mr3226606qtw.59.1466179787139;
 Fri, 17 Jun 2016 09:09:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.42.226 with HTTP; Fri, 17 Jun 2016 09:09:46 -0700 (PDT)
In-Reply-To: <20160617153637.GA9314@sigill.intra.peff.net>
References: <20160616174620.1011-1-sbeller@google.com> <20160617153637.GA9314@sigill.intra.peff.net>
From:	Stefan Beller <sbeller@google.com>
Date:	Fri, 17 Jun 2016 09:09:46 -0700
Message-ID: <CAGZ79kZgdbqnWW9uqeBHNDbyGVfc0x5gTJbyD0Nyi1i3SNvENQ@mail.gmail.com>
Subject: Re: [PATCH] diff compaction heuristic: favor shortest neighboring
 blank lines
To:	Jeff King <peff@peff.net>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jun 17, 2016 at 8:36 AM, Jeff King <peff@peff.net> wrote:
>
> Did you want something that triggers the "bad" case with the existing
> compaction heuristic?
>
> I gave one in:
>
>   http://article.gmane.org/gmane.comp.version-control.git/296947

I found that out after sending the initial patch. Thanks for pointing out!


>
> I think the difference is that in my example, the diff (before
> compaction) has the blank line at the top (because we are adding a new
> entry at the bottom), whereas in yours, the blank line is at the bottom.
>
> This patch does make my "bad" case look better. Unfortunately, it
> re-breaks another case:

I think before spending more time on discussing and implementing new
(hopefully better) heuristics, I'd want to step back and try to be a bit more
systematic, i.e. I'll want to collect lots of test cases in different languages
and use cases. A mini test suite, maybe?

I think I'll include these examples in there, too.

Thanks,
Stefan
