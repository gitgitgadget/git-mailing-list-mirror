Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F97C77B7C
	for <git@archiver.kernel.org>; Fri, 12 May 2023 00:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239623AbjELARD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 20:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjELARC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 20:17:02 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93B8271B
        for <git@vger.kernel.org>; Thu, 11 May 2023 17:17:01 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba237aec108so8424289276.3
        for <git@vger.kernel.org>; Thu, 11 May 2023 17:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683850621; x=1686442621;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fcjjmAAsg7EasDVsWFmP9f6MImok5W6QJHP7+PYYqP0=;
        b=0cOv7o2EfVmhqJphushwnKJ7Dg7EyyDIrVliREVTfpZYW1a4ccrJZ4GKDUHwBfGUtn
         qGXi5JuKu1y8diMtLOaUl6gIVGi2MaZ7vPPeWRIY/iWGiu5jEej5dO7XjTsHVXXfoPSe
         5rzn14fO2uMJIUkUJA5sJ59OzGVjIsvPEF3OOxyTm2MhhQCRoWPD9HGpwQecxsQRiZGj
         kX6a0FYxkcGPZgIW3EgsXSS8VzHAtowZ+rkiLwx8fNsAPx7aQ54g+YMHwk9gix5l+nO7
         LHKjkPeEnXJDYSoNu+zrnIDi5q67rOQ+TEfOJ/+T2HTB3fnjmF57mqmKn4NQeq6Yn6bt
         N4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683850621; x=1686442621;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fcjjmAAsg7EasDVsWFmP9f6MImok5W6QJHP7+PYYqP0=;
        b=jnF+dCs22ibOs/y9kGu5i42z7AswF8ojzjCEDcPTV9qk+1ncFI23eFXfw32E8MT5Dz
         WSTeASQYgf+Trp9b/uhVXEv39Gg1mJFiy0piGGOk9QdVav0YQ9pifLfdTCR2m4xANWoF
         CdH0Wy07nr6qSZDCQyg+t4rOEFZ5S6AcJwNkVH0qO6gUW+QAtaSBgqUiTi9uxgM/TXYV
         QfZXe+5qmb3jCuhcjBDxxsA2E/QoyU4fbRnTQUaitLEDL7tm0jzGpX0BPzHjdd1kHyoV
         3n8SNLW4q5XS3xAxDpE6lSOrWC646Wu/GWw6nHJi/3r8AWrGLfLZhGQfdhghzFCtsu5e
         HTbw==
X-Gm-Message-State: AC+VfDzQVLLBoFoar4YGdwBej9G+TTn/QVPHKWT03/2Bn4tmAPGan5tU
        LE8vjFxtLTM9911/iAFGorgUt2Sx3VzJyA==
X-Google-Smtp-Source: ACHHUZ5bQpwGlvnwVfwLu0DLd9/U4fkGl4JMkwAmtoc9oGWzgljlgXzjZ+cu6416QYW8oUqxW4BXWAnzBf/vlw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a25:2241:0:b0:ba2:a5b9:bcf4 with SMTP id
 i62-20020a252241000000b00ba2a5b9bcf4mr9854445ybi.5.1683850620967; Thu, 11 May
 2023 17:17:00 -0700 (PDT)
Date:   Thu, 11 May 2023 17:16:59 -0700
In-Reply-To: <2cc7318697ef6062f6deadf7a22feb26c2c829e8.1683721293.git.ps@pks.im>
Mime-Version: 1.0
References: <cover.1681906948.git.ps@pks.im> <cover.1683721293.git.ps@pks.im> <2cc7318697ef6062f6deadf7a22feb26c2c829e8.1683721293.git.ps@pks.im>
Message-ID: <kl6lmt2az9ms.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v5 4/9] fetch: print left-hand side when fetching HEAD:foo
From:   Glen Choo <chooglen@google.com>
To:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> This behaviour has existed ever since the table-based output has been
> introduced for git-fetch(1) via 165f390250 (git-fetch: more terse fetch
> output, 2007-11-03) and was never explicitly documented either in the
> commit message or in any of our tests. So while it may not be a bug per
> se, it feels like a weird inconsistency and not like it was a concious
> design decision.

The change seems well-justified. I agree that it does feel strange and
unintended. I was really surprised to learn that it was not a bug.
