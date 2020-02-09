Return-Path: <SRS0=3Zv9=35=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C01C35250
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 15:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CA1920733
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 15:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Elzptb2Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbgBIPAX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Feb 2020 10:00:23 -0500
Received: from mail-qv1-f49.google.com ([209.85.219.49]:37732 "EHLO
        mail-qv1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbgBIPAW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Feb 2020 10:00:22 -0500
Received: by mail-qv1-f49.google.com with SMTP id m5so2003047qvv.4
        for <git@vger.kernel.org>; Sun, 09 Feb 2020 07:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=q55aozWlVLb23WtZuigjY+euJTWHHRUCrsSwLH9bA/I=;
        b=Elzptb2ZWanxFUzqD8u413AITR59uEmCOe0EdcCF/U62B8rcsfFGNF6AFs2o0fNAxv
         wckycXV39CiL3eA6Uf5FGX0kYs4leLHvC6xNZEipdGLXsmE8X87rlY5SII9Y9itNxBXD
         nNdhpretTYrnGRrs8T9Y8u69gsR7ZDsOhxVeqoGcbYyr/RlWJ6Vt1/3ptZ1+fFVdrrrg
         M2df2L5U41sGCwkw4rOdF4rPGUz0pjoi/41viJUBubSxSAXOwzeloQ2vkkjEi1AqCcoi
         04XyXby/XgLBcIvACubOH8i8YD48/qzBUqibLV1U61LlSOh7UUtEaFVQQIz6NRKvUYny
         uZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=q55aozWlVLb23WtZuigjY+euJTWHHRUCrsSwLH9bA/I=;
        b=Nall4kwuXOIPc+sYzvcUK+tzjnoRcoKkXgo7XgrpP1q+hE3FUQuGsCqnCdp42qXxdE
         s6TsC1AlZkmS+XF0J01+TSVtOkXSQYIQwBP9QPpPQNTmGsq++7yk11HBNnb1eJ/hvawc
         hf4Quk6L1VGisKxyeJ80gtSOB4kMvqU/DAtKaakz6bfJVihoCEonP6DQcAuc6REuqkPD
         cXDsMd02d+3Wg7wI/GW8YVVo2lZ478icNpF0UB/AAXKENRaQ7PqCZ+R3pO+jGD+GcqjA
         eLODqu1ynjIGryaln2J13bVuoQtLYWptcsjbX9+OmFfoin8rxlOjoGyKPtDEvCW4lbUw
         MUNQ==
X-Gm-Message-State: APjAAAUHdVmSwgcZR9spFNDo9yWckFaAPnhYZDRiLvQGRB32kxHn0PyW
        je+mbvFkYI14zkH1dETv+2njbFHGJc7SaFkLwxA=
X-Google-Smtp-Source: APXvYqypWwsaNYmkKNtddwI1tALRyARCXC4zHEuSuPp1jfZIshVUi/hZl7rnTwEZceffijJK8iG1DOLSrN89YJsW/SE=
X-Received: by 2002:a0c:e014:: with SMTP id j20mr6697988qvk.165.1581260421471;
 Sun, 09 Feb 2020 07:00:21 -0800 (PST)
MIME-Version: 1.0
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
Date:   Sun, 9 Feb 2020 20:30:00 +0530
Message-ID: <CAHk66fte4Rv199jJ8xgrpkzyonyXdhtYzn4fPA7mWPrKA9v2zA@mail.gmail.com>
Subject: Re: Conversion of 'git submodule' to C: need some help
To:     shouryashukla.oo@gmail.com
Cc:     Johannes.Schindelin@gmx.de, chriscool@tuxfamily.org,
        git@vger.kernel.org, peff@peff.net, t.gummerer@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greetings Shourya

> 1. What exactly are we aiming in [3]? To replace the function completely
> or to just add some 'repo_submodule_init' functionality?

We are aiming to convert calls to use `repo_submodule_init` instead
and remove this function.

If they differ in functionality, implement any changes to
`repo_submodule_init` such that code that already uses it runs without
any modifications.

> 2. Something I inferred was that functions with names of the pattern 'strbuf_git_*'
> are trying to 'create a path' (are they physically creating the path or just instructing git about them?)

`strbuf_git_*` construct a path to the git directory and append it to
the string buffer passed. They are not physically creating folders,
just creating a string variable that stores the path.
If anything, it returns -1 when the git directory does not exist already. [1]

> while functions of the pattern 'git_*' are trying to check some conditions denoted
> by their function names(for instance  'git_config_rename_section_in_file')?
> Is this inference correct to some extent?

While I cannot talk about whether your inference is correct,
`git_config_rename_section_in_file` does not **just** check the
condition.

In the case of `remove_path_from_submodules` (where I am guessing you
had this doubt), it removes the section from `.gitmodules` and returns
a negative value on failure [2]

It's a common idiom in C - Functions with intended side effects return
non zero (usually negative) values on failure and zero otherwise. [3]

3. Not sure what you mean. Do elaborate.

4. Yes! Everyone has to begin at some point and learn. Feel free to
ask more questions when in doubt.

Regards
Abhishek

[1]: https://github.com/git/git/blob/de93cc14ab7e8db7645d8dbe4fd2603f76d5851f/submodule.c#L2257
[2]: https://github.com/git/git/blob/de93cc14ab7e8db7645d8dbe4fd2603f76d5851f/config.c#L3051
[3]: https://wiki.c2.com/?CeeIdioms
