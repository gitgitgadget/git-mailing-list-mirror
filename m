Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942BEC4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 11:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 458E320774
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 11:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKg0/XG2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgJELdI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 07:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgJELdI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 07:33:08 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36426C0613CE
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 04:33:06 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id y2so10401458lfy.10
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 04:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:autocrypt:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=QOiUFIIoE3oWrNghCbRL6EUoHB9KUbpYPZUAaUojFKM=;
        b=WKg0/XG2tmFr55g2hi2WD/EsmMq4KD1snkBiUHAfCiC0eT9oWS/P14HS+Um+Sxngi7
         /JIvFKi5jqUSkSbeONVxageyKq+JPXK1WMbQz+CuTHezNXeKDEB/CobyA74EKXjOX4zM
         m+bQ/YfHarTm20+3RfJs1XOwVZRfru/m/xBDWFkFjTSzzpSPyZ7GnFTlzupc7q0ye5iK
         bjQ4eTbT0X5cEPbHFCalSB8WOyTxp8IedDptNMPy388YC4WtvDg2Mwqe5lSrZahp6Dg1
         Imy9MHemmS2+n/sx5lP/M8lOgpnEhtWFe0hBUmAmCKY8B/iiCu3PBQ0cYvlm3xvKYken
         kZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:autocrypt:to:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=QOiUFIIoE3oWrNghCbRL6EUoHB9KUbpYPZUAaUojFKM=;
        b=CxpiZPE9qNggcvA4PBeNIpnFFPiQg2XIIubfMrRXIkZcAIKs0QNzEB4F1a5zeiuqa7
         mI2ISJXMes+dsg/mhb94fqNixfXblxNarnotI1OaYFa9wAH5jKD/N487g+YCXrz0+0Ud
         /zs7Z0VRXPOhy7VmZJFHYoZSpRS2855coX7+UEHWNP92OI0Z4sn5aeIhYSFMMhekdutQ
         oyIvTG1pM/zw/7RzS5p4eVaXtufBEFF3qGKkdhuEB6w78+F4lpsnXeIR+1YcxL7bYSUM
         GnMLvWLMttDYz5KCzI96ixTZCIr7a1X0vwtqnqOjlFsWe2wSzfkbJJUBb6EZGu/kHkBq
         IjBQ==
X-Gm-Message-State: AOAM532am3YGRVu7iWDsmYOkZoz977qKaSH0EAtvJuhcBVZPXHXELXc5
        js3BpJp3aFvSJbtND/jBH88jcenggJA4rg==
X-Google-Smtp-Source: ABdhPJyqNTJgdZr6QA0Nyz7oy/HJaytsTAW5mBMwnl0DsLBqurQQasJ3fOCLRnarqW9T7RSuslbDXQ==
X-Received: by 2002:a19:be0e:: with SMTP id o14mr3809830lff.48.1601897584174;
        Mon, 05 Oct 2020 04:33:04 -0700 (PDT)
Received: from ?IPv6:2001:470:6389:0:e4ff:a4d2:f658:480a? ([2001:470:6389:0:e4ff:a4d2:f658:480a])
        by smtp.gmail.com with ESMTPSA id g74sm2620159lfd.152.2020.10.05.04.33.03
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2020 04:33:03 -0700 (PDT)
From:   Tomek Mrugalski <tomasz.mrugalski@gmail.com>
Subject: bug report: gitk crashes on git commit with emoji (utf-8)
Autocrypt: addr=tomek@isc.org; keydata=
 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
 EusryCzlWytANdb+74Lo6IYFZpAzck8=
To:     git@vger.kernel.org
Message-ID: <1e06bde8-ae70-2653-5112-c97c9ee021da@gmail.com>
Date:   Mon, 5 Oct 2020 13:33:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there,

I'd like to report a bug in gitk. gitk crashes when trying to view a
repository that has utf-8 chars in the commit comments.

System: Ubuntu 20.04
Tested gitk versions:
- 2.25 (the default in ubuntu 20.04),
- 2.28 (installed from ppa:git-core/ppa),
- latest (next branch, commit fdf196b9972337a0285dae59f904f62f989fbca8)

Steps to reproduce the issue:

I've isolated the commit in our repo that causes this problem and pushed
it here: https://github.com/tomaszmrugalski/gitk-bug-emoji
The repo is small (only 3 commits). The offending commit that seems to
trigger this bug seems to be 3ad99781c449da3b1b42a098c4a820455050eb44.

git clone https://github.com/tomaszmrugalski/gitk-bug-emoji
cd gitk-bug-emoji
gitk

Actual behavior:

$ ~/devel-ssd/git/gitk-git/gitk
X Error of failed request:  BadLength (poly request too large or
internal Xlib length error)
  Major opcode of failed request:  139 (RENDER)
  Minor opcode of failed request:  20 (RenderAddGlyphs)
  Serial number of failed request:  3065
  Current serial number in output stream:  3148

There is a window showing up for a split second (too fast to even
notice its content), then it disappears and the aforementioned
X Error is shown in the console.

I've tried removing ~/.config/git/gitk, but that didn't help.

Expected behavior:

gitk should not crash. The window should show the git history.

It's very much ok if gitk doesn't show the emoji, but it shouldn't
crash. I've tried to look for existing bug reports, but couldn't find
anything useful.

System info (as produced by git bugreport)
git version:
git version 2.28.0.1022.gfdf196b997
cpu: x86_64
built from commit: fdf196b9972337a0285dae59f904f62f989fbca8
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.4.0-48-generic #52-Ubuntu SMP Thu Sep 10 10:58:49 UTC
2020 x86_64
compiler info: gnuc: 9.3
libc info: glibc: 2.31
$SHELL (typically, interactive shell): /bin/bash

The same error happens on earlier versions 2.25 and 2.28. Here's output
from 2.28:

git version:
git version 2.28.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.4.0-48-generic #52-Ubuntu SMP Thu Sep 10 10:58:49 UTC
2020 x86_64
compiler info: gnuc: 9.3
libc info: glibc: 2.31
$SHELL (typically, interactive shell): /bin/bash

Is there a workaround I could try?

I'm willing to help with debugging the problem or testing patches.
I'm not sure how long I'll be able to remain subscribed to this list
due to the traffic volume.

Other than that, gitk has been rock solid stable for me and I've been
using it for years. Thanks a lot for providing this great tool.

Tomek Mrugalski
