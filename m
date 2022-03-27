Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DA8C433F5
	for <git@archiver.kernel.org>; Sun, 27 Mar 2022 03:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbiC0Duh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Mar 2022 23:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiC0Dug (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Mar 2022 23:50:36 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75C1F2C
        for <git@vger.kernel.org>; Sat, 26 Mar 2022 20:48:55 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-de3ca1efbaso11991199fac.9
        for <git@vger.kernel.org>; Sat, 26 Mar 2022 20:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YUA9pvaz8MKnJSUjseyWRXgUbn0Pn/9E8OklfBmmRCM=;
        b=atVr9WBDud/du3RKaq/JmNF2vzOCpt+Yp/VN1T/n/PKkk/9d/pvjJr3dW9W6IhJmZY
         xOII1vKIFKAQ5im0MjdJDi+gBVcrQD9IGtKLOdbmHAVECo2XdVvx8XX5fVp1B9Ew6eWv
         iksdFHO3zrtFEg2W1pQA5ILd5DwhiCBeDS0RLa189mAcM77k2KvKgnvDQd7W8dssHBYH
         f62Xtsp+LqBQ6XvLTiuqcYhpqzi6BWO/yjvmiDzbHg/rhPt597gzT4SCvQ/7VsUVQm25
         PYjnlahi6Z7Edr5q44z6lkXdGZ5B798kkW6s5ZRTWRrjMoc74ZjpL4x9GYESdAaDxRKe
         uNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YUA9pvaz8MKnJSUjseyWRXgUbn0Pn/9E8OklfBmmRCM=;
        b=mPItT8ZuSEfB0Lb457w0O/nWxV8F41So0X9Y0kvLpKzafWKvW4TIbISwKO0kh1SdmP
         1GbWPIttCr0vKTcHySgS3R+RRY3lZSBTZAy40veev9oMdrk9EGZ5VaNEw7F0GE1CFJa1
         Q6MAfHNOnlrqJ5cunPQg0nDudKfP5+GvEqFP7C7KQ6fiuasDmoWBYBoKnN5adxospyuz
         xiXVNZAvhCrw5uuqqJP3lGlX1vNt50D0Z6XeD2DPNt23Psk8n8lkt+bD68Gmb+du3Qra
         BTJaCvj3141xGylpClrBiPzFzJUTNGrhZqQ4QgYPQHe/hiAn7S60baknXO0uYWrF7v23
         tAYQ==
X-Gm-Message-State: AOAM533gVAR15k8ZsZXyYGT0nSe29Ve9jzdk3CVV2tV4QZeRPmz3euOn
        uSCqyI6I64TgUVAck5Gdb2zX5zcjYHnSXXEXRpXXLl/usFY=
X-Google-Smtp-Source: ABdhPJxiLllDc7q7mQdiI3XlZ+18byVLYV1vBvzUs3pu/r/8sl0pgp/6xOwBFcV/Dngp35pKP4n+Qf70CCvx2yKfiqY=
X-Received: by 2002:a05:6870:f713:b0:d2:8adb:aaeb with SMTP id
 ej19-20020a056870f71300b000d28adbaaebmr8306858oab.111.1648352934328; Sat, 26
 Mar 2022 20:48:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220315100145.214054-1-shaoxuan.yuan02@gmail.com>
 <20220315100145.214054-2-shaoxuan.yuan02@gmail.com> <1ab24e4b-1feb-e1bc-4ae4-c28a69f77e05@github.com>
 <CAJyCBORDOJUwTzOC+hYwGGPUBCXST0_mBdwRLh2N+cA=5k0d4A@mail.gmail.com>
 <675c7681-c495-727d-1262-ee8c6a5c8ce5@github.com> <CAJyCBORfAV_TV6DrOxgim4KtU9T-uTibOaQCsJZsi5_FQfci1Q@mail.gmail.com>
 <97a665fe-07c9-c4f6-4ab6-b6c0e1397c31@github.com>
In-Reply-To: <97a665fe-07c9-c4f6-4ab6-b6c0e1397c31@github.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Sun, 27 Mar 2022 11:48:43 +0800
Message-ID: <CAJyCBOQT1TwkNX_be9B3uKsv4Buf_ojfZoqfTAUqQ22Na7dY=g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] mv: integrate with sparse-index
To:     Victoria Dye <vdye@github.com>
Cc:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 18, 2022 at 5:57 AM Victoria Dye <vdye@github.com> wrote:

Hi all,

It's been a busy week, I'm sorry that did not have much time to respond.

=================================
A brief summary of my latest investigations:

I think the 'git mv' command still has some questionable aspects, especially
with the 'git sparse-checkout' command. And I feel we have to sort things out
between 'git mv' and sparse-checkout first, then proceed to the issues with
sparse-index.
===========

I'm trying to fix the first 2 of the 3 potential things mentioned earlier.

> 1. When empty folder2/ is on-disk, 'git mv' (without '--sparse') doesn't
>    fail with "bad source", even though it should.

In this case, 'git mv' does not fail with "bad source" is something expected,
because this error is related to the existence of an on-disk file, not
a directory.
The closest thing that it should fail with, in my opinion, is by
calling the advise
function 'advise_on_updating_sparse_paths'.

With that being said, I now raise the first question: should we change
the sparse-
checkout cone check to be placed at the very beginning of the checking process,
or keep it at the end as a very final check (where it is right now).
My preference is
to place it at the very beginning, since the user should always be
cautious about
touching contents outside of sparse-checkout cone, no matter what.

If a certain move touches out-of-cone stuff, and at the same time it will fail
with the, for example, "destination exists" or "conflicted" error, I
think these errors
should come second, after being supplied with the "--sparse" flag.

> 2. When you try to move a sparse file with 'git mv --sparse', it still
>    fails.

This is also related to the first question, because in this case,
"folder2/a" is not
on-disk, then 'git mv' will fail fast at the first check and ignore
the "--sparse" flag.
Even if we modify the code to place the out-of-cone check at the very beginning,
and supply a "--sparse" flag, we have to make 'git mv' look into the
index to find
a sparse file. And here I raise my second question: by moving a sparse
file, which
is normally not on-disk, we have to alter the original 'git mv' logic
to make it grope
into the index for the missing sparse file (for now it does not care
about the index, except
when it receives a directory as <source>); can we make this change?

--
Thanks & Regards,
Shaoxuan
