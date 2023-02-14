Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66D0C61DA4
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 21:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbjBNVkC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 16:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjBNVkB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 16:40:01 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654FF28D31
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 13:40:00 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-4a263c4ddbaso226053207b3.0
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 13:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3qYWneW5v170yfUzkqR1EvCz/GvQSsYZ2aoxOKRkQlg=;
        b=qH7Lz5/halOWQ3sNtThJySwWuRsQdGQqObyswhsfhnohhyagoVSezPDqelDDcZY0US
         HF/c9BdPgFLvJFk56/vVGUD27af5a3PNXy0Nm0WCW035TGp8b5wdV8MwQHbJp4xy14WP
         /Bwg/yRJhXc3Pjsiz4qKPTEK8evKOdSgO3DMSmGgDBiL51E9SDjdLwsxJq7GPnSp51MR
         SkRZUN8N9i1pZ29qq1+swnWGBH8xTI/dlc2ifhdsqHJSQbFgbojM9hlKZXy+y82ZzLid
         PO9rOb1MsRuGrn7dzPVLYKnHQwLZbGFSH9+YFs2I/hWehZ4NOEKQooAs/vwcTe7lBFks
         aVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3qYWneW5v170yfUzkqR1EvCz/GvQSsYZ2aoxOKRkQlg=;
        b=Rt/Rlik8ZfQe+EBZhCUn/nNYzIBl+UqNWtEsmnsYba9UCfC2dWz72dZGC2c1ATYcN2
         9+bT9QfOokizn03LAXDD0coEX0mfNM4Z3VY5C460/FXnKDzjFVrNJjSubARFCqugQ6P2
         59JCZTCMDlIFAXPUrCNUnepbvUMbjYpoXHabJsv94DJZ95c2tkyPLnEdho9t1xTGUf9f
         7gbSzfOlaEnrLMC+NB6qlrywiIpVwvyrUhYuhmvvzDQ9A7D3lguOFdQTXkSuO13et2kO
         EqMo1MJIcJuS3h2gCJaTSd847TjqGTlKkCcEH+SELw97W/CVA4jBvdtCNI7nH+EIbQcY
         GZhA==
X-Gm-Message-State: AO0yUKVfxUnWxT0lowFRUSajsmIFlWSSOHWVuauSlzCP+evrXZw83Xua
        Kli4WgzRsgtBckYY4WPWPLc9UY55F0TPSZNa4D4+y8n+jaX/sTaCtRE=
X-Google-Smtp-Source: AK7set+W2RRbLQ8dsf3bvjJDZKQH7QhT6SqyIM9smxngFFgEyGDNrguxvDOlXT2uhASyTfh7KC+fZEOgkazdFYqib6w=
X-Received: by 2002:a0d:d103:0:b0:527:bdc3:c0fb with SMTP id
 t3-20020a0dd103000000b00527bdc3c0fbmr3956ywd.344.1676410799389; Tue, 14 Feb
 2023 13:39:59 -0800 (PST)
MIME-Version: 1.0
References: <20230213182134.2173280-1-calvinwan@google.com>
 <20230213182134.2173280-2-calvinwan@google.com> <xmqqk00lbc8k.fsf@gitster.g>
 <CAFySSZBAXCGTEhTK+rpLaZz4_RhdEDV5e5QewUwN-LHgSOTe2g@mail.gmail.com> <xmqqa61g550j.fsf@gitster.g>
In-Reply-To: <xmqqa61g550j.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Tue, 14 Feb 2023 13:39:48 -0800
Message-ID: <CAFySSZD9BZA9Qa5Z5KQymkowB9YtasUnNMehtA1feg43UsfwFw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] leak fix: cache_put_path
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2023 at 1:08 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Calvin Wan <calvinwan@google.com> writes:
>
> >> Assuming that the "last one wins" is the sensible thing to do, the
> >> change proposed by this patch does seem reasonable way to plug the
> >> leak.
> >
> > Swapping this functionality to "first one wins" or erroring out breaks many
> > tests that are setup improperly. If we continue with the "last one wins"
> > precedence, then a warning and documentation should be added. We
> > definitely should not swap it to "first one wins" -- one doesn't make sense
> > than the other, but "last one wins" at least has precedence. If we choose
> > to error out during config parsing when duplicated submodule paths are
> > detected, then those respective tests will also need to be updated.
>
> These tests expect the same submodule to be registered at different
> paths?  Is that a set-up that is expected to happen commonly in real
> life?  If so, yes, the current behaviour needs to be kept (with some
> documentation to explain why it makes sense and how it is usefully
> used).  If not, these tests may need to be updated to test scenarios
> that are closer to the real life, I guess, plus an additional test
> that makes sure such a .gitmodules file is diagnosed as an error
> with the code to do that some time in the future.

If you look at t4027-diff-submodule.sh:git diff HEAD with dirty submodule
(work tree, refs match) [.gitmodules], it's two different submodules
pointing to the same path (or more precisely a second submodule is
manually added to .gitmodules with a path to the first submodule). This
is a setup that is not expected to happen commonly in real life so
updating this test makes sense to me.
