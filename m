Return-Path: <SRS0=OIeF=BS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2D5C433E0
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 11:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF701221E2
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 11:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="moVhMHmR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgHHLYl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Aug 2020 07:24:41 -0400
Received: from out0.migadu.com ([94.23.1.103]:35238 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbgHHLYj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Aug 2020 07:24:39 -0400
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
        s=default; t=1596885871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=rutOolJAiMlm9uCeV52k7v/eCytVnhr7sU1OMZLqALM=;
        b=moVhMHmRwqZNSDF6D+of8eRrRSY3oRUiXAHsQizINCg95HZys/YyqQ9dkf4OxgcPepqwxA
        qmwuFDTy52qzcqTAOU7jK0leLsvhh/+0wmnVKxyzA3pvrmUc54gRj5zvytgpSPK+0Tn0hX
        prewhgVZORYWvSROQrGJtqnFP5TgR/I=
Content-Type: text/plain; charset=UTF-8
Cc:     "Junio C Hamano" <gitster@pobox.com>,
        "Git Mailing List" <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] diff-lib: use worktree mode in diffs from i-t-a
 entries
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Raymond E. Pasco" <ray@ameretat.dev>
To:     =?utf-8?q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 08 Aug 2020 06:46:30 -0400
Message-Id: <C4RJZM9BYO1C.21M5GRE871JIN@ziyou.local>
In-Reply-To: <CAN0heSoVs+ApvanSOGZJeOvy5DNEMrMAZ41BKUkchmfVE2kTjg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat Aug 8, 2020 at 4:48 AM EDT, Martin =C3=85gren wrote:
> Describing the current state of affairs and using imperative mode, it
> could be something like:
>
> When creating "new file" diffs against i-t-a index entries, diff-lib
> erroneously uses the mode of the cache entry rather than the mode of
> the file in the worktree. Change run_diff_files() to correctly use the
> mode of the worktree file in this case.

I see both styles around in the tree (past for the state of the world
before this patch, present for the state of the world as of this patch,
vs. present for the state of the world just before and just after
applying this patch). Neither is unreadable to me so I just want to do
whatever's the standard around here.

(I'm not convinced, as a matter of grammar, that the
commit-message-present verb form is really in the imperative mood; I
think the freeform nature of English grammar obscures that it's the
present active infinitive, analogous to, say, the fact that a French
software program with an "open file" button will say "ouvrir" and not
"ouvrez".)

> I can confirm that the bug is there before your patch and that your
> patch fixes it. Could you add a test in this patch so we can trust that
> this stays fixed?

The whole set of i-t-a diffing behaviors needs a test suite (unless I've
grepped very poorly), which will come in another patchset. t4140 in this
thread's main patchset assumes they work.
