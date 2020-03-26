Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0465AC43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 17:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFDC32070A
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 17:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oBt9lG38"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbgCZRuk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 13:50:40 -0400
Received: from mail-pj1-f73.google.com ([209.85.216.73]:36781 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgCZRuk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 13:50:40 -0400
Received: by mail-pj1-f73.google.com with SMTP id np18so4858062pjb.1
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 10:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0RGo9j/N0cGPO5a2EXZRifrQc8cHSnxKrJiruN+BvOE=;
        b=oBt9lG38uNUj9vgrYpwIRHwV+4BmQXe7Kr0s1RSJ9ALODjv+FQo2Rx0t8jUiX3bCC3
         EGvoHnTnj44ALtPH0HDxFE10auS7E/VPrRiFP6A9HCaRQJkZbERaeeobyb1QSQ2gVp2k
         CkFDpjTfdKByPfxEJKo6hIgkbd+Oq3FS0yLKEMqjNeJhSO5ITMVH0hQys5FGoak5qO9k
         BUQ5vUhLqDjqqXX9/mxm+a6RPFQyhizwKTz1Q4M+JLiWHS3Xb/ZZyZ9YT74Y/wddLYMT
         HnEsipYVdfhwrA2X042dNXrcpUcL7vXK6w6vMm2apjcbJqTRVe1YNAF4XxrVEhhi0Hbc
         BvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0RGo9j/N0cGPO5a2EXZRifrQc8cHSnxKrJiruN+BvOE=;
        b=TPCnB+Fs30aQCaLQVNdIHeQou29apVDoRbkcqNcqZWN3eF1/GJDtyR5Fvsk/cyuN9s
         Lk2kya9KduWAYFbUDi4oHgB2WQlZoL+uApdzmrBTlq7hZ8Zef41jpAEdQlch5445P1vS
         vyvKrKd7QibAhGIFcyUaop9gzgkAIA948+ZI4PJL/eqZ39nvW7kTit9qbRo3S4FHRoKP
         CJSrrB3tpvPV0FMKsrwd7mC43Ik35/E+5xr+qCcG7z3GL2+IHYdl/cDKxnYHw2jA1DCU
         qT77SDu2s/VAvIgwmShm/tCx/X66w8Ifqwpu8AcZm9sB3WcirUhjbF2VdKGlfZmkdHfM
         Tfrw==
X-Gm-Message-State: ANhLgQ3uUOuPRXx8L3sBHsL4ZENCAr5uTJfM75ukz/z7z5+C0LuLiVRm
        I4o8w4EQk37GY2iJJu3cB8k6n9mR1OAzFOieJK5j
X-Google-Smtp-Source: ADFU+vtd8AJirbVBBdTjuWM7ZKKab1tonMeTzYTXLdlq9dLoW56t0ukWf1A+TiDJZfMV06rrYQ6nzeTMuwJEav7I514u
X-Received: by 2002:a17:90a:a385:: with SMTP id x5mr1284248pjp.102.1585245038774;
 Thu, 26 Mar 2020 10:50:38 -0700 (PDT)
Date:   Thu, 26 Mar 2020 10:50:33 -0700
In-Reply-To: <20200318173051.25875-1-jonathantanmy@google.com>
Message-Id: <20200326175033.35944-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200318173051.25875-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: Re: [PATCH v2] rebase --merge: optionally skip upstreamed commits
From:   Jonathan Tan <jonathantanmy@google.com>
To:     jonathantanmy@google.com
Cc:     git@vger.kernel.org, newren@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> New in V2: changed parameter name, used Taylor's commit message
> suggestions, and used Elijah's documentation suggestions.

I think the discussion has shifted away from whether this functionality
is desirable (or desirable and we should implement this functionality
without any CLI option) to the name and nature of the CLI option. Before
I send out a new version, what do you think of using this name and
documenting it this way:

  --keep-cherry-pick=(always|never)::
          Control rebase's behavior towards commits in the working
          branch that are already present upstream, i.e. cherry-picks.
  +
  If 'never', these commits will be dropped. Because this necessitates
  reading all upstream commits, this can be expensive in repos with a
  large number of upstream commits that need to be read.
  +
  If 'always', all commits (including these) will be re-applied. This
  allows rebase to forgo reading all upstream commits, potentially 
  improving performance.
  +
  The default is 'never'.
  +
  See also INCOMPATIBLE OPTIONS below.

I've tried to use everyone's suggestions: Junio's suggestions to use the
"keep" name (instead of "detect", so that we also communicate what we do
with the result of our detection) and the non-boolean option (for
extensibility later if we need it), and Elijah's suggestion to use
"cherry-pick" instead of "duplicate". If this sounds good, I'll update
the patch and send out a new version.
