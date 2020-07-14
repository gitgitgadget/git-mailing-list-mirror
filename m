Return-Path: <SRS0=b2TE=AZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD44C433E0
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 13:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99FC5224F9
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 13:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnJB7s5F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgGNN7E (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jul 2020 09:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgGNN7E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jul 2020 09:59:04 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7615C061755
        for <git@vger.kernel.org>; Tue, 14 Jul 2020 06:59:03 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id w6so21992902ejq.6
        for <git@vger.kernel.org>; Tue, 14 Jul 2020 06:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=SriW4hfxw+HkNaoRVmiL9p/ohJuId/VshrVLXjIRwOw=;
        b=nnJB7s5FuBYBDc9T0lP0uSZElSdBlqQK7GdF8lzNVngKfld4SavIkWcAOAoPoFjI76
         dS50bK5M1ccTqXhhJA1ysRuIKoxDwkw4SzH8gIEDEJ3hi90Yh26bPz871TBZ7jFehSLQ
         Fbf0SsDtU7vui/uQtIgPuRWLWvBF6cr1wWRsfL/knO7ZKRfIH9nuI7GKAKLK3+ZY5G73
         sDQTEAdshx5KpcI03dTTXQLs+UWyA6w0TE29UkXqnuu7STOInIi9R2ohxMsT9uTzom/9
         qcAizzw/i7hMnml8QOzHoEH7O1zrsFa2ipmGDnn6fS6NKgvrj2kA2Zofz/oeZUQxlFYQ
         TG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=SriW4hfxw+HkNaoRVmiL9p/ohJuId/VshrVLXjIRwOw=;
        b=DWD/3ETxwA4PsdI+QoRcElNhLRm+xsPwStAEl6m4YAX2XlzOMnYivo8t4GdJenSMIu
         eDvFkaD1JXawoo3XJYQo4IDd+MNJg8wiq0dn80XgReUslQSWlDnv1UL3rY6u30BsHe/2
         uhObVKsjz/UL9YvzZ7MAkP+I0HVTYplcrhS1xMg+172AFkpT/VLgTN4Z5Q36PQ7F3AdI
         VBcULaNjxkQWcFN5QACCDtNeJl4HrSvnhWFryy4uJQ5HdJOTC8HaOBze4zwUQ9GxowpB
         rIGqp0Zqey9GmV1kMHpzXbkz6Dp8KyMuczyn0pv9yw/qb6V9vxNppy+0+oJMe+Awt1Yo
         wCEg==
X-Gm-Message-State: AOAM5323AvckKOfmeZqGa8aN173s5Ifb0bhLMCXGYdmcYgbZed/ZGRcI
        918UNSxvWFtV6ZE6oN9ge+DfN18d1N5T/D/KTCx7B6QA
X-Google-Smtp-Source: ABdhPJwXN1+obsWEwCRlSpjxBPLCTd2fcNcfaJLXjPSa2WRJWS7q95AWW9m3gLnJUofPEIk0nAVvF+2Mk+Ek0S0P4Ik=
X-Received: by 2002:a17:906:af6d:: with SMTP id os13mr4463258ejb.57.1594735141791;
 Tue, 14 Jul 2020 06:59:01 -0700 (PDT)
MIME-Version: 1.0
From:   "R. Lemos" <rslemos@gmail.com>
Date:   Tue, 14 Jul 2020 10:58:50 -0300
Message-ID: <CAM6_cxzzWJQpw9akM=JZAnZ0LrPBCPX+q1da8_24vOJexCKeHA@mail.gmail.com>
Subject: Empty bundles are not useless
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When working disconnected (sending bundles back and forth) it is
useful to make bundles like this:

$ git bundle create /tmp/my.bundle master ^disconnected/master

This way I pack all new commits since the last updated from
`disconnected` remote.

But if my local copy is up-to-date, git bundle refuses to create an
empty bundle, since there are no commits to send.

However it would be nice to at least send the information that my
local branch `master` is up-to-date. That is, the bundle would just
convey that my local `master` points to a given commit (even though
this commit is already on the remote site). This way, when I upload
this bundle to the remote site, then bring back changes made there,
the remote site will know which commits I already have.

Thanks.
Rodrigo Lemos
