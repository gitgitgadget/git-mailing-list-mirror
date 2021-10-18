Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396A3C433F5
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 21:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BF4D6103D
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 21:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhJRVHG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Oct 2021 17:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhJRVHG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Oct 2021 17:07:06 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39762C06161C
        for <git@vger.kernel.org>; Mon, 18 Oct 2021 14:04:54 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v17so43649364wrv.9
        for <git@vger.kernel.org>; Mon, 18 Oct 2021 14:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HWrrpieS1UY+F8P++dcf9lfw/X1YFbB2Fk74UEoaNgA=;
        b=ZnzJHkzpQvWO4mI+ZnoByQ1jJjcspb4BNkjER2kKAQ+zCZ2OBYKF0JE5jmceLUxkdd
         2I22FkDdiXQdjsWUbVFgxtY9XiQJasZiK/2uByOBc9MD4wuP/UTMr/acl3O5WuMTd6Gn
         fnMc9R5z/rLBcuUqME438v8J0o4GD7jYPJEYTakHm5tkNihUeLI0NiXas5OThm7yD9zX
         h4NaMKAvQMshAurRw5waHcFYwGXmE7/oaJpnAGagkjRWcPua5AquTm0pjXWp1FAL+kOm
         lf9xS6n+m+yyb9e7WfGfOf3c1W3C1k6sZiG8yYALrtr12v+5oKfE12Vafr3630lRn7vc
         KqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HWrrpieS1UY+F8P++dcf9lfw/X1YFbB2Fk74UEoaNgA=;
        b=7TP4lwgrWv6Y9HxDYbQkDSO0zBglLyyH08EmbD89rj4tTgi49V+C+lpb7k0roM/tzL
         P1E311OeUWASEPeMdUkYNYLJdFDjFjn1mEklCBpAPlFbvlBLPtRTL/O2UMJ4S44611H2
         CLIp+7MgNTEWUI4GyjQjoHUwGnmYECuvvdDFKSVlab4la8Bo3Z1i9bgMJEUhtpmZrttg
         hLiRwVH+IUN27qZbO/Vn8HvmmMJ0BsfhPfWbtVPI1yBuWW9psOICoKWagM1YQpq891Nw
         Otpb9B3/M3gq2jU7pcEF4V85GqeWeJIay43nLJyErJfpPWKzg9ZO8bPgNBAV79cOghyZ
         M4BA==
X-Gm-Message-State: AOAM530siY3KkiGUMZd79J/Fm5R7CSKXb4cC2Om0ltpfgxxwaIrHl9T4
        KcPaqw04cUx0DCPBY0TR6d7q76ws3a4=
X-Google-Smtp-Source: ABdhPJzDV2TBFiNaW5xnz2PyFi6DM0BCosDBPyqtScOGsh1FhiS+fpjBaqa415Hg9S0ItiAOn539oQ==
X-Received: by 2002:adf:bc4a:: with SMTP id a10mr39375464wrh.131.1634591092728;
        Mon, 18 Oct 2021 14:04:52 -0700 (PDT)
Received: from gmail.com (62-47-13-40.adsl.highway.telekom.at. [62.47.13.40])
        by smtp.gmail.com with ESMTPSA id z1sm3423412wre.21.2021.10.18.14.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 14:04:52 -0700 (PDT)
Date:   Mon, 18 Oct 2021 23:04:50 +0200
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [ANN] git-branchstack: make pull-requests without switching
 branches
Message-ID: <20211018210450.law3hfps3mydoqhe@gmail.com>
References: <20211018195755.pcdpx6xyjeawttyu@gmail.com>
 <xmqqo87mulex.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo87mulex.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 18, 2021 at 01:29:10PM -0700, Junio C Hamano wrote:
> Johannes Altmanninger <aclopte@gmail.com> writes:
> 
> > I wonder if there are more use cases for creating/updating commits that are
> > not on the current branch.
> 
> I think the canonical answer to that question is "git worktree add"?

True. Cherry-picking a bunch of commits can be much slower than just
creating the commit objects but I don't think that's a problem.
