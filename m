Return-Path: <SRS0=2Qsv=4E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46482C2BA83
	for <git@archiver.kernel.org>; Sun, 16 Feb 2020 16:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 089ED20857
	for <git@archiver.kernel.org>; Sun, 16 Feb 2020 16:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlUdOSd9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgBPQKQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Feb 2020 11:10:16 -0500
Received: from mail-pj1-f54.google.com ([209.85.216.54]:37307 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbgBPQKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Feb 2020 11:10:16 -0500
Received: by mail-pj1-f54.google.com with SMTP id m13so6121415pjb.2
        for <git@vger.kernel.org>; Sun, 16 Feb 2020 08:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=DcX/3QF08BbGKRuHLagUK0OpMWUhI47Hx/ks7QjwASc=;
        b=NlUdOSd9eA4lRfmJ7cc2MY0FtCPZ9VQV79rewn/k54GdX3JHfeF9OhgsrM8yGbc10d
         7kDz/GrOaeeTYJn8/u9DRt+pbe+AnkRF093ojIQLa+VlQIWOZ9HTEMMIlOi5uPbQUm/p
         olBC5dnZVglF52iYneqj7tQNe1drSfB2V7Hgp3V4yycEtGBVTZkfSw+t4At0XyfqUFIy
         h38jWXYNgx1AwgOw0JGMNu5e0g01B0vS2SEDS/LmxhHwJ/21qvdiaSHrjhQURHYBM22J
         F0Q1SE+x7tyamybO2+zcoqUDVW1Cc6eoNFyx22Hp6NK/Fevc7vF7h2ikeI9xJIRJ4I9c
         ilEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=DcX/3QF08BbGKRuHLagUK0OpMWUhI47Hx/ks7QjwASc=;
        b=sKtOjgro99TyEZS3h/pAGRQvR2brPQDrM3Peuf3IE4139b/8CwAJE57iBtILgzLSyB
         xMkvqCxL7UezRQC3I2xUPC99US6Pmf41WwCn/TSXW9uGBNJ6yT94OtXLbtoxU2W0k/r6
         f6/7RUYe9Cim5iKMGozFhREvV96XITFq4xfuJYvQrpMgKjAvdqlpE4el0tHy+4XeSyc3
         pfJjGDQp52a0aKt0F+vgD1pKELDX3jlEQ/XDAas7Gqa9uxKaE4mSsoDCQ9PyzKbwfHv7
         EOhtXB1xRiXuekszwKcARVa4u+t98gBZwh8Rx+zF7lNDrORQtmlyKTG8rtrOVa3/xl1I
         3JHw==
X-Gm-Message-State: APjAAAX90ACV79fDlNURF1XOny4Gj3HqR+snJBedgLsd/yNXPPzLi0Wf
        oS8aWb6FpmBAxUKEytrDzDLUsLvqKwDMpA==
X-Google-Smtp-Source: APXvYqwoEh92cOrMWQIZkocBZTFnYlLgvExOoJPwaxC5Orw+v3Bsyl1GAJb6pKwU1qfORKg4HYGJKQ==
X-Received: by 2002:a17:90a:d789:: with SMTP id z9mr15442998pju.5.1581869415042;
        Sun, 16 Feb 2020 08:10:15 -0800 (PST)
Received: from LJZDELLPC ([184.103.41.156])
        by smtp.gmail.com with ESMTPSA id d73sm13825071pfd.109.2020.02.16.08.10.13
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Feb 2020 08:10:14 -0800 (PST)
From:   <lyle.ziegelmiller@gmail.com>
To:     <git@vger.kernel.org>
Subject: ! [remote rejected] master -> master (unpacker error)
Date:   Sun, 16 Feb 2020 09:10:12 -0700
Message-ID: <000001d5e4e3$91ffb0a0$b5ff11e0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdXk43CYt09TcSEMSYqoAbgMa6bZkg==
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

Any updates on this error I emailed a while back?

lylez@LJZ-DELLPC ~/python
$ git push
Enumerating objects: 5, done.
Counting objects: 100% (5/5), done.
Delta compression using up to 4 threads
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 279 bytes | 23.00 KiB/s, done.
Total 3 (delta 1), reused 0 (delta 0)
remote: fatal: not a git repository: '.'
error: remote unpack failed: unpack-objects abnormal exit
To
//lylez-laptop/Users/Administrator/bare-repositories/python-bare-repository.
git
 ! [remote rejected] master -> master (unpacker error)
error: failed to push some refs to
'//lylez-laptop/Users/Administrator/bare-repositories/python-bare-repository
.git'

lylez@LJZ-DELLPC ~/python

Regards

Lyle Ziegelmiller


