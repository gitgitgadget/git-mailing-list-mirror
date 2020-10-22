Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE7BC388F2
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 12:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A7D5221FB
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 12:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="SbFF/DfB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898170AbgJVM26 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 08:28:58 -0400
Received: from mout.gmx.net ([212.227.17.21]:40189 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898070AbgJVM26 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 08:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603369732;
        bh=sZsjgZg7u/q1yzQ19XitK2E3XmRBBQpdvKQztFmn7Is=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SbFF/DfBITcpwVJrX//aeN3i/u1+kgoRf2DJ6U7bKCNF1T1q0s95LImg5ZNrDc7lC
         V5+wmPeeh9MP81EW4Pc7UCyZPZM9eYRk9GDDAyGEE+BVfyL7NJsdlpwWlNOVq/S5vm
         7cNeMewkzMCL5roYG/K7SA+EW7NtPqGAg1Rg/+BE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.45]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEFzx-1kfAUz17rx-00ACem; Thu, 22
 Oct 2020 14:28:52 +0200
Date:   Thu, 22 Oct 2020 14:28:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 01/10] fmt-merge-msg: also suppress "into main" by
 default
In-Reply-To: <xmqq7drj5iux.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2010221427560.56@tvgsbejvaqbjf.bet>
References: <pull.758.git.1603135902.gitgitgadget@gmail.com> <cf950c6f6a48f9a6ad55ac027afbc0640f9a535d.1603135902.git.gitgitgadget@gmail.com> <xmqq7drj5iux.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:obLGBWMSfB9SEOV48p0czwIoJhAFdYvrtLU3H8Id+dd5fLm4hH1
 lZiU6wqc8WGyRFaPReGEqiIhBNNLpkNN6Lo1DjrE1mFO/0ETmvIoCaxkOK+LxQN/0OQh6OI
 TuDSkvP5k5OcX1QqgSCbwMXXHhDDSprozOjTQXKN9thcBzzHLVJCA5O6/aDCBT5/rsg6Old
 AiXsANisAh55++rwVJFWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4v4KzoLo1R8=:IyiQmtysRHNZ/O5FsBwwlN
 B4d+VwPx/57Z32oRUHSlKVeOZ/zNjmzVdjhbC3flMrndFQFJXv7Z052PAeN72XXfFLQqW5UE+
 jtnE2doB8FjeRN9x3pSwKVmAoCat0SCkie9NeOifWUmopH5MxC19v6xOzZMWwszLCymKH940/
 ZLUIH5zlTafYRs44TtvdyZfKufT8jTE05MpZjpTkNZOBR8ah4TlqB9e+02PPfpj+JxzwBfAlF
 cF0QRioYDnXAazUcszEwSbNoe0aiI127Mnfcb0ulDxPIE7V9t8o8ZufUIb+/JqZx0c7/1+moW
 /jjojgqyKJBgTkFm2gmWQ8cM+OGeJN7KcfMQ7hePAVBNtCGlpwRyIoqmhsU/IkVJ/0lwuCY3h
 l1BNoLK8XSn7ICAQNyIyXq4u1Sjb5lsjIT7FiQCZiglw5qWP8ABI6T7jdZ1cgG2jGCOlLrNn7
 hPduX1UulxIrG5eSfW6al8GAMLqUp3BTcKKTKuNejHbbzTmOgJnpB9Kx71GwqDeFNDZrsmP/G
 a9FEahSStEIJxYSnqoYgwTPorTmciisEYbvOPIC7BHWg8Dh9mj9Tf+BR2rOT1lSwK4IPYrorm
 uqHE9LVp62pgH7kH5sBOp7s5/CJqIGJ+OcNVFqO1aHaoewI2nSPM1oCzT/D9XBNE0JSo+Th1j
 r9mnCh8vgRNeU1GByreqU2YzbAchNk4O6WBpJk5NuxFBTOFKVQ/urwMDwgqwJng9BSlzSgAj5
 yxHgqtOITOtL1K0g8whft/J3vK5qBV3tSOgVVCfGH62CcFxDxp5W7t2A8MC1AMUf9gUnRmC7/
 mfAOKBw4REkVeJt82/HYPBrDKxV1IzoQbdYVEW3/rtxeWjZ/Fgk2TTMye0lE48t5f6U2eyp9D
 rFWO/MRxaKIKcdKXaqPOXfKGEfvmTMPOSSvVO6AEU=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 21 Oct 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > In preparation for changing the default branch name to `main`, let's
> > skip the suffix "into main" in merge commit messages.
>
> Hmph, we reversed the course from "no suppression" to "suppress
> master as we've always done" because otherwise we'd add _more_
> instances of 6-letter string 'master' to our codebase, and that
> was to be avoided.  There is no such "let's avoid saying main"
> desire, is there?
>
> I can see why a series about updating tests would want a change like
> this (i.e. to avoid patches that have to add 'into main' everywhere
> to the expected output), but as to the desired behaviour of the
> default behaviour of "git merge" command, I am not sure this goes
> into the right direction.  After all, there are those (including me)
> who find the idea of having one single thing (in this case a branch)
> that is special among others is objectionable in itself, not what
> word (e.g. 'master') is used to call that single "special" thing.

The reason I did it this way is to benefit from a straight-forward
`s/master/main/g`...

> Having said all that, let me keep my suggested change to the very
> minimum.  Let's end the proposed log message with
>
>     ..., let's skip the suffix "into main" in merge commit messages,
>     the same way that "into master" has been skipped by default.
>
> That would justify why we are still special casing the new word.

I changed it this way.

Thanks,
Dscho
