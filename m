Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5C3C2047F
	for <e@80x24.org>; Mon,  7 Aug 2017 21:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751919AbdHGVtk (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 17:49:40 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:32817 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751662AbdHGVtj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 17:49:39 -0400
Received: by mail-qk0-f178.google.com with SMTP id a77so10333667qkb.0
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 14:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neosmart.net; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=RVERTBWRR4G20ElbbmWImm3mjfDp9kS3Tg6AClrY1Lo=;
        b=QQ5FiqCHWivTC21Ujsq5rkQHq6FwscKUyrq7ZBspnilZiPSr2/DQ4xnu096iAvgM4P
         XhzhEwc6pPuqYe9YA6XickHINUi7U82XV2oM4qVuOsQgq/9xC4WkjNzKczvFK2Aom/dH
         jBdZTuWQcoOgPK3YmEdi7l3P50U2pAZk3WYT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=RVERTBWRR4G20ElbbmWImm3mjfDp9kS3Tg6AClrY1Lo=;
        b=m2awTB/WTxIlNVeVpsbFLhwmQDXTNyRw7hthK0vHfvjEONaCPJz3zzdKFUDJEOGuig
         g8Dt1d9sF7Ue3hn6OLS6uCToXqiMbaB9eklckmXZYapPj9TmjkkmVslW57M0BURUuNl+
         vWcD1pYj4o/NwCz+NMMaLmMjDno9Y4wELbB47dcXx11/iVDv3Hmu1PYp7Ev1pN3POTdp
         /FlRQa2TxEieGNFab4XXZSfeAtFvr6lY0nuAF0hv33VqJnvaCabvC+KwkoTGhcyg+2qb
         /QA834qThUosneSNpHP8kfdpR7NpY/MxebJQTnh+KBJptQpSjl8lxQZ5znc8y1FeTa6Z
         /joA==
X-Gm-Message-State: AHYfb5hs2Tm4jXJyScPfMpRiiWTv+9TL1BYCKzQdxY5yk3bKSdn6RHYx
        eaFBcdwFtFEs4fhLbkOMvlN+JmR+vY1baMM=
X-Received: by 10.55.105.67 with SMTP id e64mr2568779qkc.134.1502142578951;
 Mon, 07 Aug 2017 14:49:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.35.85 with HTTP; Mon, 7 Aug 2017 14:49:18 -0700 (PDT)
From:   Mahmoud Al-Qudsi <mqudsi@neosmart.net>
Date:   Mon, 7 Aug 2017 16:49:18 -0500
Message-ID: <CACcTrKdzVCKUR8EfwhqBQR7vWzRqTLcwRJ_r-hx3VztD=xvNuQ@mail.gmail.com>
Subject: Suggestion: better error message when an ambiguous checkout is executed
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

The default git behavior when attempting to `git checkout xxx` for
some value of "xxx" that cannot be resolved to a single, unique
file/path/branch/tag/commit/etc is to display the following:

> error: pathspec 'xxx' did not match any file(s) known to git

Unfortunately, this is (IMHO) at best misleading when the actual case
is that "git could not unambiguously resolve pathspec xxx"

Can the case where xxx _was_ resolved but to more than one value be
improved in both utility and comprehensibility by providing an error
message that

1) indicates that xxx was a valid pathspec, but not a unique one
2) provides a list of unique pathspecs that xxx matched against

e.g. in the case where xxx is the name of a branch on both origin1 and
origin2, it would be ideal if git could instead report

> error: pathspec 'xxx' could not be uniquely resolved
> xxx can refer to one of the following:
> * branch origin1/xxx
> * branch origin2/xxx

or, less ideally but much simpler, only the first line of that message?

Thank you,

Mahmoud Al-Qudsi
NeoSmart Technologies
