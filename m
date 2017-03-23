Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F6A720323
	for <e@80x24.org>; Thu, 23 Mar 2017 00:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751933AbdCWAxr (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 20:53:47 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35417 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751837AbdCWAxq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 20:53:46 -0400
Received: by mail-pg0-f66.google.com with SMTP id g2so33117048pge.2
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 17:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LXmJPxayTtoQ9FFxgdWHJ0EKijhLPIS/Sx65AeXtwPs=;
        b=Yu3WdlwXLoQy3qQBFRmNOWx0NArhES5krBcO3HXhFpJMm6QZwkAQlKgJC5bu23tcs7
         UcGO5P9skzzjg07sX5Fyk0HxI6JRQiRXW1U3nEwjq3Xg16eHQlNwSx+T1KPXSwNbKWeZ
         sqksoh0x/wLxp+GdPVSbcgAlY42OeaO+1QEjwldhAEgFtQaOwH/R2d81WHDPddpXXkZf
         m37vAYmSybkDhq5PyB/H7Sbi/7VLfobV0NlYqhKTzfaJbiekwFt7K7Dbts5mdQoz22Id
         v7c26qdMOc8RfMItLjRVwte+ykSyhvxbVdFibD3W9KO1EDPEw6JsTMnm5zVQZmB0NIOe
         d0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LXmJPxayTtoQ9FFxgdWHJ0EKijhLPIS/Sx65AeXtwPs=;
        b=oqeWQCg1wtei9om7tqpCaXY1e+1UkjD8KdQSsOd4QwrO0jVEJcVeAtP+DdcmNKZWa4
         gqWBZZpL7/1KGEU2G1LzCheGr1Lm54apPihgyUSSndEXV3pkNXuio6iRzNE6x+zBwvgg
         jiRxgUdh/RuyxBgQXfs8LsOvaC+F/dHoASKZ7qTFg9IfoAwkib631XpCLDw0t1ZC1zTW
         A14dMdJO/q4tEQjeLD+NGo7y5QnnuzOQP111ut1L4ewJVe9UxCd6Cv+GDMJ37n9X23/H
         wP5N9wIUbyd7JPotcPim0cTAs5noNv1EVYJlAM+R6fAyTGIsW1voGZZlrvxwPHbIUtob
         Xnbg==
X-Gm-Message-State: AFeK/H2p6Z9gmEJX24XNl7tePLf51BT97vYRT50VVTphb0aFUpC0chbfZ7WCAfShCAOvqw==
X-Received: by 10.98.80.93 with SMTP id e90mr50780725pfb.7.1490230424477;
        Wed, 22 Mar 2017 17:53:44 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:55f5:992d:bc78:c749])
        by smtp.gmail.com with ESMTPSA id v11sm6112355pfk.32.2017.03.22.17.53.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 22 Mar 2017 17:53:43 -0700 (PDT)
Date:   Wed, 22 Mar 2017 17:53:41 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH 1/3] submodule.c: port is_submodule_modified to use
 porcelain 2
Message-ID: <20170323005341.GH26108@aiede.mtv.corp.google.com>
References: <20170323004329.15892-1-sbeller@google.com>
 <20170323004329.15892-2-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170323004329.15892-2-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> Migrate 'is_submodule_modified' to the new porcelain format of
> git-status.
>
> As the old porcelain only reported ' M' for submodules, no
> matter what happened inside the submodule (untracked files,
> changes to tracked files or move of HEAD), the new API
> properly reports the different scenarios.
[...]
>  submodule.c | 53 ++++++++++++++++++++++++-----------------------------
>  1 file changed, 24 insertions(+), 29 deletions(-)

Neat.  Is this something that could be covered in tests, or should I
be patient and rely on patch 3/3 for that?

I think this would be easier to understand if it were two patches: one
that switched to --porcelain=2 with no change in behavior, and another
that took advantage of --porcelain=2 to return richer information.  As
is, I had trouble verifying that this isn't going to break anything
--- there's not enough local information here and in submodule.h to
tell what callers may rely on and I didn't audit callers.

Thanks and hope that helps,
Jonathan
