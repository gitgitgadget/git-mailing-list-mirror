Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4694520A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 09:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbeLMJQG (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 04:16:06 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:45284 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbeLMJQG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 04:16:06 -0500
Received: by mail-ed1-f49.google.com with SMTP id d39so1369780edb.12
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 01:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=parse.nl; s=ga;
        h=mime-version:from:date:message-id:subject:to;
        bh=4eb1vgRRD4OPxjV1gU7eLxdT0aZrDB4eqiolN3FjQd8=;
        b=SrKbS623iU8TAzujAumSzdiiBjYVFitcyopit1+LdeC21hmtYaruMqP6TRdaFh5cwO
         CsjBYUoxu4J63KOk1pZEDUv/EJJG0Hf6hzRTeD+pdnpjjaizVtQcBM72e/wGdMO5SjjJ
         x/WF/+MIECjb7Ju/HY2J0PqfXIWfxyxy4Yd1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4eb1vgRRD4OPxjV1gU7eLxdT0aZrDB4eqiolN3FjQd8=;
        b=Rd809C9Yida/D9v5KUB+cGlYLp3MG02f4S1OE3y/+FB+Fv2VUR5m4SHnUFHqHsIrWz
         1Pdtzx61orw/u/ClAm+cb1UkzI1idlt43LUCL3sql0VtrfNjw2NCrhPKn6QXUNeDAq/g
         SpxW+iG+jPDAVVtXh4SY3jLwiw3MRVvIzJKdYLir6HFF/GWPf3F5u7plOfZs/SGJYFJv
         sgikTUnv1nOBxLcWmj46JTwqF56wnM1M6FDZxKv7hWSd9kSGMby7bM7LZl12NF0rysHk
         7e5HX++wnk2OXX37sh/xIF9ut0G5AxjDm+IN273UcqkKWhdO62V4AiyalzievRUwGchS
         sPTg==
X-Gm-Message-State: AA+aEWbG+LTG+SXlYgpl8bpBdsgNig29WucSSRod82Fu63HhNgYkGcnp
        Oi0yhxbSkCoykJs9UwK0Zfip7wNwnhEiCSCEBMpWjmFD19U=
X-Google-Smtp-Source: AFSGD/XhMyPcIWPy/3FV9b1b+8lFARuBaiRuPWeZghV5yJkIHx7vzLVNwWm92gtQKaQVf+YBfibHQx9NY5uLoLyjWRA=
X-Received: by 2002:a50:ac19:: with SMTP id v25mr22042286edc.218.1544692564083;
 Thu, 13 Dec 2018 01:16:04 -0800 (PST)
MIME-Version: 1.0
From:   Sjon Hortensius <sjon@parse.nl>
Date:   Thu, 13 Dec 2018 10:15:52 +0100
Message-ID: <CAHef355RQt9gN-7QjuAAT8mZsNFKfCo4hOYi2+bkp-0Av7W=Qw@mail.gmail.com>
Subject: 2.20.0 - Undocumented change in submodule update wrt # parallel jobs
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When switching to 2.20 our `git submodule update' (which clones
through ssh) broke because our ssh-server rejected the ~20
simultaneous connections the git-client makes. This seems to be caused
by a (possibly unintended) change in
https://github.com/git/git/commit/90efe595c53f4bb1851371344c35eff71f604d2b
which removed the default of max_jobs=1

While this can easily be fixed by configuring submodule.fetchJobs I
think this change should be documented - or reverted back to it's
previous default of 1

--
Kind regards,

Sjon Hortensius

| Parse Software Development B.V.
| http://www.parse.nl
