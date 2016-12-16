Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 078E61FF40
	for <e@80x24.org>; Fri, 16 Dec 2016 18:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755850AbcLPSmN (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 13:42:13 -0500
Received: from mail-it0-f42.google.com ([209.85.214.42]:35827 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755951AbcLPSmL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 13:42:11 -0500
Received: by mail-it0-f42.google.com with SMTP id c20so23247134itb.0
        for <git@vger.kernel.org>; Fri, 16 Dec 2016 10:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=MMUNm6jNrUo/gMaqf7JhKho2i0XTFcBQtoFRXJoAdXY=;
        b=pmlC/4S86ZYlYWXJDCOclMQ9OSjBxM6m2KhEtWGI9Nc9+rbVQilM1dRXri43B0WrUj
         lYGCCXCVQ6Bpjd4jQH9yx4gvTKyx4C+lZtaKu8B3vGzT2q5or40jStowL7pUGqEBrTf5
         EQsKMRHWEwTXZviE9sM2+R30BQhEe4PRuchwNwpv9al0N59+vDpZYN3ddJuS/rcPouxR
         +To+ejGaUig4cGiZLgQNLvwoQEgJn4aWWmsprQ7M2xZijngCVd8zrjcFCarcHDR1Ld6Q
         d/O+doycuzaftvHVEsAmJb4QKiJjsLxD173hBfUKc0xsY0iyvvyUSx/ob8C5Fi7s1i5U
         0ZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=MMUNm6jNrUo/gMaqf7JhKho2i0XTFcBQtoFRXJoAdXY=;
        b=CwdpM1LpkIg7eKYyduaRuWR5HiE07PqYJZCsWFB3ypyTvNLUtDmpwan7AZpop52hdi
         juE2M7MRzIi8BN255Vq/kuo96MUJmONCnVdXnAJaHKVExgf07r+IOUjF1CjGiLu4jJyQ
         FNty5L+mHWXXppco/dkHKm+1wg9Umofo/GLNvmeBrcgIzkN9Fz8ThE2zyMa4qbGoJON1
         ckmjaQsP11uaz2YEbaIhHY/N/14DFdsOzpzV3pM5QQUbiYYRSuWOrqUwAIV4FUrNpq92
         SlfrWyY+FI9cO2eHkwd2xlwpriHycSXCIGd2YFxbjdDq9aA6yFA2N/7HySXk9+m1oEpo
         vfNw==
X-Gm-Message-State: AKaTC012Jv3UpjVUKpF2dSs5PjBFTk4TLvyWEa/4mq23gdkCsao9MJVO9nThJ94kiLADOmc9kNBrDWGBVZ+nkA==
X-Received: by 10.36.82.22 with SMTP id d22mr4187917itb.53.1481913725408; Fri,
 16 Dec 2016 10:42:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.87.169 with HTTP; Fri, 16 Dec 2016 10:41:25 -0800 (PST)
From:   Josh Bleecher Snyder <josharian@gmail.com>
Date:   Fri, 16 Dec 2016 10:41:25 -0800
Message-ID: <CAFAcib_cY8FeLFkW1=MfR+P7xoupGK9DFegNY5boExHSRppAmg@mail.gmail.com>
Subject: Segfault in git_config_set_multivar_in_file_gently with direct_io in
 FUSE filesystem
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am using git with a simple in-memory FUSE filesystem. When I enable
direct_io, I get a segfault from
git_config_set_multivar_in_file_gently during git clone.

I have full reproduction instructions using Go and macOS at
https://github.com/josharian/gitbug. It also includes a stack trace in
case anyone wants to try blind debugging. Happy to provide more info
if it will help.

Thanks,
Josh
