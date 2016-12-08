Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0275A1FC96
	for <e@80x24.org>; Thu,  8 Dec 2016 10:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752319AbcLHKSm (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 05:18:42 -0500
Received: from mail-wj0-f182.google.com ([209.85.210.182]:36779 "EHLO
        mail-wj0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751845AbcLHKSl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 05:18:41 -0500
Received: by mail-wj0-f182.google.com with SMTP id tk12so89559047wjb.3
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 02:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0m9apxdyYHMBL9Je6slNdMdpiN4lU20TDQvJnaDu8C0=;
        b=N7dXc8oUT+bDGeWpFckI+SOYmNPl3hdPEFHYDPvSvlmbbp05umOWF6KnwY3EYYt+PE
         kiW9pIm9UhYlRw2mRVccMDCEmBRMQyk1DPRYC1IvOHZHTCW5EWpcqMn3wClxKLUrecmt
         VplYExXYmG7HvHhQb9rTnXaZk0xwf4Lp9yb8rFCs0reoX6WzN33eC5fbbcx8tyGvZnhl
         XQMqNDFapMpQWneHvQBkN8gvpTpRsezsgpmFZoD7rDS5bfHEtoq6KzZLeXTkIbfGkQTv
         1fEBIZnvBwgzT052o7LdE66aIxghpiKCo2vRJ/9VPljJjuhxI54sdhzLPpp/kymv07be
         o38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0m9apxdyYHMBL9Je6slNdMdpiN4lU20TDQvJnaDu8C0=;
        b=KOY+abfoVRzn7waJO3Ql0tRJeAjVqzq5IkKaoBwgObFwzssKfB+HQNbvCFjN4ll9r0
         rCcNkv998h+UP5hlYoH2/qW3sMLpYMrMwDvyR3btyjZFzUXr2OOPq/h3PXPQ4b/etczi
         fCDlHjG5JSps5bwlXEH2WWqitsdiCESDLxxVS7lJtie6CVk2qUsES4eFpmW8e5hKXRDa
         gMOjliabhCLd+w7B14somM8Ln2sjbXme3rPcdX4BH+TYnXWt+MNodLo5i1811clR/0zH
         xTe59igFxL9OEs9BjxFsBvHopDRbR+Y9pr8SMA3bT+Fag4TmXTovHqTlpxgE+IIHWb9r
         /Xdg==
X-Gm-Message-State: AKaTC01Cq1r1L/l4VCDmQDYo71BavWVRcfe2HN0XIY1va7k5xJeaYWKJwxmq7WRwIa+3GaGhJLoOnlWsPB5jHw==
X-Received: by 10.194.80.42 with SMTP id o10mr74802456wjx.65.1481192320350;
 Thu, 08 Dec 2016 02:18:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.179.188 with HTTP; Thu, 8 Dec 2016 02:18:39 -0800 (PST)
In-Reply-To: <CAGZ79kZHGqU2y19_uKhtVuE6vhspzPNpw-nVDnm8gLQ8u528kQ@mail.gmail.com>
References: <xmqqd1h3y506.fsf@gitster.mtv.corp.google.com> <20161207194105.25780-1-gitster@pobox.com>
 <20161207194105.25780-2-gitster@pobox.com> <CAGZ79kZHGqU2y19_uKhtVuE6vhspzPNpw-nVDnm8gLQ8u528kQ@mail.gmail.com>
From:   Paul Tan <pyokagan@gmail.com>
Date:   Thu, 8 Dec 2016 18:18:39 +0800
Message-ID: <CACRoPnRpZr=E6SW81Vg-2TiOr=RJo1YouAt5iZoE0CNBx-qesg@mail.gmail.com>
Subject: Re: [PATCH 1/3] wt-status: implement opportunisitc index update correctly
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, Dec 8, 2016 at 4:48 AM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Dec 7, 2016 at 11:41 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> The require_clean_work_tree() function calls hold_locked_index()
>> with die_on_error=0 to signal that it is OK if it fails to obtain
>> the lock, but unconditionally calls update_index_if_able(), which
>> will try to write into fd=-1.
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---

Ah, sorry about this. I was indeed misled by the function naming and
its comment ("do not complain if we can't"). Should have looked more
closely at the other call sites.

> However I think the promise of that function is
> to take care of the fd == -1?

Hmm, to add on, looking at the three other call sites of this
function, two of them (builtin/commit.c and builtin/describe.c)
basically do:

    if (0 <= fd)
        update_index_if_able(...)

with that 0 <= fd conditional. With this patch it becomes three out of
four. Perhaps the repeated use of this conditional is a sign that the
0 <= fd check could be built into update_index_if_able()? I think
there is precedent for building in these kind of checks --
rollback_lock_file() also does not fail if the lock file was not
successfully opened.

That said, the number of call sites is quite low so it's probably not
worth doing this.

Thanks,
Paul
