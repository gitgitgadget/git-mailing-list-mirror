Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72198C19F2B
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 19:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbiG1THB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 15:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbiG1THA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 15:07:00 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E067645F
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 12:06:59 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id c185so3427488oia.7
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 12:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=2LYE1orm2aksEasl5FbYzvlIWzlk7sN5OJ/nJtL34dA=;
        b=W/8pcHLNUe9nDTn4H/9MSuEpSCa3k8YMblSQsPaPK0YttNduR9Hl1h0GrhSBjgi2R9
         YCsyD7271md+CtNnDGJe6L41zgyMTSSt4YZXcDroHYkbLHi+2CHUMM1EUQNWYnBmiPZd
         x0Gbh2rZCpiSOtXjJP378+pIAUOt31Ldc4/7bQFMTLjjd7imm1wAntJ0A6lDs0x+9gdq
         pejgbeW3DeF0xGLaKnUUZHm0P6AMGLvwih7wW0KkB97Q0iZyDVED97DAWii+CM5QV4CE
         yWW0Y+0s5Fz9H+GPVX46XSI9gB0DZpMx36YWUx7elxYuLhSIwdpJVD6Kpzz6kTlJGaLe
         rmhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=2LYE1orm2aksEasl5FbYzvlIWzlk7sN5OJ/nJtL34dA=;
        b=GgKZhics1cUGhXkQ7NGLfxF6lFzF0gi3YWGl2R9F0/XRt7QCUF1w1eS5cWVIsZ74yH
         dHpsGHeT/7ldaVIxpRmamRZFBwDOUdh6BfegarKfKNPYF2myEKik1lKYIQklUonqMFgm
         gE7SmJkuZwl0Z+VmRPZEJcKDjO6CkkvQVXbtAdzwGh16DeK0JAsglA1WWJQezPqlGnqs
         mNn7DSAdWL3Wv2aTyiokkDryOBY9H5bMTjcHRxZia02lBA7SuMA0DdzYWEX1RqtGkWG3
         cIvDcWaIHc1qkiFW4kSCUc59pFKfc5hDuXz7CM+dvhpkWZo+GnOQ2z8eXmcQYIo2ujzR
         Fvlg==
X-Gm-Message-State: AJIora9m9t9ys3Q5SFnyeJsv5bbM/HAjorxpg/xdobnjvYEmxG3xFY8w
        VBWPFTh2sJwvQTq6WjXgU2gVXrD+gi4Jpnss7whECg==
X-Google-Smtp-Source: AGRyM1v50olepAN7UeTpzzC66glbFo0D1EiAQvtRxsX2Ucc1qGz+86BbxZBjgvqzBZHm2Iz8sG2kU14jrUNGF+6qo4Q=
X-Received: by 2002:a05:6808:1294:b0:33a:de39:89e8 with SMTP id
 a20-20020a056808129400b0033ade3989e8mr96966oiw.236.1659035218686; Thu, 28 Jul
 2022 12:06:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220718214349.3379328-1-calvinwan@google.com>
 <20220726210020.3397249-1-calvinwan@google.com> <CABPp-BGvDLvmj720PFzsjrZrYuYauprL6JeOQhiQ4BjtfjF7Dg@mail.gmail.com>
 <CAFySSZB6bB0qqCv5EPmJBJY9RbDRFv8JDYj89W+ND_Jw6Ys1kA@mail.gmail.com> <CABPp-BF2O9mT4tX-1PuNmNvQwN8S_OmMz-Y8_yCu7tmVO_ZJmA@mail.gmail.com>
In-Reply-To: <CABPp-BF2O9mT4tX-1PuNmNvQwN8S_OmMz-Y8_yCu7tmVO_ZJmA@mail.gmail.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Thu, 28 Jul 2022 12:06:47 -0700
Message-ID: <CAFySSZAfvjHR9SJEwyZ4JB1=uHp+XAxnoxnvekQ=pZ6To46DXg@mail.gmail.com>
Subject: Re: [PATCH v6] submodule merge: update conflict error message
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> For the failed to initialize case, yes we also need a merge -- the
> submodule is conflicted due to the lack of one.  The steps the user
> needs to take are probably even more involved, though (they also need
> to initialize the submodule), so perhaps that one should be special
> cased.

Adding a needswork bit to this one. Don't quite have the bandwidth to
figure out what would be a useful message in this case.

> The 'a' or 'b' being a null oid is actually dead code, as discussed
> earlier in the thread.  Perhaps we should change those two code paths
> from "return 0" to 'BUG("submodule deleted on one side; this should be
> handled outside of merge_submodule()")', and possibly with a commit
> message linking to
> https://lore.kernel.org/git/CABPp-BE0qGwUy80dmVszkJQ+tcpfLRW0OZyErymzhZ9+HWY1mw@mail.gmail.com/
> (and mentioning the "a and b being null oids within merge_submodule
> will never trigger" portion of that email).
>
> The 'o' being a null oid is not dead code.  That particular case means
> that there was no submodule in the merge base, but both sides of the
> merge introduced the submodule and have it checked out to different
> oids.  (At least, hopefully it's the same submodule.)  In that case,
> yes we do need some kind of merge.  So I think your message should
> probably be included in this case, as-is.  Since the cleanup thing you
> mention is an issue, perhaps you need to refactor the code a bit so
> that you can make this case somehow get the same message printed for
> users?
>
> All that said, if you want to defer any or all of this to a follow-on
> series, that's fine...but it would be nice to have it mentioned in the
> commit message.

BUGging out for 'a' and 'b' sounds reasonable to me. And I also do
believe my error message applies to the 'o' case. I'll add a test to
confirm.

> Um...if the string doesn't need to be marked for translation, and
> isn't marked for translation, why would translators go looking for a
> comment to help explain how to translate something that doesn't appear
> in their list of strings they need to translate?

Ahhhhhhhhh I see...facepalm

> Using
>     printf("    git add %s", ...)
> means that the string "    git add %s" will not appear in the po/*.po
> files.  If it had been
>     printf(_("    git add %s"), ...)
> then it would appear in those files with filename(s) and line
> number(s) stating where the string had come from in case translators
> needed to look for clues about the context in order to know how to
> translate the string.
>
> So, I think you can just drop the comment.  Or am I still not
> understanding some nuance here?

You're not missing anything. Wasn't aware of how translators worked
with the project.
