Return-Path: <SRS0=1y/A=EO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89771C388F9
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 11:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E325206ED
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 11:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mozilla.com header.i=@mozilla.com header.b="PqYRBBLO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgKHLPS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Nov 2020 06:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbgKHLPR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Nov 2020 06:15:17 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECF5C0613CF
        for <git@vger.kernel.org>; Sun,  8 Nov 2020 03:15:17 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id oq3so8170669ejb.7
        for <git@vger.kernel.org>; Sun, 08 Nov 2020 03:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mozilla.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=M380Iicu9R9LcdW4HqPeq1Eo1Y+FzOzL/4Wr4MDsZPY=;
        b=PqYRBBLORgMw0jxcxf1Xbp1tti4CuO1hkbjCKlWMd7UKezlgnL8K3hQPQKOU5JA/ZD
         tNT7RVPBAvNAEHUXonYsmfa/0JkRxllW4p+vRIE6NqZBcP4DmowtC4w1z6IcBU8tHDcx
         Abb0Wl68XsYyS/8CRWwl+FRkNIW3Lws4vcz9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=M380Iicu9R9LcdW4HqPeq1Eo1Y+FzOzL/4Wr4MDsZPY=;
        b=Vv0Ocw4FuUbACfOrnn7JbXnzHOre9dIcOdLiQcAYXv3w4Y6WsjLklBMw/lEPD5nIvd
         Hasd0PQec2CT6suN6whyHHmhXSfjEzL9VxRudDJ5WGunKeukjUMoc5go7XifICkoTlye
         i0vGBVyjV+8OcXCQ1OlNAo135pVGZmYqPbINGfStR6uWbRAhN3vEniHRjL963B+4TMJa
         pCPdFxDvMfa/TDj9/8jc9LQoNXniV9j5IWV77fmsBQ1vOxPd3fLwU4uDSAsz/DWHdGxo
         FU1ZaGX5Wv3CUjvfwH0eMsggIllTsPFtmHpwLclW+Qbayf5cC5tnLe1J5tVJij9vo5JB
         RTRA==
X-Gm-Message-State: AOAM530/JlbjGsdarRD9l3rVbdp0thyWmCsElNYUuAQT+tqREBBrSMNj
        IUQzt9U67A0CPpUwOX5lYVDt3n9kJxwYzZpflDm0rwpHqfJryOV5
X-Google-Smtp-Source: ABdhPJyKF8ffSgERPozU3wJ+IG/2Vw3gFlvjybwNNY7L8hSqNPafzbP0lCIPNo8uNijXBLLMeK+KFMxkQj7brLZizI0=
X-Received: by 2002:a17:906:1390:: with SMTP id f16mr10177022ejc.504.1604834115885;
 Sun, 08 Nov 2020 03:15:15 -0800 (PST)
MIME-Version: 1.0
From:   Jean-Yves Avenard <jyavenard@mozilla.com>
Date:   Sun, 8 Nov 2020 22:15:04 +1100
Message-ID: <CA+phgpFS_MOKOib5+yAE7U2QPMqMD_t+yXhR29UG9aSO4pgk+A@mail.gmail.com>
Subject: Request for change 610e2b9240 reversal
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

At Mozilla we use a mercurial repository, however many developers are
using a git repository; we maintain two git mirrors, mozilla-unified
accessed via the cinnabar plugin and a geck-dev native git mirror.

Our repositories contain a .git-blame-ignore-revs that is used for
both repositories.
https://searchfox.org/mozilla-central/source/.git-blame-ignore-revs

That git was ignoring invalid entries (for the currently in use repo)
is a requirement for our use.
Following the merge of 610e2b9240  jc/blame-ignore-fix later we have
lost the ability to run git blame on any of our files.

Could we get that change reversed?
If it ain't broken, don't fix it as they say.

Thank you
Jean-Yves Avenard
