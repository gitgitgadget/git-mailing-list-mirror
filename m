Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A454120401
	for <e@80x24.org>; Fri, 16 Jun 2017 05:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751641AbdFPFs0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 01:48:26 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33043 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750921AbdFPFsZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 01:48:25 -0400
Received: by mail-pg0-f46.google.com with SMTP id f185so16434775pgc.0
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 22:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IZ89ukOQkcxbbU/3C8HvU6cwCdYZkBDbGOfeq1M7rjU=;
        b=GL0IVHTuMzes8qXcPe0SJWvnBPkx18H8o3pHiMLEfDo3o2lbFiPtijhPqEln8iaol2
         PuW4dYg+rv8EASGaAPyPB9nUUaBwAgJ7S0ql0g4B+IJv5lcQkSi0+56+70mMFhIeRmJb
         9YDZafMNYpON8I0CXbze+859/WUepG3b7ULoM4zbB1odc36ahPanHSJczDgEjUe0fH0g
         eYx2KX99JwqAJyfd8w4rK74IGb9HJ4EC5tq3WdMdhfwCMf5vr2V086N+hPiiJ3tM9QT8
         G5FSmWAI1eXRTUJpqC4RrLL27RGCHiQAT9xrIKBofXF+aHTEPiQ58JrnIP/+5MRkECnf
         xtWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IZ89ukOQkcxbbU/3C8HvU6cwCdYZkBDbGOfeq1M7rjU=;
        b=JZD7z27M75eXgckJ5GNyh4I9gefHQeAH8G1Pt6mwUSeB95Pc34bf5DjZZRWcOzK77J
         Eif62KbmR7iF7sl+AbFWwv0HFN+Tqp/Ir4y+LwqPk5AJcAYQ01jEzzTdWzxFCi1NcaSw
         rcZ0HzwdnFdi438K7HTD2nOB18i3xRYmhkNC6posoLhiBTzCzuy8IZIbMOyhPIY4EX19
         UB92fcUZvs8bnbvxlU91IVft6cGjeijmnCUwSPC0JqJiLyZRx19D1XNQl3t4T1Kn2tVf
         MHivL4kztUnoxbVRiIKDk7l9kPD8BBSSvAh11IiKhFlhJc9sn/5wwcgkgbfvCWRyGzVn
         s6NA==
X-Gm-Message-State: AKS2vOzT6fRU+yIr6cT/aVsIbCagl/7czx+r5orA67dPu+fwxT9QdlMK
        D/X4ziC3CWT7+hzOubq8AaDJhMgWiQXs
X-Received: by 10.84.137.165 with SMTP id 34mr10421158pln.167.1497592104996;
 Thu, 15 Jun 2017 22:48:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Thu, 15 Jun 2017 22:48:24 -0700 (PDT)
In-Reply-To: <831f8a3f633374f173f630d9c65d870fffd0896e.1497534157.git.mhagger@alum.mit.edu>
References: <cover.1497534157.git.mhagger@alum.mit.edu> <831f8a3f633374f173f630d9c65d870fffd0896e.1497534157.git.mhagger@alum.mit.edu>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 15 Jun 2017 22:48:24 -0700
Message-ID: <CAGZ79kYFm8vZ9-qzM8sNsF_xgywvdcdZBAAJw3QJfQqBRr+OZQ@mail.gmail.com>
Subject: Re: [PATCH 18/28] packed-backend: new module for handling packed references
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 15, 2017 at 7:47 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Now that the interface between `files_ref_store` and
> `packed_ref_store` is relatively narrow, move the latter into a new
> module, "refs/packed-backend.h" and "refs/packed-backend.c". It still
> doesn't quite implement the `ref_store` interface, but it will soon.
>
> This commit moves code around and adjusts its visibility, but doesn't
> change anything.

I did not look into it in detail (as the origin/sb/diff-color-move
series ought to help here, but I am in the mid of rewriting that again
to have a better design; also on my laptop, such that I'd have install
that series).

I think this commit represents another common case of
code movement, where you would not just move around code, but
also add/remove some keywords (e.g. the static word in C, or a class
name changes in Java/C++)

Maybe we would want to not just color up moved blocks but show
the adjacant lines of moved blocks in a word diff (such that the
class name change would be highlighted) in a comment or such.
