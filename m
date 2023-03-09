Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77A0C64EC4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 19:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjCITBJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 14:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjCITBG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 14:01:06 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A84FAFBD
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 11:01:05 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id pl10-20020a17090b268a00b00239ed042afcso3080770pjb.4
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 11:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678388465;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R1iBhxt365qwwS0yWvW363M4KHTN9td8M3h+oNj4zWI=;
        b=j6xcApMCQ3+MlX8gpCYfKgmN8OPZ/L8U/FHD5A4z4pfXZc9PXD9pkWSisurrOATq+C
         IheXOBDXsNSa+EjkC5xKREfBmN4xzxH/363e7c2hGEJgTuWl8oqaLiSwPhy/3YDwMJpU
         XI1FdmEfqKiPzvZK/xMS7LfokTS5JBCV4xAQmpzoIGz0/h9k2egt87voiXugpxhfWr94
         Ej/589kgmKvi2MZEMrCjWJRe+LJPshg4O0wpLukNYOXPduZs4Oq6+FtYg2JRUEBXE3Rc
         tslKRHxWNIrBaxuR+vThphJa1DSe5NL8Pfp6zG/2nkQAU+HGr233H9Sq2mBKrvfu645H
         wowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678388465;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R1iBhxt365qwwS0yWvW363M4KHTN9td8M3h+oNj4zWI=;
        b=5qxxngeCQk2PkHWbDt+3sr2WJe70VtV+81K4PFUJeJkW8zv0i1Ilx+rnz1VRFYntMH
         oXMyiP2dOZuf9gd8GFOXS/QdCUx1vx9mWQYJNIAhlK8S/APpcoGT+FDK1KkuAR83utP2
         OmltEaYRfbQLN+LBhCe8XAx5Pmlg94hcsQpIvtzVQGtHuka22WyaEdHeTyZ43IJGEtSe
         RXcTGqTf8Aun2TguTtXLDgHimM2Yv5FI/FYoYahpo/YOSKvVuKfSW+Sder5cB9Nqa8gY
         /pv81bYJ3skyoKjOVPDxfATZHoXOAlbPCDaiRDtRdIazWMRC2CkF8vZMB6w2Ic4HBfJY
         PtYA==
X-Gm-Message-State: AO0yUKUH/Kca4XaJ28C/lPMRg8pi7lNf83DLRieiX3xiJY7/sndG42mx
        ZTI2N2IHECRPjrstScX8Fq3X0PBAACyzIw==
X-Google-Smtp-Source: AK7set9V7wxsItEbsjY4B2PvSAcwh/R8a2yaLcgpWVhYCIZ8iaYTbEIU8DuZ0eWACUcydCHjCnhXZaQ3Kxtlmw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a63:135f:0:b0:503:130c:aca2 with SMTP id
 31-20020a63135f000000b00503130caca2mr8975822pgt.5.1678388465394; Thu, 09 Mar
 2023 11:01:05 -0800 (PST)
Date:   Thu, 09 Mar 2023 11:01:03 -0800
In-Reply-To: <patch-v7-5.9-dced12a40d2-20230308T090513Z-avarab@gmail.com>
Mime-Version: 1.0
References: <cover-v6-0.9-00000000000-20230307T180516Z-avarab@gmail.com>
 <cover-v7-0.9-00000000000-20230308T090513Z-avarab@gmail.com> <patch-v7-5.9-dced12a40d2-20230308T090513Z-avarab@gmail.com>
Message-ID: <kl6lbkl1hhqo.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v7 5/9] config API: have *_multi() return an "int" and
 take a "dest"
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "SZEDER =?utf-8?Q?G=C3=A1b?= =?utf-8?Q?or?=" <szeder.dev@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, raymond@heliax.dev,
        zweiss@equinix.com,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Have the "git_configset_get_value_multi()" function and its siblings
> return an "int" and populate a "**dest" parameter like every other
> git_configset_get_*()" in the API.
>
> As we'll take advantage of in subsequent commits, this fixes a blind
> spot in the API where it wasn't possible to tell whether a list was
> empty from whether a config key existed. For now we don't make use of
> those new return values, but faithfully convert existing API users.

I think the commit message is fine as-is, but perhaps you intended to
include this paragraph from v4 [1]?

    A logical follow-up to this would be to change the various "*_get_*()"
    functions to ferry the git_configset_get_value() return value to their
    own callers, e.g. git_configset_get_int() returns "1" rather than
    ferrying up the "-1" that "git_configset_get_value()" might return,
    but that's not being done in this series

Which is nice, but the commit message reads fine without it too.

1. https://lore.kernel.org/git/patch-v4-5.9-23449ff2c4e-20230202T131155Z-av=
arab@gmail.com/

>
> Most of this is straightforward, commentary on cases that stand out:
>
> - To ensure that we'll properly use the return values of this function
>   in the future we're using the "RESULT_MUST_BE_USED" macro introduced
>   in [1].
>
>   As git_die_config() now has to handle this return value let's have
>   it BUG() if it can't find the config entry. As tested for in a
>   preceding commit we can rely on getting the config list in
>   git_die_config().
>
> - The loops after getting the "list" value in "builtin/gc.c" could
>   also make use of "unsorted_string_list_has_string()" instead of using
>   that loop, but let's leave that for now.
>
> - In "versioncmp.c" we now use the return value of the functions,
>   instead of checking if the lists are still non-NULL.
>
> 1. 1e8697b5c4e (submodule--helper: check repo{_submodule,}_init()
>    return values, 2022-09-01),
