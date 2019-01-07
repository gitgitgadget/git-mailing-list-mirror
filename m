Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D2FE1F803
	for <e@80x24.org>; Mon,  7 Jan 2019 12:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfAGMu6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 07:50:58 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:53510 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbfAGMu5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 07:50:57 -0500
Received: by mail-wm1-f49.google.com with SMTP id d15so773167wmb.3
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 04:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=tL1eIRK6Uqc5W+rpsC2toMtEsXOAtDV8MST5CKgB3Ho=;
        b=HbjaZT6XOcnUgzP349SfsmANtK9gUSCkzNiO9gb6jgZ+ujopRcEkuF2ixzJJeldYH8
         76Hb7tXgi6HcaRAZHMo3ER86hGkoHdYuDDpLn8tTFvwWTOAhTglw4sT//lJStBTut2nN
         029jyTlYDyY+YRHplSohhx1k9ImBCi0gbN07g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=tL1eIRK6Uqc5W+rpsC2toMtEsXOAtDV8MST5CKgB3Ho=;
        b=pRzG63p/U0mNydh4X8Mf2GF1EXSjbFc2oUmFW+ygR1vHQGfp+BwSih5quGTDN38JTp
         U/J/tOXKV2AOArY88/HOeKXPWeny0fE0VA+5xX4Qogt/PDs+Q5h3g6D3+MRHyPPoRnxE
         MinFC3eSOdur1vV988SQluAO21kqiJJLE/71i/ndeUd6i/R98R/SZ/K+QVy9vlhIUNC8
         SoFcythC/ISpSBxs3JPoNwjZeQMEQM4yL3e2XUUJZO+uHUn7jeygQGY9AWUDu3tlQAEI
         xHBggCN0VaN7UqGb8POorE1T/gD9BxtP77wctw34J1sLVak1qJNB674UVEZ1TRG3XNcC
         i8IA==
X-Gm-Message-State: AJcUukdpmkZfW7/X3/6M3CIeqdmkf909yQPC/WvPP37GovHKvUt2DGmt
        uyshmpGqCbErw9w2yZx1KCM/diZgvLGf0No2HRFDId0y
X-Google-Smtp-Source: ALg8bN4eIROzOFyclQNn/JTR/0V5q3knyIGWTk44BrfQ/rZuxTe411pE11UIvmJRtl8ccNLTYpkJvTsvRIUqxd2t8PM=
X-Received: by 2002:a1c:2314:: with SMTP id j20mr8467568wmj.142.1546865454454;
 Mon, 07 Jan 2019 04:50:54 -0800 (PST)
MIME-Version: 1.0
From:   Luke Diamand <luke@diamand.org>
Date:   Mon, 7 Jan 2019 12:50:43 +0000
Message-ID: <CAE5ih7987J2WXdCJvs2e3hOn3zucpE6gsr4JJtxO+XE5=K2G_Q@mail.gmail.com>
Subject: git-p4: default behavior for handling moves?
To:     Git Users <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc:     Chen Bin <chenbin.sh@gmail.com>,
        Merland Romain <merlorom@yahoo.fr>,
        Vitor Antunes <vitor.hda@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-p4 can map a "git move" operation to a Perforce "move" operation.
But by default this is disabled. You then end up with a P4 commit
where the file is deleted, and a fresh file is created with the same
contents at the new location at revision #1.

Rename detection gets enabled either with the "-M" option, or with
some config variables, git-p4.detectCopies and git-p4.detectRenames.

I've been tripped up by this, and I actually know about it, and I know
other people have been as well.

Should we switch the default over so that it's enabled by default? I
can't think of any reason why you wouldn't want it enabled.

I think the rename code was first introduced around 2011 by Vitor.

Another option is to add a warning, but people just ignore warnings!

Thanks!
Luke
