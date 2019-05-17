Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD9A91F461
	for <e@80x24.org>; Fri, 17 May 2019 08:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfEQIKC (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 04:10:02 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:43039 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbfEQIKB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 04:10:01 -0400
Received: by mail-wr1-f42.google.com with SMTP id r4so6054689wro.10
        for <git@vger.kernel.org>; Fri, 17 May 2019 01:10:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qbDTGSQymAKW56vxaoLGu5xEolIuGlHW3A+euRQtlpk=;
        b=o4XPO3F5RDGvDBE68fXtqISWVo6EvlNiACc54QPlkAiNmTeWc0Yixm5Jo3duB2LYyE
         7bqys2wqHbhdaIvJoFDTBemj31qtXfRfAV2kbc9IvQvad6LaK0J+GJbE4bzolGmAEWWs
         ihbo+FMJU2R4xbe0dV9M4bk3SnAd8UDadQ4Rb3xU3blfv+eUeqnMT5disdBZZboRk0bp
         zt24ji59MQKIKX/cFZEkjFwXJBMANs8qbQxk6xD+2VCAHW2AY5oT35CtOorY6kuGK1z+
         Ybi1a7IHP3CbSth779oyHofT696fFjn7jTCjlECMHu57e3Zz9OPbE8wvOho82g7YU7A4
         JGKQ==
X-Gm-Message-State: APjAAAUHCPJlsgrH/1YuW1me7DGzwSTcZVjmL7XP85XNGFjerBCecpFa
        a7cESqtDUKsXaUssTuAtSuAlCTtlxvwXxw6uzLA=
X-Google-Smtp-Source: APXvYqxsY/fn5krBdDOG4Tiqaxvv8zUQzZI1RBBwWjSpcR5kZ1afNSu6RqS+N9wNLZmSoFbf9SJP+wntYx0GT9XsmA0=
X-Received: by 2002:a5d:45c1:: with SMTP id b1mr22942213wrs.252.1558080600013;
 Fri, 17 May 2019 01:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAGqZTUvTg5S_-i9JjOwEG75CY+xFXJHAwTqh8uLG3SQTa3O0YA@mail.gmail.com>
In-Reply-To: <CAGqZTUvTg5S_-i9JjOwEG75CY+xFXJHAwTqh8uLG3SQTa3O0YA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 17 May 2019 04:09:48 -0400
Message-ID: <CAPig+cQ0MB4F++JDC-RO2SFA4Hv7DiEW4hNJGQs71Wi75pXuOg@mail.gmail.com>
Subject: Re: getting pull/push/fetch url
To:     clime <clime7@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 17, 2019 at 3:30 AM clime <clime7@gmail.com> wrote:
> for my app, i need to be able get remote urls (fetch/pull/push) so
> that i can derive some information from those, e.g. pull url netloc
> from which i derive where other custom endpoints (binary file storage)
> related to the remote git repo is located. This is just one example. I
> am also using fetch url to store it into the composed package that i
> generate by the app.
>
> Now, the problem is that getting those urls (fetch/pull/push) doesn't
> seem to be an easy task. Currently i have the attached scripts to do
> that. But i noticed that older gits like 1.7 use origin as a fallback
> for pull url whereas the newer raise an error.
>
> My question is if there is a better way to determine the urls that
> would be backward compatible and easier than what i am doing right
> now.

Perhaps not a complete answer (and I'm sure people more familiar with
the topic can provide better direction), but have you tried querying
this information via higher-level commands rather than low-level
git-config? For instance, to get the name of the remote for a branch:

    git branch --list --format='%(upstream:remotename)' $BRANCH

and, to get the fetch URL for a remote:

    git remote get-url $REMOTE

or the push URL:

    git remote get-url --push $REMOTE
