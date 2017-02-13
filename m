Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FFB42013A
	for <e@80x24.org>; Mon, 13 Feb 2017 02:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751443AbdBMCuG (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Feb 2017 21:50:06 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36655 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751346AbdBMCuF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Feb 2017 21:50:05 -0500
Received: by mail-wm0-f66.google.com with SMTP id r18so16963582wmd.3
        for <git@vger.kernel.org>; Sun, 12 Feb 2017 18:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=zygNlqYDAmfOV/kA8ZhiVguNh0D1dTOkf7gYSUiElWo=;
        b=d0+suEs6pg6icUhu3sc/IVezWG4txiZ9UXtcNom3Q66zwzN007xBBIeKFCuKKipHa0
         xMpvg2me9Gi+Nj2FvDuuNmQcYMePtgwyoyMqZHAizWCjObHVeNX1vGoWo54ZCV8IMFlq
         cEPGT6zu3ZofBoNtO1z4z557FLbWpbLrAb+oW5tTgvIVW0D1qd5cmT87PqaCB4e3+8xs
         VnHlBNHMONOGULWh1Zuv3PDMUy1EIU/DCN6XCqHUYpRnaj8tkeRzUrXSJ3pHzXDu+zxq
         awx/F65DEkgm6d+UVUiOpUf2gCDPghhD9DJJ/Fmf1LYBAlVeqUMBd0Z3JRti9rWepw92
         +5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=zygNlqYDAmfOV/kA8ZhiVguNh0D1dTOkf7gYSUiElWo=;
        b=s4R+g9zDZZrt//TJCZAk2UK5Jp2rYMGge7K3ydYvd8YnTuY3xJvxEgCrOtezFC2aSf
         DJPDhB30Vsm2gepK0P6Y+h5b+Jxg58plydOjYEvVHQXtHrVseW+bMePoYfPPvlVa8tTm
         rRH4HejlN01xrfleT+yTAySqo44PHDZTM66t+cB8GzBEYaxG5VI3hmVCsK8/zZln4pHh
         vhPNSWzSPktivSXHBELTXfd4CcTJClZLL0yWfvDiPQtgYw6ar6OxNyzduKtyejPaWdm9
         3n3m89kENlsyaF67gIDgpCOOfUOeezdZcc5Y9PmnA51kZMaA72Ze2gooyce/Pzy45Ifi
         dEPg==
X-Gm-Message-State: AMke39lgaPdR+TDyKZEZPmpSRvnet/ayE7XTqyq6l0kMR+vYX84euV54qXJD9vLBP26uTV0IlF061YQJYm1OLQ==
X-Received: by 10.28.132.2 with SMTP id g2mr34576038wmd.103.1486954204172;
 Sun, 12 Feb 2017 18:50:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.62.208 with HTTP; Sun, 12 Feb 2017 18:49:23 -0800 (PST)
From:   hIpPy <hippy2981@gmail.com>
Date:   Sun, 12 Feb 2017 18:49:23 -0800
Message-ID: <CAM_JFCwYAKCWrHqCtcwid27V1HvhuSmp4QpbNpgyMzrzWUNYog@mail.gmail.com>
Subject: Incorrect pipe for git log graph when using --name-status option
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `git log` command with `graph` and pretty format works correctly
as expected.

$ git log --graph --pretty=format:'%h' -2
* 714a14e
* 87dce5f


However, with `--name-status` option added, there is a pipe
incorrectly placed after the commit hash (example below).

$ git log --graph --pretty=format:'%h' -2 --name-status
* 714a14e|
| M README.md
| A rm.Extensions/BitSet.cs
| M rm.Extensions/Properties/AssemblyInfo.cs
| M rm.Extensions/rm.Extensions.csproj
| A rm.ExtensionsTest/BitSetTest.cs
| M rm.ExtensionsTest/rm.ExtensionsTest.csproj

* 87dce5f|
| M rm.Extensions/GraphExtension.cs
| M rm.Extensions/Wrapped.cs
| M rm.Extensions/WrappedExtension.cs
| M rm.Extensions/rm.Extensions.csproj


IMHO, I think this is a bug. I think the correct output should be
below.

$ git log --graph --pretty=format:'%h' -2 --name-status
* 714a14e
| M README.md
| A rm.Extensions/BitSet.cs
| M rm.Extensions/Properties/AssemblyInfo.cs
| M rm.Extensions/rm.Extensions.csproj

| A rm.ExtensionsTest/BitSetTest.cs
| M rm.ExtensionsTest/rm.ExtensionsTest.csproj
|
* 87dce5f
| M rm.Extensions/GraphExtension.cs
| M rm.Extensions/Wrapped.cs
| M rm.Extensions/WrappedExtension.cs

| M rm.Extensions/rm.Extensions.csproj

I'm using this:

git version 2.11.0.windows.1
GNU bash, version 4.3.46(2)-release (x86_64-pc-msys)
Windows 8.1 64-bit


Thanks,
RM
