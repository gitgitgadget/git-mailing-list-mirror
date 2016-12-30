Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4967D20441
	for <e@80x24.org>; Fri, 30 Dec 2016 10:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752232AbcL3Ku7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Dec 2016 05:50:59 -0500
Received: from mail-io0-f181.google.com ([209.85.223.181]:33305 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751820AbcL3Ku6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Dec 2016 05:50:58 -0500
Received: by mail-io0-f181.google.com with SMTP id d9so369597232ioe.0
        for <git@vger.kernel.org>; Fri, 30 Dec 2016 02:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=tLXuTypquRYaP88RsP3fZwbcXUHEXbWaZqDDYY/wXD8=;
        b=hI8vkGTLtUKCQ00GelM4MYAcl3YuQ62VTAENsKOVktHHsTLJ/nYbjEobbpJNXqDoCK
         n+6nolCsw65s4kgoTAoRYCckPtUaHBnRjLFZrogtafeoPohDX13vfaXufaZbsjPGcopT
         WW5nEJyKk0gPdhiWnaCzzaJW7DRZPISuBSzzj1gImDGqMEO2XCrvUNH3svkKkfFz7Lkg
         ngPxSGByY32+nzDnP6QUTGSj7FjfmDOb4PmshznV+sBKkX3Xq8zQtNQkjq/sDVSJsOis
         EDzeJKxfDStjBaCbeHs7KPFJkCS/u7zxS1hokrQD6JrnVN8m72AcqeFvbxilMi/NaJEU
         5P9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=tLXuTypquRYaP88RsP3fZwbcXUHEXbWaZqDDYY/wXD8=;
        b=OoPABP2Av3IcTDPFA8JECJK3zeEvhWMd9Db/Owr3CxYrLibBbforLN6kteBSP7/j3u
         CAkDdKPQrmt7FAwqhCTaJ93xSNkpmStMVLHOqA9nNrD6eEDWbr3BKVuOUk3CoFiPkiA+
         rzHb5a4tADSOEck8TRfXiA6mwBF+G+/5y9w4gCeiKHLCoURzzh5zFFrdPobodj9GixnT
         rL33RRRFUByg9NzKUTdoeo06we77dyKey6OdS6XTVp1a9nlQGvq6QFiaTGP9LkAPCKI+
         ngUSDQBXDU5O4507EitgB6//MC9FbKfAjcZPZ4IflzJJ9QC/yWVmuMg6KtWyCRqR3cNe
         GciQ==
X-Gm-Message-State: AIkVDXIIORbsBbxsI2BmXo1/sTPmaWxAN7EbeWaoGZafMBsTfcvLQ2yy2OENJhzG8MZ9MFkubteX7NCj4WUxAA==
X-Received: by 10.107.152.140 with SMTP id a134mr40763362ioe.207.1483095057450;
 Fri, 30 Dec 2016 02:50:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.136.130 with HTTP; Fri, 30 Dec 2016 02:50:56 -0800 (PST)
From:   Tor Andersson <tor@ccxvii.net>
Date:   Fri, 30 Dec 2016 11:50:56 +0100
X-Google-Sender-Auth: -QO5IeQY4U7TCOC1nElbmLM958o
Message-ID: <CAAmwXB=M8yZY2sFLwavrrQSEW9bipFhNZyLduwYXtZNK6-Ppxg@mail.gmail.com>
Subject: Wanted: shallow submodule clones with --no-single-branch.
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

When adding submodules with --depth=1 only the master branch is
cloned. This often leaves the submodule pointing to a non-existing
commit.

It would be useful if I could pass the --no-single-branch argument to
the submodule clone process, since then a submodule can point to any
tag or branch without ending up in this situation. I've got a local
patch to hardwire the --no-single-branch argument in the
builtin/submodule--helper.c clone_submodule function, but I'm not sure
if this will have any other adverse effects?

Better yet would be for the shallow submodule clone to automatically
retrieve and graft the actual commit the submodule points to, but
that's probably wishing for too much.

-Tor
