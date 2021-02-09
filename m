Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8BFC433E0
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 07:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 322CB64EBE
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 07:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhBIHOt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 02:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbhBIHOW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 02:14:22 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21825C061788
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 23:13:42 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id l3so8497437oii.2
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 23:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h8G2FqiAc15JfYEZTYGEYpwMP80CEX1CXjv6B61dFyo=;
        b=lXZyY9abbVh7LPHyvAC+NAtSOqPID66ZNXIRPalzIJnd0oU1/PnLmj3Rce4hg64QTB
         ox7KEYEXRAo7JlI66ycu4nsAhiZ3bbQnnukIx5A/mOb6RikDAfpYwCw2k3Cu/e5Gxzvi
         +eQGWYC0y/RAzOsEsoSPJzLh/FP72gcmR1ap5CkWT+OtkH5VcdSNOmnx8KfWaVVJ4cfr
         f8ERGK2td1VUY3ADQjbvWc2xFF65No/fUmTxURxDa0YxKo4AWII667A6SCqjlWsw50zS
         ePntzcRxfBrHjiYIFBUfWj934YwLhauSIV2xCqE47Y9A38mJhImBemRDPi/S3gTcJgdO
         A1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h8G2FqiAc15JfYEZTYGEYpwMP80CEX1CXjv6B61dFyo=;
        b=F7PGWaplPT4rHy23YEpTbSHB4/0WPHOg9JowHlIUdfrAshXWxNYKsVW4DJM8wURxcy
         ggn7/UDWvs0AzozaR98HEu0Lj32OkE5P2otGVQaEhLUIYzRqvEhCMUrlf0NxytQvGHk+
         m0D7IlsdUW1cRIj1RcjPkkcf2hpvZ5JElYO1ZfWr4XWbvv6mt0rvx23b8TApaTUdcyTS
         M5B5FCK+H6lvkMV0auWkoD2JoQvgxiD0fDfvsxtlQ/sMNdPPZ56sdjkCCTWZTD6GB1BZ
         5tLY68fyNw6It1WNGW5A8gGQqlMEZ/lOkLnHL3qAcXZy6lxHRc/ifR/jFqmLCPOp/BHT
         KXAg==
X-Gm-Message-State: AOAM531nIKmOTzHwZ21AxpCJl5MVQAWL/+3AO4w96If3nfnhiWnW14jW
        ueU2PPCDXr9Gs+qMJwXfXIITZCjmI2o5EAUbIVg=
X-Google-Smtp-Source: ABdhPJyjK8ttLj29ie8FBkMx4KWbyLtFE7ArojR0KZreeipuzxMWr4fXVgbBeBGTwJ+r1bt9gE4eh0d5jNfg9OYd6dQ=
X-Received: by 2002:aca:b255:: with SMTP id b82mr1595061oif.98.1612854821633;
 Mon, 08 Feb 2021 23:13:41 -0800 (PST)
MIME-Version: 1.0
References: <20210207181439.1178-1-charvi077@gmail.com> <20210208192528.21399-10-charvi077@gmail.com>
 <xmqqwnvi44qi.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqwnvi44qi.fsf@gitster.c.googlers.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Tue, 9 Feb 2021 12:43:30 +0530
Message-ID: <CAPSFM5dWP+_NzbVJvWdCQq3Q6bz70hm9z4W4eFhVKFzwQgQqmw@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] t/t3437: cleanup the 'setup' test and use named
 commits in the tests
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 9 Feb 2021 at 03:11, Junio C Hamano <gitster@pobox.com> wrote:
>
> Charvi Mendiratta <charvi077@gmail.com> writes:
>
> > Remove unnecessary curly braces and use the named commits in the
> > tests so that they will still refer to the same commit if the setup
> > gets changed in the future whereas 'branch~2' will change which commit
> > it points to.
>
> Doing two things in the same commit?  I think ${EMPTY} thing is a
> general style clean-up, while tagging is a bit more meaningful
> change to make it easier to understand tests and is a change at a
> more conceptual level.  The ${EMPTY} change would be better done at
> the same time when the here document was cleaned up in [v2 05/11],
> I would think.
>

Okay, will move it to the other patch.

Thanks and Regards,
Charvi
