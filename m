Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71DBA1F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 07:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbeJLPG2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 11:06:28 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53309 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbeJLPG2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 11:06:28 -0400
Received: by mail-wm1-f65.google.com with SMTP id y11-v6so11295358wma.3
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 00:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=u5gdkRYorQsBoQkLh0Ml5S88ktQHEj8ajNS9UXMsaoo=;
        b=FjXZIexmFcGkxqpT2PDS470T6HrsZ7fMQE8ZFUcr4/hu1ffqZgoQv2Dh24Qlxg6lti
         TBmUCtUHxP7zcauEJK4d6B9h+7M85KMbnPcd+cM4+KLLLesA4yiHzHdn+sexBSpTnHcG
         SiIBeJLwCuJBUu1mEnEM1FBlikaR0I/GT02NOUABWHoQszapnlf5w6w7g8TbGH9pa5qw
         0ds6qfRg9nSXzvuOgP3bNElw0sMVmSaeBUbVIFnWIBahFyIm3a5dOPP0NFm+pOXkWrJi
         lOMbkJPHZRPBxzrZEqEoRmX3QXCCHu7o84DJUX/qASydNh1io8KZSNO2lkvGuMlqrSSE
         NldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=u5gdkRYorQsBoQkLh0Ml5S88ktQHEj8ajNS9UXMsaoo=;
        b=U026S0Tjm6XmscO4Nxx8YjvV3uG0G5DcAnabXttUoDKXAM0QToqVimXA4aUSw7J2S4
         h3vOT6x6lxnYMP5UJrghkzK2m6rGV3kUWpUJh5BBiG1062cuZDL5L+nKCjAZINk8uK74
         uXmsNlK25EEFb/lt+HM6DRzYI04K3mqv6MZ6B2hSP0FXsTtwUzAjnOBetDsSylD0jtNU
         /7WCkNI8UnW2Ksn5ovuiaLt4w9Bp78n/YKJaaTrVFwrl9rJ+zp8I1Sq8V065IB9M0tVj
         1qhUYiGuR8RRnp8OnI8Eno+m5f2rf3DyLi9A+DMvUsM/XTVkonQaaVklkBvJH8xTK/zK
         gIJQ==
X-Gm-Message-State: ABuFfog8N0RcZc03fgblPzae/ODWlVzqCuaiWQ2l6lbEHFSn4zwq5veO
        hJp8HNSt1ee1q51EqdhYWHU=
X-Google-Smtp-Source: ACcGV610alG6JsaD3A05MK8SZs9LEqPcsxSwdkRgsO+yKduy2NMI4aGci1tq07eXF89VXsPsG9USkQ==
X-Received: by 2002:a1c:8b94:: with SMTP id n142-v6mr4429422wmd.38.1539329718775;
        Fri, 12 Oct 2018 00:35:18 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b5-v6sm218056wrr.94.2018.10.12.00.35.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 00:35:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Roger Strain <rstrain@swri.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Multiple subtree split fixes regarding complex repos
References: <20180928183540.48968-1-roger.strain@swri.org>
        <20181011194605.19518-1-rstrain@swri.org>
Date:   Fri, 12 Oct 2018 16:35:16 +0900
In-Reply-To: <20181011194605.19518-1-rstrain@swri.org> (Roger Strain's message
        of "Thu, 11 Oct 2018 14:46:01 -0500")
Message-ID: <xmqqk1mnbosr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Roger Strain <rstrain@swri.org> writes:

> After doing some testing at scale, determined that one call was
> taking too long; replaced that with an alternate call which
> returns the same data significantly faster.

Curious where the time goes.  Do you know?

> Also, if anyone has any other feedback on these I'd really love to
> hear it. It's working better for us (as in, it actually generates

The previous one is already in 'next'; please make it incremental
with explanation as to why "show -s" is worse than "log -1" (but see
below).

>                 # processing commit without normal parent information;
>                 # fetch from repo
> -               parents=$(git show -s --pretty=%P "$rev")
> +               parents=$(git log --pretty=%P -n 1 "$rev")

If you want to learn the parents of a given commit:

	$ git help revisions

says

       <rev>^@, e.g. HEAD^@
           A suffix ^ followed by an at sign is the same as listing all parents of <rev>
           (meaning, include anything reachable from its parents, but not the commit
           itself).

so

		parents=$(git rev-parse "$rev^@")

ought to be the most efficient way to do this, I suspect.
