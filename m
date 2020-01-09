Return-Path: <SRS0=y4cH=26=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0CFC33CA1
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 19:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C4A206ED
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 19:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PXbn6xP9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgAITQ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jan 2020 14:16:29 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:54065 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728971AbgAITQ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jan 2020 14:16:29 -0500
Received: by mail-wm1-f49.google.com with SMTP id m24so4204345wmc.3
        for <git@vger.kernel.org>; Thu, 09 Jan 2020 11:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=wNUw/QcncULzG9vZAmyFtA21NlQQ4Eza7cpRGmWVu68=;
        b=PXbn6xP9Kp5bWDLd6ldmV1FcFUIgsSSSw5CkbpZsg66MHeArwBcPhbioF+J5Xbbwxz
         Aea+hb2iguaxDR3HPNEQXgd+VcEGR6DdokvyYJewZCEXnNowlQ5uYKVaTTkens/HrDZa
         aIYRQ4FdghNPBwVLOnVzxZ6fWz7pPry7fjEUC6jdmoP8gXqTrjg5MjWtbTfLwW3wJjWK
         RVCBxZP4TdqTx6LyK3KH3R8EUDizCS9yKrDXq/BCtjD+qRtqy8PjoRT5QtvRRZ2FecUx
         R1ZpQAvPPBu0/tiUOWfRxlYiQdb8htOpNhW7E13q/ulahSozj4YSQGt5mpTgQeL6epUS
         Z3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=wNUw/QcncULzG9vZAmyFtA21NlQQ4Eza7cpRGmWVu68=;
        b=CCwIH16nkk18k8o+3UpgKHrgjOExu87q23kz1k4zcfuuOEVwLfhfnmLUuB9kPlRLaJ
         Il+BzeW17sNcasiadm1//lAdI1tiPLOAWiq9X6JMrGB3xqP++YRb/H8nb7BpUBdFfi6C
         1SRbpcOO3+hkxZLc8QEalog4fFWvvh6AE66xwFXWI/NjtzAZA65441z/eQ/WmfnAuSu/
         WyRTtWRjpjs6l1sa1tNXRQMt2/3r28KI4jADItd0a8qe6WD/lpd4BP7rkfUq6BeF9alV
         VuheSmL9XOwius99jBS9RRBTHZykx57RYj+PDdLVwmz5ALSCWjxtsIXkwd0MN1QXtTxd
         vwAg==
X-Gm-Message-State: APjAAAW6+MO6z47cUGP+HZ0QNdsfff07GVS9Hk8jrt2UceUhqJ/8+ueM
        i16tYQeN2md0nUkA5ZQQUlbUktVEhm5Yf8shHKIAkO9SNr8OFg==
X-Google-Smtp-Source: APXvYqzZurmFAv6oTxsh01iblchZROhfW8XyYwDaerFWuYD3wE8dDLk1mj1FiL1LxqvUpNB970mWs+kvx/WQZV3ydlY=
X-Received: by 2002:a1c:3dd5:: with SMTP id k204mr6399630wma.92.1578597386277;
 Thu, 09 Jan 2020 11:16:26 -0800 (PST)
MIME-Version: 1.0
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 9 Jan 2020 20:16:14 +0100
Message-ID: <CAFQ2z_OhNHauK_W1wL7WcOJnm2vCUGXLfYn_ZmLnt2rez+_TDw@mail.gmail.com>
Subject: reftable progress
To:     git <git@vger.kernel.org>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

I have some alpha-quality code for Reftable support in Git at

 https://github.com/hanwen/git/tree/reftable

I'd be curious for some feedback, both on the library
(https://github.com/google/reftable) and the glue code in Git.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
