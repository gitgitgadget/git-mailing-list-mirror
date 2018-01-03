Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 553791F406
	for <e@80x24.org>; Wed,  3 Jan 2018 16:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751756AbeACQH0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 11:07:26 -0500
Received: from mail-it0-f50.google.com ([209.85.214.50]:39171 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751422AbeACQHY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 11:07:24 -0500
Received: by mail-it0-f50.google.com with SMTP id 68so2315109ite.4
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 08:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Rq9sOajsZ/0bvQ3Tbg1f/7bjHoMAEN+khk4OaCHlZu0=;
        b=hFqsQwM+tQsSPiLiRAUzoBDeSs5XmFatG5VxF7gFpM4SiWqCSa/whkThd0zzNUf51M
         LTr3wOPj3JDJPBdG+52D+EWIqK976OCB26GbJ6yaFDryzIfsJ9CxlmGKB82Y3yQd+TmP
         2kdaJ7wNc4vLFoKwh3lGIQikFRBCTgZrB7nwDkjFpUPi8yTIHJZCf/CFSrWZR1BluYb1
         DZhmJ6jXNK1GhdF11SzAL4rxAo6f/I/4ZHRXJkG3iHNc14OKcuJQU742EAPp5karB+uj
         bZdFgXULiZBRLrkjVYokdYNw4lRb5BZiYT5fw1w2Ct2vLbQ2oZBtxUQLF1+X7AZ7U2zz
         /ZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Rq9sOajsZ/0bvQ3Tbg1f/7bjHoMAEN+khk4OaCHlZu0=;
        b=lL0q759oOkHJjulj4WSS3g0At5C6h7kZF5HnDOI3wOd7FaS0+kRxch65BEtpP4jInF
         1iuu7oEWhvfu2AxVDmg4XqDb2P02Is4dFNmmaxirbklSMG0VIpeS428vn1yWhXDCuoLT
         wKseyRN+YdPgRG0YfO8bM78AhMIKJRlZ+NN00pj20Zf9VTrho5/DED/fx8rPJa8jqZF6
         19gf7NtcRT/8LP7i3dam3ACZMoa1lFMl0eDtx+JBIEhCxT4QsFJZrNhjclAuOaxRHaVc
         FSd0IkSqge/2p7xnESQ5HT2J8k0CiBQfzTw5TKgiTYxiYCqgB6fiVuBhpnf9FfFO1Rle
         larA==
X-Gm-Message-State: AKGB3mLS5G06a542s29mIhU9Wmx/+l0oR0pUC7yMqPc842a/SW2Z0Cz0
        oxBh6k5FG4FMgqXvaa+CcdDi0rMIkvefAQZlYptMdRGo
X-Google-Smtp-Source: ACJfBouLM1i4r57v6mDNu9ynGTlYxiCPwCrXGvRz0pjCKXI5bZjVmivmIr6m3N1kNmIiSPQFp2PYvd6hcF/l7R0n/zA=
X-Received: by 10.36.137.137 with SMTP id s131mr2242705itd.22.1514995643873;
 Wed, 03 Jan 2018 08:07:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.62.3 with HTTP; Wed, 3 Jan 2018 08:07:03 -0800 (PST)
From:   John Cheng <johnlicheng@gmail.com>
Date:   Wed, 3 Jan 2018 08:07:03 -0800
Message-ID: <CAJzZBAT--X8GXg_knege_pZ8A=_Qk9nyMCLaoRMvjhUFGQYsZA@mail.gmail.com>
Subject: Misleading documentation for git-diff-files (diff-filter)
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I originally asked this question on stackoverflow
(https://stackoverflow.com/q/48039277).

I wanted to know if git diff-files shows files that are not in the
index but are in the working tree. The documentation says you can
supply --diff-filter=A, which will select file "that are added".
However, git-diff-files (appears) to never show any files with the
status of "A".

It seems like the cause is that git diff-files includes
diff-options.txt which uses a standard template for --diff-filter
which includes the "A" option. Perhaps a clarification can be added?

Compares the files in the working tree and the index.  When paths
are specified, compares only those named paths.  Otherwise all
entries in the index are compared.  The output format is the
same as for 'git diff-index' and 'git diff-tree'. Files not in the index are
not compared.





-- 
---
John L Cheng
