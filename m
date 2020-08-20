Return-Path: <SRS0=wu5b=B6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AFBC433E1
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 17:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C48BF20724
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 17:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o/ewigu1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbgHTR1U (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Aug 2020 13:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730601AbgHTR1P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Aug 2020 13:27:15 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57016C061386
        for <git@vger.kernel.org>; Thu, 20 Aug 2020 10:27:15 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id r21so2075684ota.10
        for <git@vger.kernel.org>; Thu, 20 Aug 2020 10:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3HSijpktJBBQd/wbWhF/eu8hXaF/7oYCs94Ss87u+qQ=;
        b=o/ewigu156P9QJSTsmjFNGzna+4WnB7ebASww6gr2cRSjPgYceFJspXNmczJByCK9E
         Dk9tCY4TVLuA8IHFt/0W/UfTltbIjEj8UlUkl99Weibzw2dr5qM1P8GrqYWAc3t+cEq7
         P6F2smVGubkS3DORWJrPsZKOJSUDngui2k+FLyTs595ZDaB1HfH1fPgrGsw9zAwWVt84
         e0DR51M6DQ0r05lYh2YmCgLR2LNGbKMtGliTY58WxJrQAEaCZWIL2URFH5RM97QntDl+
         bIV671z4qe/TcelKVv2vfP2ubEoqQTOaDfs9E8pXme2quSgHU6pUwFSucTZ6h47MdmGB
         ttPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3HSijpktJBBQd/wbWhF/eu8hXaF/7oYCs94Ss87u+qQ=;
        b=J8gAcdQa59SXuerykBgrA11telbOa4Lj6NZCPTTgECWorVG77pfpe5UcJeb3paT4rb
         0mM0/86uBMFdXlVTXK5dyyaBi9yCkFxWyFZ3dmOo2rNzAjvpq1aPdlpnjUe5xRwokdbW
         MhcCSa8ze+HOTG5Uw0PcGFpOGbWkvNygnMJr0jsGXUZZ5nEHTjAllQFa8rv9ZfExL0Gy
         s54N9fpTm4lOskE2AG/Z8i4SmMkx/n+etto0MHOaRr+eBQaXkCuaa2Ay/Wygwrofjm9X
         c5KqDln+FgHbmKKPVf7dplgytOyxxyGW3brWHkkREx1nI752/inbNNVdWtGWXTzBt0kr
         A/Tg==
X-Gm-Message-State: AOAM53151E/KX6t7MOqTz4avE1NOBemqxDPoGbG9IOXci7UQBZiZOj57
        P2t2Kg6eYAUxV59GlzeeGBeOp6Q3QacBR7vCMqxPeyDPi9CwVXAK
X-Google-Smtp-Source: ABdhPJyc5f6edpH2OUYK5BBLN8ssDhDq96YxDH6NwM2EGph61AT0fhUJUe9YfdCxiYksM7tw6ky+HGOEo/48X3B8ilg=
X-Received: by 2002:a9d:f29:: with SMTP id 38mr3010662ott.281.1597944434573;
 Thu, 20 Aug 2020 10:27:14 -0700 (PDT)
MIME-Version: 1.0
References: <pull.684.v2.git.1596664305.gitgitgadget@gmail.com>
 <pull.684.v3.git.1597687822.gitgitgadget@gmail.com> <0ad22c7cdd3c692aa5b46444e64a3b76f1e87b4c.1597687822.git.gitgitgadget@gmail.com>
 <xmqqpn7p1373.fsf@gitster.c.googlers.com> <CA+CkUQ9tkwXmrHq_ZV+RCgwoFHZ0M4dEhBkjUd97Xi+3shB-WQ@mail.gmail.com>
 <xmqqimdevd4l.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqimdevd4l.fsf@gitster.c.googlers.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Thu, 20 Aug 2020 22:57:03 +0530
Message-ID: <CA+CkUQ8=ej=NuG=FjsE6oqT+n8YUpGeVVNyhhs3FZ7UwZ5pG_g@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] pretty: refactor `format_sanitized_subject()`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Heba Waly <heba.waly@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, Aug 19, 2020 at 9:31 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Hariom verma <hariom18599@gmail.com> writes:
>
> >> Also, because neither LF or SP is a titlechar(), wouldn't the "if
> >> r[i] is LF, replace it with SP" a no-op wrt what will be in sb at
> >> the end?
> >
> > Maybe its better to directly replace LF with hyphen? [Instead of first
> > replacing LF with SP and then replacing SP with '-'.]
>
> Why do you think LF is so special?
>
> Everything other than titlechar() including HT, '#', '*', SP is
> treated in the same way as the body of that loop.  It does not
> directly contribute to the final contents of sb, but just leaves
> the marker in the variable "space" the fact that when adding the
> next titlechar() to the resulting sb, we need a SP to wordbreak.
>
> LF now happens to be in the set due to the way you extended the
> function (it wasn't fed to this function by its sole caller), but
> other than that, it is no more special than HT, SP or '*'.  And they
> are not replaced with SP or replaced with '-'.
>
> So it would be the most sensible to just drop 'if LF, replace it
> with SP before doing anything else' you added.  The existing 'if
> titlechar, add it to sb but if we saw non-title, add a SP before
> doing so to wordbreak, and if not titlechar, just remember the fact
> that we saw one' should work fine as-is without special casing LF at
> all.
>
> Or am I missing something subtle?

You actually got it all right. Thanks for the insight.

Now, I got it. There is no need to give special attention to LF. I
missed to see that `titlechar()` is already taking care of everything.

Thanks,
Hariom
