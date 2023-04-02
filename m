Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A83C76196
	for <git@archiver.kernel.org>; Sun,  2 Apr 2023 15:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjDBPQc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Apr 2023 11:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjDBPQb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2023 11:16:31 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A27B8A73
        for <git@vger.kernel.org>; Sun,  2 Apr 2023 08:16:30 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id o25-20020a9d4119000000b006a11eb19f8eso13211322ote.5
        for <git@vger.kernel.org>; Sun, 02 Apr 2023 08:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680448589;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oK9Rfuf7vsi0afjw9vm3DYflA8ihU8UniQJadLhgtho=;
        b=h8B20rlAA9ZBhzkHP54seL5XLiw+srjKGOhyJqjy3cmVA2GkgmB0hShcN5nIiilqDw
         CC/cVAf/5BUVUtAujiEsRS2FUgHKNECtfyVmlz8Eq4XyAbXWicDR5vf0Qfo3cXfEBKNP
         OIVPndAE7YRv+1rVFVMVdzJAFY4E1f9cpgNy3YRLew2cHrJTHmxwIZ9aUrVgnlR3asbW
         KS6bxxbw51F5LHuV62+zPmxbhMQaLUlCW/3O8+oSXH9ZKNgE9VanbXPU28Wz1ZoPcALS
         lPaz5t3658Y40L0FxoMvN8I1xJoNJWnB0xV4tYOqlJHRVZRVw3i3SdhODs3yan6YBY1/
         uJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680448589;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oK9Rfuf7vsi0afjw9vm3DYflA8ihU8UniQJadLhgtho=;
        b=IFBzuI+kAa3UGnK5ADQR0cFp4Otv01JCDVHlF8ChUNV04DnbVqXeIXpnLsR3dFzKx1
         gUKtQLRlxHchYdSJnLIwbw3abeFywh5GjyJowEpokc4u+TsAt5nFnKHbYPQGewHfdKZW
         OXsaUlZvh7dNc6DGVgSqHYasRopP8bYJH6RtVrHF3NK2Vl3TwiClNSQvann9Rn0UtSE0
         1r4Ms/5pMI38DYt3ozYuBY/R8YF9O5uCP0erRuAI6gsFg1G8Sx4kO+vvWFGH7SilAZab
         drKhY2rt154ZM50l4Oy/MobZUOUbfCFHnPh9Lv46n7y4+q6MuzIqVUqyykJOSJUGnOC3
         pCHg==
X-Gm-Message-State: AO0yUKWqAHI5bYuszRTynK+IzcjUKqlm+3DW+SMKjkWuyCI8rjb7my0X
        jYcitV9OhUyRIDXiM2GZk3Ue8wbDj3DUmy1HXvPoL3o2Yp216w==
X-Google-Smtp-Source: AK7set8IEd8N0vJO01IvXnJ9zItKLFt1E/WVcULAq2sYTXL0ZYjio+lQy0c14YK3e3rdtAHaEC56BlNsejDRrSwss0A=
X-Received: by 2002:a05:6830:1bcf:b0:697:7885:3e3 with SMTP id
 v15-20020a0568301bcf00b00697788503e3mr10224312ota.4.1680448589600; Sun, 02
 Apr 2023 08:16:29 -0700 (PDT)
MIME-Version: 1.0
From:   Alexandre Garnier <zigarn@gmail.com>
Date:   Sun, 2 Apr 2023 17:16:18 +0200
Message-ID: <CAFFOgCUs9d6wJDf3p-+8UkzXRSymCgBctGt+rP+k0CzZPp2LJw@mail.gmail.com>
Subject: Revision ref '@{push}' not resolved as documented
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

I followed the example of ref '@{push}' in the documentation of
'rev-parse' (https://git-scm.com/docs/git-rev-parse#Documentation/git-rev-parse.txt-emltbranchnamegtpushemegemmasterpushemempushem)
and it doesn't work as documented.
Here is a way to reproduce:

# Setup
$ git init --bare origin.git
$ git clone --bare origin.git myfork.git
$ git clone origin.git local
$ cd local/
$ git commit --allow-empty -m init
$ git push origin
$ git remote add myfork ../myfork.git

# Check for
$ git rev-parse --symbolic-full-name @{upstream}
refs/remotes/origin/main
$ git rev-parse --symbolic-full-name @{push}
refs/remotes/origin/main

# Follow doc's example
$ git config push.default current
$ git config remote.pushdefault myfork
$ git switch -c mybranch origin/main
$ git rev-parse --symbolic-full-name @{upstream}
refs/remotes/origin/main
$ git rev-parse --symbolic-full-name @{push}  # should be
refs/remotes/myfork/mybranch
@{push}
fatal: ambiguous argument '@{push}': unknown revision or path not in
the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'

# Push is done with the expected remote, and only then the ref can be resolved
$ git push
Total 0 (delta 0), reused 0 (delta 0), pack-reused 0
To ../myfork.git
* [new branch] mybranch -> mybranch
$ git rev-parse --symbolic-full-name @{push}
refs/remotes/myfork/mybranch

So it means the branch has to exist in the remote to resolve '@{push}'
as a symbolic ref?
I think I remember that a few years ago the example was working as-is
without the need to push.

If this is the expected behavior (not the best IMHO as it was a way to
check where it is going to be pushed before doing it), documentation
of the ref needs to be updated I think.

Regards,
-- 
Alex Garnier
