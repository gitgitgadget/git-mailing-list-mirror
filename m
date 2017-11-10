Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECD6E201C8
	for <e@80x24.org>; Fri, 10 Nov 2017 01:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755430AbdKJBKL (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Nov 2017 20:10:11 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:45983 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755317AbdKJBKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Nov 2017 20:10:09 -0500
Received: by mail-it0-f68.google.com with SMTP id u132so10072626ita.0
        for <git@vger.kernel.org>; Thu, 09 Nov 2017 17:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=d9bSILvoQ1txpE++Rpiiwrf0OyyXcnsD+r+hCKxuieY=;
        b=kkrvgKMistQ3noO5Eb2szMaqEzsikf1lSvzWL9JFAo4Qmg6UKa2yHeYMT5KcBo6ojv
         6quYJFkm+/zbRzy+1eESsxVtpex2htru87y3nmEtBKgeFf1pyQziSokmAfRJfDqP+AvH
         58nSbZfjqY1q3dWEzP1WfsmMFcuzB9l7TWktye6xfhrZnOzavYsBZf49OUw+FxSFtPcd
         6ZQXZiBvphkOnYcVxouhmWj+Nk7UaPlRDEI0AWGg65Cub32guRkukjuiT+x6PBrQ3RiH
         lRH5Luh1MXEWmtTpe5RCyC/fqKzBufcvVeq0Dmuj8keHhmxJmHKD2GjGViRKiDKSLayN
         hBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=d9bSILvoQ1txpE++Rpiiwrf0OyyXcnsD+r+hCKxuieY=;
        b=Oy4qExQfD+J0noCekW0jYbjt8fEqBer4xfbzHU067dXFkbb1579dw4gQe9mgh+KuhI
         X8v+FSe++kHSzyTGk4ubCyWoWsl9g6uMOqGVyDkRSsSGCyx42vEiTUd4P6DfH+JKRPHo
         MbN1Gm/yspPN9QXwT/IgpM4lgwZ3/blz8hYjwH3vFtoMggWWjHzomvq3m3r+JjGllGNH
         mqckrxak8LHhD5eFzYF13userATWXlH9q6Cef6fDo61Prpv/FU9Rle22ErfeNxlSFWoi
         0svrLp+iEomjbv2/LcF+Ta1hM7+2B608aIyqVtBJEi0uqThFyCK2VJb8VSS5AhLwntWJ
         Gfnw==
X-Gm-Message-State: AJaThX7TxdKC9zzNe2dFB4mh1TOasS0SvQEwR/HL+wmnxlGprBOsQAv3
        nJc7Bkoe2r399/xjBV9GwNvusrqhbjE=
X-Google-Smtp-Source: ABhQp+QEv5sogaaIM9xtTil3jRdwuH+vbqs1U0jUINaLOnQvjc4f+ynVmIkj77VyBY9MvoRRp008Eg==
X-Received: by 10.36.40.132 with SMTP id h126mr2289459ith.24.1510276208519;
        Thu, 09 Nov 2017 17:10:08 -0800 (PST)
Received: from localhost ([2620:0:100e:422:3816:f49a:2bf0:e33c])
        by smtp.gmail.com with ESMTPSA id t70sm4015143ioi.72.2017.11.09.17.10.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Nov 2017 17:10:07 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [RFC PATCH 0/4] blame: (dim rep. metadata lines or fields, decay date coloring)
Date:   Thu,  9 Nov 2017 17:09:58 -0800
Message-Id: <20171110011002.10179-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.128.gcadd42da22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is picking up [1], but presenting it in another approach,
as I realized these are orthogonal features:
* dimming repeated lines/fields of information
* giving a quick visual information how old (as a proxy for 'well tested')
  a line of code is.
  
Both features are configurable.

Any feedback welcome.

Thanks,
Stefan

[1] https://public-inbox.org/git/20170613023151.9688-1-sbeller@google.com/

Stefan Beller (4):
  color.h: modernize header
  builtin/blame: dim uninteresting metadata
  builtin/blame: add option to color metadata fields separately
  builtin/blame: highlight recently changed lines

 Documentation/config.txt |  25 ++++++
 builtin/blame.c          | 216 ++++++++++++++++++++++++++++++++++++++++++-----
 color.c                  |   2 -
 color.h                  |  49 ++++++++---
 t/t8012-blame-colors.sh  |  56 ++++++++++++
 5 files changed, 313 insertions(+), 35 deletions(-)
 create mode 100755 t/t8012-blame-colors.sh

-- 
2.15.0.128.gcadd42da22

