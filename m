Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 029FF1FAF4
	for <e@80x24.org>; Tue,  7 Feb 2017 08:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752872AbdBGIQs (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 03:16:48 -0500
Received: from mail-io0-f172.google.com ([209.85.223.172]:33628 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751927AbdBGIQr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 03:16:47 -0500
Received: by mail-io0-f172.google.com with SMTP id v96so84695642ioi.0
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 00:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=cQHC0VoxwM6PA+N3h9oHE21nuBfUZgf8eBCEs/F6p+w=;
        b=DgjaRa4vC4EQWw5g0lwhOVftJ7RDO1CbmZS6UoQtYgZUh65fITWUQDGqO9UF15n1yL
         rrbEeXmVuqT3eU4scbtjZj75/SbJ2r7AdASxn82wkU5V7sLDyjGMT7BoVgyXBoPQGOR/
         RwUau2mr13Tym0dil6NoF3k1PUtDJl9tWinFVH9wG58zOXVyFjYGb+cGbtfy5U8tutfQ
         nyHS2oKhiHwJLpCWZfDAZdwJFxRupgeUzie0hCDzgG0r5z/F2EKeGMkJg6gI5MgY3vvO
         ufqidTe7c1AXYHCApNpI2JISnhW2bjqVm7ZV1IRB87wtGau5omG/AToirQHS6x+2+Ed+
         /tfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=cQHC0VoxwM6PA+N3h9oHE21nuBfUZgf8eBCEs/F6p+w=;
        b=N+3/QtBAEUQh56L7ym4NirLWLQDPCYU0lmxuV4VwRRAauMxNvBeVcHgER7UraAbLP7
         YNcRTQmxA7gloQR+VXFmXUSxw4XXZ/xpM3ELh/q/Jg+qm0F2Z75Ht4Rh95DYmLvL51SL
         tNawNgmqZADlLoLtUL4GPujoXPMWdGmEcJ32OCecIBCoYE0vSYZtcX0GkP4iXDeH3raM
         Iyb6ZB1l5UbGSY/+0xmimpqlePIM0rgpoXJO8xolSZ+OzQ16KbHMTEcWluycQBdu98OC
         y/FJTEa98rfnDTXDZTj15eVCcLl3KG4yM3z3gUmNoocRuQ2jLxWjSPWpaWsqlLleTrlO
         Gutg==
X-Gm-Message-State: AMke39m8aq8Oqt+s7VrQkX5PyzyYfG3F6EMyOfxxkrMK/mLL/sb3OWeFSmSEwZkagvTiZIbH1P4sOLtV0ssqmw==
X-Received: by 10.107.175.199 with SMTP id p68mr12310880ioo.80.1486455406973;
 Tue, 07 Feb 2017 00:16:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.12.223 with HTTP; Tue, 7 Feb 2017 00:16:46 -0800 (PST)
From:   Stavros Liaskos <st.liaskos@gmail.com>
Date:   Tue, 7 Feb 2017 09:16:46 +0100
Message-ID: <CAEXhnECi3LvSA92dSjL5PZ1Lx9p1PWELS04nmfJW=8K9o4T-0Q@mail.gmail.com>
Subject: subtree merging fails
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Following the instructions here:
https://git-scm.com/book/en/v1/Git-Tools-Subtree-Merging
will lead to an error.

In particular, if the subtree is merged and then updated, this command
that is supposed to update the local subtree fails with a fatal:
refusing to merge unrelated histories error.

$ git merge --squash -s subtree --no-commit rack_branch

A workaround could be using the --allow-unrelated-histories option

$ git merge --squash --allow-unrelated-histories -s subtree
--no-commit rack_branch

But this completely destroys my project by pushing the subtree
contents into a completely irrelevant directory in my project (no in
the subtree).

Any ideas??

https://github.com/git/git-scm.com/issues/896#issuecomment-277587626
