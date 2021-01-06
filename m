Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C40C433E0
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 19:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B94202311B
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 19:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbhAFTVa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 14:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbhAFTV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 14:21:29 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D923C06134C
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 11:20:49 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id b24so4083468otj.0
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 11:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CTG9GW/CfBGQ8C3IohR9i0xiGd8P3Q6dSeV8iiBVzDk=;
        b=JtStNWeLdXQtKp59dUJNbWXNvE+fgDVGUkYZbDatW7T89mkR0Jrodo7Ulsdm5eKl+s
         uA5cXrXcWGhhsRfE/3j4Z4IPDNRhJhSdbBgJI5hFtDRofFLIfdAe+thcJjlqxo0QJ0tb
         yuQ7mYihsZWXdhT3ZYBhupXfPT0kKNKXUW8bu0DJ6SXA1I7RLFjVef7zknGyYEvrUg2a
         qbALQXcjpbz3yhIHOVcrqFwIlE8J41PD4M/7v+Nh9nE+lkpRLWOzP2HMBv/1NooV1O0S
         cMA/EPzQMlmhMwyrXgpxhdXtCYurm3nshCJkmp+oi3nqsesHIk+2rJuhf+/717NTCm0c
         1R1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CTG9GW/CfBGQ8C3IohR9i0xiGd8P3Q6dSeV8iiBVzDk=;
        b=raS4jMmRo35n+K75aOmA61A35s/VTt5T6KwkeDQayBy+P/4lXMm8ay8akJfm3t8Rvh
         A9MpgoKD02NluC4Ugmj/Zj1qTKiisTTR1nxfMbLL8451tpgPTkPqE8dVBUjQXi4l7o0T
         gtAof46pftTePDYSSIEuYpQtBV9Q1HjTNT+Sy9+sl3zczBhwgrprW8ev4wx8FQ01NUYc
         ET4SeWcnCYQtMn+BMp0n4ubDd1YLxCbnu04AiBEYzg2BofEj3U8I+0G3Uw+4Tn3fGW79
         QDfBiWCXS/JaJscfVVaXSWJtXgv3fHaMlV6d69CmFFwda4hj3PjpXdV5tmq1vPXk38US
         uqtQ==
X-Gm-Message-State: AOAM532Pei9bu3Uv2OBjUigFaOiFrC16acHLEgC+HCTtPKu5sLdD+ntk
        wNZ0MdshClWSsDCt+/9oovsoJiZE+Bu0UQfQ0Vo4lBBg
X-Google-Smtp-Source: ABdhPJzmsAyE1MlOJrcrUv38XyVOFMPaTCCgMszOE7K6sHxdAEmoNYoPGIcCdU0ZcziKnOd25Q7E+ihSWAPEpOf4Fl8=
X-Received: by 2002:a9d:b8e:: with SMTP id 14mr4264086oth.316.1609960848742;
 Wed, 06 Jan 2021 11:20:48 -0800 (PST)
MIME-Version: 1.0
References: <pull.815.git.1608270687.gitgitgadget@gmail.com>
 <pull.815.v2.git.1609468488.gitgitgadget@gmail.com> <5f6d5428-36ce-3e91-4916-8968ac1b8686@gmail.com>
In-Reply-To: <5f6d5428-36ce-3e91-4916-8968ac1b8686@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 6 Jan 2021 11:20:37 -0800
Message-ID: <CABPp-BH0wN8UD91-dnTMdkE1qnbJ5eP=X526bAn=kFpQKKxYDw@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] merge-ort: add more handling of basic conflict types
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 5, 2021 at 6:23 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 12/31/2020 9:34 PM, Elijah Newren via GitGitGadget wrote:
> > This series depends on en/merge-ort-2 (it does not depend on en/merge-ort-3
> > or en/merge-ort-recursive).
> >
> > This series adds handling of additional basic conflict types (directory/file
> > conflicts, three-way content merging, very basic submodule divergence
> > reconciliation, and different filetypes). This series drops the number of
> > test failures under GIT_TEST_MERGE_ALGORITHM=ort by 211 (from 1448 to 1237).
> >
> > Further, if en/merge-tests, en/merge-ort-3, en/merge-ort-recursive, and this
> > series are all merged down (in any order), then collectively they drop the
> > number of test failure under GIT_TEST_MERGE_ALGORITHM=ort from 1448 down to
> > 60.
>
> I finished reading the rest of the patches. They are well-organized to
> present the merging logic in small chunks.
>
> While this is a very dense series, the proof is in the test cases. I
> look forward to testing the ort algorithm in CI builds and start enabling
> it in my repositories.
>
> Your patch organization will help if there are bugs that we won't catch
> until we can enable this merge algorithm more widely, as we can blame to
> these well-crafted patches to assist with debugging.

Thanks for taking a look, as always.

Your comments reminded me that I intended to dig into your code
coverage reports and try to figure out if there are parts of
merge-ort.[ch] (and diffcore-rename.c) that are uncovered by any
testcases.  I bet there are some.  There were certainly many in
merge-recursive, and while I've extended the testsuite coverage over
the years, I never did it with the aid of a code coverage tool...
