Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533CBC433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 08:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbhKWIHF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 03:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbhKWIHE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 03:07:04 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1D7C061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 00:03:56 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id w1so88446042edc.6
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 00:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iNZ4GH4mb7G2meL140cIcJC7mdoOJoItHLy3wiEXluw=;
        b=P144pzBt2E1bF/bW9mLkLZnso8IhLuOY4RwGOdPQWw+SM5OxF9zv616tmTScbHsO2c
         LPk5V7Grsw8NutdJoduWuOWZ8XwPwPKyV6+MdxfRf1xk77Q6wn7zgl3vZugDGOlz/a7I
         lXOt+DxOkxYUQS2CPxOfwKYAX01LX6X1JN4S2412lXavIc0DJnfXaL6iCKT8bfRDDV7T
         9sKWcEZyWtbzPH7BX2bigEXRzh7IFRHLNT9ADJd9Z6tf1LPnobZ1q7bj8I6zeR/wnRHm
         delNIiWJbBYE9hUZ9rTJrZhcpL9Q2/SPZ36ecZSm78U/xSVGV/9VTNt2UlCGa9aNm55g
         6W8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iNZ4GH4mb7G2meL140cIcJC7mdoOJoItHLy3wiEXluw=;
        b=T7bu0MaWymVQMG/A6nOpIkhAcD7H1s+1HMmwt6FozZKqY7Ksxlkh9v2aenLyIJwSFt
         O8TOuzUu70D4tpNqK2Qw50TJw/UySNUPV0lCcOXrDrx7BtyB+exSQ3cm12G3e4A7znW4
         TWOlqc61h2E+9b+zHnEvVbuk0UfLzaVn7N0pgrjOsoYbOQb8kQ6r6ns0om5MTVMHOI/n
         zD/m6I3PVmIOXdI1vNTmKEG+nKXx5vL5K4D4FeS4JP2R91EPv62zplnvHYYGoQdKaVII
         oa5/L+IsfLW9DG6bDm0Egc8yckd4dwx3x51wWgXuBSxgwxm2KD4VODmun8Ls0o6DOB6M
         W45g==
X-Gm-Message-State: AOAM533Fcsmvt1Y52QuXF542rPJNinn7xRhc0zPzSncJw8rYYaZpnOOy
        Dt4lV7QxURBoIUgwj+zKrzpmIJ/1wZwbrWzGiJM=
X-Google-Smtp-Source: ABdhPJzcxRcSH3J5ODFskD62uWqkpoDHovT4ZIbWMGOQ2wS1vuyZzLqzrd3/URZ0W2HiYtA4ggiw0/2xF04CGy+7VWE=
X-Received: by 2002:a17:906:4c9:: with SMTP id g9mr5097519eja.172.1637654635092;
 Tue, 23 Nov 2021 00:03:55 -0800 (PST)
MIME-Version: 1.0
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
 <fd2595d370a8a257c44693fdc98194cd8447e22a.1637590855.git.gitgitgadget@gmail.com>
 <3ff61d01-ddd1-6b67-d8cb-4bd22736738e@gmail.com>
In-Reply-To: <3ff61d01-ddd1-6b67-d8cb-4bd22736738e@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 23 Nov 2021 00:03:44 -0800
Message-ID: <CABPp-BF+C1_XS+9FKwhwur4s5j0dUqs1VP8PDdZzw-edbfhRjQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] show-branch: show reflog message
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 22, 2021 at 11:44 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 22/11/21 21.20, Han-Wen Nienhuys via GitGitGadget wrote:
> > From: Han-Wen Nienhuys <hanwen@google.com>
> >
> > Before, --reflog option would look for '\t' in the reflog message. As refs.c
> > already parses the reflog line, the '\t' was never found, and show-branch
> > --reflog would always say "(none)" as reflog message
> >
> > Add test.
> >
>
> Add what the test?
>
> > +# arbitrary reference time: 2009-08-30 19:20:00
> > +GIT_TEST_DATE_NOW=1251660000; export GIT_TEST_DATE_NOW
> > +
>
> Why don't you use oneliner `export GIT_TEST_DATE_NOW=1251660000`?

t/check-non-portable-shell.pl will flag this construct and throw an
error if you put that in your test script.
