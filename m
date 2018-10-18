Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A32D41F453
	for <e@80x24.org>; Thu, 18 Oct 2018 19:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbeJSD7S (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 23:59:18 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:35855 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbeJSD7S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 23:59:18 -0400
Received: by mail-io1-f44.google.com with SMTP id p4-v6so21716573iom.3
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 12:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kNO9lg6M7D/h+sz9qLzhn/2c8ajlWQYgh/LRPYQb9JQ=;
        b=DCtyHRtFGd4UawAmBXT5CHyOj9csn5DQ3gPVuu/DDHla+AuKdHD9F6+dF7LmAMeWq/
         JN0T9OwlX2EixaPq48j8+d1ITS97Jo708feAS4QI8Cke7gQvH0zJx1Y/LsX1HK17EUFg
         yvLhdtQ+LqK2nEIK83TSwb+qGe269qRJUeeucSHa52bMbAiVFjNjLkFHNWeNO2nUgW13
         eBLiM20GLgfSXgFaO39+ZErXhRUrXddDgJ8CjoTVEwcW85ztlet4GEom4RqkcUmPEbVp
         SuGJhGn9j+PdIvUuj6nQRIWse7r+fsNB22jiS77kLhH64EIZJK11tJMi2LtvTdT52Kkj
         nnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kNO9lg6M7D/h+sz9qLzhn/2c8ajlWQYgh/LRPYQb9JQ=;
        b=OcHIMnQiaF2Xc343HvmN1QekAIHzYfb05hCUVEQZbNWgNJouSX8f/rKpiCN2nXY5d6
         qDbyL5yPhk8ijR9lkaTkFWP4GLisJqAzouLTy+1wXsKGeS/8ZcsAk75HidgqKCmXfi2L
         czauEybMu4fBwRHrpn59tuBPUJLmhHOBKv3DHbmIL9dQbwsxbHfWCSEDsFKE1jR8tw92
         DSncrN/zNYsBih+UP0RQ8SiWfvcq9Ka0Te+mpEIOShtFtlQYVmKSHqWz7VTKR8sG06XN
         8Liao2KhYMRqsbItwpdpbr1780Qdcp93FG0ib6GhrnOeYr+v6NPplVw43Y2FoPkRVN4w
         FxWw==
X-Gm-Message-State: AGRZ1gI5sQ0uvE1DNmT8UZG+wip0sCwZjRpNX1zZ/Rpg8IkCe001+C7M
        qj3qmu2PnyMxtv2f4N1EM7NGaxVdLF/+5lcblJ/hlQ==
X-Google-Smtp-Source: AJdET5czdE3iUqglnfUHVHi8lmXo3hf+zWNTIaSIyks/ZcSzPHXtUM/9IEzcmJT/bPxj0JEOglINWQ3K1wviihjcYdw=
X-Received: by 2002:a6b:8fcb:: with SMTP id r194-v6mr1237129iod.266.1539892602966;
 Thu, 18 Oct 2018 12:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <20181018185920.22975-1-carenas@gmail.com> <16e462a7-cdd6-9d5d-d740-d5241485787b@gmail.com>
In-Reply-To: <16e462a7-cdd6-9d5d-d740-d5241485787b@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 18 Oct 2018 12:56:32 -0700
Message-ID: <CAPUEspixnjOm7YAuCgCTfmWf28kF8jCACD=-VHNDAeL2Gu8mQQ@mail.gmail.com>
Subject: Re: [PATCH] multi-pack-index: avoid dead store for struct progress
To:     stolee@gmail.com
Cc:     git@vger.kernel.org, dstolee@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 18, 2018 at 12:36 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> Is there a tool that reports a wasted
> initialization that you used to find this?

I'd used clang's analyzer recently to track a similar issue before in a
different codebase, but not for this specific case.

Carlo
