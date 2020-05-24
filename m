Return-Path: <SRS0=NZH0=7G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23868C433E1
	for <git@archiver.kernel.org>; Sun, 24 May 2020 19:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2677207DA
	for <git@archiver.kernel.org>; Sun, 24 May 2020 19:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SajNxqqV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388065AbgEXTJS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 May 2020 15:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387744AbgEXTJR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 May 2020 15:09:17 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B665C061A0E
        for <git@vger.kernel.org>; Sun, 24 May 2020 12:09:17 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id s21so1687111ybe.5
        for <git@vger.kernel.org>; Sun, 24 May 2020 12:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=8wRxVAofDDe1aveBXYf2yGe298LGz0ymj2cBuU7W1qk=;
        b=SajNxqqV6x14BFbNfBhB247RFb5nHOvXY+ZwlCgv70nr6T7fHpKn0QXGNu2JNXddhr
         Ia9ge6SMdUP94rgFfU/uCRVHSUiPNV6ypbgExHgIwY19csdzdePvme524AsZFXIZtsps
         b3XIH95u/cczBrRRKEn43q44OLm2GhuPqZNKQqbdWUHD+0gNIeagJaeHBHFKmwtqPAaN
         y29kkVjM56wOjDCAc5/NQ1qYp2g3YLglfjeE6TvB6SqF0OstAO5BhJpVDjtV/3Qp8X4t
         AWbBafgo8Gkeln6N8Db7ozE0NqWg7ny/R+voofJOdPH4tw7hYsxQHJxmiIeq9XHhqLHL
         Md6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8wRxVAofDDe1aveBXYf2yGe298LGz0ymj2cBuU7W1qk=;
        b=AWQuGh35QhZP3/j61ucYIxu9RtAhd4FptXEzmMoSSvci3IJNeAl1jc8ywyIKuWz83V
         nu4zp1DKJyD0NkXYY+6Q//2rQrvyuutojLs1UqGK6wIO/78dyQXGnhd9C+YmwB6eGoAJ
         aMwI9W8YTLPOyx+tkeIB2DkP4/OEEpf7sCF2bu9uBE1IaY7Y4dNDpUfi9foPsrm1e5j9
         I6ssHnald30bfbOdrSCIumgXnJt4/P0uCeuhq5o/bl9MkvJ4Z0fZIwY7Wng3JiqduUzZ
         3mrB+unLYMtSEVfa6NNMy7abHu31TEprzldVdLHffaYgwROyUC99LJX71r2GFayw6Wow
         mbKA==
X-Gm-Message-State: AOAM533YoUIMeUh8tOrSxCAjlJ5hg2nW16RH8EN9d7eNrW87o9DHigGu
        iTSr7s7LXyHauROwNfasH7zZJzn8WdCCQH/A14XvxejT
X-Google-Smtp-Source: ABdhPJwAfoA6w63mQCv7IUWwr1h0gZCYFUHhSjSaxMlUXazCd+p0SrqRMFGcAjogzhuMaTkZPphRwQdZPaTOXs1HywU=
X-Received: by 2002:a5b:945:: with SMTP id x5mr39698677ybq.90.1590347356607;
 Sun, 24 May 2020 12:09:16 -0700 (PDT)
MIME-Version: 1.0
From:   bruce <badouglas@gmail.com>
Date:   Sun, 24 May 2020 15:09:05 -0400
Message-ID: <CAP16ngrRWAyicohAWt7ZDZZ_i4tdO7KJuq2PJDhZtAqWVmmiEA@mail.gmail.com>
Subject: might be off topic -- looking for a github resource
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.

Apologies if this is Off Topic for the list.

Working on a dev project. The project will hopefully have a few devs,
and need to have a resource that will be the Github expert. I'm trying
to find someone I can talk to who might have the skills/time to be a
part time Github Guru to hep run/manage the overall Github/dev
process.

If you're interested, or know someone who might be interested, feel
free to give me a shout.

thanks

-bruce
