Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56216C4332F
	for <git@archiver.kernel.org>; Sun, 13 Nov 2022 04:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbiKMEya (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Nov 2022 23:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235145AbiKMEy2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Nov 2022 23:54:28 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C0F13E09
        for <git@vger.kernel.org>; Sat, 12 Nov 2022 20:54:27 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id o13so4315795ilc.7
        for <git@vger.kernel.org>; Sat, 12 Nov 2022 20:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nN5DeOJyT90VopSZjvdaYMG07C+jGd1cwu7rPb9Bsqk=;
        b=1jnNpynh4ykbR4i/7qHVwD82SWQ4bzL0CXIsF+0toe8aJGd6UM3M75K6tVfKWEt6E4
         fUqEcTXo6FF9gw+FRBaMLe3rNOP1PvMLDa0Ux4INUNotQfMhtA0UAEqoosmJEYZYX0s+
         AB7rI+1r7HJC53/frqqiG9980pl+6kqDMgrLX2Td1d4fqkOcMOFJGY0rJLcsi/CDEhb9
         Pw98h3aqlLo++EWruBOQuNOgnPHkj3IOai7UBu3o8uBygW/zuhtRQ52ZME/CY9tFv49v
         oXCvZUQNY5+HA8zOYR0poA+c0le9OMKL6EKDPBOew4o+rq2l5VX1MWrQZrscD9oiYMa6
         SEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nN5DeOJyT90VopSZjvdaYMG07C+jGd1cwu7rPb9Bsqk=;
        b=EJeeTvEmvCCe3lwLwlk19vzfOPm6Z0gjCcEwp7KFqV2N2mNmOZntXfSbHZwMiW75A/
         utnOpSOBeKDiE3RD++ij/bGjVNBSTWyQjo3bl6xaj+5FIQ6RDFN9AFp0nnhIA6gQRaxR
         6PG6GtQ9aEras8mJ+qtVWP6dKVgEXP3JUreoobprW2ej1IqxRiZZr3F6gNINAvTj9Gxy
         X/PaydcDgNtfhvALVjSlvKQ+UDjUBBbLMCFw43hv4YYxu+NeAXKRUCOqo7PRVN+i8o6x
         FpjUhk3NXA9dbrwRcIhyqTzYTryi/MlUv2QEZOVH9q8ETBjlZQ1UuRJz4WDggXS2eWTw
         OfVg==
X-Gm-Message-State: ANoB5pmCu+j7IX06FEfNwwBq39w4b8HCizx+IZNYJlHvb1Shl4uwNLcX
        GAg4ZrOvhVRcXEF/4yXz/52DtA==
X-Google-Smtp-Source: AA0mqf4TEyKjD8o5M16WakGfEbNw509gwPGjp8tAkxA2gkdZmKiGSZK6DuE5JdieWWMcUdPbq6P7Cg==
X-Received: by 2002:a92:c6c3:0:b0:300:f2cc:c6e3 with SMTP id v3-20020a92c6c3000000b00300f2ccc6e3mr3972621ilm.126.1668315266881;
        Sat, 12 Nov 2022 20:54:26 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h10-20020a02c72a000000b00372d05cab42sm2326658jao.23.2022.11.12.20.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 20:54:26 -0800 (PST)
Date:   Sat, 12 Nov 2022 23:54:24 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Kyle Zhao via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        kylezhao <kylezhao@tencent.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v7 0/2] merge-tree: allow specifying a base commit when
 --write-tree is passed
Message-ID: <Y3B4gGWgnlCpAFDP@nand.local>
References: <pull.1397.v6.git.1667472621.gitgitgadget@gmail.com>
 <pull.1397.v7.git.1668210314.gitgitgadget@gmail.com>
 <Y3B4Tl+luEPJgVJP@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y3B4Tl+luEPJgVJP@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 12, 2022 at 11:53:34PM -0500, Taylor Blau wrote:
> On Fri, Nov 11, 2022 at 11:45:12PM +0000, Kyle Zhao via GitGitGadget wrote:
> > Thanks for everyone's careful reviews.
> >
> > In this patch, I introduce a new --merge-base=<commit> option to allow
> > callers to specify a merge-base for the merge and extend the input accepted
> > by --stdin to also allow a specified merge-base with each merge requested.
>
> Thanks for the updated round. I applied it locally, now let's see what
> reviewers think of it...

Oops ;-). I should have looked further down in my inbox before replying.
Looks like this is ready to merge down according to Elijah, so let's
start cooking this in 'next'.

Thanks again.

Thanks,
Taylor
