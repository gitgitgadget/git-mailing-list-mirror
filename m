Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA00C433E0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 18:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F299464F94
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 18:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhCKSC2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 13:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbhCKSCC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 13:02:02 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749B9C061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 10:02:02 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id 31-20020a9d00220000b02901b64b9b50b1so41611ota.9
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 10:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CW9oBN/4is30aV4k9lIyReu5cclbAd/y6v+S4W05noU=;
        b=cKGaC+IUSmuHQ8vAWtybT9uz2ADDqezIwMZWYJUxeKtAvaj5H7uMnT/WCdlsdZ0eQ6
         9W3V3C/KNETtpLNEzPpAhu8pvbHFa0qQYCOmwWlO3YilT/PWk9HaPOrS2r6j41m09Yg+
         +m3BiZglrGQCNdgO8mw7b3Ksnm/9fDd1XVbFFiJR+ISw8DenK1AJkLO+7vtHb7MN9YWl
         QVvyKrAunDFw8rdUgAQj7MEiOqz7I6phAZgbhMPWsoZQ84zJuNsRqfguYmF5WaXOu0wU
         Qcj2wwGsG0Iy897M/o+2Z4sVFj97QhVbASpz4Hdgz+r53+X51R/Zw9oFMA0q7cU/AL2M
         t+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CW9oBN/4is30aV4k9lIyReu5cclbAd/y6v+S4W05noU=;
        b=GURTFQazRHmmZsmK8KkIdljsVQzzHUMzTewYhaWoRRYBA1q3RdeIxBSdwS5HrE/dQk
         AzH6cFT0aDMr0DHcEQPHck3XOJYgdROd20RTwH2uncL8qEr+DLbRBValhy/G/i5rIMzl
         BoEfa5bqOLXZQIZy6uyGP3Wobq93HL8AmL5WMUHdJk0paDrRSu4DWW9iVNbIg/ownRr2
         UB86slnAf8dJQFJlj/JErdMFaKe4c40NFHfqXqjbA4zcAa8PnlEHlFGZLV7jti/1Lh0a
         orvTixPP6dagikTZ7TCMqs7jiCDXNfBqYvFFX1kL9QO8NpeScdUFkiFnADCfqvXjHWFg
         COQQ==
X-Gm-Message-State: AOAM531ckLPOuoisDonQMN/KeVvOrt8mJVeCYLpi0OAeaIOgnyXxor67
        B3P92c+pkKKpjSlCfLPDQb/OAIE2Q4pk1p6QPrA=
X-Google-Smtp-Source: ABdhPJyJo6zQNh6KKUPmeoTx9QndRqgxxFAu1txJ7/P2a9wQFl0Rn6rFIRug0LNTbF+U1hcBbAs14EonYq4mlFMUa4Y=
X-Received: by 2002:a9d:8d5:: with SMTP id 79mr52248otf.345.1615485721914;
 Thu, 11 Mar 2021 10:02:01 -0800 (PST)
MIME-Version: 1.0
References: <f6cd9386-8a58-ee52-4c7b-60d9bd14a51d@gmail.com>
 <xmqqblbqipeh.fsf@gitster.g> <cd7c6682-7409-f72c-8751-02b70a423f83@gmail.com>
In-Reply-To: <cd7c6682-7409-f72c-8751-02b70a423f83@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 11 Mar 2021 10:01:50 -0800
Message-ID: <CABPp-BFPj4E=pOK_f=w9k_zGA+=A1F0Hv-PgYyNDdN30mXMBuw@mail.gmail.com>
Subject: Re: [RFC PATCH] merge-recursive: create new files with O_EXCL
To:     Ephrim Khong <dr.khong@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 11, 2021 at 1:58 AM Ephrim Khong <dr.khong@gmail.com> wrote:
>
> On 11.03.2021 00:01, Junio C Hamano wrote:
> > Ephrim Khong <dr.khong@gmail.com> writes:

> As a side-note, the strace on the affected file also shows that git
> writes that file twice during the merge, with the same content. There
> might be some potential to further optimize merges to avoid such
> double-writes. A small example to reproduce, note how "b" is opened
> twice during the merge:
>
>   git init
>   echo "foo" > a
>   git add a
>   git commit -m "Initial commit"
>
>   git mv a b
>   git commit -m "File moved"
>
>   git checkout -b other_branch HEAD~
>   touch c && git add c && git commit -m "Some other commit"
>   strace -otrace git merge master -m "merge message"
>   grep '"b"' trace

Yeah, this is somewhat fundamental to merge-recursive's implementation
design; fixing it essentially requires a rewrite.  That rewrite is
nearing completion; so this double-write issue will be fixed when
merge-ort is complete (or for anyone who applies the patches and tries
it out now).

In fact, if you don't see the permissions problems when switching
branches (because branch switching uses O_EXCL?), then merge-ort
almost certainly incidentally fixes that problem for you as well.
