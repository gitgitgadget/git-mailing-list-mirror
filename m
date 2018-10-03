Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F376B1F453
	for <e@80x24.org>; Wed,  3 Oct 2018 23:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbeJDFzZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Oct 2018 01:55:25 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:39222 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbeJDFzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Oct 2018 01:55:25 -0400
Received: by mail-ua1-f74.google.com with SMTP id t14-v6so1577813uao.6
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 16:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Nawr343adD0n05O58wcD4FVh/Cccr365ZEHIIhlZ96c=;
        b=kbmsn6ZcrZuvWNNsVMUQgadtjQT+RAzEticAyI+b9SEf2gcPCyzQnb5JKkZLC8Goas
         zFnshO3TfonCRSCmaSr6AGEac0jPuPaAbSMO9FGYvQRx1R03Mzu9bNuCpyYqw4oLnehM
         e+o1Ryu4cwlVxKUJ8ng9G7fiDdqbiGIXUf4tONU1GmgGWSaeoWL5hKYzFsZv1Ov2EXqe
         vIb3NkGDSDyGNZPLG5PLvlbSu6H/HkV45frlNWk8TuZFvj6omWZl11C9Mxfnf/72Pq69
         pi0xomveBCA3bR6JUowWE3UqWSTg0mI32W8d/LkAARcROHRRwiS/bI91nMjeIvckgea4
         6Vdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Nawr343adD0n05O58wcD4FVh/Cccr365ZEHIIhlZ96c=;
        b=fzxzHJDxRhDiNK29aM8odygh5CW5Qat6lyvd8LQ5qXIAxqWAuWpcVjFEvY8/po1h9X
         nzHrXWEQ64TqEfEaQqWXtbrZllAXaSUQLH5k+yPCLR/kdnCTLezwm6Bb4Q29ANW24dtq
         hf+NvoL/koGeo3+tkcrk4Dx2mztliihXPChJG+TFRPBACUWX6nAvBIVvwLnaIMWW24+2
         85f3cpAjbt3pDd7/eR4lsPNinRL8uNwHzKPdSroZZBvyvwDKlTjZGXv+gfGziBdtGDRC
         WNb5Nsh9vaIbTtJMw78wmFiIBRVBlOaSL/na1bsPcc8r4Rdss2ywZiUuwpl9lePTfH4z
         6Iaw==
X-Gm-Message-State: ABuFfogyhnt62CLlmXSGeJ0aoXIeJtbeAy9CwqiWcNjnLATwH5FPz2sl
        Sp6QVmJA4uhBCowX83HbPDRWuPN2IU855wES7ETdNCoLQOdMt9EUcDL4Hbu7D5XvnNKgbMhYn7f
        UMAj88TTPFsqQzprC2IG+RhpHlhLL+7LJ654aH97bFIHJy3ihsOtLz8IXmENHqRpuy98YVFu1vh
        rG
X-Google-Smtp-Source: ACcGV63gKUAfFTd0L3E09wjyzundsK4cqbG/LOZepWKC9qTE7pW1ZpQR6XJjFXBprMkYib57t56/m+NvxLw/EhM6kkAo
X-Received: by 2002:a1f:b915:: with SMTP id j21-v6mr3292694vkf.13.1538607898230;
 Wed, 03 Oct 2018 16:04:58 -0700 (PDT)
Date:   Wed,  3 Oct 2018 16:04:51 -0700
In-Reply-To: <20180924154516.48704-1-jonathantanmy@google.com>
Message-Id: <cover.1538607476.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20180924154516.48704-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v2 0/2] Lazy fetch bug fix (and feature that reveals it)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This seems to break 5520 and 5616 when merged to 'pu'.  
> 
> It seems that merging master to md/filter-trees and then applying
> this is sufficient to break 5616.

I verified that 5616 is broken on [master + md/filter-trees + my patch],
and after investigation, found a bug in the lazy fetch implementation.
Patch 1 contains a fix, and more information about that bug.

Patch 2 is the original patch, updated with the commit message I
suggested [1] in reply to Junio's comment.

I bundled these patches together because patch 2 (in combination with
certain other commits) reveals the bug that patch 1 fixes, and to make
it easier for others to verify that these patches together pass all
tests when rebased on [master + md/filter-trees] or 'pu' (at least, as
of the time of writing).

[1] https://public-inbox.org/git/20180927183718.89804-1-jonathantanmy@google.com/

Jonathan Tan (2):
  fetch-pack: avoid object flags if no_dependents
  fetch-pack: exclude blobs when lazy-fetching trees

 fetch-pack.c             | 115 +++++++++++++++++++++++++--------------
 fetch-pack.h             |   7 +++
 t/t0410-partial-clone.sh |  41 ++++++++++++++
 3 files changed, 121 insertions(+), 42 deletions(-)

-- 
2.19.0.605.g01d371f741-goog

