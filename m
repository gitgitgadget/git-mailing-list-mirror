Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 914E81FC96
	for <e@80x24.org>; Sun, 27 Nov 2016 02:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753091AbcK0Coj (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Nov 2016 21:44:39 -0500
Received: from mail-io0-f172.google.com ([209.85.223.172]:33974 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752505AbcK0Coi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Nov 2016 21:44:38 -0500
Received: by mail-io0-f172.google.com with SMTP id c21so174124393ioj.1
        for <git@vger.kernel.org>; Sat, 26 Nov 2016 18:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=3Xoj2BrrtB3qRQOY919d5uNlFZPDmvknmuRcTl87SsE=;
        b=VFaPFvSe4zeaeyIG3zrAW1JUriXBSRSJIArOXcIqRLwAy8Yn4gYGk7Nrqv1WLwfnTb
         k2fR0uCz3cZOktbkenDEFiMD5nwVmxA8AihPZUGtcQkOLx/44Yv+nyRcfkRzuldTUiMi
         TeBuSddVEklsUf6pKwDeD2pjeuvoex3Tkso+/Oupu+fdgZYBzvvNgRz8htJxt76V98ls
         ATuY4/UT9nduEFujmbyG94hT8tF23/thA47H+E1iuCMJJzDwLeItfo4Ihkr4/PeC9sG7
         s2CVBINpiJp8KJvbE8FB5dCuGM6WJn069ZVbc/lv0jIGIFLXp0GNH/eK2ux31UrIxU44
         Fqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3Xoj2BrrtB3qRQOY919d5uNlFZPDmvknmuRcTl87SsE=;
        b=bC9KS23VWoIRSqm3Iib0RHwwlcJVAdKPSw1Y8onU40KgvlnNm7U6RbqC4V9jAA2HwY
         yzxoJfGfZzs7DAnn+rX6koBOztaV34b7AbvPA8B4TClQaS1hO15Qs9x9uVu774A5dv/u
         BgTWEV7tOlzqI5+7iY7cyJATyKO5iXd7GwJT6js1SZY6OQDR/7yti8LiFPPd2/udYvra
         6hXJxdYMFGxMAOE84kz8J/OdOJkiLjTv6cqf0zLtDFQRuGe2vguAmsWS6htNdbFD1llP
         nP/ZRYjtMP4pDUMg4/H833yxDEE65u/NrXJljMzpzLAWprw3J040hcFlpCMo3JyHWtiX
         QbDQ==
X-Gm-Message-State: AKaTC01FtJlC2lIaxm8hwqFhA2cDXFXPz2QenLnjYWSfWFiKTw00axc+ApBT/9ztrN6g5MNfRoxKssjDW5Bnkg==
X-Received: by 10.36.125.198 with SMTP id b189mr5057589itc.88.1480214677362;
 Sat, 26 Nov 2016 18:44:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.160.199 with HTTP; Sat, 26 Nov 2016 18:44:36 -0800 (PST)
From:   Dun Peal <dunpealer@gmail.com>
Date:   Sat, 26 Nov 2016 21:44:36 -0500
Message-ID: <CAD03jn5PAZcFeesaq2osjo7cYd1frWZeN0odNqTh+AMxSEmLgQ@mail.gmail.com>
Subject: trustExitCode doesn't apply to vimdiff mergetool
To:     Git ML <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm using vimdiff as my mergetool, and have the following lines in ~/.gitconfig:

[merge]
    tool = vimdiff
[mergetool "vimdiff"]
    trustExitCode = true


My understanding from the docs is that this sets
mergetool.vimdiff.trustExitCode to true, thereby concluding that a
merge hasn't been successful if vimdiff's exit code is non-zero.

Unfortunately, when I exit Vim using `:cq` - which returns code 1 -
the merge is still presumed to have succeeded.

Is there a way to accomplish the desired effect, such that exiting
vimdiff with a non-zero code would prevent git from resolving the
conflict in the merged file?
