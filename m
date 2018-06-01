Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF9FC1F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 02:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750941AbeFACtt (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 22:49:49 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:46145 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750724AbeFACtb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 22:49:31 -0400
Received: by mail-pg0-f67.google.com with SMTP id a3-v6so10565977pgt.13
        for <git@vger.kernel.org>; Thu, 31 May 2018 19:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PicWejSsHIwlsTBVPA9byRsuXsUwxp+CfZc8LT4VhmM=;
        b=dVKIv7+cR6yg6kdd73r/cWyiYablQ6bek8Zv1/PWsgCPwleZx3dP0bIxzTfZcUgH02
         76aCCUfpSF9uJ7svH704X+dzrkHhlHhrqvw61H59sgAFsrSYGbo8UKhaWpNiOeXY2UDA
         MXYI/4e2S3iWowO5gGYqSTC6D0SdSJ5fc3goDY/lixhCsZYxJhBo4mGAXToGqHlNTW5w
         XKUqlqCeF/NUPE73yfw3E3w4JF1NXhkumvtbxg7AKecbgJhGtOCKFfANf0oEhVxFyE00
         8MmVpMH3rvNpv9NIVNoRHl81xjCeM2hSe9olop6yWTQ0xc7nW0SpK2nEkcxfyTrYBf5V
         ULqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PicWejSsHIwlsTBVPA9byRsuXsUwxp+CfZc8LT4VhmM=;
        b=HRvXK1+KRGDi05CM0PgkIFwY2EMjCuSO36BEydbwGUHG/hwCD/3Y6GJrX8uZ6Z4awe
         XPEha0mcxiQeMjVLWrkQ39SSwZxyiriJuLBprrdxCk5LVqyu62er/dlIr/rkqILzTEzU
         Yg9gounsvDH/afwO4HLa2ZRzVJhoTd/7lfhqdZrIAB6LtGwrywnC01sd+L6sGF9vIQoe
         dVDxqOYtsPIHy0+LKgTSJGcWiHXLE1TYumjAEcIzWzFx/LME06/jp6omBROfQtSTjW3i
         SxqocwcpV33+LZfsa1rh9U8DYfW7+SrD//FoVMrxdaWPM/q7/pFGOSGGW/joh8K2i1SH
         JqgQ==
X-Gm-Message-State: ALKqPwdas/N/CcBQmzgqK13BEw08DcP/9U1aeUf5xMCYX2sXH7C7Q0yi
        UB0tb5xrRb+SD3JJJHoJOpw=
X-Google-Smtp-Source: ADUXVKIwGi1N+Th6nz+8dyyrXyuM/DEl329dqYAhpFTb5gBw0lSjsfLXYKTAnyGLkF2RSNF+1By6FQ==
X-Received: by 2002:a63:6185:: with SMTP id v127-v6mr7238228pgb.301.1527821370435;
        Thu, 31 May 2018 19:49:30 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id s1-v6sm56183207pgr.66.2018.05.31.19.49.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 May 2018 19:49:29 -0700 (PDT)
Date:   Thu, 31 May 2018 19:49:24 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] fetch: do not pass ref-prefixes for fetch by exact SHA1
Message-ID: <20180601024924.GA111965@aiede.svl.corp.google.com>
References: <20180516225823.235426-1-bmwill@google.com>
 <20180516234822.182663-1-bmwill@google.com>
 <20180516234822.182663-2-bmwill@google.com>
 <20180531072339.GA43435@aiede.svl.corp.google.com>
 <xmqqtvqn9rwa.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtvqn9rwa.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> This patch adds a test to check this behavior that notices another
>> behavior difference between protocol v0 and v2 in the process.  Add a
>> NEEDSWORK comment to clear it up.
>
> Thanks.
>
> I wonder if there is a more effective way to smoke out other bugs
> remaining in proto v2.  When the fetch-by-SHA1 feature was added
> originally, we certainly would have added a test or two to make sure
> it won't break.  The root cause of this breakage is that we lack the
> ability to easily exercise proto v2 on these existing tests that
> were written back in the proto v0 days.  It there were such a way
> (like, a common set of tests that are run with all supported
> protos), we would have caught the breakge even before the topic hit
> 'next'.

I had a similar thought.

I am not sure I agree about the root cause, but root causes are
generally slippery to define.  Because this bug had significant
internal impact, we came up with a few next steps:

- shore up protocol v2 test coverage, as you described

- arrange for long refactoring series we submit to be divided up for
  the team to review, to avoid reviewer fatigue.  Hopefully this will
  make us a better example for other submitters of long series.  We're
  open to cooperating with others --- maybe we can set up a volunteer
  reviewer brigade to get a more diverse set of eyes on each series
  --- though organizing that is harder.

- improve telemetry for our internal deployment, to get earlier notice
  when Git is producing more errors.  I suspect other installations
  may want something like this too --- e.g. I think this is one of the
  benefits of what Jeff Hostetler is starting to build with json-writer.

- help internal users triage errors from Git (like those decision
  trees parents have to help decide when to bring a child to the
  doctor), so that we get earlier notice and can roll back and report
  upstream more quickly when they've run into a Git bug

Or in other words, please expect more in this area soon, and feel free
to pester me if the test coverage doesn't arrive. :)

Thanks,
Jonathan
