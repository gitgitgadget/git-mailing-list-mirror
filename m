Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CA2C433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 01:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44F73604E9
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 01:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243745AbhIXBcG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 21:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243687AbhIXBcG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 21:32:06 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056C6C061574
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 18:30:34 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id y201so12395463oie.3
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 18:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3tcBvpzYkX4shnXE9dx6avXP6qiPp1oNsk843JXSLCo=;
        b=W8PjScyfzSB/+p8t5fMZvm/QIyqzcN/BvZdE6ZTKpovIOPHe6BZtZAfTCus+AbB+ZG
         n23D1QnIEvEAu9g3DZ/jD48vj45UmS/EONDEgnAzlOl5ZFDeitnUE0O4nepJuNdVRmBj
         aWv/nG21E4bJ28illFgtjmATvW85M/81xaaN6VasHJCSXrqb9zrtUw0NbUM/EIPLjiGa
         1zPJ8L4sBYMu3Bydsjw5HZaB5qzASWoDbcHyFZsPnLnF0AM1+CAOmDLWQ+nwJXDa8sfp
         r3zPZjbctnGBoQqUtdMTOpGs7Ng9VGVWqWdUu1n7n5ppbAw618W9K0q2npXPjjMX7cb7
         Tosg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3tcBvpzYkX4shnXE9dx6avXP6qiPp1oNsk843JXSLCo=;
        b=azdjy3x5NZbYk2O7xtsdLyQpZWaEi6PkQ+0NG8UtznRxKR7CBTfybb6vr8J2lKjEna
         Q/HpLAWwRL7J3sdYrAza08DgvWraDevq57ksrQ8VWA3IHEJ4aJ/lal/gdHgxTOuAjIoS
         M5VDPIYSloF3ku3ICUPqIQvIfIC9Ke8xCJ2AZtBMGQiwYKHTrNhuI0KuP4bC8gqrruOX
         FQqfU2Bmr3HdYzDOpJ+mo5WlAL6H9rvZrW8x7iUuNU2u3rQHyJmFy1riMQ+S2/saupyw
         2TTQ4o/G4fq6Dd28eRDwqS7I7o4VncrETgbjmcHNveMrRtQqAtZWQkBN+9/5qDVmcsyP
         +V4A==
X-Gm-Message-State: AOAM531kYQJ7/Fl+OPORFkrZziSJHA6vyy2eTYnATWN29ZOgX4PDT4yi
        t/6oHmFbF0fzsOLhwJ9YV/9bekpKGzQh9FJlgJIPlX+Kkm8=
X-Google-Smtp-Source: ABdhPJxEVFx6lPtcjtXoX1vpTXeikwiCLJJK4ainxE2Qk+oRg0u3k5P/o3fkQgxGtonNiG8elpYNvopBF4ts7oWuXyI=
X-Received: by 2002:a05:6808:1a29:: with SMTP id bk41mr14879990oib.167.1632447033331;
 Thu, 23 Sep 2021 18:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqa6k2yj1j.fsf@gitster.g>
In-Reply-To: <xmqqa6k2yj1j.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 23 Sep 2021 18:30:21 -0700
Message-ID: <CABPp-BFXrdj7ZV5LYW0cLghzX1Q8a=NuBfWaUsj4JO9m+v7yxw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2021, #07; Thu, 23)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 23, 2021 at 4:24 PM Junio C Hamano <gitster@pobox.com> wrote:

> * pw/rebase-of-a-tag-fix (2021-09-22) 10 commits
>  - rebase: dereference tags
>  - rebase: use lookup_commit_reference_by_name()
>  - rebase: use our standard error return value
>  - t3407: rework rebase --quit tests
>  - t3407: strengthen rebase --abort tests
>  - t3407: use test_path_is_missing
>  - t3407: rename a variable
>  - t3407: use test_cmp_rev
>  - t3407: use test_commit
>  - t3407: run tests in $TEST_DIRECTORY
>
>  "git rebase <upstream> <tag>" failed when aborted in the middle, as
>  it mistakenly tried to write the tag object instead of peeling it
>  to HEAD.
>
>  Will merge to 'next'?

I think so; the series looks good to me, and it appears Phillip
addressed everyone else's feedback.
