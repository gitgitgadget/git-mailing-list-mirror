Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4E7E2023D
	for <e@80x24.org>; Wed, 17 May 2017 00:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751531AbdEQAwA (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 20:52:00 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34878 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750950AbdEQAwA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 20:52:00 -0400
Received: by mail-pf0-f172.google.com with SMTP id n23so83531109pfb.2
        for <git@vger.kernel.org>; Tue, 16 May 2017 17:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=AnsHp68LQjO5GhcVjzemQgqKiqH15mD+B8+dqY8LwLs=;
        b=BXHzpS1ojM+12HN8cu2pN3YxjODxDVdObYvJpKdeFdAzJVRhIrWtsjOfbGXgahO0dt
         wePwayOKyD5QyhWzMAzu3MkSOpBDqSNO3ITVMlzs3R7g2FT4i8LcZCSDHo6nLOpe74ef
         ObpjSoWkeqYjyW2ExPtypWLMPyzWyynLfxsVBdeT0Df/L12mwhOoBAv4ljMktq1SLCL6
         GlxBSAC7sL9snDKG0nI1eDaJEsM8dZAROF+HCnWUC4L1E7HpF4ZHQjhQAPRNsbk4qZID
         bvBiiULDXaZUBVhKPn0JUIg8GF6iRqyK6cll94ok81zzvFXVNy0xPvTamEUAmzrROKgT
         UD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=AnsHp68LQjO5GhcVjzemQgqKiqH15mD+B8+dqY8LwLs=;
        b=uEwQ46J50b1XGlR3TgxMr6ihurwj3lzzFymwsZwgBMPrYkEwOZpafQiBstKXV603zS
         nt3c7cvOUaj0IHjiwv6L59i+0Dh70iTLdnNvFlURLOz+CsfeX+54kYTccE6LlFcDCZ8N
         Mzzym5Fwx2DBIoIbIZmbd66qDw+B/Rqjf4QBB52w1vRhdm7jAxXi/SXOQFgIzAFXwRBG
         K54pMNdjHulfST+t/MDs583HAn5/10yZ4CGkBaGpa6XIXZhKsdMcSZl/B94UM/FYRGtf
         J8zOSd9YsvU4LYqnxtlQYjUBkGR/O1TyVspj2Je303iKQPzM99J2wMRQk1gPdDH2xWNP
         qUjA==
X-Gm-Message-State: AODbwcAymnk7mpkdLW5SUTrEcuoDszk66CxYP9UbeE+wh0GKJiOLawUT
        iE9nt1SbKkn2jQ==
X-Received: by 10.99.158.82 with SMTP id r18mr800273pgo.231.1494982319199;
        Tue, 16 May 2017 17:51:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:78bf:56b6:7690:fdbd])
        by smtp.gmail.com with ESMTPSA id b1sm382981pfc.27.2017.05.16.17.51.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 May 2017 17:51:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 00/11] Start retiring .git/remotes/ and .git/branches/ for good
References: <cover.1494509599.git.johannes.schindelin@gmx.de>
        <xmqqk25m98rd.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1705121216290.146734@virtualbox>
        <xmqq7f1h63h9.fsf@gitster.mtv.corp.google.com>
        <CACBZZX5EXxsB3TWiiB0TH-ZpOsadcAPAe4chrQBe7py9VAMY+Q@mail.gmail.com>
        <xmqqh90l188a.fsf@gitster.mtv.corp.google.com>
        <CACBZZX5oVKGZLKgS4aF0=XXtHO67ynS+zxSopDN9ErJGzV9n-A@mail.gmail.com>
Date:   Wed, 17 May 2017 09:51:57 +0900
Message-ID: <xmqqwp9gz4nm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> It seems pretty haphazard to me, is it even documented somewhere?
>
> I'm talking about an establish process backed up by code, where for
> example I can add an experimental feature in v2.14.0, it'll be subject
> to change & warn unless you configure core.use_experimental=true or
> whatever until v2.16.0, then it'll be considered stable, and changing
> the semantics of any stable feature will require opt-in configuration
> that'll only become default after N more release cycles where N is
> some well-defined number.
>
> Git's deprecation cycles, such as they are, seem to be better
> described as: it'll be noted in the release notes or docs, then left
> for some indeterminate amount of time until we have the argument on a
> case-by-case basis of if/when/how to deal with that specific case.

I do not think we have any "Statutory law" about how to make a
backward-incompatible change in Documentation/; I do not terribly
mind if we see some write-up on the topic there.

Having said that, after getting burned by "git-foo no longer is on
your $PATH" change in 1.6 era [*1*], I think we have been pretty
good at following the same pattern to ease the pain to the users
during transition each time we had to introduce a change that forces
existing users to adjust to the new world order.  Recall how any of
the following (not exhaustive samples) were done: introducing and
making the default value of push.default from "matching" to
"simple"; removal of "git tar-tree"; "git add -u" working on the
whole tree even when run from a subdirectory.  We start by issuing
warning message when a deprecated feature is used or a feature that
will change its default is used, wait for a few releases (depending
on how entrenched its use is), and then finally flip the switch and
remove the message.

You are right to point out that we tend to refrain from setting the
timetable from the beginning of the deprecation dance, and it might
be a good idea to set the exact cut-off date upfront.  I have no
strong opinion.


[References]

*1* https://public-inbox.org/git/?q=gmane:93813
