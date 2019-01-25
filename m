Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7F151F453
	for <e@80x24.org>; Fri, 25 Jan 2019 19:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfAYT4v (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 14:56:51 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40349 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfAYT4v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 14:56:51 -0500
Received: by mail-ed1-f67.google.com with SMTP id g22so8282587edr.7
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 11:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/gS9VBM7pZIAUVpXispvELxOKxerYEpoTxtKybPWgCI=;
        b=UJ6uyW+Kax0CK612yNUhSvkpznzcwM++T2rAX+utST+x1RP+xUxj+fy+AF/TqICYB1
         LQYqwfGKwQzTWyFjE0zlN2yllw4WiS+QLu3090aegMaoUOvZeLoblhLWJro53Ewd5PpG
         OwzoWNwKlOJBO8VX6BQYEwtAsJMy/i3vmPp6b801/hBKpwFRvKJ/5VqFWJDk+WUV/2XV
         kd5HH2jgf9u1lekHYhEzNNLjtD7KWPmq7SgJ5QJfgA5AM8eQaRpP4PDBrmau7wjIlJMx
         5V4T3I5WWcKmzoWHxiukJwF1zd218bHtEZnvoG+jq7w9VulmgBM73O6WCWeN+Sv9N5Ql
         Amlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/gS9VBM7pZIAUVpXispvELxOKxerYEpoTxtKybPWgCI=;
        b=cB8GOAqMhCGj35J08FMlLUg0XiQZ/xHHmixZcorseLX1kUVO8sHhc9JBbFbSA8vCVT
         zU1PkLue531IDduBy5UwaOZjyIiEvzFjHCoCs2noqHcFFLg4FRe870nVKfEv51uO0IKL
         6GGEw1Nuzd3aR3WE+o/Ju4/DYg7gTVS0ai5zXfXQWp/XNf/UR9zW5OqxrvNpGB02L5AM
         8LaM1ju2Gfo8VawIQ73WJIr6VCWhB69siB9LroawTJu5eCTLqzOZQ7DNzehHQRBDmz/e
         gH6RjqUu16jqqejmh+wGSzCSrMO9ehD0ISKuj+zpVrBAfL6qdJFwdJXzCl9fINStzWIa
         nQoA==
X-Gm-Message-State: AJcUukeYH28CIJDa+/YExHVt/aLUsyM9cZFlVqqG5093uAvnwSxqfEzc
        HIT9jiRjSd+YDBlFryu+0tN4TjQfmTFGr3Pms/qJzw==
X-Google-Smtp-Source: ALg8bN7qziw5ke6ZFMZZ67p8amVT+BBUpmwbh+BmgcW2amXWWuUj1PqZmekInfJlAVEuVpefQkX/q7hNR/5d+Hq0QrY=
X-Received: by 2002:a17:906:cb2:: with SMTP id k18-v6mr10838538ejh.129.1548446209086;
 Fri, 25 Jan 2019 11:56:49 -0800 (PST)
MIME-Version: 1.0
References: <20181204224238.50966-1-jonathantanmy@google.com> <20190125153348.GF6702@szeder.dev>
In-Reply-To: <20190125153348.GF6702@szeder.dev>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 25 Jan 2019 11:56:38 -0800
Message-ID: <CAGZ79kZRnuTU3ukP1UdBUZD1x+nubYSwLxYgJse1mcj8JUOa2g@mail.gmail.com>
Subject: Re: Regression in: [PATCH on sb/more-repo-in-api] revision: use
 commit graph in get_reference()
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Have fun! :)

$ git gc
...
Computing commit graph generation numbers: 100% (164264/164264), done.
$ ./git version
git version 2.20.1.775.g2313a6b87fe.dirty
# pu + one commit addressing
# https://public-inbox.org/git/CAGZ79kaUg3NTRPRi5mLk6ag87iDB_Ltq_kEiLwZ2HGZ+-Vsd8w@mail.gmail.com/

$ ./git -c core.commitGraph=false describe --dirty --all
remotes/gitgitgadget/pu-1-g03745a36e6
$ ./git -c core.commitGraph=true describe --dirty --all
remotes/gitgitgadget/pu-1-g03745a36e6
$ ./git -c core.commitGraph=true describe --dirty
v2.20.1-776-g03745a36e6
$ ./git -c core.commitGraph=false describe --dirty
v2.20.1-776-g03745a36e6

it looks like it is working correctly here?
Or did I miss some hint as in how to setup the reproduction properly?
