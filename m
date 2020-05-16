Return-Path: <SRS0=AWh0=66=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0005C433E0
	for <git@archiver.kernel.org>; Sat, 16 May 2020 11:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C055720727
	for <git@archiver.kernel.org>; Sat, 16 May 2020 11:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCUY47HQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgEPLDA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 May 2020 07:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726188AbgEPLDA (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 16 May 2020 07:03:00 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D62C061A0C
        for <git@vger.kernel.org>; Sat, 16 May 2020 04:03:00 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id g15so1745646uah.5
        for <git@vger.kernel.org>; Sat, 16 May 2020 04:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a6fxcI2Ap8vEyJ7iBuoLkgAm+jfYSxO2QL/sniAzRQY=;
        b=TCUY47HQQCFDZPjmDk4xuSAf3VGv7CpaSp70ZfvETWsaFFME+xN08T2t78xXb9vzae
         I6mDCEhRgx9O7cCwjnWPWqva5dm08VC5kGZbijGAf2HtqrtzyzQKzEdZ5JVLPiyn6L4g
         LG2iNP2kjvPHPoMxSFxCr+JIRJMSmLw8tlmLpkqEcchzBFA2gllYxRW3DkPVSq3zcU9b
         oGwsKNV7mHC4HivZQk6i0smRgCtGGScdnF7upOy3b+0mYSFeEUyq2V9UsGNrcgpl9iD6
         xE6GhPYLJx3dbBmXlnN05HRfgXGWEgNDpelXrmWc04GG///hXBE89GL5ztg6mw3/JZSU
         Dzaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a6fxcI2Ap8vEyJ7iBuoLkgAm+jfYSxO2QL/sniAzRQY=;
        b=nlmna8qVwq5Nkm7QDoUlOn1RU9AlPzY0eNekjecz3OVDn0WSKRrB+tcGdjObSR3lGo
         AfALoEADCvuDtmcUfph8SaCawQKe9v9/qLOHkvmR0zU11WnZpE6fo93UZPNLDWs66kNS
         h4wFsRRUOsEZN6ku9se+qhRUsleEDOAPSs1bKEwPPIrCmzFFDuJbV8u2G5E0UgjtyCHb
         LG/kRcjiFm1iHsFLiTxbbXaqNg5/d0AoBjB0cRqciSAlQScFhd5XAWDFmNswTRngBynw
         rytHXhDnckE7JLjPnMo6NgYvqX1hj1TNG+qkSX0b2DFPjD+kYP51ZlGdfaTNiy72xTI9
         fUWA==
X-Gm-Message-State: AOAM530cU/bYIZN7yT6BJh9TBYWDy1eQ5b6mPYzEmbhljARcXqju7uPX
        rnF6ym2G9XwJloQo8437tucZAjH1eWUDxZpaCkA=
X-Google-Smtp-Source: ABdhPJx4LIEmMVwJtB3/RyA5qLdEYfSWul37KbvQl/bFbw0UIwG896xQEvEv09Yf9dfu0Stp99NzRAlHUER6tL29JVg=
X-Received: by 2002:ab0:7845:: with SMTP id y5mr6087315uaq.34.1589626979344;
 Sat, 16 May 2020 04:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200513005424.81369-1-sandals@crustytoothpaste.net> <20200513005424.81369-22-sandals@crustytoothpaste.net>
In-Reply-To: <20200513005424.81369-22-sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 16 May 2020 13:02:48 +0200
Message-ID: <CAN0heSqf8E9cXvJcDJmx_YU5Eiwnqre-g3MwU3UMe40SioCNPA@mail.gmail.com>
Subject: Re: [PATCH 21/44] t5704: send object-format capability with SHA-256
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 13 May 2020 at 02:56, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> When we speak protocol v2 in this test, we must pass the object-format
> header if the algorithm is not SHA-1.  Otherwise, git upload-pack fails
> because the hash algorithm doesn't match and not because we've failed to
> speak the protocol correctly.  Pass the header so that our assertions
> test what we're really interested in.

> +# If we don't print the object format, we'll fail for a spurious reason: the
> +# mismatched object format.
> +print_object_format () {
> +       local algo=$(test_oid algo) &&
> +       if test "$algo" != "sha1"
> +       then
> +               packetize "object-format=$algo"
> +       fi
> +}
> +
>  test_expect_success 'extra delim packet in v2 ls-refs args' '
>         {
>                 packetize command=ls-refs &&
> +               print_object_format &&
>                 printf 0001 &&
>                 # protocol expects 0000 flush here
>                 printf 0001
> @@ -21,6 +32,7 @@ test_expect_success 'extra delim packet in v2 ls-refs args' '
>  test_expect_success 'extra delim packet in v2 fetch args' '
>         {
>                 packetize command=fetch &&
> +               print_object_format &&
>                 printf 0001 &&
>                 # protocol expects 0000 flush here
>                 printf 0001

So we need to pass this capability for the SHA-256 tests to run ok. But
if we start passing "object-format=sha1" unconditionally at this point
in the series, the tests will fail:

  error: 'grep expected flush after ls-refs arguments err' didn't find
a match in:
  fatal: unknown capability 'object-format=sha1'

That is, we don't yet actually implement "object-format" handling. So
this will still fail with SHA-256 ("unknown capability"), just that once
the implementation is in place, the SHA-256 tests will pass (as will the
normal SHA-1 runs). Do I understand that correctly?

Or put differently, by the end of the series, we can do this:

diff --git a/t/t5704-protocol-violations.sh b/t/t5704-protocol-violations.sh
index 47e78932b9..22993812e2 100755
--- a/t/t5704-protocol-violations.sh
+++ b/t/t5704-protocol-violations.sh
@@ -6,14 +6,11 @@ communications if the other side says something
unexpected. We are mostly
 making sure that we do not segfault or otherwise behave badly.'
 . ./test-lib.sh

-# If we don't print the object format, we'll fail for a spurious reason: the
-# mismatched object format.
+# If we don't print the object format, we might fail for a spurious reason:
+# the mismatched object format.
 print_object_format () {
        local algo=$(test_oid algo) &&
-       if test "$algo" != "sha1"
-       then
-               packetize "object-format=$algo"
-       fi
+       packetize "object-format=$algo"
 }

 test_expect_success 'extra delim packet in v2 ls-refs args' '

Should we? (And if we do, we might as well drop this function and inline
the whole thing, IMHO.)


Martin
