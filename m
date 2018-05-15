Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52DC21F406
	for <e@80x24.org>; Tue, 15 May 2018 01:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752090AbeEOBOH (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 21:14:07 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:38567 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752057AbeEOBOG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 21:14:06 -0400
Received: by mail-yw0-f193.google.com with SMTP id y123-v6so4183862ywa.5
        for <git@vger.kernel.org>; Mon, 14 May 2018 18:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+M5x7tm5o/SGELkoFl3bD8i8xkiS/w46PC0LD2GWA7w=;
        b=kj4J4u+iv1JM74Gcbc05qZD0r9OIXJMFG8jW/jnIU8fLtYTVeiS61m/FxthE4N1QLj
         jnUYZCJ294jdBDqdvq10zHkqCRlkTYLlHUoWTQm8a5nO+I/hoT3O1Epf90NnsfzEYCcg
         5KUu4Pv1xiV7gcjwF5ZQgbguHGLcumlgqIkr6UY7UI0L9JLnw58b0tGPt2spU169iacW
         zzIpPFEJwD7p0pLcGl2rzxNut7xX/Tatvgary9x0TwtKBl8TRqo8K1cHm5/jwdfV2mh2
         QhAO21JEWK+ctacAJXzqfMtYy+VUIurW79DDdrsUdORPgZlndYzEIGa/R28ofPVEJptK
         ltxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+M5x7tm5o/SGELkoFl3bD8i8xkiS/w46PC0LD2GWA7w=;
        b=nkcs5OosLJck4P9sVVQTDOvDqJS7bvaAMTgMExM36uSJPEOUd4hi5t/fyw8oUM9WEZ
         qmW7eLZXBUrauB6ZjjYoLSUZgq+AMoDWH+fqfA7lQ73PuBObec0avf6MF2a7cP6q1jW8
         UPQADV+llSAUJmaMeBCqAtQ+5/n71q5M7dyZlcSptY9aXvk1Bb8D71+XMHnAcysWHdhy
         uMc6J80/OP6q9Fi6lnMa+MR4iGm12HpLzEjLXhQEeMnlrcTQ8aoyWKbenDiKpqLAjaMe
         7oBkBmYG5VdyJVNH7W8JlXFcpmSaiKm35zHshokqbThK3J491GClPXyfJILTogPgHV/v
         2Jsw==
X-Gm-Message-State: ALKqPwczA+9vW9PQv5ihqqNWRgmXVg4SM+tOjDTELzLVRjpoyNSUzvhq
        GyZbMHhYHJMqq4Ufuk2GM4POaEzSGZf5HXhbFVjkLw==
X-Google-Smtp-Source: AB8JxZq3ZyR+nYrEAfSf2x/x+Q/V32e0h/QEjGHzne68igQCgnVka5YYb8V+RBzN61HQOm2EUHxVLZt7gi/pMCAWkJg=
X-Received: by 2002:a81:9447:: with SMTP id l68-v6mr5431799ywg.345.1526346845318;
 Mon, 14 May 2018 18:14:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cfd8:0:0:0:0:0 with HTTP; Mon, 14 May 2018 18:14:04
 -0700 (PDT)
In-Reply-To: <20180514105823.8378-1-ao2@ao2.it>
References: <20180514105823.8378-1-ao2@ao2.it>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 14 May 2018 18:14:04 -0700
Message-ID: <CAGZ79kYACxYyUKz95cRL_HeeCxzyG28sbTF+xO4KBgYW89PqaA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/10] Make submodules work if .gitmodules is not
 checked out
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>,
        =?UTF-8?Q?Daniel_Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Antonio,

thanks for sending this series! Happy to review it!

>   - my git terminology may still be a little off: do "work tree" and
>     "work directory" mean the same thing?

Back in the old days, you had a "worktree" which is a directory where
things are checked out and you modify files. It sort of the opposite of the
"git directory", which git uses to store all its information.

Then quite some time later, the command git-worktree was invented.
Now we had 2 things with the same name, which is unfortunate.
But as the command git-worktree added more of these directories
that you could work in, the name collision was not apparent.

Later when people noticed the subtle difference between the
command and the thing on the file system, consensus seemed to be
that the thing on the file system should rather be called "working tree"
such that it sounds very similar but is distinguishable from the command.

However the outcome of the discussion did not yield a bi&complete
refactoring of the code base, such that there are still places with "worktree"
referring to the thing on the FS, "working trees".

I am not aware that "working directory" is an official term we use in
any documentation for Git, but it sounds like you mean a "working tree".
(From a point of view not based on the version control, "working directory"
may sound more correct, note however as the directories in Git are
named trees, the working "tree" sounds as if you can make changes to
Git trees, ... which you can. :) )

> If anyone wanted to pick up and finish the work feel free to do so,
> otherwise please comment and I'll try to address issues as time permits.

First let's review this series. :)

Thanks,
Stefan
