Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6217C4363A
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 09:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64AB0223BF
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 09:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mol9kVxr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896074AbgJVJrB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 05:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2509987AbgJVJrA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 05:47:00 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D17EC0613CE
        for <git@vger.kernel.org>; Thu, 22 Oct 2020 02:47:00 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id n15so1417379wrq.2
        for <git@vger.kernel.org>; Thu, 22 Oct 2020 02:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H5E8lpc5frEA30qgWP1LfhjrLVpr2sWegkJQ6TCSG7Q=;
        b=mol9kVxrCzJpgHap38tHkL9eOWjl3YjKablvFbRnz3PBpNwRfC0VL+kRunZiA61CR9
         B+Or1Uk9fK+4TbDtVDm8R6ezOKYkne4Km+AvvtW5rEWHOkmBAtPOa6vfPaARyXboO/Kj
         RhLnefOSfXwGG01tcxliiUhpE/shzeGcgOlw899AhDkA9iTrVxq/bSyZI+u7FaRut4y8
         Z5N+DxnESOJ6+FuxTDfZc3dkr5tm4q1M2ElznWM9CKPT0MBTNqLuwgVsWVHCPaCWMCkh
         yQCNKaE4ZwWG+2VH0DjxKBUu9rKi+P4py0dr5IBhaCC4eKAz7+fCmGFmZ8dKZJTqHgdG
         oG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=H5E8lpc5frEA30qgWP1LfhjrLVpr2sWegkJQ6TCSG7Q=;
        b=ttCGcljM9OdMfin9VX2ha7VMqHrZ/TXbZCtCeM/BhrSW+IDUn8P8EbDV4Ls4inIiUr
         CqYqn08oPmeOki2eaOOr6Smw9C/kHym9QmL0pyG0NPg9+a0YBjZurJmPadGyFTMFTPK/
         fUbInIhoyfJTd8fwb8dP2xBAumPTiKJRCeIjNOGky9hIbY1gboECGkTH+ZcJf479Hv5/
         a/hct6249E3JD6Kvvi3YPc6gDq3HkfVnLr2nI2J6xSBJUqelPO6QdjkPl69KQLjmlSsw
         GTl+cpCF1gH54T9oX9NIukAJsdwa7krlHPWn5NvF8UF/ueodQbCFY7/JZtJotr8gKU22
         8aKQ==
X-Gm-Message-State: AOAM5301bYg1hNvfLoKbRB1SR2tV/JdxImc0ktPg92mtJCVydA3kc2z3
        76DXEt3dTnuAswyEwJt98l8=
X-Google-Smtp-Source: ABdhPJy2L9X507+m0IK5F615eoBglSvk4yoiFeYl2c2T7lnx1J/i/lBEspslw/ZqR2hjQGkqkM0SeQ==
X-Received: by 2002:a5d:4e48:: with SMTP id r8mr1685170wrt.141.1603360018261;
        Thu, 22 Oct 2020 02:46:58 -0700 (PDT)
Received: from [192.168.1.240] (13.45.90.146.dyn.plus.net. [146.90.45.13])
        by smtp.gmail.com with ESMTPSA id e20sm2602480wme.35.2020.10.22.02.46.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2020 02:46:57 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH][OUTREACHY] bisect: allow `git bisect` to run from
 subdirectory
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, phillip.wood@dunelm.org.uk,
        Sangeeta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Sangeeta <sangunb09@gmail.com>
References: <pull.765.git.1603271344522.gitgitgadget@gmail.com>
 <2f71d0c4-a5de-c22b-9cbe-a9efcb3cd21d@gmail.com>
 <20201021162044.GB111581@nand.local>
 <xmqqr1pr73ve.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2010221047550.56@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <cfe33eef-974d-8ff9-ebb4-d1153abd497c@gmail.com>
Date:   Thu, 22 Oct 2020 10:46:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2010221047550.56@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/10/2020 09:52, Johannes Schindelin wrote:
> Hi Junio,
> 
> On Wed, 21 Oct 2020, Junio C Hamano wrote:
> 
>> Taylor Blau <me@ttaylorr.com> writes:
>>
>>> I'm not sure that that's the case: Junio pointed out a while[1] ago that
>>> we'd have to answer the question of "what happens if I'm in a
>>> subdirectory that goes away during some point of the bisection?". I
>>> think that you could probably find an answer to that question, but the
>>> fact that there isn't an obvious one seems to indicate that we're going
>>> down the wrong path.
>>>
>>> I agree that it would be nice to run bisect from any directory, but it
>>> may not be as easy as I'd hope.
>>
>> True.
>>
>> I would not mind all that much a single "git checkout ancient" that
>> makes the $cwd go away and confuse the user.  But a bisect session
>> would jump around versions randomly (eh, logarithmically?) and you'd
>> end up switching out of a version in a non-existing $cwd to another
>> version that has the directory (created internally by mkdir(2)), and
>> I'm fairly certain that your phantom $cwd that is not connected to
>> any other filesystem entity and the directory that should be at the
>> same path in the newly checked-out version are different filesystem
>> entities.  I'd rather not have to think about the interaction
>> between git and the system after that point.
> 
> By that token, we should also prevent `git rebase` from running in a
> subdirectory, but we don't.
> 
> Besides, this only becomes an issue when the directory becomes _empty_
> (including untracked files) because we don't remove it otherwise.
> 
> I am actually more worried about bisecting between revisions that replace
> the current subdirectory by a symlink or something.
> 
> But again, this is pretty much precisely the kind of scenario that we
> _already_ allow running into with `git rebase`. So I see little point
> refusing `git bisect` users to run in a subdirectory.

Except rebase always runs exec commands from the repository root and 
assumes that any relative paths are relative to that directory rather 
than the one it was started in.

cd t &&
cat >script <<\EOF &&
#!/bin/sh
exec pwd
EOF
chmod u+x script &&
git rebase -x ./script HEAD^

gives

Executing: ./script
fatal: cannot run ./script: No such file or directory
warning: execution failed: ./script
You can fix the problem, and then run

   git rebase --continue

git rebase -x pwd HEAD^

shows

/home/phil/src/git

when run from /home/phil/src/git/t

I think both bisect and rebase should be documented as running commands 
from the repository root as this is what rebase does and it gets around 
the missing directory problem.

I'm not sure rebase is doing the right thing with a relative path 
though. My feeling is it would be less suprising to resolve relative 
paths to the directory where the bisect/rebase is started and store the 
absolute path. The script may disappear while rebasing but that can 
happen now if the user points us to a script in a directory that 
disappears while we're rebasing

Best wishes

Phillip

> I know that _I_ often grumble after `git bisect start` fails, then try to
> pull out the last remains of my patience and insert `-C ..` or `-C ../..`
> between `git` and `bisect` and _still_ get what I want, all while shaking
> my imaginary fist at `git bisect` for forcing me to type those extra
> keystrokes.
> 
> Ciao,
> Dscho
> 
