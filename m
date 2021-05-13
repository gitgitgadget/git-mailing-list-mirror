Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4C9C433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 06:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 367BF6143B
	for <git@archiver.kernel.org>; Thu, 13 May 2021 06:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbhEMG6v (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 02:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbhEMG6u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 02:58:50 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07291C061574
        for <git@vger.kernel.org>; Wed, 12 May 2021 23:57:40 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id y2so33637980ybq.13
        for <git@vger.kernel.org>; Wed, 12 May 2021 23:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=5WqmyPVkA5ZnuQIMwJkrVJvM49AqvYJltueKgQFzvi0=;
        b=KFq7UCPNu82hwZHT83HzLh+1ncyVVgKWVaGILQvCVSa2Tw4KWqfPnmKVpH326zWEXb
         p1XeD4rraUtkSxS9pdNgfl/frFxfWBMcz0pM55mPE+iPISTO8LhagH5U6YXvosG/iWMO
         N5vW7nx69Cg7ZnAQUkrnfP2JfsdNAP0VBPYVsRSpC3El2JmVglm9H18DtFl7aARKN2cy
         od1fkeIVnNill752MXCAbUWVhkCmg50GwaYLZVbl8G2KUazk5Z4qaBMt9F+NsUaSPkoF
         0rof4haara2oGt03J+F8yfgvI+wxRqwXtlBbuJg0zFRPsD7XfS7LzceLsgSBFugvdziC
         HmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=5WqmyPVkA5ZnuQIMwJkrVJvM49AqvYJltueKgQFzvi0=;
        b=t5f1TjulkZWFl670pWuipMw/Z44nyIJPwk6hmIYVKdrjQQjCD5+pufypRuj/ObOiv7
         34QV730avgy+ibYhS3qmWiuC0uVyn+R/PjTMw9cXMZvD96e8OJTwXYLvyDCqqiKfe86B
         G1VAYedId6jOXwGD8fWeoGPsIvVojBvLFwlSU8C1dd/T5mjlr8v41EpeegBq/YJP8XR+
         c7SNEItk4mjCTkTAdqtc2U8MVynzQ1w0LDzDW6X7lg/Ied0bJ+nj3FyJ/nOkqbiRlSQs
         3/I/SUxwyf2sgxVdx8PzqYrp1ReC3zcseQUYX3NZ91awHfbEX/wss/uAraPQbIHamDxp
         RcqA==
X-Gm-Message-State: AOAM531wh2XALmHDUX5mu1/OAsKO2qgx7cSIrEHCP42LPN7vKOp4YXGG
        VAOZXDbxBvkdquCybJ3A5gxauZVOPMOj5sEvbyiQa8JD9A==
X-Google-Smtp-Source: ABdhPJzfjT3bq1fmNUbjrldN4W25PUc1NPz9PLYSGP7oEyewp0nZUuEMj0Yq0X4q5MzafbCTRF6Q7HRa3JMfo1zTOTo=
X-Received: by 2002:a5b:50e:: with SMTP id o14mr54094419ybp.43.1620889059210;
 Wed, 12 May 2021 23:57:39 -0700 (PDT)
MIME-Version: 1.0
From:   Alexandre Remy <alexandre.remy.contact@gmail.com>
Date:   Thu, 13 May 2021 08:57:28 +0200
Message-ID: <CAKToE5BnzXd_2pjhJY13E=e6b1ZgOV=NmXr_WfpCQd+LxXsO3A@mail.gmail.com>
Subject: Git pathspecs difference in behavior between linux (wsl) and windows
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I do not understand why the same command works on linux and not on
windows. Is the pathspecs syntax differ or there is a problem on the
git windows version?

* On windows (git version 2.31.1.windows.1)

git status -- 'src/test.js'
On branch master
nothing to commit, working tree clean


* On linux (wsl: git version 2.25.1)

git status -- 'src/test.js'
On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   src/test.js
A classic git status gives the same result between linux and windows
(with correct file detected).

Regards,
