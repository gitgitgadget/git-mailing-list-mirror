Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFDE820A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 19:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730460AbeLNTK7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 14:10:59 -0500
Received: from mail-io1-f54.google.com ([209.85.166.54]:38127 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730410AbeLNTK7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 14:10:59 -0500
Received: by mail-io1-f54.google.com with SMTP id l14so5278737ioj.5
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 11:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=khv48W5VEMGl8Zv3GZfG0srs6E7+3EVJQyA/3ODNz+c=;
        b=MAqISEalqFwsRI8n7zc+DCbWHAn2FkKUpvrQqDDQNhPWtU9sXPo2OCUA+/WAzNnGk0
         v/7pOHMQnSEUtqY5/QlT4PMmfw2vY6WhZ3udHGCPro9iDcF6SctlPPEF77HtXuaoV9tM
         WDtrMjMpYsvP7Ak3WDN7GFsMH+FDTc8EAZw5l0qOEAvh/0HMtdqkUzwax3CbeQ6uZllq
         dL4UIKC3+6YD3a374nxZGgDAJSBhsDk6oFcnreYFRe+u6CIOjBAephZ5Y8N5BAvXgc3e
         L5XqecL9AqUpEPtXTz+W7zWvDYNhn+DS4hLjp2SdRwmvRfs3qvHRvelYbXqZFcL9PaEJ
         wFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=khv48W5VEMGl8Zv3GZfG0srs6E7+3EVJQyA/3ODNz+c=;
        b=hbCirUK61pVEV7cGkeoaLYUVuRxK0ZIcEfr4oBnpsBiFDCRItf74DYAQkMShR4PJFq
         0UPVYPP5w+S+qcibr9cQsCsRVhfjw/EybcMFSyyc6BRXd2RKHTczCRXjfX5s4U9ejhuR
         fyJ8TdY8f3aTP+vlkROijIcmpkHs4hPneXF8CORerA1Rc53b5iBonAlgv4YVk4t1VWlv
         /gVXMxIyrIDjuK0A2kC0DPLbaCFgn3kopUAzskn8Z1uprA9oYk2XNo7q8u/K/aRQYc8C
         KwpMFuUccsYsjN4rzPKDPL8I/kfiihYwwlpqbZgoIWjFvDiBXdeofYyOG2uikmFo2UUM
         fbcw==
X-Gm-Message-State: AA+aEWZbFzE9xnLpntqt5mtebiWhvtBFHmnhbP3FBxnVaLBwYBzIBQlk
        FQB7Xv5FIM9ExjXqRYPnls/QmlR8bOUpownGbp+87EZzWpw=
X-Google-Smtp-Source: AFSGD/U4TJhRMElrKEFfAESV6OP0rqWuhiUIY2ptiZI1nil9cNPt7m82XI2FpfQc2AZr/Og2H5HpECHDjXeQh0/HN9Y=
X-Received: by 2002:a6b:f80e:: with SMTP id o14mr3733471ioh.68.1544814658107;
 Fri, 14 Dec 2018 11:10:58 -0800 (PST)
MIME-Version: 1.0
References: <CABXAcUzoNJ6s3=2xZfWYQUZ_AUefwP=5UVUgMnafKHHtufzbSA@mail.gmail.com>
In-Reply-To: <CABXAcUzoNJ6s3=2xZfWYQUZ_AUefwP=5UVUgMnafKHHtufzbSA@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Fri, 14 Dec 2018 11:10:47 -0800
Message-ID: <CAGyf7-EZaiVBnoBfRJXAK7KdaXzPaDFVocUrB8LQNU_Hi16u7g@mail.gmail.com>
Subject: Re: Git blame performance on files with a lot of history
To:     clement.moyroud@gmail.com
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 14, 2018 at 10:29 AM Clement Moyroud
<clement.moyroud@gmail.com> wrote:
>
> Hello,
>
> My group at work is migrating a CVS repo to Git. The biggest issue we
> face so far is the performance of git blame, especially compared to
> CVS on the same file. One file especially causes us trouble: it's a
> 30k lines file with 25 years of history in 3k+ commits. The complete
> repo has 200k+ commits over that same period of time.

After you converted the repository from CVS to Git, did you run a manual repack?

The process of converting a repository from another SCM often results
in poor delta chain selections which result in a repository that's
unnecessarily large on disk, and/or performs quite slowly.

Something like `git repack -Adf --depth=50 --window=200` discards the
existing delta chains and chooses new ones, and may result in
significantly improved performance. A smaller depth, like --depth=20,
might result in even more performance improvement, but may also make
the repository larger on disk; you'll need to find the balance that
works for you.

Might be something worth testing, if you haven't?

Bryan
