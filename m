Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F55C28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 18:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 366C420747
	for <git@archiver.kernel.org>; Wed,  6 May 2020 18:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVZfJmnM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbgEFSQs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 14:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729995AbgEFSQr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 14:16:47 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871ECC061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 11:16:47 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id 1so1638437vsl.9
        for <git@vger.kernel.org>; Wed, 06 May 2020 11:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=V0UoMRO8azallKhkt7wz0u9wcQZnIt8NMJRekivxGA8=;
        b=fVZfJmnMBNF/r+M3QBcIANQM4fjFk2Rwaf2y9D4PvxYLsPH1xCaAFaL4ZU5Aa2RtVv
         FO0iuyOlFcpVL1om/7717YWOV36pRiSYUAyTRPy+z3RB8+B7RQtLRwW7xZtwHIkxFzZP
         6x/04dLtpIitSjd8r/7DsVhkRSfs4adJvoxncxX7x5Js74LgLHxgBhawNw3+W4BsOZwN
         eCv2oZhAB+gDaQVqdeCmwU7qulqgCu370+JY0auiFygvV9EqyvHvrVWCjyQBiYiPgy/l
         i58EruxB5Cb9hxZIgoaZ0dtoINSszFJ76COnzUDh9MujICHK8peslllkoHLMS9gL+mZM
         dVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=V0UoMRO8azallKhkt7wz0u9wcQZnIt8NMJRekivxGA8=;
        b=UHvtFgHH66kyS6wUDsR5/V6WJcWictmXjdpVCAB1+wMOjbhY9V+0Jxy8AUQ+2X950O
         um0W3I10eR9hVjmhLV9s6PjpDuwFnj2MTGDyEQxIgOeC+JcToN9QtTUryAG0fmk+Xpnq
         S6/VLlhk4EjHZUONB9b9dzAxfq9CKx3rQ5x1kx1WLHNLD5XbX6yNvj/p3Ow1scbEMSY0
         CHnTsFnREZPFsRGaoz0KxslZpTKcwRjERQ6QGEw1E8sPPWlWPEJj0e+n3b7j6BW0a5xP
         menyq72ob4ttORaeYFMJN82saO1jO2hsHwXF/fZsKv4+74bsYPIeEEM4Wym0fjyQy1hL
         WWQA==
X-Gm-Message-State: AGi0PuYM4j0ho+WtWypyYYub9+CN3Eg3TyzFHEkRvoCcDl60MqL3ewi6
        +kS9+UEbUlMe1DF5P1ACHgNebEDkLP5S8XTA1xa8qdn2
X-Google-Smtp-Source: APiQypKc2aZSOqRXa+AHLAcVs9xo6XnOTBHxyIIL9uLrTkPkUgP+oLGwdnua5MvUPpKuJ4Tm2/QjQbayfuiw1+pIi4w=
X-Received: by 2002:a67:edce:: with SMTP id e14mr9721335vsp.235.1588789006465;
 Wed, 06 May 2020 11:16:46 -0700 (PDT)
MIME-Version: 1.0
From:   clime <clime7@gmail.com>
Date:   Wed, 6 May 2020 20:16:35 +0200
Message-ID: <CAGqZTUujRh-f-83A8NYokbxLGZ-bnvGrtguzJsMdg9EX04NsGg@mail.gmail.com>
Subject: tags sorted by their depth, *committerdate, and taggerdate
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I have some very specific requirements to get annotated tags sorted in
a certain way. I would like them to be sorted:
- primarily by their depth (i.e. how far they are from current HEAD
and if they are not reachable then they should not be displayed).
- secondarily by committerdate of the commit they are associated with
- ternarily by taggerdate

Is something like that possible?
Is something like that possible even with git 1.7.1?

If this isn't possible, I am thinking I could write some simple
utility in C to do it but can I rely on certain binary format of
commit and tag objects? Has the format changed at some point since git
1.7.1? Is there a git library I could use for it? Or is the format
documented somewhere?

Thank you very much and sorry for so many questions
clime
