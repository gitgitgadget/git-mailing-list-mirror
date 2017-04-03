Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 240601FAFB
	for <e@80x24.org>; Mon,  3 Apr 2017 18:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752135AbdDCSEP (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Apr 2017 14:04:15 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:36259 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751757AbdDCSEP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2017 14:04:15 -0400
Received: by mail-lf0-f45.google.com with SMTP id x137so80384848lff.3
        for <git@vger.kernel.org>; Mon, 03 Apr 2017 11:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Wbz2o3GnJZ8qoI2/r6c63Hyaog9Ig+aLPEkXWiU40b4=;
        b=lakAA1MO7Bp9v8kx6Ve9QmXy5W7dqDbZff2lBGXmhfmrJa1Z9xv1shWxP8W9Usptyi
         DSpIQJsiRx+uTjex5o3mi5DlMcl4xTiHBOTraD0u2nUly6N1MbZ42RKudTUTjv6jSwFQ
         vo800azto22kHs1iJkIM4jHCujI307fISrvCVnXv0adelPiP9qTLU1PiQITzPPmfV1V7
         P1pVaLL2vIyI7tpjbqvfuW2kmpK0VfWDGbM5IOsTlo5CDhqnRmbC4kvt+ksbNewcnCHB
         TFVRAshAn59nmEoj70yPAEqevvqlkN/DREzwJwR16zZ6hulJVqSH7ozaQs+Uxav0S3BE
         6YHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Wbz2o3GnJZ8qoI2/r6c63Hyaog9Ig+aLPEkXWiU40b4=;
        b=eYL5qNPEOKK1KiWGIyLLyZY2C9n+wAy9uYmQoysYVjYWRF5XiaWzJv3d6ZJQ31GrOS
         IehWJ39FrpgQhqOfrJ1ZbpwqbiDQ3w8smpDI9Meswb5HN0FHX20eKIa+dpVMgDb/jmie
         sw6af8Cu9tAwnHyRLYU2eqiCwfVX6tPuajrgK9YMY6PwF0dtl4CIieh0eLqXvAcuxBYc
         cF8cPk8KdcZuwkv19EnqAPiCiPPHNL6TxErxhXHZfqHLqM3se8Aqh6evH0bpRaJwiRQ6
         KU+HDA7mOLXbhZ/0+SHGrJ4huOcVr+UzW7Vl5M5jVL3ZCwJ2DGi4Ytb/A5Th9KFa9U5A
         wXtA==
X-Gm-Message-State: AFeK/H2uH7+Uo8/iEqZ++NOaw1gTuIujEvG+NpgaSMjJ8Tu/CULFYjWY6X6dAQl6WTDlGNYeQ+eRbJj8JRtilQ==
X-Received: by 10.25.34.87 with SMTP id i84mr5917575lfi.140.1491242653507;
 Mon, 03 Apr 2017 11:04:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.18.73 with HTTP; Mon, 3 Apr 2017 11:03:43 -0700 (PDT)
In-Reply-To: <76c92397-8e15-b2fb-432f-0ae3d987ffa8@alum.mit.edu>
References: <1491163388-41255-1-git-send-email-bnmvco@gmail.com>
 <1491163388-41255-5-git-send-email-bnmvco@gmail.com> <76c92397-8e15-b2fb-432f-0ae3d987ffa8@alum.mit.edu>
From:   "Daniel Ferreira (theiostream)" <bnmvco@gmail.com>
Date:   Mon, 3 Apr 2017 15:03:43 -0300
Message-ID: <CAEA2_R+EBbrD1rbcrP598AKJAEZDZfGY-ED8g+ehgAaL9tLG8A@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] dir_iterator: refactor state machine model
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 3, 2017 at 12:36 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> As far as I can tell, you got the logic in this complicated big loop
> correct on the first try (well, if we ignore v6 :-) ), even as you added
> new features. I think that's good evidence that the new structure is
> more comprehensible than the old, plus the new tests probably helped.
> That's a big win!

Thanks for ignoring v6 ;)

Another gain is that the other proposed features (only iterate over
directories, do not recurse into subdirectories) are also quite easy
to add with this new structure.

> It's not ideal that the test code depends on the numerical values of the
> flag constants, and it makes the tests harder to understand. It would be
> better if this program were to accept options like `--pre-order`,
> `--post-order`, etc., as I suggested in an earlier round of review.

Although it does make tests harder to understand, if we were to
specify how to iterate with human-readable flags we'd add the getopt()
+ flag configuration overhead to this helper program to be able to
handle all cases properly. Additionally, new flags added to
dir_iterator would have to edit the test program as well, generating
extra work.

I personally think that the string describing the test in the script
is enough to explain what the flag-as-argument is doing for the sake
of readability. The only gain I see in your suggestion is that we
avoid the programmer committing errors calculating the flag by hand
when writing the test.

That said, I'd appreciate some more thought on this.

> Michael
>

Thanks for the review. I agree with all other points and I'll address
them in a next series.
