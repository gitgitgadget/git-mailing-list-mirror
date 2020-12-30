Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11D0C433E0
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 15:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A82D207A6
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 15:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgL3POT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Dec 2020 10:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgL3POT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Dec 2020 10:14:19 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0820C061799
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 07:13:38 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id q25so18919401oij.10
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 07:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=snJUN8y9evYWCJ1INTHe+9kw1sG7QDVVXSoEF2F8ysM=;
        b=WPkNVb1UsAZhoM2wFREWc2eqO4XBnPxWJhp9A/Te7rr+szgo85tkGiYBOSa8IWXz4p
         kE2KFFx56gWVDucBJJrEXieciq8sUw3B9c6Bw3h08nlvGCAhMJt93l83xkmj+H20nBRN
         w+z4QXv+rWelq+aTHgcYTm2zppkVpMpu2/M7KSK2s/QVXCSWOvrfUULN6ZTlvPPjZig0
         7Lwu6BGSpQY3ZBeLMXdY2kXudg8L2u2JCXkTCFF4mFlxsJfAWsUmFTfNjSUsMJm4ClUb
         wJo0el+gdngk0W1XwEyO82VWyH0InIfy2Kv+Qk97Ku4I/OgVVsRpjJ3Xa1WpGcSaOfAn
         lgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=snJUN8y9evYWCJ1INTHe+9kw1sG7QDVVXSoEF2F8ysM=;
        b=ZndKEAyAk+keIfgaAs6tc9xPLZsNW+RARl6yQ1ERY+BSFgvrtyBZE3bA2oSqPuSnU4
         G+huXi9FFvFhOtWF1HzYI5n4o3+1P1hhuPQ1/e1InIu4ZMBoxhe+nZ+0NnNYjNyOC59t
         a9IALCazueDXtwuDOA+VpPYA/v9hfRb40cSZc6/FhsH00oCs/f8EOJSatIOyMZWPpIgX
         Mvk9UVuBNtMIKCrGmqSFaxoE9K7YZc/ehqbddBfKR5yHiv7xJmzyebVhmwA4m75Pe+tx
         fhHTZDzlRGPp2baxY0Ze4MXn4uryeGEMJPfqie2I8sNOMVEEU7NTQPhgcOxnbllL0JOc
         S3Ng==
X-Gm-Message-State: AOAM531TToXJTxmbl1rJf+ZLRP5DutzhxgY6FzAdJ8Cetmv5qMmF8tgY
        QHS7l0pYBFLRGTcyAuUh7IlCdA+B51AyA/IXi7Y=
X-Google-Smtp-Source: ABdhPJx0zEm0Ku/6pv4SVWrTt5XijbvDz5kd/piAYpcKh0ZQieLpkehl9x77nCbWvmP2jeVjJYEAA0E5/Mn7mkFuCCg=
X-Received: by 2002:a05:6808:991:: with SMTP id a17mr5304119oic.167.1609341217669;
 Wed, 30 Dec 2020 07:13:37 -0800 (PST)
MIME-Version: 1.0
References: <pull.815.git.1608270687.gitgitgadget@gmail.com>
 <382a009c18efc8a46a9c0210754f2266c3116ee4.1608270687.git.gitgitgadget@gmail.com>
 <cb08fd8a-b4e1-77d6-7d8d-9f0431db2404@gmail.com>
In-Reply-To: <cb08fd8a-b4e1-77d6-7d8d-9f0431db2404@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 30 Dec 2020 07:13:26 -0800
Message-ID: <CABPp-BFrct6hZW8bh5hhRpGSPhjeGO9viCjpO02gUyTqNnrAgg@mail.gmail.com>
Subject: Re: [PATCH 01/10] merge-ort: handle D/F conflict where directory
 disappears due to merge
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 30, 2020 at 6:06 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 12/18/2020 12:51 AM, Elijah Newren via GitGitGadget wrote:
> > +     } else if (ci->df_conflict && ci->merged.result.mode != 0) {
> >               die("Not yet implemented.");
> >       }
> >
> >       /*
> >        * NOTE: Below there is a long switch-like if-elseif-elseif... block
> >        *       which the code goes through even for the df_conflict cases
> > -      *       above.  Well, it will once we don't die-not-implemented above.
> > +      *       above.
> >        */
>
> This comment change might be a bit premature.

Or perhaps it should have been squashed into an earlier series that
was already merged to next.
