Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 715CE1F405
	for <e@80x24.org>; Wed, 19 Dec 2018 03:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbeLSDJw (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Dec 2018 22:09:52 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:39318 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbeLSDJw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Dec 2018 22:09:52 -0500
Received: by mail-ot1-f42.google.com with SMTP id n8so17794090otl.6
        for <git@vger.kernel.org>; Tue, 18 Dec 2018 19:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=PB5pGT/5PWBndAFZRKm/DIQ4EHYk8PO/vcW+Hf8RR2M=;
        b=srAkXzDhgR6UE9QojlYXlb6t4taLTor9B2PlQaO1Abvt3mJ0Reu6UEgy0pxJbh7VSY
         XGGz+4XyRuMLBIX5vE0zuhjiyOWdii+zHXbG4znH59ZaCqg2WKd8Kp1QoXPfP46toawi
         GCMEPWZjSmdf75fVHF4GhaqWuf4l3GHU8+Qxkd10QVcY52bRqWbtO+w1OcEfJJYiqvg5
         yMZoQMBtWZgxzppCbjxD91Ueyo+S6aqR8WCZuFgscujGYDhyTBaFyaV02KuuvuKz4gji
         8xgzskO+LCVFaCD6vkVKwlf0BMBFufd/oXO6JkV8zKbVrgU98qtl5MoRfEIbwqAQ+jqw
         5d2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=PB5pGT/5PWBndAFZRKm/DIQ4EHYk8PO/vcW+Hf8RR2M=;
        b=XFfygvUn2pR9J1mU2AUTY5hNYjfCRRV2FksKB8yPzFuGdLrcCe7PSm782gWGvZ42YO
         EJEmRMkhxKKuvaWSIH/3ZGifxYTQd7gsQCYEr54kIktCM+hS+orLQmKfPic86mhlbzx+
         f12KdmBVK1/u/q3bnGdDic0SvOfbMB7k92tQaxZonOMCOgNOw7gCp7D6Lx1g6Ec/7wNi
         y2ASEXesmZ6T/fifQUlkYqWk3r12zE2jtLh1wvm3kWpYEgW7fX/g6xupPvzc+kzIJZzJ
         vx47IZqBdVMok08jAof4iWCDgLj3CYuofURDXZtGgwKayx1H2TbUUhhS5l8Kg9b+Z1VK
         Nekg==
X-Gm-Message-State: AA+aEWb74vwFRfAGd0cNKd11LMZHGrvLbp4uOC4gB1DG69HKKToG6UWi
        +X7P1CSPHTjyz9otXQ4A7eOUjJIyob6Zhl+5WEE3JQ==
X-Google-Smtp-Source: AFSGD/XsrSSh2a7J6LrQNKbkZDasAhtLpnW3rx1YuYoo9FJ4C0Jkox4VCzt1xiFx7YMvM0rdTxUDICjmFWrveWp9utw=
X-Received: by 2002:a9d:2c65:: with SMTP id f92mr14089255otb.18.1545188991432;
 Tue, 18 Dec 2018 19:09:51 -0800 (PST)
MIME-Version: 1.0
From:   John Passaro <john.a.passaro@gmail.com>
Date:   Tue, 18 Dec 2018 22:09:14 -0500
Message-ID: <CAJdN7Kioa22xrDP2ssZXmBbu7KDkcr2MQCUDW=Tzm5ydzeChBQ@mail.gmail.com>
Subject: Can git choose perl at runtime?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I recently submitted my first patch using OSX and found the experience
frustrating, for reasons that have come up on the list before,
concerning git-send-email and perl dependencies that you need to be
root to update.

Last seen here:
https://public-inbox.org/git/878t55qga6.fsf@evledraar.gmail.com/

The struggle is that Mac's package manager Homebrew has opted,
apparently with some finality, to no longer support linking to a user
perl at build time. PERL_PATH is hard-coded to link to the system
perl, which means the user needs sudo to install the SSL libraries
required for send-email. So for send-email to work, you need to either
sudo cpan or build git yourself. The obvious solution here would be to
do /usr/bin/env perl, but in the above message Aevar pointed out
pitfalls with that.

It seems that choosing perl at compile time necessarily comes with
tradeoffs. So I wonder if there is a way we can support choosing a
perl at runtime without breaking the existing mechanism of linking to
perl at compile time.

I'm picturing adding an executable "git-perl" to libexec that checks
config core.perlPath and envvar GIT_PERL_PATH, in some order. Having
chosen one of these or the build-time PERL_PATH as a last resort, it
exec's the correct perl executable.

Then relevant scripts (e.g. git-add--interactive, git-send-email)
invoke git-perl instead of /usr/bin/perl, and the makefile no longer
replaces that with PERL_PATH -- instead that will be used at runtime
via git-perl when we can be sure the user does not explicitly prefer
something different.

That does mean we have a new command to support and document: "git
perl". If it is preferred to keep this hidden as an implementation
detail, we could call the executable something like "util-git-perl"
instead so that it doesn't show up when scanning libexec for git
commands.

Does this seem like a good idea? I'd be happy to work on a patch.
