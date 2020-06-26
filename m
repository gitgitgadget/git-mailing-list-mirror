Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F71C433DF
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 01:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7A9120767
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 01:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkaVUW8O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgFZBIg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 21:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgFZBIg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 21:08:36 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A0BC08C5C1
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 18:08:36 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id r5so4613289vso.11
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 18:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LHwbBt2FXmgM0vgfIM7i9SjLQ3PWgD5w7XwsEAtk5Tc=;
        b=JkaVUW8OsuyuB7KzWQGoNgs6r2ybvrdKu7XNDd51w4qvYUD05cWfylzgfMu/OMIPzd
         ITL1DQBSRgq5MZkAbs55grJFdCdJDjPgdGLd1JuoGeuVx+M+lSRxG/ur+ZwZlWpqerDY
         CBdIXS2Z1vujE+0gaKbOEt8xKh/A8vM1Qn2sFgWRWy2eULmWyAVTpYYY9rsxnDatINRx
         KzsSaY9bmHi0w+LL6bA1LJ/RnvWu3oe+cL++BlMKRenJpc/IBaC/bu4O88prVhSicuBw
         CZdUbLszeUxpuC6I/cr1peHaJCY3ydlJLYK/nuxLOdOIqF8Kldn4ZV0yX869YCRIxg4s
         t2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LHwbBt2FXmgM0vgfIM7i9SjLQ3PWgD5w7XwsEAtk5Tc=;
        b=PPLBgNjay/3IMhuDJH/oroh6EZcXqic0JRDUU5/fqcvUuTXCi8ast0JZYHdKmh/gwM
         vGbdyRYX64UCTfbLCStVfpyUoIO9K7459hPKJYhHBFCpmBuFW1z47uiH2MuqTQOwW6C3
         axFg+W0p5qgxn5sLfXsm4cVOmgcwTRcX1gsD7di9uAl0rclnX7BeO+LC+MCyFOVj5DND
         cApc2oTCO9u/Rqot7k4G2dBLzT/8gu06BSK3+AhWoJOA9erxiD0vKqur+RpbirIdS9Fg
         23tofTf5n7soL8foU+XOljMmUerSzIMB7LP4cWI/SSf9W5WohF+iGeWXU1fTPpLMurKf
         n3fQ==
X-Gm-Message-State: AOAM532h3wbGrN+oYmOdykeoZqLcltWNMdm8XJ+HgCrZFqqipQeL5BLl
        8ME6oDgDBu2BsikYGT0wive1zK+wuDy+ioskngF9JArV
X-Google-Smtp-Source: ABdhPJzMTKqxjErOdh4CY50f34roSFHyRNH3IBLp9lWt7B7NWXCdOg48v6gvmBG8YCI6g/nzs1shL84d994IcXv6M/w=
X-Received: by 2002:a67:ea08:: with SMTP id g8mr714824vso.7.1593133715165;
 Thu, 25 Jun 2020 18:08:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200624195520.2062298-1-aquini@redhat.com> <xmqqo8p85eud.fsf@gitster.c.googlers.com>
 <20200624234539.GH1987277@optiplex-lnx> <20200625184715.GC2117795@optiplex-lnx>
In-Reply-To: <20200625184715.GC2117795@optiplex-lnx>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 25 Jun 2020 18:08:24 -0700
Message-ID: <CAPUEspgoDUGUmFqoKkmKDpRzSB5dQNb+PasaPjbPwb04SBz=Ww@mail.gmail.com>
Subject: Re: [PATCH] send-email: restore --in-reply-to superseding behavior
To:     Rafael Aquini <aquini@redhat.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

a test case in t/t9001-send-email.sh will also help, as I am not sure
this might be "expected behaviour" as hinted in the man page for
git-send-email (under --thread):

"It is up to the user to ensure that no In-Reply-To header already exists
  exists when git send-email is asked to add it (especially note that
  git format-patch can be configured to do the threading itself).
  Failure to do so may not produce the expected result in the
  recipient's MUA."

Carlo
