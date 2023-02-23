Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1284C64ED8
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 20:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjBWUfZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 15:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjBWUfW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 15:35:22 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD0952DD3
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 12:35:17 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id by8so7165305ljb.7
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 12:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=86MkxP9XJqqU8msIaqlm8ez71plnudzOnlsH0W/x2aA=;
        b=Z4YXOVEInStf/llbx/jjb8dh16SDs+MaJPDcnDkfVUAhCjEwgXb+D8GDp9GX3UHTDz
         54LNVXBnjRhTABQdfRjYtnupYaNjXB1wqlOfupYTeY9jfj77PgxzdQbjYY6Ro1+K8SFF
         BDTXPVAm04fkkILlXkt/bJVfAo8u6hnXXMX4W2aefvnR90XN66vkUbEWB0eoJql++YKZ
         Q0PkiesnxW0NexZWG23L/OxuRriTy1YXJ+XNZNlnYDN88As4h5OkA0aPZ/pX0FCxLGam
         cpRjEHzIEiQ8pLpSjQHSTjcNhWQXwntLRNZcJTUVGgh1KeqB0cTeNdwEsHYu67zUObKV
         6M8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=86MkxP9XJqqU8msIaqlm8ez71plnudzOnlsH0W/x2aA=;
        b=S9jCVPEuKkVsFxkcOI2f1/EgclJ3LA/7dbMr7OfbJRM9EgqP4AB761qtH8S0uUZT9X
         UXIgjFlR913jdqwRDTFBTo62Tb0eOQeoo9MFQhOpnSKcCkUyl2P08+CVWU8SUnIfgVAP
         rPDwP8O5zm6eXef55ofoXaCljtdy18A1rRMFPIzOyiSoPh+P9N6JdE0CKBBliAJkH8nV
         1SgJJ4mGjqy2JMkhS9xumlRNJCP0w4lme3WyF353qSZJG3O3b7LPARIPdtxvn67ImPY0
         nqRFwZxNLGql2bT7na5aNq3bKvbXyixddjipZMMMYV8zFzx3gsE02nClnog2rReNzd1A
         E4Fw==
X-Gm-Message-State: AO0yUKXb2ODF7jgmiM0QB1Dk8ZTe6rJVamQVxQ8yUV9XH87Me+WPby97
        FxL39kCpSgJj1bQQX5QuST25D7hEoC7Eo5FK6avXTOLAWHw=
X-Google-Smtp-Source: AK7set+FpoUBxK7d+iRjgnCLpe7/VoO7YCsmVa8G202a3QNBPs8MxNlmQ2FoyC9DsrnGBEWuzpbKMZxIzm8aGcIWKn8=
X-Received: by 2002:a05:651c:3dd:b0:293:47b3:474a with SMTP id
 f29-20020a05651c03dd00b0029347b3474amr4194465ljp.6.1677184515305; Thu, 23 Feb
 2023 12:35:15 -0800 (PST)
MIME-Version: 1.0
References: <pull.1149.git.1677143700.gitgitgadget@gmail.com>
 <16ff5069-0408-21cd-995c-8b47afb9810d@github.com> <73d694c5-f2d9-c05b-c880-8d5650f36797@github.com>
In-Reply-To: <73d694c5-f2d9-c05b-c880-8d5650f36797@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 23 Feb 2023 12:35:01 -0800
Message-ID: <CABPp-BGu8DKBcKCxLnBMBbPvo+DdFyad_iqTt1sbyRSm5tKH5Q@mail.gmail.com>
Subject: Re: [PATCH 00/11] Clarify API for dir.[ch] and unpack-trees.[ch] --
 mark relevant fields as internal
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2023 at 7:26 AM Derrick Stolee <derrickstolee@github.com> wrote:
>
> On 2/23/2023 10:18 AM, Derrick Stolee wrote:
> > On 2/23/2023 4:14 AM, Elijah Newren via GitGitGadget wrote:
> >> This patch is primarily about moving internal-only fields within these two
> >> structs into an embedded internal struct. Patch breakdown:
> >>
> >>  * Patches 1-3: Restructuring dir_struct
> >>    * Patch 1: Splitting off internal-use-only fields
> >>    * Patch 2: Add important usage note to avoid accidentally using
> >>      deprecated API
> >>    * Patch 3: Mark output-only fields as such
> >>  * Patches 4-11: Restructuring unpack_trees_options
> >>    * Patches 4-6: Preparatory cleanup
> >>    * Patches 7-10: Splitting off internal-use-only fields
> >>    * Patch 11: Mark output-only field as such
> ...
> > The best news is that your existing series makes it easier to flip
> > to the internal pointer method in the future, since we can shift
> > the 'd->internal.member" uses into "d->internal->member" in a
> > mechanical way. Thus, the change you are proposing does not lock us
> > into this approach if we change our minds later.
>
> And now that I've read the series in its entirety, I think it is
> well organized and does not need any updates. It creates a better
> situation than what we already have, and any changes to split the
> internal structs to be anonymous to callers can be done as a
> follow-up.

Wow, I was a bit worried pushing a couple dozen patches last night
that it'd be weeks before anyone took a look, and perhaps even that
I'd again get comments that I was pushing too many to the list.  You
read and reviewed all of them across both series, including some
comments showing you read pretty carefully, all before I had even
woken up.  Very cool; thanks.
