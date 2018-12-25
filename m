Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6617B211B9
	for <e@80x24.org>; Tue, 25 Dec 2018 12:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725896AbeLYMj6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Dec 2018 07:39:58 -0500
Received: from mail.javad.com ([54.86.164.124]:45046 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbeLYMj6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Dec 2018 07:39:58 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 2F8733E97A;
        Tue, 25 Dec 2018 12:39:57 +0000 (UTC)
Authentication-Results: mail.javad.com;
        dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=javad.com header.i=@javad.com header.b=LcQIdZBa;
        dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1545741597;
        bh=0Qp0h5wPuXJuSXK2TvP5fFiaiRb8mR4r3+NGjXVvWvA=; l=1202;
        h=Received:From:From:To:Subject;
        b=LcQIdZBaPG3VKYnQosOAPSTx1eQD2or4g/psWzW2qjq5j2gtDwpA2GFqxf4n1kqE9
         ZdNAMEHAIMLE065ulKlQvELnQCG+YhPW99ZiKRndsXEoL/5ZxffiIGnCiL0XhySlyR
         OOJO8y+qml0Tdh4/oXIv8hAO9dz3wycGJHlVQBpk=
Authentication-Results: ip-172-31-2-110;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (ip-172-31-2-110: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1gbm03-0000MJ-IS; Tue, 25 Dec 2018 15:39:55 +0300
From:   Sergey Organov <sorganov@gmail.com>
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Allow 'cherry-pick -m 1' for non-merge commits
References: <xmqq5zvwesvz.fsf@gitster-ct.c.googlers.com>
        <cover.1544762343.git.sorganov@gmail.com>
Date:   Tue, 25 Dec 2018 15:39:55 +0300
In-Reply-To: <cover.1544762343.git.sorganov@gmail.com> (Sergey Organov's
        message of "Fri, 14 Dec 2018 07:39:03 +0300")
Message-ID: <87tvj1ok4k.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

What's the status of these patches?

Thanks,

-- Sergey

Sergey Organov <sorganov@gmail.com> writes:
> When cherry-picking multiple commits, it's impossible to have both
> merge- and non-merge commits on the same command-line. Not specifying
> '-m 1' results in cherry-pick refusing to handle merge commits, while
> specifying '-m 1' fails on non-merge commits.
>
> This patch series allow '-m 1' for non-merge commits as well as fixes
> relevant tests in accordance.
>
> It also opens the way to making '-m 1' the default, that would be
> inline with the trends to assume first parent to be the mainline in
> most workflows.
>
> Sergey Organov (4):
>   t3510: stop using '-m 1' to force failure mid-sequence of cherry-picks
>   cherry-pick: do not error on non-merge commits when '-m 1' is
>     specified
>   t3502: validate '-m 1' argument is now accepted for non-merge commits
>   t3506: validate '-m 1 -ff' is now accepted for non-merge commits
>
>  sequencer.c                     | 10 +++++++---
>  t/t3502-cherry-pick-merge.sh    | 12 ++++++------
>  t/t3506-cherry-pick-ff.sh       |  6 +++---
>  t/t3510-cherry-pick-sequence.sh |  8 ++++++--
>  4 files changed, 22 insertions(+), 14 deletions(-)
