Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77B081F404
	for <e@80x24.org>; Sat, 10 Mar 2018 14:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932126AbeCJOXI (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Mar 2018 09:23:08 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:53888 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751145AbeCJOXI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Mar 2018 09:23:08 -0500
Received: by mail-wm0-f54.google.com with SMTP id e194so8697750wmd.3
        for <git@vger.kernel.org>; Sat, 10 Mar 2018 06:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=6ndir/pTN5SSyHTloJ5NLletNgcyikWpRT4yPJ3ZocY=;
        b=njPAugG/cRMbYc2hFLsYxus/fjOmxmiJYX3wDKwTBi2LIkeneSYM7hT0jPAB26OYDu
         7Wi58oS5J1LtCVLG0RwZAQQ+xJEfT3MUP718CtA/d4qlQx+6lHy+D16Da0A8fafHhueA
         Z1FskURklxMJE+i9wB3KOkls2PwOXaOp6T0yxhtQoliZWhfAMhPkc+3Gi9lW3P/4Qzbd
         iP6o+xvCFuBvD2VizwUnY5ctf1DgetKE34uCPrcGj7DcMURE+++0vEgtO0nR6R/mRQ9a
         a6xM9WjRcxYJaILy41U7H3bNJ9ApyVH3amwJc01vfohsL8D5tSIX9WkEBqKQadDzADWS
         L9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=6ndir/pTN5SSyHTloJ5NLletNgcyikWpRT4yPJ3ZocY=;
        b=AUXn6PMuljyX5nt9vxYj2ZZu1eoL4p8PL3EvxUOc9Yau64ONSzqbp7D99YN/RbWxfb
         6KJTNDmeXT7p028iEv0a7V9JObzufmDC25dpUYB5QAEvQFgUNovBNQ1lAkN3s+sDzp4n
         iNJVpQyfNbjpM/1fg3LBqaoT/rldTKlXCY7FC2CImpWer5jHoETTXAKld1OwY88DlOp/
         zBZopHNtSFXZk678NlH34jv61eqgruV3MoBeGI4xjPk67Nzu3Bt56X+fx0rOB5fKFrYl
         pmyke/HqS+BnFkE7mOZHzpmrvRsJw68BmngjGk3ZBJl8gGavwx3H5IWzqt+c03yPEIle
         aDoA==
X-Gm-Message-State: AElRT7EBWOjfEcWuIG2GvQODs6EviP9BCaYUy2Ss6YujASYiacavLSLN
        jbG/fv96R/9YFRioFmwugPJkVzEI2FqS7jYhr7q5yxBk
X-Google-Smtp-Source: AG47ELu30O/hSHJAQo8phg8kJL4nCnqmYW7LiQitSvHZC3LfaXVTZGfGD+uLtLpk3j/J9tItpYCrdxpkwInHqAElBO0=
X-Received: by 10.28.231.6 with SMTP id e6mr1357714wmh.51.1520691786568; Sat,
 10 Mar 2018 06:23:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.153.235 with HTTP; Sat, 10 Mar 2018 06:22:46 -0800 (PST)
From:   Ilya Kantor <iliakan@gmail.com>
Date:   Sat, 10 Mar 2018 17:22:46 +0300
Message-ID: <CAFU8umhtBxs9X+f1p3k8D6a4mue6OvM9cydrK-cRW8Nsq8Vcww@mail.gmail.com>
Subject: git rerere to remember half-merged progress - valid use?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Let's say I'm merging a branch with many conflicts.
I resolved some of them, but then can't proceed or need to switch elsewhere.

Will it be a good practice to call `git rerere` to remember resolved
conflicts, so that in the future
when I re-merge, I get my half-done merge back?

I couldn't find such use of rerere in the internet.

How can I save the merge/restore progress otherwise?

---
Best Regards,
Ilya Kantor
