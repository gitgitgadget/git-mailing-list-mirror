Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 621F51F462
	for <e@80x24.org>; Fri, 26 Jul 2019 23:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfGZXWr (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 19:22:47 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:37855 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfGZXWr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 19:22:47 -0400
Received: by mail-ua1-f68.google.com with SMTP id z13so21882638uaa.4
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 16:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZJn5LkYj+iMVPr3zUd70qLYCzj1fXJt8m2lzwGV5+cU=;
        b=l300/bshWJzlKakpSXtC7sgJJpXrehdUhpM8g9paTKkvuOstcQCYM9L5TVqYe9f+Jx
         2vFGqN44qYmT7AUgDSuOhP+M5r1yaZbumkw4B/YY0TeRhZZ11oirOL3LLR5Uo0YuJYO2
         D2L59CbyXOg6uUsGIoWkh3iy+NjX2rVVA7M55wy1W16Skg15uG2azpzD77Y3XAmGAe0q
         meTaem+YDujS9K38Pyf/mu5fL0RDAPdYHlMIl2WiSeH7hF5Na5TCLtjA/OQtoUAKAHtd
         hV2IFl78aJDC9VE+NwURdzNd4neZvgWdVJREQIUU5jKojSNwmCRoFE3pyblCujG30/l4
         YwwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZJn5LkYj+iMVPr3zUd70qLYCzj1fXJt8m2lzwGV5+cU=;
        b=Qsa/5RYI3hsEFrYfXZIaZ+zca+PqqEDhJB9sIfpLlZ1K0koDxTSNhir8htKPwTLJNS
         AfPlLeFlUcrBKMS8TnyIZWXjKklZWFXq8R1pm7igfNH9Rz0j+GaySIFYM5SscxdJYn09
         9MNQjWRY2/nQIIy44tKb+Dne4afSIIft0ur4iHGMIxl9CVvcjLxYAeuAGOcVuV79NfiY
         wcsFkoBr77MU8SDLC8YM2K5UeNXacbISMXjmaBhT+aatRc7rqmZWd2fiIf6OB7Bx1SFX
         9jDLge54LAtJiMdj/mEpwSmJYtrnD9GRp18/Q5AKpc/+hQyFUUHrgpxli5nVcSu4vijh
         XuEw==
X-Gm-Message-State: APjAAAVC1DHjQnhkUH4KbCX4AHvFeBLPw3znQA/AbV3h3s6cKkcluTHJ
        Lr9hT799H/QGBoQUBEynfhXqcAIiXfgcIujIXzM=
X-Google-Smtp-Source: APXvYqx/aEiaKOt00f1GIN440b96Z74K2K31mE5lSAngxwJ8HVVD6bWLld4Etm2Mzu+qUAoqtqt7IgM+D10T/5iJNfg=
X-Received: by 2002:ab0:3159:: with SMTP id e25mr12430824uam.81.1564183366035;
 Fri, 26 Jul 2019 16:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190725174611.14802-1-newren@gmail.com> <20190726155258.28561-1-newren@gmail.com>
 <20190726155258.28561-4-newren@gmail.com> <xmqqftmsobf5.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqftmsobf5.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 26 Jul 2019 16:22:34 -0700
Message-ID: <CABPp-BFZvVDjg0tZM9EHh9cse2j0QXRdbVKmK0emq696xO3sEg@mail.gmail.com>
Subject: Re: [PATCH v2 03/20] Ensure index matches head before invoking merge
 machinery, round N
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 26, 2019 at 12:15 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > ...
> > So, load the index in builtin/merge-recursive.c, reload the in-memory
> > index in builtin/stash.c, and modify the t3030 testcase to correctly
> > setup the index and make sure that the test fails in the expected way
> > (meaning it reports a rename/rename conflict).
>
> The last paragraph is what describes what this step does.  What is
> left unsaid is how that small step relates to the change in the
> larger picture (including the title).  We do want to have a code
> that ensures the index has no higher-stage entries and match HEAD
> at the beginning of merge_recursive backend (as your lengthy preamble
> leading to the paragraph explains), but adding the code to populate
> in-core index to two codepaths does not make them check the condition
> automatically---it is only half the story, no?

Indeed; the other half is the movement of the index==head check in
patch 4 so that it happens immediately and ensures we don't run into
this problem again.  I can add a note to the commit message that the
next patch in the series will be taking care of that half of the
problem.
