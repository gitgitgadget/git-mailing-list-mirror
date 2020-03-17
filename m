Return-Path: <SRS0=62NG=5C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CE9C2BB1D
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 15:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A1B420714
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 15:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tSSLTIMD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgCQP2i (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Mar 2020 11:28:38 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:38351 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgCQP2i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Mar 2020 11:28:38 -0400
Received: by mail-lj1-f179.google.com with SMTP id w1so23387793ljh.5
        for <git@vger.kernel.org>; Tue, 17 Mar 2020 08:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=qzN+XYVGe3OWu2YGfi5t6sAP8Yq5vH6MedKonP8uNRc=;
        b=tSSLTIMDC29nCVrT3AxQpZ4ptiJmwpix7Cjbg9mLPabOET4Q9JTs4+FB1Ns1tKJ5A2
         yg37t5jXd7WPnqk2Xz+S4hznv+fT3liUg/Un+r3vpuPMVoPUg7PP18nx3ETfIDVDItn2
         0Mo7pCVVIkvZXP9XQoFcMNBN3x6rKoDwTRs6srI1n2PECeH53aBc16DCd0Ct/Tof9kC1
         mJd0vYzGUvd1jdn1h0sVkWcmidNN6sO1JiTqeCEYtg1P3ah6QrUN6Cs0qRFd7Mg51yuF
         kLfEzEHqxKGL7EDbRsuMy2QA/AetmwA81Ke32+PeJezQCmisQc5GITGbRGLRj+Z0k/Fe
         RfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=qzN+XYVGe3OWu2YGfi5t6sAP8Yq5vH6MedKonP8uNRc=;
        b=DtbsZuPCySNsJx8er4BsGz38C/Oy0hb67omprFkWKp+nQHHHDMJSExiBbGj2CuUk7/
         2sl2WOG6rOlProCsH7OSySA0OjiC44fk5FQKPJvPq3nDUCQHbuEqFEUpNJaXHCbjtwia
         DLaCNefM+lrqWnBqTJbK5v4p82ANRbYZKgT25qw74wdV3amhFv3JGPNNh/ndJjBhF9Xw
         QUIPvqAYGPPls0CG3BuGF6gqymgKYpxw709kQNoHLrYFipQ1EExtDHsUXnP5aisU5fOC
         MAWQ0o9j2QK16Cld4oBoP5YyR2HkWz6jIrSj59ffuJDl1iw7GlqBt1DEV2KunFvZIJv1
         NTkA==
X-Gm-Message-State: ANhLgQ0LWPwC9D/0N1LeuXVnHSJHGbGXyJBGHIPd/4k/e41d4RAe04tH
        yKPwYZnrpXRaoXOGrFrcUs1kJEkjG8GthDcVQhMtUga4
X-Google-Smtp-Source: ADFU+vu4kpBsCn3KBhrsJPAmJrM3zPZxodU05t8rVEM+gq51VIVIBFQ9FEvDZuadj69145hSosl//qEP+MAaRLlVT58=
X-Received: by 2002:a05:651c:233:: with SMTP id z19mr2953049ljn.176.1584458916626;
 Tue, 17 Mar 2020 08:28:36 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Tue, 17 Mar 2020 10:28:27 -0500
X-Google-Sender-Auth: wmCdpo1f1KYDnnh_VnvIwE5VQ0c
Message-ID: <CAHd499DiCi3FJb9qWJNBNKyVQg_zYMgJRuYcH_pOP3LnGwk5Tg@mail.gmail.com>
Subject: Conditional newline in pretty format
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have the following alias:

```
[alias]
    release-notes = log --no-merges --pretty=format:'* %s%n%n%w(100,2,2)%b'
```

With a branch `topic` checked out, I run it like so:

    $ git release-notes origin..

This gives me the "release notes" on my branch. The goal is to have it
formatted as a bullet-point list in markdown format so I can just copy
& paste this output into Github, Bitbucket, or other sites and have it
already set up for render correctly.

It works perfectly right now except for the case where `%b` is empty.
In that case, I just want one newline after `%s` instead of 2. Is
there a way to make my second `%n` conditional on `%b` having a value?
