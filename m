Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33891C433EF
	for <git@archiver.kernel.org>; Sat, 26 Mar 2022 13:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbiCZN0U (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Mar 2022 09:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbiCZN0S (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Mar 2022 09:26:18 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8DD6362
        for <git@vger.kernel.org>; Sat, 26 Mar 2022 06:24:42 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2e6ceb45174so68088187b3.8
        for <git@vger.kernel.org>; Sat, 26 Mar 2022 06:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=s2UhQC/Xv6tVoWnXu+C72tjJGFHGuwRHqChlAA9VLeI=;
        b=XMZyorQqeDcu6N8u6KEvBsA63Z1JFvMzJJ5IoS1k8RgIgFmbffeRb6hQlIXmOvclww
         ogr/l8k4w70rH5NMmJMSGNOBcnDd1Dg4w1fthz+8sTdZSFQgGXF1f022JYtdDHV5rmF6
         hYITsIUiTDJpVV9AkOYC+w6jDuOD9Ts7njbrtD+L9Fwf5qiDXao+tE4zMaeDsQyWNkX7
         ZyCPY+ZPmZj5U/EuM7YKjib4tFR2qj+qKGqNfMfb7AygV54PFm1bp6TKfWRcRU/vlI9I
         Uq7zyNb4iszdk0riHMtPHoobQhbGvBGh1BiWpR8z2+Vo7+qzA6udlvEdoiN6qMhkkyc8
         LfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=s2UhQC/Xv6tVoWnXu+C72tjJGFHGuwRHqChlAA9VLeI=;
        b=lrcgc4Zn7QYgAkVGefPxokcbPNo1s4oik3dL9qJiGS/gbhxG50lcI9coBSNgpYjyZu
         /R3eeeuReAK17ZfwHhSrJ9lYybDfLRo6Z2bnT3qcAaPTB7emPoZYTArGWb/DnMxoSIwX
         S7Iqn8IS1BSYdB5nwx+pxX7cnK7bJwqE0KIxx9VEZvxfybo9J1MZjWX+n/sCuSye0VBs
         yzABEzWBxhjIX3dj/Sy69eGxMQRh0YWqEI5vzIws5q3gK6259Yz/kg5qHdFMIWcyQhBb
         RIG0exyi0hc076eaoJ/E9toTBDdOrxlPESFjZHGA3jVPOLN4lPDMVuocep1JUzBCnsoE
         V2Qw==
X-Gm-Message-State: AOAM530iTfqnm0p3BDW7x2AirLzSj1lbGddU8KFQA3BCA2wP3LOphcRt
        guN2w8JeZ6i6UMCH6cXdwUyzZvDHRMOoh4Dt49FFjLSqX1M=
X-Google-Smtp-Source: ABdhPJwiWxqnkmY10FwlMhdJsWsChgte9WBNa+0BJGMaNNyoChWRGg9fiMVAfzXvvj2njQ/0+is7tABIXbIEqLZz4P0=
X-Received: by 2002:a81:5206:0:b0:2e5:fa2b:5289 with SMTP id
 g6-20020a815206000000b002e5fa2b5289mr15968705ywb.409.1648301081417; Sat, 26
 Mar 2022 06:24:41 -0700 (PDT)
MIME-Version: 1.0
From:   Lars Strojny <lars.strojny@gmail.com>
Date:   Sat, 26 Mar 2022 14:24:30 +0100
Message-ID: <CAOG+ZNsY6Pyzp11zjybNzvD4F0xZFoppiPHanvS+n2hx5y0Aqg@mail.gmail.com>
Subject: Bug report: filters not applied with git add --pathspec-file-nul
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everybody,

it looks like git add --pathspec-from-file=$null-sep-file
--pathspec-file-nul ignores filters configured in .gitattributes.
Without --pathspec-file-nul it works as expected. Is this a bug or am
I missing something? Git version is 2.35.1

cu
Lars
