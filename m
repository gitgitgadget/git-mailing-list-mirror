Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019D9C4338F
	for <git@archiver.kernel.org>; Sun,  1 Aug 2021 21:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC95160041
	for <git@archiver.kernel.org>; Sun,  1 Aug 2021 21:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhHAVlT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Aug 2021 17:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbhHAVlS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Aug 2021 17:41:18 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E53AC06175F
        for <git@vger.kernel.org>; Sun,  1 Aug 2021 14:41:10 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id w10so10458134qtj.3
        for <git@vger.kernel.org>; Sun, 01 Aug 2021 14:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=IMWcsUjYZKBcEn1UhTiLD2mu/oaZ7Bzhhr5XaOa6Rp0=;
        b=YdOTiZesIdSwq7YmUNYosVkf68zrztkfn9P7+N+vJ0hW8IRoETL7Dy2EBPuv8IrcuJ
         8uMMkGV6yK8OWFQ7YyeoRHc2EnQ8+X4YDxtiSoNNZgGnIJMC9w7f593JxCGxR2SaPzU5
         LdOD2Em+jdnroXLzq3cOd6ZnlKRj+cXoUHR6MCo7P4SUOai1qDv8aKALV+zv3ZK1CKfx
         e5RjNbDog+SEIdiAN2XZYE2W1jxHNroscl8qJyENP4jMSzyzha1VOlOyEuYQ/ztM/kdY
         PSDULTIRMcHbiimZRYYx8NBZ9gGB5LhvEybYpVXY3oTRPnuO/lA7+cfgjK6lQ6fqrB8J
         dh2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=IMWcsUjYZKBcEn1UhTiLD2mu/oaZ7Bzhhr5XaOa6Rp0=;
        b=gy8C+timQmCHCfvOE8rvYEVzvkqQ+j11elvrDMnbrwz6sbCNnlEvE3NrX2RwMG7R4/
         HFgHMaXXbHuEwvNXK3rpiRUu0HGOiZuJvgzY8o8MmfND9t1eCpiwwIqZ10SVzptFrWTd
         g7UzrdPTphD763PTqDT9HjAkEcO3Pn8irCJHoyvCOSP8+FIH24lmvmK3JvUSbl3smtXw
         NqaF82EwSBZEkkmv4WPTglcmB5SDglfKSsnQeqreaXT/PWCWy7PVr4wq3zQnmOq0GMdK
         xeaRUhYN9Ea/YRfTgQJRxRXTSXTMM67Ns6HcwdnhD8saXr6FdopnGGocZJU2bJknJOG9
         mhMw==
X-Gm-Message-State: AOAM5318hE989zRj2NrXTWxKWVqp+tXu9biL+xdAEXkPdsSfwXK6RJG7
        xR7B0zsnkcn4T9q9ufuEqhiEuAuruAuu3//qDKc5KC2n
X-Google-Smtp-Source: ABdhPJxQxLF/p6eeqMykHSStuTmo6UrgDAEuu+JGe1x02DFQzgvNRdoMvt6+w1w7jrUhSrE8EUpdPQSvTtAB3P5Uudc=
X-Received: by 2002:ac8:7c85:: with SMTP id y5mr11838603qtv.376.1627854069421;
 Sun, 01 Aug 2021 14:41:09 -0700 (PDT)
MIME-Version: 1.0
From:   heapcrash heapcrash <heapcrash@gmail.com>
Date:   Sun, 1 Aug 2021 16:40:58 -0500
Message-ID: <CAM1Tk15N6uK3aU5bY6mWQVX5UdEOraysrRmO+v4TA+P-Wa9_hQ@mail.gmail.com>
Subject: Enhancing --show-function and --function-context in default configurations
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all!

Thanks to all of the Git community for making such amazing tools.

Some of my favorite features of Git are the --show-function and
--function-context features of git {grep,log,diff}.

However, the default configuration leaves a bit to be desired --
setting some simple flags in ~/.gitattributes for e.g.

    *.cpp diff=cpp
    *.py diff=python

Makes these features MUCH more accurate and usable.  However, one has
to know about gitattributes, diff filters, xfuncname, etc. in order to
turn these settings on.

I'd like to contribute changes to Git that makes the "obvious"
correlations be the default setting.  Before I start, I wanted to
gauge whether these changes would be accepted or not.  As far as I can
tell, these would not change the default behavior of plain git
{grep,log,diff} unless the --show-function or --function-context flags
are specified -- and if they are, the results would be improved.

Should I work on a patch that does this?

Thanks in advance,
Heapcrash
