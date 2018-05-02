Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06EA321847
	for <e@80x24.org>; Wed,  2 May 2018 18:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751318AbeEBSAO (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 14:00:14 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:37548 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750930AbeEBSAK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 14:00:10 -0400
Received: by mail-qt0-f193.google.com with SMTP id q13-v6so18727775qtp.4
        for <git@vger.kernel.org>; Wed, 02 May 2018 11:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Rx1XaNf4skZdjTzBrIZeMu3D3v3F8TsbD+exOu0jj+I=;
        b=ApiIEuFMktDF7nPJ38xuITZKA22EK90Rtlyb156WLxIktwB8sokrc0puaUQjReN4pp
         VgaNbKbrTDZV3E5hiZr3lJK53dLs6zlEhrU6dg4ZrUSd3uVetcPfbgzuDpMXbLCNq0tt
         CF0UL3QcwM4OTZ6gTmI6gc8AJ0PkWlQJixSC9Iz4g4x3wbDfSxDo26sxI1SiQQMGhIbT
         k1BMxogIPwjqY/cwtzs0USmuR4EtUunsD4u50dUnECli+ZZO7hjswpviXkPoCI2hCv+p
         Kd5IXirDsvcliCYhUqVRltoCaMKSsLu8ufQoeUy7mkxbdbcod8UQMQ77epVpMu0sT1OT
         /L2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Rx1XaNf4skZdjTzBrIZeMu3D3v3F8TsbD+exOu0jj+I=;
        b=Lh2iNyPFPGVQca/kWiVuAI0+B8MXKIjwaOtVd1+KFz16HAYWu5292Hvde5OTKCwo8N
         LpDW/OostjwHFW9gsr5bKA8SFXlzdyLZ3NI3KWZ8nfXImvzs59rRiPry4gE3v4sj2t5C
         ZjlcAzJaxwedKIj+mcN1x3FFUhRPBLdj0r0c86SfvpDhlIXoZ5n64lHvfQN5qtkJ7Lg1
         Vze7esIaa38x9bxW5zTurlI99S6B6sSZpEIAvinHC/NNHpyv6Fu5ro6r9OFaMdd3HrY8
         NyTaQF5B8usEpNMynW5bTfHqlvnp1WT3BbbY1y/ozukBcSWyMZf/jCblGYPSCQaW8cNW
         MwwA==
X-Gm-Message-State: ALQs6tAg+uPtDylQSeNZMipzz4WwoKJmiOZwP2QAXKretaN9w9PNEYMF
        67t+Vak9oq+CSpG88kdlWBT6Xno0wQg1E9IOzXA=
X-Google-Smtp-Source: AB8JxZoujYJDlARDTnzUVVbrgc53b2RWqfgUuC2Da+vSyq6fKJ1jxjyW4/wbL16DJ4apkdgTizgHYLeCqe4PnytzR84=
X-Received: by 2002:ac8:3267:: with SMTP id y36-v6mr17012546qta.25.1525284009627;
 Wed, 02 May 2018 11:00:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.170.75 with HTTP; Wed, 2 May 2018 11:00:08 -0700 (PDT)
In-Reply-To: <CACsJy8Ae9PP8BMbyX5mPJukGpC06jMvvbg0fMFL+fu+EUg1kPw@mail.gmail.com>
References: <20180502105452.17583-1-avarab@gmail.com> <CACsJy8Ae9PP8BMbyX5mPJukGpC06jMvvbg0fMFL+fu+EUg1kPw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 2 May 2018 14:00:08 -0400
X-Google-Sender-Auth: D50od6g9fWq5q8sbgnXqQCHTqBI
Message-ID: <CAPig+cTZyYC-1_TxL2PrfOF6HAktUxxM+g5EXcByS5fCDMdCHg@mail.gmail.com>
Subject: Re: [PATCH] checkout & worktree: introduce a core.DWIMRemote setting
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 2, 2018 at 11:21 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, May 2, 2018 at 12:54 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> Introduce a core.DWIMRemote setting which can be used to designate a
>> remote to prefer (via core.DWIMRemote=3Dorigin) when running e.g. "git
>> checkout master" to mean origin/master, even though there's other
>> remotes that have the "master" branch.
>
> Do we anticipate more dwimy customizations to justify a new dwim group
> in config (i.e. dwim.remote instead of core.dwimRemote)?

A few observations:

1. DWIM has broad meaning; while this certainly falls within DWIM,
it's also just a _default_, so should this instead be named
"defaultRemote"?

2. Building on #1: How well is the term "DWIM" understood by non-power
users? A term, such as "default" is more well known.

3. git-worktree learned --guess-remote and worktree.guessRemote in [1]
and [2], which, on the surface, sound confusingly similar to
"DWIMRemote". Even though I was well involved in the discussion and
repeatedly reviewed the patch series which introduced those, it still
took me an embarrassingly long time, and repeated re-reads of all
commit messages involved, to grasp (or re-grasp) how "guess remote"
and "DWIM remote" differ. If it was that difficult for me, as a person
involved in the patch series, to figure out "guess remote" vs. "DWIM
remote", then I worry that it may be too confusing in general. If the
new config option had been named "defaultRemote", I don't think I'd
have been confused at all.

It may sound as if I'm advocating the name "defaultRemote", but that
wasn't the intention, and I'm not wedded to it; that name simply fell
out naturally as I enumerated the above observations.

[1]: 71d6682d8c (worktree: add --guess-remote flag to add subcommand,
2017-11-29)
[2]: e92445a731 (add worktree.guessRemote config option, 2017-11-29)
