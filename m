Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B96C1F790
	for <e@80x24.org>; Wed,  3 May 2017 01:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754699AbdECBdE (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 21:33:04 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:34013 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751046AbdECBdD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 21:33:03 -0400
Received: by mail-qt0-f170.google.com with SMTP id c45so126809697qtb.1
        for <git@vger.kernel.org>; Tue, 02 May 2017 18:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudcheckr-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=ZIpryIdBrxBFC2nH9z1ZWDWeGu/FJDafr5jUoke9H/I=;
        b=KW7pGY7l55qRnPkWnt5HarVabTMu+ZLuhPNr9GpXJP4vyHZp4Xa+utEDbOWSEjYtlN
         ShsUCbGdRqJ0xv2CIQQJuOhwfsq7/EooGmqPz4ijuXRYaLEWPBwbAHln5oyciN+wCilY
         cZT5mJGEwKU4dJjY2uFG5i+CHYwopDn+lpT/YzBvtzvK475eXSgl7XSWGHDI8WQtJBKf
         +TypMy7zePr7gLunrtqiNOtIucLFxL3uJjO7R/AzpU+U7pwOi4/fqMwX2gpOHieQ5KSS
         08aaATqWvaqht8y+6F+IUCbsMHouF676zzhRF/qCLQ7H58L2+WMv8UhmfWGDUh4+9GcC
         JmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ZIpryIdBrxBFC2nH9z1ZWDWeGu/FJDafr5jUoke9H/I=;
        b=aQot/EreQSAs0D6IhM1ADBvcgNUzsHBkYToXnfgPeM56cOBE1KCUmymQ3XbdpJTXU4
         Je5WxZR5nmMDXi279WCpJicDVv9RqC7TbSS05uc6I+n54k1x8b0QTeCguEI0yiof8akI
         8e5kbDXPnP1eHVRkvWcnRimLOICWt+Jgw47FRSeQyVHENJMBRI9hLgIGJFfwEAmvxshR
         UVi8ovKCLfpSzJpItCHeZSkzBjllVBYH3vtmEjcc6rCGkhWoyzqrFMVRtFVSqqGaK0IP
         SUx5VzNsBRk0i5/dxjgvt9RBsuP074PirhiQ72j8Ui6hVA+4pSDONolPU893Qt1a3trw
         4jvA==
X-Gm-Message-State: AN3rC/4/Gku8AoRfYtsDY7702D7YJaBKGpAKoMXTH0nCpOdZLp4W5N75
        YwcFlWg+ouN6sPcs78RQwCdRuOMzHNoauFM=
X-Received: by 10.237.60.77 with SMTP id u13mr28491599qte.267.1493775182750;
 Tue, 02 May 2017 18:33:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.105.246 with HTTP; Tue, 2 May 2017 18:33:02 -0700 (PDT)
From:   Paul van Wichen <paul.vanwichen@cloudcheckr.com>
Date:   Tue, 2 May 2017 21:33:02 -0400
Message-ID: <CAK6FQHcHxwCgzGFCnV_3wvX-sVvL8cHpZH11x6ffbzxUJTTGCQ@mail.gmail.com>
Subject: Git checkout issue - deleting file without apparent reason
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

We are having a strange issue that we haven't been able to pin down.
Scenario: master branch and feature branch both have a specific file.
1. Master checked out.
2. git status show no changes / clean staging area.
3. Checkout feature branch .
4. git status show no changes / clean staging area.
5. Checkout master again.
6. git status shows that a file has been deleted (i.e. the file was
removed from the file system and the staging area shows it as
deleted).

The file exists in both the feature branch and the master branch. As
best as we can tell, the file is identical on both commits.
The issue occurs on multiple platforms - tested on Windows and OS X.
It only occurs for 1 specific file.

Based on the activity of the file, nothing stands out as unusual.

How we go about troubleshooting this and determining the cause?

Thanks,
Paul van Wichen.
