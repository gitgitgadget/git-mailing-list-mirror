Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	URIBL_DBL_SPAM shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C324720248
	for <e@80x24.org>; Fri,  5 Apr 2019 07:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbfDEHev (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 03:34:51 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:41196 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfDEHev (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 03:34:51 -0400
Received: by mail-qt1-f170.google.com with SMTP id w30so6298000qta.8
        for <git@vger.kernel.org>; Fri, 05 Apr 2019 00:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=av0tOeYqjyws2FGTNZ+KQcs9Ad8bOnoTO+PXNxvbc18=;
        b=VsA5bAD4PfScNuyrA2TFSpdank0KmGzYVFQmgtiJfECgUVv1bWsDvmvXqmCb4uWjMO
         ZpWX9IyVrcMDvUQtSn/pIPXQ1ItNgBzfB+yhH8vCK+Jy7xiqnQq++wN7JXKHCxRpZ1RR
         HekBcSo0J+9fHFO6TVhM0Er3G1Q+wiasRfzJsFttn8a88m1PPmpLqgL31sE0kzgOrkfK
         6feY7JJhiRtlo7Hto8R+83wLd55Uvsi/iGD7TUkmCvPRuC9OyrdW0Xx0gWa9UfcIS+XD
         O7Jxmvfd4STwsxi8tT2RHPGtuDY1tpxyvlKzuQ9speD+J0U9fETppqgg1FHa8Aj222BI
         gC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=av0tOeYqjyws2FGTNZ+KQcs9Ad8bOnoTO+PXNxvbc18=;
        b=F6O0KL8xVwkjqlow6Qf8NsRixRVSJGAZ0O1Lx6X4kgrRq1cRleVammDtxDaTKIDGon
         4gJq4V7+gVIyuu9PX1mM+RhQw6aNG1froTAJ0gBeYkjRd3Rry2/1mMRKO4K2j7IgWk82
         G4vdFmyPv0FUFvtY3MYnt5xlB2Vg1toEVfuqsYntlcBTAdzx7Xlny0vIEGTAt3Bjp1WO
         l9dAqhRF6GCWj9spyZ/3LZq7SXJj9tUSHCGiZOqDilG+5ftHzg9+ruVMvAUlp3L2pTmL
         Y/riTP2GIPYeRma+wnp+CBg6WgloRAHSlp/VrCaAOILTmiBtDiPsCqrUA3hGy6fCktCd
         Hmdw==
X-Gm-Message-State: APjAAAVejXrDvjvIQrzpdhyRXc/w51Gl/FRj15IhC4+JPrpISoQlf5rk
        7J8bNgYdsxT5tAzJMqhPZcCSiX63OBOmNwRNFeY4VgWJ
X-Google-Smtp-Source: APXvYqxhgoRqbGAPtLPqYNZjqXw2OyOsxvtxblwmTnmZlxCScTN61nh2wiBQcjRUWjSHOn/lo17n0huda5qnyE1YCcg=
X-Received: by 2002:ac8:38fd:: with SMTP id g58mr9816081qtc.14.1554449690306;
 Fri, 05 Apr 2019 00:34:50 -0700 (PDT)
MIME-Version: 1.0
From:   Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Date:   Fri, 5 Apr 2019 09:34:39 +0200
Message-ID: <CAA01Csp7y9=2n9=TNYMMw9LUO_cENz7FBeZjFrUd2FvHFT9NCQ@mail.gmail.com>
Subject: "commit --author=..." does not work if global email and name is not set
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have a repo downloaded on machines which do automatic tests.
Sometimes I want to make a quick fix there and push back to origin.
Reading git-commit docs I had impression that I can use "--author=me"
and it will work. But it requires setting global user name and email:

========================================================
$ git commit --author=pkruk

*** Please tell me who you are.

Run

  git config --global user.email "you@example.com"
  git config --global user.name "Your Name"

to set your account's default identity.
Omit --global to set the identity only in this repository.

fatal: unable to auto-detect email address (got 'some@default.(none)')
========================================================

I do not want to set the default name/email, because I want commits to
have real names, and not some "automatic test account" info. For
pushing back to origin I already have to use a read-write SSH key, but
lack of default name/email would prevent accidental commits (people
WILL forget to use --author ...).

Do you think changing git to not require default name/email if
"--author" is specified is possible (and hopefully easy and quick to
implement ;))?

Thanks,

-- 
Piotr Krukowiecki
