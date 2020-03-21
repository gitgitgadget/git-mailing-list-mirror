Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44BAC4332B
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 10:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B80206F9
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 10:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="MK5R81r7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgCUKvT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 06:51:19 -0400
Received: from mout.gmx.net ([212.227.15.15]:32801 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbgCUKvT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 06:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1584787870;
        bh=EoMyFOsmZu4pnhxxOpcR8hyBwE9rPDl7lzHLlI5OHU4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=MK5R81r7c6J+50DZid6M8dWs8jcwxNUxUXkCbRU4axf1JI14AmJa2LwbT3+kQvpR1
         BdcehuwIeaFrVYU07lbUyWXc6acv0mfHgqjYZqgw3mgPCqVXBwSnLn/DaQLIp8LecK
         LBhNhEGhcxMQqAbKD2qDN8V62T3g7op0dJ2Cu2d8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([213.196.213.14]) by mail.gmx.com
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MFKGZ-1j4HzD02DB-00Fhp8; Sat, 21 Mar 2020 11:51:10 +0100
Date:   Sat, 21 Mar 2020 11:51:10 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     George Spelvin <lkml@SDF.ORG>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Feature request: rebase -i inside of rebase -i
In-Reply-To: <20200320233528.GB19579@SDF.ORG>
Message-ID: <nycvar.QRO.7.76.6.2003211135380.46@tvgsbejvaqbjf.bet>
References: <20200320223015.GA19579@SDF.ORG> <xmqq36a2bpxz.fsf@gitster.c.googlers.com> <20200320233528.GB19579@SDF.ORG>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qRD5DZmbPg4oHiV/tI5dvJlULNL+M96XJuezhDOpa07KhjvXkRb
 hr397EBgAnZSOcq1BnCPd0+P6QpEqvJZNjx1RlVk1Fu0bdLF0SeM7SeS60sq6iRrdwESktO
 QPMA6vhI6laDOR6z7jMnloN6AZMjNq8sG+W/Yl4NUYafkelIySyJnINRWz9JRdbea4WX1OK
 HT6CHcDiuLWy9HJp5hAXA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6+m7YRB8vwo=:Vee4dGigDGBL1fi32//1st
 vQw1bxAC/ZXk4Nw8zqyHkMKWCm7Y2raozgVZ4dNSvKpt9eXJyk9Pmj+Ogsuhptbm2Or/AvePR
 YPPhkgLwuPmHdI6XNxHax9MbHdac43GKOT9J78mFTNUnMD2n6WJBVQr35gS8JYhTtuymY5vQe
 nKhoVdaaF45r2PYWW2RJspI44mle/tuvDFQjSMioGUV4JVooCRu7HoFm6VnvrEHxzplVw2bhd
 /LyPxOrUE1D21NIrJ/lvQsKxw1zX48PsA51plD6i8n6s3RJJisLkvnj0g5ChCgmIbIz5MhsIk
 /Qvv07FX6uY3vMab/QxUXR3gosePDppXHVIflHGoJfOZbaGo6jHz+fVz0eOjFQQPtlY0/YS2n
 CGJQARyabzcoiGjh61nCfYfbF+mHy5rS604q20iqiTJ5Uya3G1WhJsP2llydwvk2sLDBrOKcW
 EJoWmIZhCm/PTTBN/3kyxJ6r1SCbWxj5DEGjHKwgI4LUBKSa9z8l2gqCQYrqaVqkO0rxgNewE
 UOFoOiKWuhJ2VaxW9i2u/Ntgu+q8pbVCZXrHr8QxVEFA8B5onXrziUysauaj1TroznN0PNPXk
 6iwVIv0NHAc3xpzBjiJgM5KowSj0T/0v/s5DP+S/5b2qPANzomZotVsI0mnuEQR2fuzlc9xex
 ehTTtXnOMfWr4l8gFyCCTRypwg+pQHYaE8VcTWOWApSHfyKHATGr3hdpJHVwe0Vh1BFx20YNH
 RJWb9H1/+EH6qZzXTkAQrQiCdTEYX/2/YqpvgQdOIu0jlrfvxUIvDAT+1Xijv0QCvSWFL0ytT
 9VkIVopIsL0+2TmDM/uOHR3AaasqVNIb/sOvsQFrfrPHYrSvfKQOElATus/+t7LfKfnL7zAn2
 C+w8B2CL05Bf98qLDcCg/kK1dNpVpAjpR3bshQRskTiJvDVc1Fd509kZbS8wXw1Prcu2n0W6t
 CQx8702FXpNDsvClCx7C14Un/7mW+4so88zwPxkwWA0yzKmBrL2OIvime8vqc2xkLKKLBm/au
 1WptQWrSf+Q0ylNY3a/B2jXb4EhSaC0V/TVAnr4fzh9O7mm9/BxdGro4wX+hwwsTDCsvhaVXb
 jAFFidtd65xwJsjgxamgagJwgOddtU8K/4LpmI8SmurH5wZfz1S8cRWV4jveEjTj0fra1m9MK
 qlBhiCq5D3REBcTc7PcTbg/FAnejOxX/rbVfriwlfTu65HOPf6x5PIUvcBp73Z4pM6spZnlmi
 wcvuzuqEdBhkeh/OS
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 20 Mar 2020, George Spelvin wrote:

> On Fri, Mar 20, 2020 at 03:51:20PM -0700, Junio C Hamano wrote:
> > I thought that "git rebase -i" allows the todo file (i.e. list of
> > steps still to be performed) to be edited before continuing; would
> > your use case be supported by using that?
>
> Mostly, if I do it very carefully, which is why I thought it would
> be easy to add.
>
> I think I could manually add the commits to the start of the todo file,
> reset --hard to the old state, and rebase --continue.
>
> But cutting and pasting commit IDs from git log into the todo file,
> and putting fixup commits in the right place is annoyingly fiddly.
> That's exactly the sort of thing computers are good at.

FWIW I have a super-hacky work-around for this use case that I am using in
my automation of continuously rebasing Git for Windows' `master` onto the
four integration branches of git.git:

1. create a throw-away worktree without checking out the commit

2. fake-run a new `rebase -i` in that worktree, with a custom "editor"
   (which is actually the same script) that simply consumes the todo list,
   aborts the `rebase -i` in the worktree, then deletes the worktree, and
   then inserts that todo list in the original todo list.

3. continue the rebase

I never got around to implement that as a proper "nested" mode of `git
rebase -i`, but it should not be too hard. The user interface would
probably look somewhat like `git rebase -i --nested <arguments>...` and it
would _expect_ an active interactive rebase, and it would insert the todo
list into the existing one, at the beginning, with proper commenting, then
reset `HEAD` after the user edited the todo list.

My biggest caveat is that I had to force-exit the rebase at some stage
due to reasons I only vaguely remember. It had something to do with the
replacement cache not being updated when an `exec` is executed that adds a
replacement object via `git replace` [*1*]. This issue might have
_nothing_ to do with nested rebases, but as I said, my recollection is
vague.

There are a couple more concerns, of course, such as: what to do if the
user deletes the entire todo list (which is traditionally the only way to
abort a rebase)? My gut feeling is that it should go back to the
_previous_ version of the todo list.

Another big concern is what to do about `rebase.missingCommitsCheck`: with
nested rebases, this will get increasingly tricky. Like, imagine you are
rebasing 5 commits, the third of them results in merge conflicts, you
realize that it is obsolete and so is now the first, already rebased
commit. You do a nested rebase of the latest two commits to drop them, but
they don't have their original commit hashes any longer. So it gets a bit
finicky to keep track of what commit has been dropped on purpose and what
was forgotten to pick instead.

Ciao,
Dscho

Footnote *1*: to refresh my recollection, I would have to scour the
history of the automation script, see
https://github.com/git-for-windows/build-extra/commits/master/ever-green.s=
h
