Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BE0620282
	for <e@80x24.org>; Fri, 23 Jun 2017 19:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754796AbdFWThH (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 15:37:07 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35323 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754773AbdFWThG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 15:37:06 -0400
Received: by mail-pf0-f178.google.com with SMTP id c73so27661095pfk.2
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 12:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FT3YJ3fDDzH04vlEpwOkSQgRHOmSgUffydOX2ItViyw=;
        b=dDIjgEs3y6YMWdzy/e9esEN92KKc8/7vAzwZxfgSFGxMIOTD4P3qGf/jbdumzJesLb
         rlQc5D0FrhWgSDUENlx2nsOK5QaqqsnaQWrnlXlK7E9UrzTRzsRhZAc9K8I/cXyKBvY0
         IwkWveWi7upC1PzGouMiS8BLFSD6Sm5LtwpYquAYRXADfiCUbr7BCPfVHZX2jA3NOKG8
         TIW6H7XX0TDFwNTgcXHO85awoZGYVNfOOuplRh0aayXidOwBp3XyvhoFiNxNqnGSeMZ5
         iASH8mtP3Wme/Dy2kjCeG5OLouwBAXyUYGvGThfbS52SlpAK+zl1lDPCrhMEZME4Z6eK
         Lh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FT3YJ3fDDzH04vlEpwOkSQgRHOmSgUffydOX2ItViyw=;
        b=YO8TQD1bXZPIKExvIYoVRgFdYGgXNK18k4zGRiC2daDbxOE1owwFacxWBwAlqtoynR
         RSiJOOKn2mpM1CAngWUdjdyIJGMBLUy2wv2HTFDa2m8qbkP0/fhaVk6u99cuuJjUsSFN
         D85CJFdH3Z/+X2RqzPhj4kB4LaAjkQDjPeu0zjLLvxyp8Lc527Pl2s+D660wd/FGUUmw
         047xNvCnlkpKzZ1sKn7m8eBXfXSTk9bH2qwO+/e4utInfMcKGbN2Fmy1FFTQ8MaSS9Wq
         tl+ZXsyTAZPcNqso7ItLryEbJmvxFyeEJv0plIKTVel2Hgknijl07AAW6mBt5KPZ1Xdw
         A1nw==
X-Gm-Message-State: AKS2vOy3TdFUxKqmDN9gtd4KbY1olx6kemjhPR5tWedF1aKg2jDBC9AF
        vxSwy8XQy6WJu8+8sRIFw4/Nxf3BeMjG
X-Received: by 10.84.209.228 with SMTP id y91mr10778355plh.210.1498246625579;
 Fri, 23 Jun 2017 12:37:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.161.227 with HTTP; Fri, 23 Jun 2017 12:37:05 -0700 (PDT)
In-Reply-To: <xmqqinjmecuk.fsf@gitster.mtv.corp.google.com>
References: <20170623103612.4694-1-git@thequod.de> <xmqqinjmecuk.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 23 Jun 2017 12:37:05 -0700
Message-ID: <CAGZ79kZb+ziJGx6GvSVwX85Szce0zT=2gaF1GpPtz8ft1uhdPw@mail.gmail.com>
Subject: Re: [PATCH] xdiff: trim common tail with -U0 after diff
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Daniel Hahler <git@thequod.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 23, 2017 at 12:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Daniel Hahler <git@thequod.de> writes:
>
>> When -U0 is used, trim_common_tail should be called after `xdl_diff`, so
>> that `--indent-heuristic` (and other diff processing) works as expected.
>
> I thought common-tail trimming was a hack/optimization to avoid
> having to pass the whole thing to have xdl_diff() work on it?  What
> would we be gaining by unconditionally passing the whole thing first
> and then still trimming?

So I tried finding out more about this hack,
and found the patch that introduced the common tail trimming at
  https://public-inbox.org/git/7vmysez0oa.fsf@gitster.siamese.dyndns.org/
  913b45f51b (xdi_diff: trim common trailing lines, 2007-12-13)

In the early days there were much larger email threads apparently.
I haven't seen such a big one in a while. I did not find the email that
the commit message referenced to unfortunately.

AFAICT we have 2 things going on:
* swapping the order of xdl_diff and the tail trimming
* change the condition under which the tail is trimmed
  (as a logical follow up/ cleanup because of the first point)

I do not understand the first one, yet.
