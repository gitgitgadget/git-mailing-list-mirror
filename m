Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2061A201A0
	for <e@80x24.org>; Thu, 11 May 2017 19:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751853AbdEKTln (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 15:41:43 -0400
Received: from mail-vk0-f49.google.com ([209.85.213.49]:36847 "EHLO
        mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751272AbdEKTlm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 15:41:42 -0400
Received: by mail-vk0-f49.google.com with SMTP id g23so7282798vke.3
        for <git@vger.kernel.org>; Thu, 11 May 2017 12:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=UhuWUDPoc1LEtg5ofo7mfMcDgK6V5TZiL6a+rZK3cJA=;
        b=cMcWew1oSic0m5lmIn8AhzSjmIKJQOcfKqXD5FwepGSh/BK7i9r7MggfEJWemK352g
         9QoxOWc8+0lFF44TRbWWQZ28zuxWn1+6sic2XprSixMsq/hA9l3FpnAyiN+Pzi6qpRfv
         1FSE44B+sSiI1f9FpHhqj120D81Bk6HwuWjaOHkb2LgLH18PkSAWR+Uc6HIPiFjzDZm0
         hX5nrqYNEzG93wKPgV7q2DXGP3VV5TU4Wm81pQheAn2mR0RRWgN8SSnKmfjhqJrwXzTG
         rPmViejuv2ziVZW5+LjVR7Sfpxm3znm2WLUvk/gaYrbJHeQyeW/rrk7dauCjilfibj2+
         6MIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=UhuWUDPoc1LEtg5ofo7mfMcDgK6V5TZiL6a+rZK3cJA=;
        b=oWZfqsqGhNb86AAiFG71aXey/b+9PHv+CScF/yhj3VXPJAs9zrMTav4LRa+7o32jEC
         /5Tqx4zyiCRYx2SzzGCK9kq7W9ycKtk/Rv5msP9slaNes5w7Ju3fD73mS2wRMVMSY6ch
         K/DANtmT7uXAGIT1vL/J4ub6qeJow9/i9k8v8P5I1jU/9XQlwLPr+YxFE7RC5q09PR1f
         Lm6rkWIfFgsOVs+i9Qozuaa62UAoMb1uA/8q1dNDpEeb1uMqqSiyj1+qGT8DK7damO96
         tpo4jO8eZP3WoFOqCRKGEMzOUTZHVF36NQ8EckGrqI+cv7CDavdIuOi5y90wUiqH7Otw
         wLtg==
X-Gm-Message-State: AODbwcDrxRQRTPIVPHYi5enqZ1bs+H136mjGtcEGCy1cao18WC/zgBdK
        i6OF4RKsqzzftw/juO1+jG8HsUxgvfUr
X-Received: by 10.31.96.8 with SMTP id u8mr153506vkb.124.1494531701890; Thu,
 11 May 2017 12:41:41 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.159.55.168 with HTTP; Thu, 11 May 2017 12:41:41 -0700 (PDT)
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Thu, 11 May 2017 14:41:41 -0500
X-Google-Sender-Auth: GEtH_ajd3KOx0Lh7rriFMoyE6t4
Message-ID: <CAHd499DjBHsWCf8h+i4EstR7qs-9hkO4En5-B-WA17DoPZQNoQ@mail.gmail.com>
Subject: Best "triangle" workflow setup?
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I know Git has evolved to support the "triangle" workflow model in
different ways, with the goal of making it better. However because
there are so many different options from separate push URLs for
remotes to various ways to manage tracking branches, it's not clear to
me which specific configuration suits this workflow the best.

So my situation is that I have 3 repositories: The original upstream
repository, a fork of that repository (also remote), and my local
clone of the upstream repository.

What I want (as a default) is for `git pull` to pull from the
same-named branch on the upstream repository, but for `git push` to
push to the same-named branch on the fork repository. However to
override this behavior for when I want to push directly to upstream
repo, I should be able to use an explicit `git push origin my-topic`
(but `git push` by default will act as `git push fork my-topic`).

What is the best way to achieve this? Is there a different workflow
from what I'm imagining that works a little better (in other words, I
don't need it to work *exactly* as I've described, mainly I just want
to avoid accidentally pushing changes to the upstream repo in the
default case when I want to push to the fork instead for pull
request)?

Thanks in advance for any advice.
