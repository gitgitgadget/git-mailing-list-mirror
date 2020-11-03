Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F05C388F2
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 19:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 018B122264
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 19:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7k0F4jn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgKCTOg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 14:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgKCTOg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 14:14:36 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3F8C0613D1
        for <git@vger.kernel.org>; Tue,  3 Nov 2020 11:14:34 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id m143so10174531oig.7
        for <git@vger.kernel.org>; Tue, 03 Nov 2020 11:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e+rlXtjUS4M4hkVyweS+j2x3nVKxn1VSjMjoSxg89FA=;
        b=B7k0F4jnLxw5fATZiIDr7WvQxMlRtSCGi+mXdLqbEUpRT/m33CyoQ/nSeCZWfw0vsb
         qRKZZAJKKt5Z0FFL56ym5sGBfu8VeOaWp7SC/WBLwXy3aQEjrFvqQPLGDbb8YAgjwKxx
         wybXsOrrIxMziXiXgAIVjXkqIwhkT1ghgDFBkq9TfI1RejRJLbAhLkocvXbURauy3y1p
         LjT19Z3jthfAypaFaZXdOCVCLltOyLdU3kqP21yZuH3y22Nf3HOtblj2XI8+hvSmSZbW
         YX9XaghXJXFqR2GBLNKohCd1X3g+1ohejMVR7iEONspDxZ5smFGexuxX0htbOp6/8WXw
         o49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e+rlXtjUS4M4hkVyweS+j2x3nVKxn1VSjMjoSxg89FA=;
        b=cEHjah0XS+to8GZI1OTtQYO/QBCTl06Xw+HcMVjBx0BI/Dv2CT07Ug8+rVk+43B6DD
         Oo7ZyFTLdYMmHG1E/bumF4VwUEdoeR7iAIdW4vjYWnaNfMatSmtpRMCk2YmTySU1fbBI
         QjrUgtJBDU+153N1Mafe7S9ujg2h1lK7mWZIRN1KuXIGD6rJfYE8fQOdLkxraBkQLPFG
         keCgRZOUKjaLa3cuk56gVKSeprVOPViEgyCVxE/yytpZCmGkfbiGzbSUTnIhV9YfJ1ao
         cgF8LamO9RFyTDu3KVRQc1aCUEgMu3+QRLosKGNVhQpMvTSFwwf+9dSPO1iPW5Ibsx3b
         S7Xg==
X-Gm-Message-State: AOAM530yCeYOKpTcQ8ayl1LN9/EudNpWrFPBw03NTQVvTXxe3HYSw5cu
        dWNrmdNug3EbheFeoZNXHv2kr2D9CHMGTkh2dm0=
X-Google-Smtp-Source: ABdhPJxYfJLY76Y5xVEskahPmliP65QFAiuPHXrqB0UWFgg+VG5hWNkLfgxiHxi17cwHRuEudDfJ5MAOGcmiGwMPnB8=
X-Received: by 2002:a05:6808:17:: with SMTP id u23mr386196oic.31.1604430873746;
 Tue, 03 Nov 2020 11:14:33 -0800 (PST)
MIME-Version: 1.0
References: <CAHqVHwt1QJjXCAbDD5ViZ1E_rD8u+H_XeJ=FOv4VFPTS8y3xjg@mail.gmail.com>
 <CABPp-BEF2wqP+Cx5-6yq6cfQ1Pa+8iOXWR11DNBH02yh-D8oFg@mail.gmail.com> <CAHqVHwv4BC-OnfCvXySvksGHCx_+URQedz-BT6CqGbndDTM8Tw@mail.gmail.com>
In-Reply-To: <CAHqVHwv4BC-OnfCvXySvksGHCx_+URQedz-BT6CqGbndDTM8Tw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 3 Nov 2020 11:14:22 -0800
Message-ID: <CABPp-BHewkGXj41tLagMQ-DtdxqU2q=WpMqX+xziePtERt23MA@mail.gmail.com>
Subject: Re: git clean -Xdf doesn't clean ignored files in subfolders
To:     David Besen <dbesen@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 3, 2020 at 10:36 AM David Besen <dbesen@gmail.com> wrote:
>
> > Is this the same issue as reported at
> > https://lore.kernel.org/git/4F1384AE.1050209@pcharlan.com/?
>
> Yes, I believe so.  I am indeed using git clean as a substitute for make clean.
>
> But, I still think a fix would be appropriate.  Ideally I could trust
> git to remove all auto-generated files regardless of whether or not
> the project even has a Makefile.

I'm not trying to argue against a fix, just verifying that it wasn't
recent changes that might have caused problems, and linking the
reports together in the archive with a url to help anyone interested
be able to find them.
