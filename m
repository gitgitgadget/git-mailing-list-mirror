Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC3FC77B7D
	for <git@archiver.kernel.org>; Fri,  5 May 2023 19:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjEETc6 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 5 May 2023 15:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbjEETcK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 15:32:10 -0400
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F441991
        for <git@vger.kernel.org>; Fri,  5 May 2023 12:31:56 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-61b60d0c5b8so10808856d6.0
        for <git@vger.kernel.org>; Fri, 05 May 2023 12:31:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683315115; x=1685907115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tgPSV77gJG4EuLaEI9TNFEq7UBMSh2Yn0IuBtJAivfQ=;
        b=HL2ad9B/BfzhY0d3osa5pTBziP/agChRWgMEqsQo0/cWJ7FRt0zct3dN3YOv9EMglZ
         jGJAh0vxHnIasttiRhzgymVceJ5EL+HhMsffJU0ifp6Havw6261/HfoH3NDL6DXltSrU
         4Z2C4EK22gYgF3/uJn36guSDnxNdf2CerBdfsKxcAl0favYz+rtKPBQymYNffktgt4nQ
         oEOK5oDNn7BcHM8tA7uJP1i6nnfgR47mnXB5IhSn36GOYN5il95MGO7+nBMNm2pYxRVW
         WR+YE9/5vCQTJ2jSYFoozA0qVWDBFl47NxIyM5XxM7v8hGy0ZRN79JE2XL2H9/L3IYoe
         m/Pw==
X-Gm-Message-State: AC+VfDwLG+bae5Z+A59u+N/mItUx8jmQx7mJ33LnKVw8cumMFhkouzuZ
        S5pCqZOuF91zEKPhnNWbxj2OwIeKR7g509WA3fvAKW9SKJM=
X-Google-Smtp-Source: ACHHUZ4JRl/2jV3GboQuBGkOCkwWwvbrlmC4tEVjOT3/URg5qU+mX8nx4X7xMmiTNRarZqW3S77P8O6A+jL/Wt68MAc=
X-Received: by 2002:a05:6214:3009:b0:61b:65f9:c1e6 with SMTP id
 ke9-20020a056214300900b0061b65f9c1e6mr3472143qvb.17.1683315115546; Fri, 05
 May 2023 12:31:55 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1225.git.git.1646774677277.gitgitgadget@gmail.com> <pull.1225.v2.git.git.1683314270964.gitgitgadget@gmail.com>
In-Reply-To: <pull.1225.v2.git.git.1683314270964.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 5 May 2023 15:31:44 -0400
Message-ID: <CAPig+cRRyMBQCiS7v0B1J+PSJFVVR++oOssrW7M3xwXS-2_jwQ@mail.gmail.com>
Subject: Re: [PATCH v2] name-rev: make --stdin hidden
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 5, 2023 at 3:19 PM John Cai via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> In 34ae3b70 (name-rev: deprecate --stdin in favor of --annotate-stdin),
> we renamed --stdin to --annotate-stdin for the sake of a clearer name
> for the option, and added text that indicates --stdin is deprecated. The
> next step is to hide --stdin completely.
>
> Make the option hidden. Also, update documentation to remove all
> mentions of --stdin.

Eradicating all mention of --stdin from the documentation makes it
more hostile for end-users, doesn't it? If someone runs across --stdin
in a blog post or in some in-the-wild script, then this makes it more
difficult to learn what the option does. In other such cases, rather
than purging all mention from documentation, we've instead mentioned
the deprecated option only as a minor aside of the option which
replaces it. For instance:

    --annotate-stdin::
        Transform stdin by ... omitting $hex altogether.
        `--stdin` is a deprecated synonym.

> Signed-off-by: "John Cai" <johncai86@gmail.com>
