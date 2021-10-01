Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741B4C433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 20:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D493611C8
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 20:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbhJAUD1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 16:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355080AbhJAUDY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 16:03:24 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B62BC061775
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 13:01:39 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id y25-20020ac87059000000b002a71d24c242so4585005qtm.0
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 13:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Da3nHtXi6dy19catU12g+83zRZ0jspn8mAW1dmXryvg=;
        b=AFT3rqvFBPM5jeWDQcZabVJePLT/C9d1RFw+S9zxwtSXEi47uT9ugGT8L5EM7JmyTN
         EmAo9Z9stGcVdImNpnuNq7i+AT4OlwKtbHE2NVUogorjejHyPJ++PCst7Rm0b7kGihwH
         G9AINk78wmfCOt0Oh0+RW9UssDzzPVYX2X+tiXWztJS4HGM3YSgvY5WRhA6ihnvE2OgV
         4KPgxqm53Hs1PtNzWMYJWWHJA3w4gqU9V7NLtyWGbHpDs2wlNLytcd0aSUS7C/CIADOh
         uVLbq7nEOOjrORQIr6PZ/k473dgAns/yQqcUwV6DvhzZnq4jJTripID5RLor+xtI4knF
         kmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Da3nHtXi6dy19catU12g+83zRZ0jspn8mAW1dmXryvg=;
        b=AJVzb4F5ntDQnn94IXX/dlqlIm21FXgU4qQi4iIY+oyttrpCpBgBdaVBIOTInfhJMQ
         ILTvMYZwVFXDjIEgXyi8gCG/wuiqNkKsnJ8G6yhSagPF5LeJaIBVCbLHqS27ngdQsBtE
         YXleNiHWw93sWbXI4o7laOq5M9ppKlArZ7sLYt34rlFGYyildBvxTNZPBxfd1Ua6miIG
         QU5J1cRyVfOtgLhjI2h8J9bISe1FCsUWMhdoCAxI0siQZN8ClSvKPwRpexDuUEPSfK8o
         lmXVtNPAG3vALiE9G7QJAbVfzoh5EnPKaz97+9Cww2YAq1kkwsQtRX4OIlDDCmIhXrfv
         7wVw==
X-Gm-Message-State: AOAM533F8CPOfeaQjrMr57S6NcLDlH+BEeVrboLRjc9NMwSSN3AxDCsY
        lvUaT7BduRzDueL91rJYrLdb/lgwyw+GmR7qhEQk
X-Google-Smtp-Source: ABdhPJwQcj4znEduVSN9gvg4lA8ozk2Enc30lR0TM/B+JGKgsQ1kyNR3ZdCbzObi+U5nFyf9WmuOh6XhE0fx2iyJ89iI
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:3009:: with SMTP id
 ke9mr11152358qvb.30.1633118498449; Fri, 01 Oct 2021 13:01:38 -0700 (PDT)
Date:   Fri,  1 Oct 2021 13:01:35 -0700
In-Reply-To: <cover.1632880469.git.me@ttaylorr.com>
Message-Id: <20211001200135.215855-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1632880469.git.me@ttaylorr.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: Re: [PATCH v3 0/9] repack: introduce `--write-midx`
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, peff@peff.net, avarab@gmail.com,
        gitster@pobox.com, jonathantanmy@google.com, steadmon@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Here is another small reroll of my series to implement the final component of
> multi-pack reachability bitamps, which is to be able to write them from `git
> repack`.

I see that all my comments up to patch 6 (of v2) have been addressed.
There is one outstanding one involving a potentially uninitialized
variable [1] from patch 8 (of v2) that you (Taylor) might have missed
since I sent it after I reviewed the first 6.

Other than that,

Reviewed-by: Jonathan Tan <jonathantanmy@google.com> (conditional on
that being resolved)

[1] https://lore.kernel.org/git/20210924182247.2922561-1-jonathantanmy@google.com/
