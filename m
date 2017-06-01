Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99C2720D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 22:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751130AbdFAWp2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 18:45:28 -0400
Received: from mail-lf0-f46.google.com ([209.85.215.46]:32976 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbdFAWp1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 18:45:27 -0400
Received: by mail-lf0-f46.google.com with SMTP id a136so20293665lfa.0
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 15:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=TGIRfr0q6MJPe0xZYEX5EmfbWOXgUm3Su94QqIjP3Q0=;
        b=rDJQiDaG7RxBUBr895ufW9CocGuPwWhu7ubFp4PELuK8djzSVHcJ77kIjC8YLJP73m
         FFcWRIUf+Xk1orh/regzZ4/Elp/rbrVzetQPYR/+F8Z+PmSfqLNQktjCKwh80DQeZsUT
         vW5cbfu1XfTGNbp6HHgxv+e/h/W9A86ytWNoc268Llk0dqLuLsa4epxXbvxYQelQjbyj
         DttAT0YB4KP4en4ntl9lHV+UuFHoUYpRiB6w538cEm/Oc//CoutgPiH8th5vwwhxVKIp
         F+JOSlF09+DDIc1Fx3bm1JPuIPNeccawHrXVJBlJsmPSG061VgVuTtAVVIyLXHnDnCE7
         bVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=TGIRfr0q6MJPe0xZYEX5EmfbWOXgUm3Su94QqIjP3Q0=;
        b=gusUYugQQXOCWIU2R5vyLl1JHXqFq7N6ZG5LvjrjebCP/3aBYP/JDmu6CnMVjxmKE+
         onBYzaFXVuTb6tR2oNAfSx29kGjabLNuUnSbq54JWmHLNEgGYCWM18jXfvVcUfO1e3Lz
         QTxV/hirzHvXiIL/j98tsPDzstdUkRkJsYWZ8G564u4Qo/t9c3y58ZJNKrqm0QCU3Dtr
         sZWg1ZaxSCHN1bFczHM5kgRVfwZFzHpnXo42J68tZ7irGfWcq+D/X1IBIx2NPCdqckW6
         j4uUMAkX8Y/WC6TU+2bsefcgS6rh+BEkP8sZCrLsqEy5bdX4eKPOWD6X33OYL4IxUMry
         +MZQ==
X-Gm-Message-State: AODbwcA2DQfNZ3LgmmGCybBGeInckkKt4PCUk31bwgj1GppNv5OGs8wI
        45f6x6TzQFpfAhemrNOXHrGPGa+5HGj94Go=
X-Received: by 10.46.97.18 with SMTP id v18mr1318519ljb.123.1496357125414;
 Thu, 01 Jun 2017 15:45:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.32.133 with HTTP; Thu, 1 Jun 2017 15:45:04 -0700 (PDT)
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 1 Jun 2017 15:45:04 -0700
Message-ID: <CA+P7+xr39qk9qHE0=uU3HZE2wOhU9X7rmENoDfP=bp09j9N9Mg@mail.gmail.com>
Subject: git-send-email no longer works outside a repository?
To:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I often use git-send-email in order to send patch files. Recently when
I tried to do this outside a repository I got some cryptic failures,
I'm using the master branch, git version 2.13.0.311.g0339965c70d6

I generate the patch files and copy them into a separate folder
outside of the repository, and make sure everything looks good and
write a cover letter, then I try to send them with

$git send-email --to=<address> 00*
Can't call method "repo_path" on an undefined value at
/home/jekeller/libexec/git-core/git-send-email line 1759.

Even weirder, if I move into the repository and try to send files
which are outside, such as:

$git send-email --to=iwl<address> ../patches/00*
fatal: /home/jekeller/git/patches/00*:
'/home/jekeller/git/patches/00*' is outside repository
format-patch -o /tmp/AZatqXB1uD /home/jekeller/git/patches/00*:
command returned error: 128

I would expect that if you're outside a repository the command (as
before) would alllow you to send files. It shouldn't strictly need to
be inside a repository to function.

I found this first on pu, but as above, I checked out master and still
seem to have the problem.

I'm working on a bisect now.

Thanks,
Jake
