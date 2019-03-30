Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_HK_NAME_DR shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17926202BB
	for <e@80x24.org>; Sat, 30 Mar 2019 19:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730933AbfC3Twb (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 15:52:31 -0400
Received: from vwp8955.webpack.hosteurope.de ([176.28.35.119]:33012 "EHLO
        vwp8955.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730542AbfC3Twa (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 30 Mar 2019 15:52:30 -0400
X-Greylist: delayed 1023 seconds by postgrey-1.27 at vger.kernel.org; Sat, 30 Mar 2019 15:52:29 EDT
Received: from mail-lj1-f176.google.com ([209.85.208.176]); authenticated
        by vwp8955.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1hAJlE-00006b-JI; Sat, 30 Mar 2019 20:35:24 +0100
Received: by mail-lj1-f176.google.com with SMTP id f18so4732041lja.10
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 12:35:24 -0700 (PDT)
X-Gm-Message-State: APjAAAV1s23Dyuj4fncRsqSnI6V9UWPbIyO/IKkaFZ5U7AHOZaRxiHK9
        R6dRk1pSGPfm+IvBpPn5kyO2lVUdaRp93GSp8xM=
X-Google-Smtp-Source: APXvYqzh3jOaTKOyRBpCIguh2kW7Xu4kkja9BApCU0yfFP/7APz/4/+BFhdBU6qlb7ixpxP2VR76rMYagjOMPqiQjcI=
X-Received: by 2002:a2e:7114:: with SMTP id m20mr30735579ljc.120.1553974524134;
 Sat, 30 Mar 2019 12:35:24 -0700 (PDT)
MIME-Version: 1.0
From:   "Dr. Adam Nielsen" <info@drnielsen.de>
Date:   Sat, 30 Mar 2019 20:35:13 +0100
X-Gmail-Original-Message-ID: <CAKrvxcUkLcJ782xe-ETAPNWvD-zv_KXmu0VxRPvJhOGnrChVOg@mail.gmail.com>
Message-ID: <CAKrvxcUkLcJ782xe-ETAPNWvD-zv_KXmu0VxRPvJhOGnrChVOg@mail.gmail.com>
Subject: Typo in the .gitignore docs?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-bounce-key: webpack.hosteurope.de;info@drnielsen.de;1553975549;28377bd2;
X-HE-SMSGID: 1hAJlE-00006b-JI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

I think there is a typo in the gitignore docs.

Its stated on https://git-scm.com/docs/gitignore that

>If the pattern does not contain a slash /, Git treats it as a shell
>glob pattern and checks for a match against the pathname relative to
>the location of the .gitignore file (relative to the toplevel of the
>work tree if not from a .gitignore file).

I think that maybe two things are not 100% correct. First I think it
should be "If the pattern does contain" instead of "does not contain".
Secondly, I think it should be mentioned that this is only true for
slashes that are not a trailing slash.

You find discussions about this at
https://github.com/git/git-scm.com/issues/1332 and at
https://stackoverflow.com/a/41761521/2311074

Here is my proposal for an alternative, maybe more clear version:

>Whenever you have a string that contains a non-trailing slash "/" , its always considered from
>the root. There is no difference between foo/bar and /foo/bar. The pattern foo/ is not
>considered from the root, because it has no non-trailing slash "/".
>One may match a path that does not start at the root by using "**" (see below).

Also since we are on it, I would suggest to reduce

>If the pattern ends with a slash, it is removed for the purpose of the following description, but it
>would only find a match with a directory. In other words, foo/ will match a directory foo and
>paths underneath it, but will not match a regular file or a symbolic link foo (this is consistent
>with the way how pathspec works in general in Git).

to

>If the pattern ends with a slash, it would only find a match with a directory. In other words, foo/
>will match a directory foo and paths underneath it, but will not match a regular file or a
>symbolic link foo.

What do you think?

Best regards,
Adam
