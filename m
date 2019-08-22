Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLACK shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26DC31F461
	for <e@80x24.org>; Thu, 22 Aug 2019 18:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388771AbfHVS0V (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 14:26:21 -0400
Received: from mail-ua1-f50.google.com ([209.85.222.50]:35234 "EHLO
        mail-ua1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbfHVS0U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 14:26:20 -0400
Received: by mail-ua1-f50.google.com with SMTP id j21so2341930uap.2
        for <git@vger.kernel.org>; Thu, 22 Aug 2019 11:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=wIGloSgGCO446rTb9ovIAv69P7EWkueNf4jN3w/K+ys=;
        b=qUjwRC/KztXwWFMG+MgUUu80m5FbwFan/E3xygXUlToKaI3TtYw5/LK0E0s0abnjui
         z1japnaVc6L0S6FTSVeXLc3vFFe2AuV8HVsfq67AOp/7iIlm0bjYtA01IWTpLjCF6hf2
         sn+psiyWD6epmg86rlAPNy+L5pHcBk4RpkMX7+XtBsztD9zSTea7bwxR78jJGyKdLesc
         LS/trqEHa9G4y7Yj4G1AjXhQU2g+EpOen708mAS5sDRs7HLQa8slkUVLJzPNIudI+w+T
         IVSv9Y6i/ux8LOpCSzpugpPGSUi2NHoFSLipBv0L63+0c84G9+1dOWV4fPFDvK904vty
         rf1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=wIGloSgGCO446rTb9ovIAv69P7EWkueNf4jN3w/K+ys=;
        b=CqW6MSUSAAKBwe02Ju93iOQj1T9+3FlrVh/wa2AMLWkS9+jW9rTevZNz0OiqWXmBfH
         3h1fu+rWGFL1Wl2RzH9TEKAHc7+a/UHP1kQFDouh0s/XsJSmnA4HZjMQMA9wiWkFlgzX
         1Q4OHk7siOO1vE+WNHOopYLSKZHSKgKA/L6Wg8mNPFDe5Hni9f/zoGMYCdqB0fQqE0If
         UPvU90OLLKP/GTzx2/XLrLOfP3Bg7qVPRiQsxQLEbAX4td+GnfJqcovQBlNraOeL821t
         TJ2uOL7C1h/KV/8NUxdd9v2Bo5WlXsJGZ4VoGploRQ9VvK3UzEt5TvSW/ysfApmKRP6v
         payw==
X-Gm-Message-State: APjAAAWyaVHmzrJjYJ6a4XSLTVSVEqWDGdywUDAKyLtNSb/2Run+/8yA
        ZFCVr6VmB41rg+JIt5/uH0b2G5mXQIpmbRKO2BovZ0Cn
X-Google-Smtp-Source: APXvYqx64bKPM5/qm6hTxzC6ByBBs/VRb6KsNIJ9iNcFPzobGCQ7VO8UfbNUq1P+APhIMiKqnxMp/ehNOjiNxlcWDm4=
X-Received: by 2002:ab0:20d8:: with SMTP id z24mr604761ual.1.1566498379230;
 Thu, 22 Aug 2019 11:26:19 -0700 (PDT)
MIME-Version: 1.0
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 22 Aug 2019 11:26:07 -0700
Message-ID: <CABPp-BEr8LVM+yWTbi76hAq7Moe1hyp2xqxXfgVV4_teh_9skA@mail.gmail.com>
Subject: RFC: Proposing git-filter-repo for inclusion in git.git
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

git-filter-repo[1] is a tool for rewriting or restructuring git
history.  The recent Git Rev News article[2] on filter-repo introduced
it and explained how it is much more versatile than git-filter-branch
or BFG Repo Cleaner, and with speed comparable to BFG.  (I probably
also should have gone into more detail on how it is also much safer
than filter-branch).

I propose merging git-filter-repo.git into git.git.  There was some
previous discussion at [3], but the tool was incomplete and still
under heavy development back then.

Questions, comments, or concerns with this proposal?  Alternative
proposals?  If inclusion is acceptable, are there any other tasks that
need to be completed first?


Thanks,
Elijah

[1] https://github.com/newren/git-filter-repo
    or
    https://github.com/newren/git-filter-repo/blob/master/Documentation/git-filter-repo.txt
[2] https://git.github.io/rev_news/2019/08/21/edition-54/#an-introduction-to-git-filter-repo--written-by-elijah-newren
[3] https://public-inbox.org/git/CABPp-BFC--s+D0ijRkFCRxP5Lxfi+__YF4EdxkpO5z+GoNW7Gg@mail.gmail.com/
