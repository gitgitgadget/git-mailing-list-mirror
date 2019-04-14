Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9F5E20248
	for <e@80x24.org>; Sun, 14 Apr 2019 18:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfDNSUO (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Apr 2019 14:20:14 -0400
Received: from a27-197.smtp-out.us-west-2.amazonses.com ([54.240.27.197]:36670
        "EHLO a27-197.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726147AbfDNSUO (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 14 Apr 2019 14:20:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1555266013;
        h=Content-Type:From:To:Subject:Message-ID:Date:Content-Transfer-Encoding:MIME-Version:Feedback-ID;
        bh=GeQABPh5Ry9fDZJBi6G24DkP2LUMxy9fCFembHgFCkU=;
        b=JLIVW5bHvDQJBoCaH0JaEm3jO/npF7fBv0PVUNSF86DiaOR8cowItPmDy2yblcna
        ak9CaCYQuaox273Y+sa/MMAXFg9M38UbnfzSqCUjAnrYzbzHiiXTi7PgE3uvSOGdXhd
        9m11oEpIjnl9rW3SD7eii8UM/guSIZuTBAd17PiE=
Content-Type: text/plain
From:   mqudsi@neosmart.net
To:     git@vger.kernel.org
Subject: Supporting untracked files with `git pull --autostash`
Message-ID: <0101016a1d14099f-4ac42e38-256a-42a2-94d3-430417d74a25-000000@us-west-2.amazonses.com>
Date:   Sun, 14 Apr 2019 18:20:13 +0000
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-SES-Outgoing: 2019.04.14-54.240.27.197
Feedback-ID: 1.us-west-2.PCEy91/Vd+GU67P48MglE9FKtQG6qQD9MhgwC/YKQRM=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Just a quick request for an enhancement to the behavior of the =
following
command:

    git pull --autostash --rebase

When executed with local, untracked files that would conflict with =
newly-added
files upstream, e.g.

An untracked local file `master:/foo` =
would be overwritten by a recently tracked
file `origin/master:/foo`.

Currently, the following occurs:

```
mqudsi@devpc > git pull --autostash =
--rebase
First, rewinding head to replay your work on top of it...
error: The following untracked working tree files would be overwritten by
checkout:
        tests/eval.err
		tests/eval.in
		tests/eval.out
```

where

```
mqudsi@devpc > git status --porcelain=3Dv2 | grep eval
? tests/eval.err
? tests/eval.in
? tests/eval.out
```

As currently `--autostash` only applies to files that are tracked by git, =
and
files not in the index are ignored.

(Additionally, with this change it=
 makes sense to enable `--autostash` to be used
with a plain `git pull` =
without necessary also including `--rebase`, but I can
live without it!)

Thank you,

Mahmoud Al-Qudsi
NeoSmart Technologies


