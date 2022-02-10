Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36141C433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 23:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345707AbiBJXeD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 18:34:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbiBJXeC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 18:34:02 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFF25F67
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 15:34:02 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id s207-20020a6277d8000000b004e0300e14f7so5295286pfc.23
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 15:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to
         :content-transfer-encoding;
        bh=4JT1Av4FQxRqVOT9qV1GgL2sHXyxG4BY2hA9vNi2k7k=;
        b=IC59VsKkLDVtD3tlBp3xYn5l01OiGI+ccmhaF0gFcgtVna0WODTiTxQ5tg9WesEHWG
         1nt5iS8z/OAvOsJZ08wA4pyNyyDJX+tuCvDiKLWCbfwK1M8a/IyvB7rWMthIKlS9GIrx
         ABHpV06QsJf25lLb/MYfef/VO72v9AZLzHd+iv7WqpDZKuy1Xo6q1+zI0tn+lZbP4F+X
         UCTV6F9ZIpHvJ+wOrrIANplb2yGn1BULPHMDJHebjOQmtnxVeSnJ3gltGS9jY/E5uoeX
         OFqlLJjQSnJ+GZ/H550Wf12lwy0EfDeq7WVqSjdWfG2du4oHijSp7fFax/tMzipP2RAl
         I9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to
         :content-transfer-encoding;
        bh=4JT1Av4FQxRqVOT9qV1GgL2sHXyxG4BY2hA9vNi2k7k=;
        b=t2YWmYZRemve39k3zpM5j3cXtRFZewHofJkGJrQGmMroQprDmoChYKCmfX1n8+cEK5
         nBR+oJd18KgGapQLN8Fy+JHilNCI8UFjE0RJ+SAEnJlAHWYCWAVV3By/SkAQ2NyzoddM
         SnFNEcwCy8IPsScS3SYShSRVROoXDaTYiW6WTUaVFcacCCtokY4SuAIyQpRs7mGIFVsV
         C+yfx7SkcXRUfWnLyLqZhwqUO0ZQ3nxnpZdR+CegIgjKMFNqDraXVLA6AOPLa6GB9UM4
         e8HokhvdTIxwhviIyOut5T+Dl5aJbc15+Ja3cWEMOFWzcj2QXjOaejEPfJh8Zk0JspB/
         Ajug==
X-Gm-Message-State: AOAM532rwCLzcWjRyAbF00s1/54LenmUNo3Z1HLtzIaVycWsKNuEPMt1
        ZrJW1JRQxq9FNTKfhKWtRwv7Ue65taBylEa5xnVbs5/UFSPcIl3g67AeVpHLBrtChUg1DOXkrGE
        KjalH/UsMy3YPO9VBRt25hYTbaGEkI/iV1m+xR7A+gKCO0cuT2cJ3TVlBQgsgT9zStQ==
X-Google-Smtp-Source: ABdhPJzhEcGWKoFBHO55iEVYXgPcIN0cijivdIV25NoGvewtmzzyabvNXP0FdNkeb4KfZwnfslorflWHRqSTVrU=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:90a:16c1:: with SMTP id
 y1mr5261475pje.176.1644536041996; Thu, 10 Feb 2022 15:34:01 -0800 (PST)
Date:   Thu, 10 Feb 2022 23:33:45 +0000
Message-Id: <20220210233346.1009735-1-calvinwan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.664.g0785eb7698
Subject: Review process improvements: drafting a ReviewingPatches doc
From:   calvinwan@google.com
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

In continuation of Emily=E2=80=99s "Review process improvements"[1], I am
drafting a ReviewingPatches doc to help standardize the review process
here on the git mailing list and to provide a rubric/checklist for new
reviewers. In order to do so, I am looking to compile examples and
input from everyone by asking the list a set of questions biweekly.
Please contextualize your answer in terms of whether this was a
maintainer, individual, or drive-by review.

Maintainer: in the context of the overall project, is this series a
good idea? Does it interact well with other features? Is it
maintainable in the long term?

Individual: in the context of the individual's own experience, is this
series a good idea? Is the implementation readable, correct, and
efficient?

Drive-by / nitpicks: does not answer whether the series is a good
idea. Makes suggestions for missing pieces, bugs, and/or code style.

Here are the first set of questions I had in mind:

What is the best review(s) that you have ever received? What was
especially constructive about this review and do you feel like it
could be improved upon or is missing something?  Conversely, what is
the best review(s) that you have ever given? Feel free to leave
examples for each of the review types.

[1] https://lore.kernel.org/git/YbvBvch8JcHED+A9@google.com/

