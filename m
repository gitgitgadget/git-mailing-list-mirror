Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7869C678D5
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 18:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237219AbjAISeV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 13:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237553AbjAISdB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 13:33:01 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6FC15719
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 10:30:23 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id k2so4622765qkk.7
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 10:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e/dEFvKUrN7YgPKnZ9d8jeXq11tjdh4WXLAY/Ze02wY=;
        b=EA60oL8vEpwl/rLZmDCEXtvrFdCQxR0h2KfrPW/4+19RERS3iqz/3XgI3NTqkCOgVR
         Cz6qGAjA7Iac/wNWzrwPf7yHppKuJ9nM2qW8JXLGoSCsul1gCZOlk8tZfvIGqOvgfZFq
         VQ+nVJSmuDoYSS2KOead8DESx81ss4847iy5cRHdpsPbCK0oxj75GUUqmjBmPkBdowR8
         pmHmxqP5gaTBJlTMmSDBnSyzIPwbXwK/T0ZrK7y0qd0erdsqkXfUAgSClZBMb5Y7VJ08
         2LNabYvl0UFO+boKCY86FR2oK7hFsTBsmbY73rIQv0nukaoRRFnverD+fPCGFcpCWbW0
         n6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e/dEFvKUrN7YgPKnZ9d8jeXq11tjdh4WXLAY/Ze02wY=;
        b=Xtq70TT6fXfeKNQ2RqQjuUBr0LGSv+v8UBKv4zkjdFvkIvWNYrvVQGL6N5Pkjl0W66
         tdCkCFl6+ZOvFrV5Ulo4VZUBUuafRj7bquvFHGttKZCmswNiq+Mxjtguf3H/tnlfqBK8
         4L9jJ50vwbUErFuMdU32et0doSovonpM6orcWtZAm3WKjBbV2MIFI7mAsAgGBysSk4mc
         MmhGluOKztU5/ANCilWGnJV4PhD8xKvVZxHuVeq3QkcsU5cpS1TYjvgFqneDe71Hz+H0
         KplkniUgS8g4dDWKwN21w3NP9NoIboQ0weICa3fQHdWo5imBYB0uUJ3F8mM19Do3177u
         SpHA==
X-Gm-Message-State: AFqh2koA0GeTlhcwcFPC5jyjCceqvKouMZZ+wfTliGt6Oz3WReoMSOTd
        LGlcDlAx7AfMIp/X1Tsaq0KBLCM9EJq/ecMY7WiAzkQp
X-Google-Smtp-Source: AMrXdXvEk7CX/yaZdYSzH5IDBV0ggO6YsqlWPFZQ8vNnoaKPZCQWkvf7JRYnr9KoeR5Tk/tlPZ9HXK5eI3XBuIOOhAc=
X-Received: by 2002:a05:620a:191f:b0:702:4519:496b with SMTP id
 bj31-20020a05620a191f00b007024519496bmr2843926qkb.619.1673289022745; Mon, 09
 Jan 2023 10:30:22 -0800 (PST)
MIME-Version: 1.0
References: <20221216033638.2582956-1-phil.hord@gmail.com> <xmqq359gnfhe.fsf@gitster.g>
 <CABURp0pWwfWO3msZ4U=_i3zkEDOq6+CUVT9Tb7KCjeBRK34Miw@mail.gmail.com>
 <CABURp0pqQFiM4+L0sRADTt-jmAsHcMMWLR6xa4NbqrziZjmdOQ@mail.gmail.com>
 <xmqqbkn8um9q.fsf@gitster.g> <xmqqy1qct6e8.fsf@gitster.g>
In-Reply-To: <xmqqy1qct6e8.fsf@gitster.g>
From:   Phil Hord <phil.hord@gmail.com>
Date:   Mon, 9 Jan 2023 10:30:10 -0800
Message-ID: <CABURp0oAuT702PfFppir-u9psOt0ETDXeO+_8TwB5UO-edoaKw@mail.gmail.com>
Subject: Re: [PATCH] date.c: allow ISO 8601 reduced precision times
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, congdanhqx@gmail.com, plavarre@purestorage.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 9, 2023 at 1:16 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Phil Hord <phil.hord@gmail.com> writes:
> >
> >> Do you have any suggestions about how I can better alleviate your
> >> concerns?  I don't think there are real regressions here and I tried
> >> to explain why.
> >
> > Other than "including it in a released version and waiting for
> > people to scream", I do not think there is.  The "next" branch was
> > meant to be a test ground for these new features by letting
> > volunteer users to use it in their everyday development, and the
> > hope was that we can catch regressions by cooking risky topics
> > longer than usual in there, but we haven't been very successful, I
> > have to say.
> >
> > Thanks.  Let's queue it and see what happens.
>
> Actually, let's not queue it as-is, because it seems to break many
> tests for me.  I won't have time to take further look myself before
> later in the week when I come back online again, though.

Oh, wow. For me as well.  I thought I ran all the tests before
finishing up, but I guess I was too focused on the single test module.
I apologize for the oversight.
