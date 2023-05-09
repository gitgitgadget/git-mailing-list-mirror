Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E524CC77B75
	for <git@archiver.kernel.org>; Tue,  9 May 2023 02:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjEICNX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 22:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjEICNV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 22:13:21 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A6693C5
        for <git@vger.kernel.org>; Mon,  8 May 2023 19:13:20 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-19290ad942aso4072821fac.2
        for <git@vger.kernel.org>; Mon, 08 May 2023 19:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683598399; x=1686190399;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRvYX7xZkWKNqnMmKHbWvv/V774hnveaH9gtvjkc2no=;
        b=NLdEnMVfoe+Dq2BOjoxmN4ATvvX+xUamgx3BMjBTXb9BdwYb3xqM5fdI3tyDGIOoUW
         S0SgWcQVRmeH+4QeNGdccbOXKOe37FWRR9R0irigXB0JZXVYcgP2iBhLanLkkUm6nSXY
         b/h5rHxFdpGFkubAsLhyzCNOFW8P4LC+ribzCApLieNR3uAIWIqSRwfOentOGVjcOVxd
         2V88hew2oZv5VUi4lUb6CUz3KbVniOtHxua2k3zF9UyKZ0zeKTHI3KZB7rPnI7eK2KIO
         ghQmRESdcDpqZvju7EulYv2aWMH4utTTgjUvAdEqT5PWoDGLTyVczuAeNEavz/HfPSmA
         DWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683598399; x=1686190399;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iRvYX7xZkWKNqnMmKHbWvv/V774hnveaH9gtvjkc2no=;
        b=AvkpYNLIjnaKOBVa4KPALULIARpCBDTGx4u3PvHTOy10eWb4jN2VABijg6YIR1KsME
         QY0aBrgQf8CRVXTxWsVxsEy2Ve6RuU60f0/5TfamwB/qdTSAHoy6V3OrUmgVVxDoO9hN
         ftlu3M8sSjxP6YY8t7wwChikgJ22kyqMnjUqP/KY7qssT/b77rYwe8le55fwC6qSJ/zh
         wUdsvnx/Raz2RRwCtppD800+3qmsRT9k6D0armeVSNpq3LGfquo1dWnm50EZIylKuCyx
         1ZBq9kKXjXRGRBFn+AG6KELSoGVh7HHHOZkJzVkl3ey69hux4CyPoTZ2TvfZa2/kHGkg
         ux1A==
X-Gm-Message-State: AC+VfDx3wnG6OM+c6JAemt7wQ+mrHl+AuKwouP10rShzsmu6AHyV0RG3
        aAKyFcKDKvsmBWHpMOULzwI=
X-Google-Smtp-Source: ACHHUZ76wwQ3xlZ26Ddnna/5Te4B8mwvv3rUtjvqa4kpWG9/dZ8s5rnqLmRZ1kzhmBSuYdKEwzFiGA==
X-Received: by 2002:a05:6870:90c2:b0:188:170:49f with SMTP id s2-20020a05687090c200b001880170049fmr5284879oab.56.1683598399510;
        Mon, 08 May 2023 19:13:19 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id d18-20020a4aba92000000b00541fbbbcd31sm1197672oop.5.2023.05.08.19.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 19:13:19 -0700 (PDT)
Date:   Mon, 08 May 2023 20:13:18 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren <newren@gmail.com>, Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Message-ID: <6459ac3e658c6_7c68294a1@chronos.notmuch>
In-Reply-To: <CABPp-BGTByZg5rJCmBeZNwjNTFwsoQ5HTjEhmhYFFfi-KbfgTw@mail.gmail.com>
References: <20230503184849.1809304-1-calvinwan@google.com>
 <20230508165728.525603-1-calvinwan@google.com>
 <CABPp-BGTByZg5rJCmBeZNwjNTFwsoQ5HTjEhmhYFFfi-KbfgTw@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] strbuf cleanups
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Mon, May 8, 2023 at 9:57=E2=80=AFAM Calvin Wan <calvinwan@google.com=
> wrote:

> > Range-diff against v3:
> > -:  ---------- > 1:  e0dd3f5295 strbuf: clarify API boundary
> =

> Huh?  I thought v3 had this patch.  v2 certainly did, and with the
> same contents.  Did you just give the wrong range for the range-diff?
> =

> Aside: Can I plug gitgitgadget for a minute?

I guess I can plug git-send-series [1] as well.

>   * handles the range-diff consistently
>   * sets up reply-to nicely

Same with git-send-email.

>   * ensures testing on a variety of platforms
>   * makes it _trivial_ to download the series via a simple fetch, with
> remote/branch/command documented in the cover letter

This is orthogonal to sending a patch series, but anyone pushing to
GitHub can do that.

Advantages of git-send-email that gitgitgadget doesn't have:

 * Everything about it can be handled locally
 * It's a standalone script fully in your control
 * It's not tied to any organization or corporation

[1] https://github.com/felipec/git-send-series

-- =

Felipe Contreras=
