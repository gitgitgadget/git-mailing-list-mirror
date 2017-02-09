Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B4BA1FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 22:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752983AbdBIWkj (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 17:40:39 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34741 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752761AbdBIWki (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 17:40:38 -0500
Received: by mail-pf0-f195.google.com with SMTP id o64so75838pfb.1
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 14:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CZXCf2Pr52GWKwKguaUR8w6ILoTemT9yxBi/O7w0xzI=;
        b=lRVkzj/D/KHOVH/sOrwZHQRJlRlVfLSKdLUyUzq8uWdRegq75QG85Wwu9kmb3/cQnA
         Pa1Fx70l4iivRCEkn+fyEDDXnvZ44SIN6p3VUN8WFo01mqP210fKWG3BDbkosSPlFMcA
         aqFctRSc1yGX28DRjO9A6l1Yx+YnA9LnbQEyb6HkvN3I4S64oIjD5+aQ8USV9PNlLX+x
         ROV+qaYhsJR78NlJ2UzRybOhJpzYQlGiYP4zbcg9kW1k1tGbs8LjArYE3M9SLubcsaP/
         5264kKoq0b7ORwnmeYPVGiobKIOUk+HdKgBthSBQhCvV8gGFlL2d9CydEWgzPcoHF+ub
         Vhkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=CZXCf2Pr52GWKwKguaUR8w6ILoTemT9yxBi/O7w0xzI=;
        b=C9qOwLZJtKxqxNQOmq+Is+Zeiu1fAV/navlOfRN/AGoEsSXizfxc5pArbw0gd0QdDL
         mbbJkBsY4Bas+GSaMips/Tbwh3JONGW6/IMipkv4TcroabMjk/qR4TCIWgIpsqU6rKMY
         +YRVCEKDx1l1EnJSmfxXjGeQ19rHnRbgBDTG2rvr9B5ih02e0E0SEF/Gm38jCFbUnVMJ
         rKowDLyaPnV82lAvj9m99CCYkxjcuYfo8WCBctv1NFdP6oUvmSrYvdDQLgo/TTEY1Nde
         BTbSqhj/7JQH3wHCZBIDz1npb11NJ+1LVlsnvqnqUtsBaJXhGOAvv7Bk5U7uXnE9wAxq
         Mxdw==
X-Gm-Message-State: AMke39lIVLq1qHOKMc1xbocxzSyKgVUeNOnM1AJ0xeH2st5h5yARI+ebFZVCToNmSwrOAw==
X-Received: by 10.84.179.99 with SMTP id a90mr7127576plc.139.1486680037853;
        Thu, 09 Feb 2017 14:40:37 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:704f:61dd:c9f4:9782])
        by smtp.gmail.com with ESMTPSA id z74sm31319062pfd.70.2017.02.09.14.40.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Feb 2017 14:40:37 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Let the sequencer handle the grunt work of rebase -i
References: <cover.1472805251.git.johannes.schindelin@gmx.de>
        <cover.1486678952.git.johannes.schindelin@gmx.de>
Date:   Thu, 09 Feb 2017 14:40:36 -0800
In-Reply-To: <cover.1486678952.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Thu, 9 Feb 2017 23:22:59 +0100 (CET)")
Message-ID: <xmqq1sv7ng2j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> After all of these patch series y'all had to review, this is finally the
> one that switches things over.
>
> Please note that it does not (yet) handle the `git rebase -i --root`
> invocation; I tried to focus on the common case, and I rarely use --root
> myself.

As long as the longer-term goal is clear enough and the short-term
approach does not conflict with the goal, solving the most common
problem that yields the largest payback first is absolutely the
right thing to do, and omitting "--root" and/or "-p" and getting the
main use of "-i" right is a great way to start.

>  .gitignore                    |  1 +
>  Makefile                      |  1 +
>  builtin.h                     |  1 +
>  builtin/rebase--helper.c      | 40 ++++++++++++++++++++++++++++++++++++++++
>  git-rebase--interactive.sh    | 13 +++++++++++++
>  git.c                         |  1 +
>  t/t3404-rebase-interactive.sh |  2 +-
>  7 files changed, 58 insertions(+), 1 deletion(-)
>  create mode 100644 builtin/rebase--helper.c

And it is surprisingly short and sweet ;-)

Will queue as js/rebase-helper topic, forked at 6e3a7b3398 ("Git
2.12-rc0", 2017-02-03).

Thanks.


PS. in case if anybody is wondering after reading [*1*], at this
point, I _have_ read the patches not just the cover letter, looked
at the branch name the original author gave to the topic, chose the
local topic name I use, and chose where to fork the topic from, but
have not applied the patches (so I may later end up saying "the
patch does not apply cleanly", "the compiler complains on this
line", or "the new code is inconsistent with this existing code that
is a bit beyond the context of the patch that I did not notice when
I reviewed the patches alone" in a separate message).  I do not have
a new entry for this topic in the draft of "What's cooking" report
yet, or have not decided if the topic would hit 'jch' or 'pu' yet
either.


[Reference]

*1* http://public-inbox.org/git/xmqq7f4zqiyj.fsf@gitster.mtv.corp.google.com
