Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 344651F453
	for <e@80x24.org>; Wed, 17 Oct 2018 18:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbeJRCMY (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 22:12:24 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:34621 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbeJRCMX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 22:12:23 -0400
Received: by mail-lj1-f178.google.com with SMTP id j17-v6so25257449lja.1
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 11:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=tH3rjuZC82qJi6fh1Uo9A7j8QTJCCdEvCaIp4XTHaVo=;
        b=RfaVBggBhJHp6N9mQYXMUgiFWkidCg+j2FrFiO4vU6I/BHvR54d/OXaQKIRCCn80wF
         264fC7nsWDhyGFA5+hH6m8FTjxEFNa2uz1GZNJ254SkOBdwPAUq6p8fMF4pJ7p+ZRFxq
         ffJv6CyVxfwXGGZXm5bHnrd4+V3GTqCuvFpwaIGnQ32wu1i3cAEzMSYpml/b9BiQqMJG
         HXozWp7j1n9wmdcFbhNgQhDzu+dTD1muXK0zHJFM1dKLjD6xVeTMNSNVThJ1yOMdSdsc
         LnCXwkH3l48XM3sGDnjtzH2qoy9zSHiGUctd7Obl+ccC0+M6rI9251x+v3dUoF0ixEeO
         UjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=tH3rjuZC82qJi6fh1Uo9A7j8QTJCCdEvCaIp4XTHaVo=;
        b=JHU1D90Mut4y57kJJu+yXy/OYMx/FreT/IMlDTuhAsqCzBxk8hT1DkZ7rY6pfXugj0
         B3XoJ8ilRAIVmETtrdHQAJAXCe5eIEiVRgaRapITTVD9uLJb5Hsh3sBUik+1IhymZ9Cn
         UzIGB+0AtViNPLTPfPrDEK7ptbDC7Z7deC1+7jb8ehV1y4fRKcqwNT/JS0n2N9VOdau5
         7+5kLxBy+D6Rr5mXwH5tf+lTvPk5s1omiKmf2vceBHBcr8Znp0Njm93zErECCFZUCHSY
         Q412iaNIvjx9br171mcVAipADIb6HI971R8gU3u+B34FQmta+zyeK+2b3Ai3IRCN4WE+
         kJDQ==
X-Gm-Message-State: ABuFfoi+pe5peWbHXuOq5bmx5VamrlhyTpPkoZZzx0AFalKx1IvwhAWB
        u/oQQ3CvxbSdIhoHQ4uB6X3eb90b+AJW6KIVpGx9VwbT
X-Google-Smtp-Source: ACcGV61DibH28zQT2ot+C0D/QdcIQ/oZ4Aj/P39p+uQibyn0tVjyEikB9XzpKCGZ1RMCqBuXpMB2CynXtex6BP5dxh8=
X-Received: by 2002:a2e:2997:: with SMTP id p23-v6mr17431549ljp.12.1539800130230;
 Wed, 17 Oct 2018 11:15:30 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Wed, 17 Oct 2018 13:15:18 -0500
X-Google-Sender-Auth: 2tVYfJxYGScHIMKWpNiF_t4DqTE
Message-ID: <CAHd499BSVRytaFKOUhE=A4Zv+MMx=uKrWKUcT13QwzOCZWhEtg@mail.gmail.com>
Subject: Sort output of diff --stat?
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'd like to sort the output of `git diff --stat` such that files are
listed in descending order based on number of lines changed. The
closest solution I've found online[1] has several readability issues.
I'd rather see a built-in solution in git, if one exists. Can anyone
recommend a solution?

[1]: https://gist.github.com/jakub-g/7599177
