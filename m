Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80527C433DF
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 04:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64C9E20771
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 04:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgGWEvq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 00:51:46 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37799 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgGWEvp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 00:51:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id y3so3845792wrl.4
        for <git@vger.kernel.org>; Wed, 22 Jul 2020 21:51:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/lc6nrJqa0J98ei0sZWyUrUz82SCTEDMT9de8eMepGQ=;
        b=iKq7jSmmf7X0A2A46v1zD6cHSfe4K3dO9jCJf8317zbf+Gj/0LQcfkzHMu2D0M+DyH
         8dkDsaipWyfBqNegCtF+5xhypKhrtQd9rqk8Ur9qUmQvTNHAf1WcyoEDtvUw6uYZ9Rwk
         /DnztARD8zvUl8xoiWTlfVTyygNc5NC79/Ze1wd4POVXOO1QuZcEuBC2gpT/Uw/qP9Ua
         uJX/ARu9GZd9l8xNQoywaFP7JOqv+dGcYtJC++96NRE0sc0/b8XGoZKVQ/fNnOy/I3Gf
         /dPBJ2D0Q8LYN2xagHRVp/ndgD4f7ONMHYRS8qRdiTb47jPyAjoSeZrIfSbo3C63VWUS
         kA4A==
X-Gm-Message-State: AOAM532yar7EzXdHr9qpkGVH8eNSz49MJZMfxpfd6SaBPMcWbeMJJZ6H
        MBgnGTwg3IMU3PJ+s+E+K6/tMOK84KIaMNLrrYHJp+I5h/w=
X-Google-Smtp-Source: ABdhPJwN2lSF3GLnRUaRHffrudq/noz9UQ79gHhbbLQRXRf7qcqORT8ZtMcSbBh3WAQKQ6UkzqV0hATtBM/GZqcq6+Q=
X-Received: by 2002:adf:ec45:: with SMTP id w5mr2289151wrn.415.1595479903583;
 Wed, 22 Jul 2020 21:51:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200723010943.2329634-1-sandals@crustytoothpaste.net> <20200723010943.2329634-35-sandals@crustytoothpaste.net>
In-Reply-To: <20200723010943.2329634-35-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 23 Jul 2020 00:51:32 -0400
Message-ID: <CAPig+cT36rhfMzOTH8L59cyoBKQQoF92nJ-Unccm+yf9RCgXMQ@mail.gmail.com>
Subject: Re: [PATCH v3 34/39] t: add test_oid option to select hash algorithm
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 22, 2020 at 9:11 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> In some tests, we have data files which are written with a particular
> hash algorithm. Instead of keeping two copies of the test files, we can
> keep one, and translate the value on the fly.
>
> In order to do so, we'll need to read both the source algorithm and the
> current algorithm, so add an optional flag to the test_oid helper that
> lets us read look up a value for a specified hash algorithm. This should

Readers trip over confusing grammar: "lets us read look up a value"

> not cause any conflicts with existing tests, since key arguments to
> test_oid are allowed to contains only shell identifier characters.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> @@ -928,6 +928,17 @@ test_expect_success 'test_oid can look up data for SHA-256' '
> +test_expect_success 'test_oid can look up data a specified algorithm' '

Readers trip over confusing grammar: "can look up data a specified".

> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> @@ -1468,7 +1468,17 @@ test_oid_cache () {
>  # Look up a per-hash value based on a key ($1).  The value must have been loaded
>  # by test_oid_init or test_oid_cache.
>  test_oid () {

Should the function documentation be updated to talk about the new
--hash option?

> +       case "$1" in
> +               --hash=*)
> +                       algo="${1#--hash=}" &&

Bikeshedding: I wonder if this should be named "--algo"?
