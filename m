Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8A361F576
	for <e@80x24.org>; Sun, 21 Jan 2018 18:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751301AbeAUSbm (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Jan 2018 13:31:42 -0500
Received: from mail-it0-f48.google.com ([209.85.214.48]:38331 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750925AbeAUSbl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Jan 2018 13:31:41 -0500
Received: by mail-it0-f48.google.com with SMTP id w14so7376802itc.3
        for <git@vger.kernel.org>; Sun, 21 Jan 2018 10:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=GasDCc84EIKLuonmBdU5Vl0W91nxjDImrMdzmV7GCNM=;
        b=P6iLl1lfqrr0LoWAg1ShLZhKWLl+OwNDdyUWDMqTymIt08aQ/Ex8Pu4GQDoFPAQaNp
         poR7sNjnzOSSw38jLpX1qWDyPVQYFddfXeDFpIi9qEwuIo31Jgxwo0mZnVyEBiqx2KI9
         XkZcjhdWPng3rcuVLWmYriYAcokY226lMk9ceLt3+S1ub36t2oWclH1Qtobxxycpe7dG
         kCjYDDq5FGZ25LXbODzAQ0zvlNS3VoyDNyeIRfU1XOqhMEUBtxK201K1TpnRSNZfOYZ2
         vvMmOJMdsyBbNrpHQun4OYnNH+4gt3/XZce4L1Hsm/lbHJqO2zAqLrWsXN70QDjhdVNl
         M5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GasDCc84EIKLuonmBdU5Vl0W91nxjDImrMdzmV7GCNM=;
        b=QgzzURZOG0Tm6Dhb9b5oPZtDS3X1FwMpdiXj/zszWJc5WFFEPB1FwGj1l0RLoB/WHx
         Y4q+FVl15GVECiFmmtwARqIalPxPBLzxgxlOpmZ5M5+GWuL/BsR+GNF6iELT/Q4lm+Gm
         nFzHLxB70K+FJSc+dSwu0Ot1zVmTbDvjJlEXHXH5aSIjVkmwBjywoJO8AkONp/zkJBsS
         VSoc9hIcJyxGFDnDerhjNFC/amHRHljNnB6qzwus5yvSh+v8j/+aYVp3dIqd2p8epvLu
         0OR6/Qr0eAX419f/VfEnUA4KoBrsB6kC6Z2j7xNbLq4kJy+HATTJgSawvh/iGY5ZqEUs
         Y7Nw==
X-Gm-Message-State: AKwxytedqVFcZvwyt51SixvwmgVdkQ1G17k+nVAmxoPvdV+1itC/OnWt
        Rszb6NQGbomzGR4FLr/+VU9nPdDELXueg3ha+kSfKhOC
X-Google-Smtp-Source: AH8x225KHMBwaR7Qh/U+O3DofviipSPqo2KtkcTAq2rxYsGJwJQ5dUG3UqMY6v8n6rRQP2L3JU2JSdOmYquCqkp5qWg=
X-Received: by 10.36.189.129 with SMTP id x123mr4093138ite.31.1516559500596;
 Sun, 21 Jan 2018 10:31:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.134.103 with HTTP; Sun, 21 Jan 2018 10:31:20 -0800 (PST)
From:   John Cheng <johnlicheng@gmail.com>
Date:   Sun, 21 Jan 2018 10:31:20 -0800
Message-ID: <CAJzZBAQuOqwRmBLOdUEVMY74_xT2dWe3a+9qT9ufc4bp8gjgig@mail.gmail.com>
Subject: cygwin git and golang: how @{u} is handled
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am experiencing a strange behavior and I'm not certain if it is a
problem with golang or the cygwin version of git.

Steps to reproduce:
Use golang's os/exec library to execute
exec.Command(os.Args[1],"log","@{u}") // where os.Args[1] is either
cygwin git or Windows git

Expected result:
commit 09357db3a29909c3498143b0d06989e00f5e2442
Author: John Cheng <johnlicheng@gmail.com>
Date:   Sun Jan 14 10:57:01 2018 -0800
...

Actual result:
Suppose that cygwin git is specified, the result becomes:
exit status 128 fatal: ambiguous argument '@u': unknown revision or
path not in the working tree.

Version:
git version 2.15.1.windows.2
git version 2.15.1

I'm not certain if this is a git problem, as I could not reproduce
this problem using python to script cygwin git.

A list of scenarios I've tested are
1. golang + cygwin git = "exit code 128"
2. golang + windows git = "exit code 0"
3. python + cygwin git = "exit code 0"
4. python + windows git = "exit code 0"

I've tried to write a simple program to echo the command line
parameters passed by go into the process it executes - and it appears
that go itself does not change "@{u}" into "@u". I'm a bit stuck at
point to figure out which may be the cause: golang or git. I figured
I'd start here.





-- 
---
John L Cheng
