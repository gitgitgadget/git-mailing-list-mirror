Return-Path: <SRS0=EE6k=7Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56850C433E0
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 17:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33AF72053B
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 17:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rqLhWirT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgFCRoT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgFCRoS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jun 2020 13:44:18 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937E2C08C5C0
        for <git@vger.kernel.org>; Wed,  3 Jun 2020 10:44:18 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id e1so696007vkd.1
        for <git@vger.kernel.org>; Wed, 03 Jun 2020 10:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XZe00PGZHWcuF61N77Q+yGoapAWjb2VOyrkaQCPglxw=;
        b=rqLhWirTNa7Pi7Y2MtMJMW4U5QKWC3Apud1sRixVPcpDbtHETtiLdAmaA9IpI7AK+a
         zSm3dCio3mFvg9yuVynqePWtM6TrWuCHs3AGV0Fre12P5VWeTIG5bX/rrK5Xia2bnH03
         Mlx27GqAq2lHR9ZWFJn6yz7cm8oBB+bbV44W+BxZUOT6rctmS1ne97ou953ICdIAt0+D
         ICPTtNyqQmedMjWnYx9Ob+IQh83MyVfVJDOh518LSI8rhrrjRjddEXnkTXlkfSX8V5Qv
         EYax54hZI4kWiFBSpfSvLoPRX/onBqfnksFCldRCFQ376DgqW2cn//WCD9jTgeeNLfP1
         Oe8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XZe00PGZHWcuF61N77Q+yGoapAWjb2VOyrkaQCPglxw=;
        b=TBcNsOmfqwGMr4ObY+8UQKt3P/tUQ2ue2vX1knrkNsFPOjKLkjT6GuI8e2L5gRklqh
         P52/IiVmXj6onkWDnhT+HpaktL23vUMD5nO4qPDKIppBDH1KUg867imQpnNUm535qsxu
         CYkrsPGaUsXUpt2+05/licIYv901GZ3Bl6EgYmUpTWfrBFNT7v7zw5xLkct8/ZFP5gKA
         vHXOrhRNIH4TwDQAvHSf/KVjK583debnrKppTbvm+x9DDCt3rOri2QfAZ9oRd62W19Qm
         7F/76zgy1FNTwxqpP+DMq0iacun+dpct9z5e95ulCEh5c1k8ReR+ZzWz2+j3NBK/f742
         XbVA==
X-Gm-Message-State: AOAM533XnYkHlqc6RmOXuheYduVqk3t/3y2k46RCec87tgkesbYE9YoI
        q3r3td/ET6wPJECQ93z2tF0zpBEaYm1mFTWnRCcPDw==
X-Google-Smtp-Source: ABdhPJywnQXUTQfvw3unpVHiFf5Qq9TlSxQ7kiQCjFApBnVYjU42m9Budut4a7vKkwnK7uoWQe1c6NEVRj4QzWW4Gcc=
X-Received: by 2002:a1f:2354:: with SMTP id j81mr728856vkj.64.1591206257525;
 Wed, 03 Jun 2020 10:44:17 -0700 (PDT)
MIME-Version: 1.0
References: <1d1a94426f95d842e0e3ea6a1569c0c45239229c.1591086316.git.ps@pks.im>
 <04116cc57ab37eeb50bd51a065a7c06503493bf3.1591186875.git.ps@pks.im>
In-Reply-To: <04116cc57ab37eeb50bd51a065a7c06503493bf3.1591186875.git.ps@pks.im>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 3 Jun 2020 19:44:05 +0200
Message-ID: <CAFQ2z_OSfsKKkOu_wKEAWi-Zihp4g265jtmXzteaU=BQZohEAQ@mail.gmail.com>
Subject: Re: [PATCH v2] refs: implement reference transaction hook
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 3, 2020 at 2:27 PM Patrick Steinhardt <ps@pks.im> wrote:
> The low-level reference transactions used to update references are
> currently completely opaque to the user. While certainly desirable in
> most usecases, there are some which might want to hook into the
> transaction to observe all queued reference updates as well as observing
> the abortion or commit of a prepared transaction.

I have an alternate suggestion, but it would depend on having
reftable.  In reftable, the transaction is

  0) create tables.list.lock
  1) write out new reftable(s),
  2) renaming tables.list.lock to tables.list.

If you insert a hook between 1) and 2), the hook would not need to be
supplied with any data, so it would have minimal performance impact.
If the hook runs, it can compare tables.list and tables.list.lock,
read out the new reftables, and make decisions based on that. Or
alternatively, the transaction could be passed a list of reftables,
that the hook could then process at its leisure.

> +For each reference update that was added to the transaction, the hook
> +receives on standard input a line of the format:
> +
> +  <old-value> SP <new-value> SP <ref-name> LF

Does this work for symrefs as well? Should it?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
