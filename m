Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77BAC10DCE
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 14:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8525520775
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 14:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lastline-com.20150623.gappssmtp.com header.i=@lastline-com.20150623.gappssmtp.com header.b="ZHaffo7v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgCROnI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 10:43:08 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]:37358 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbgCROnH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 10:43:07 -0400
Received: by mail-qk1-f177.google.com with SMTP id z25so34190352qkj.4
        for <git@vger.kernel.org>; Wed, 18 Mar 2020 07:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lastline-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=GJAHydofpYHMeI1Twts7HfgivN+e2Vifhi7FNClfWo8=;
        b=ZHaffo7vVPHeMDXEe5+un4ES3Vlnn6N7S0qrdI9fSgp8QkHrURHCndeJfuFjli7RSW
         O8a4BTXSdwRJAMg/gfRuvBp01gywNMwyLj4aZy/IhetNeihNm0sTx+at+TLtuFAI6osd
         Nw+7svHub2YMZ97btK40d0rOnrl/DmcsRRFKkqFPIQ3/Sj4yrdDU73+aGzAy+iHr+pmz
         fwu2zeYJYL9MyFWqlez3ECq+1Yku5IqT943WGyL/Ahn4SbwltCKhoe+ji0Rxf99rOVeK
         4dDKsyWdb+KZH7DcfMtmoU4BRArnYCLsl/81pjB1nzvPijanAabA674y9htbNJO16ToQ
         601w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GJAHydofpYHMeI1Twts7HfgivN+e2Vifhi7FNClfWo8=;
        b=Hog1kIqbMvliwLn/iF7s0PApdqprebY4Js1QSMrrFqdj7/cPPkOh6knwu+U3MSwTJt
         5LI8xKgJZOqkSrmdN8FEfre1eeH4tq7HSMqUhfAvGlX0gtQSal+KwOpd+zjY2hPnWhno
         fayB31sOjqL+B2SRKBFW1o4XnN7wsKZaqXaWLTcf9xALzihUms10W4DQZpWi/OZRqSEG
         fY0+tJX5G7G1/643hEMd+lyg1KRFZ9NN7wdzlo+ES0r96K8z/papbxD8jPR90SFJawnb
         FF6N1r1W2jgq33fFf3zITlUhwgfs8gM2vvMv3BPwyTqXp3p/W8k3Z2hdebxbF198QtYb
         SSJg==
X-Gm-Message-State: ANhLgQ09WVJyqq8DBwGo/xbWKRQ3XlVS9AzqI0lGjyHrgA5PZED4mjrd
        HJCn2YuA2W+A+ggUQVh+R1MplQ80eG33GHdlGqPOjLeRJTM=
X-Google-Smtp-Source: ADFU+vt2Cd+KOgW2gqT6jJkAwpjDOBAjv8ybsv9isHPegmqnoIJdkR5NkZDGErhWUV11jAGzCrAhyYttMTSKKnAoTXs=
X-Received: by 2002:a37:8101:: with SMTP id c1mr4290302qkd.236.1584542586277;
 Wed, 18 Mar 2020 07:43:06 -0700 (PDT)
MIME-Version: 1.0
From:   Andrea Wyss <awyss@lastline.com>
Date:   Wed, 18 Mar 2020 07:42:55 -0700
Message-ID: <CAB8VZwTXVXHOf_WuU9goDaJRCdTnKeeQfL4hYn2PNQjhbYR9=Q@mail.gmail.com>
Subject: GIT bug: "amend param is not available to pre-commit hook"
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Issue
amend param is not available to pre-commit hook.

Problem
Cannot write a pre-commit hook that stops amending a commit that is
present in other branches.

Steps to Reproduce (git version 2.21.1 on macOS 10.15.3)
1. In the pre-commit hook:
   echo "DEBUG 0='$0' 1='$1'"

2. run:
   git commit --amend

Result
   DEBUG 0='.git/hooks/pre-commit' 1=''

Expected Result
   DEBUG 0='.git/hooks/pre-commit' 1='--amend'

Please, let me know if you need other information.
I'm looking forward for a fix or workaround.

Thank you,

Andrea Wyss
Sr Frontend Architect
www.lastline.com
