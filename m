Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F10C77B75
	for <git@archiver.kernel.org>; Wed, 19 Apr 2023 12:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbjDSMXM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Apr 2023 08:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbjDSMXA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2023 08:23:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98941FCE
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 05:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1681906972; i=johannes.schindelin@gmx.de;
        bh=Y2nEk2P1Kc/ui2EihtH7fd4V9oXfNBnKkC7doaCNW9M=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NS4MkNw4oULD/p+QHlBPWg42kovZo560mksLGxzEOk9Lxsg7B/I+pkHmORH5+Ekht
         BRuIaPNZ7KSVNBC6zHstDn1MVEwVkhmSqiwvHoBuNF9syl5XPwSi3Yq6OcVMm0fydN
         T5wJLfiidi1uihXo3RwNQ/X5OLK6h9KSVq0LqEAga+93rxGWT1qgvZfiBUvGZlVS+e
         o9+tB49BfSdwx/fuu/MOaHotSFHncS8yQi5no/Nn6gfBnzP4yQdatVkdctEAkzVXlr
         n3mkz3IjyW81LHkjQw1LgMrnZISSCmRV3B8gyMR2jNQ6BCdWtyrzrvPvZgWZpS5pZX
         hmrGrgaS52PPw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.23]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAfYm-1pe8U01Wi8-00B32A; Wed, 19
 Apr 2023 14:22:52 +0200
Date:   Wed, 19 Apr 2023 14:22:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Samuel Ferencik <sferencik@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2] config: introduce an Operating System-specific
 `includeIf` condition
In-Reply-To: <xmqq7cuamjmu.fsf@gitster.g>
Message-ID: <67a2d12c-6250-c4ee-dd26-fd8ecc71b8bc@gmx.de>
References: <pull.1429.git.1669037992587.gitgitgadget@gmail.com> <pull.1429.v2.git.1669058388327.gitgitgadget@gmail.com> <969a4399-a6db-7c72-f96c-8bbe5f6208d4@iee.email> <xmqqk03jcwxz.fsf@gitster.g> <CABwTEiRz+-+Zdx3Ed7O09Ch8GoXH-SnmJyc-vFOdF-hk_uO-yA@mail.gmail.com>
 <xmqq7cuamjmu.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/qlbiNNdv4APo1BODqeCYtmFnXcaic/iDjA7gvFQQCol/Chomyk
 RCmE7Mwk4M6KrF+8tDA1/HFzCBE2HZgBBoHu1pXzLNBp0VyXgyHWhJ0f0Dq4CHMec9yoLDS
 7/Pd9nzFl9V3WfkmbIKJ/V4W2Z1ADzawg2Hf4tBxisXB3lRS09ooI+k/DUrw74WnF2OqK++
 rSxZwFQxV+d9NnYrCX1gA==
UI-OutboundReport: notjunk:1;M01:P0:BQaB5FgxAYc=;nq+V26W8n2k6lL7TUZOjnFzTjlo
 cCBAa6IZq+Rpc/UQrlVYcWNK2PBDoIVR4a5A1rQjB+kMPQrwXc9StZPqHrhxfzwnCi8FPg9KS
 rzDSvOWVOpI+GlPovAhaUOyImh8CfC18YDnQB6Ntjur4/pGEZQOmlHJdN3CRjGZrWf1Ee/CSN
 kDFEIbXVm3l892MCZR6mWmsayceIerU3RFa9mXfqeIA1xzYr3xJROnwC8u//cHjA75Ns5ibmk
 hfcaZho7aBG6mti0Q0OraboT1AE1HynumFT3L2PX/kD2afmbgKjNmsF1zPAoDQ4jdtTq3jsjm
 pR/+lyj458iTCWk6omRkiHhvVgs7cFPdVrEuun4eKT+aCAs3VygTJiW4Xy0vDHkBptKkib/kb
 X0Nk+ZTYTmB/qq02m/YstHjYi4hbQbI4VXHJwoaK6HyzozOzz3QHV8gpp0Ha/YRthBhEn0zOL
 ReVINq3rlPgVrLbDj3QtpYOfIS3bKQgQ4ceOeMaP17gDpu4STeZ1cIhaTEwXLsNxfhSuhCmwK
 IufrM/dotR8E6sd/Sx2gU44XsxtDujDOY384+xX6sa26Ic7kzFIOu8L5QBa2P8KOpAKXXhZBk
 JyDZCQCefx8hdjWZMCr+tp5dEiJHrUwGkaTNYPxnp2io5Ad8tqNmxK4+u2TfFqZ11hi4vx1TD
 TEJNe9arVIchsS13u4MT+QIFF+jL0Qva3mjQszQBNMdU36Q4deuBt7Xuj5KSXGtRz5awDLJZ8
 W/A6kM8HqKJ1fJ2GZ2QkBbAY1uOQE7CjI/W28BNmoOqFZb+1jp2LP9SbVRyjiPCxyIwUU5ZXn
 APxB9cCaUXPexz0nX6UCTg2bAV0Q0XeizXT11LT623r1lKVVW6IN3FJrNRPEABGqG+sgQhCUu
 Jy0Kjk+v4f8kUPDtlfNjVbE9I2XWiPRvfLNM5KzDhYbGWr0eNF6S6QyfzVmeeZblgnZ1ullMy
 YnPHwA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 17 Apr 2023, Junio C Hamano wrote:

> Samuel Ferencik <sferencik@gmail.com> writes:
>
> >>>> Let's introduce a new condition: `os:<uname-s>` where `<uname-s>` i=
s the
> >>>> system name, i.e. the output of `uname -s`.
> >
> > The discussion about https://github.com/gitgitgadget/git/pull/1429 see=
ms to
> > have stalled on several points. I'll try to summarise; let's see if we=
 can move
> > forward.
> >
> > (I am the reporter of https://github.com/git-for-windows/git/issues/41=
25, which
> > led to this PR. I am vested in making progress here.)
> >
> > 1. name of the setting (`os` vs `uname-s` vs `sysname`)
>
> I do not think it is a good idea to squat on too generic a name like
> 'os', especially when there are multiple layers people will care
> about.  But I think the original thread discussed this to death, and
> I do not see a point bringing it up again as the first bullet point.

Given what you said about "Operating System", i.e. that both "Ubuntu" and
"Linux" should be able to match at the same time, I kind of concur, but in
the other direction: rather than forcing the current patch series to use a
less intuitive (i.e. user-unfriendlier) name than `os`, I would want to
modify the patch series so that it _can_ match "Ubuntu" and "Linux".

> > 2. casing (use of `/i`)
>
> My preference is to do this case sensitively (in other words, start
> stupid) and if somebody wants to use "/i", add it later after the
> dust settles.

I strongly disagree with this. This feature is meant for Git users, who I
must assume based on my experience would expect the value to be
case-insensitive. I.e. they would expect both `linux` and `Linux` to
match. Let's not make this feature harder to use than necessary!

> > 3. handling Windows (MinGW, WSL)
>
> This comes back to the reason why "os" is a horrible choice.  Is WSL
> a Windows?  Is WSL a Linux?  The same question can be asked for Cygwin.

These questions actually have pretty obvious answers, with the exception
of WSL1 (which nobody should use anymore): WSL is a Linux, Cygwin is not
an Operating System by itself but runs on Windows. But of course that's
not helpful to help configure Git specifically in a Cygwin setup.

> The answer depends on which layer you care about.

Yes, this is the crucial bit.

> The underlying kernel and system may be Windows, and some
> characteristics of the underlying system may seep through the
> abstraction, but these systems aim to give user experience of something
> like GNU/Linux.
>
> And this is not limited to Windows.  There may be similar issue for
> systems like PacBSD.  Is it a Linux?  Is it a BSD?
>
> > 6. what's the use-case?
>
> I think that this is the most important question to ask, and from
> here, we'd see how #3 above should be resolved (I suspect that you
> may want to have at least two layers to allow WSL to be grouped
> together with MinGW and Cygwin at one level, and at the same time
> allow it to be grouped together with Ubuntu at a different level).
> And after we figure that out, we'll have a clear and intuitive
> answer to #1.

This is probably the most valuable feedback in this entire thread: What is
the problem we're trying to solve here?

The original report (which this patch tries to address) asks for a way to
have a user-wide ("global") Git configuration that can be shared across
machines and that allows for adapting to the various environments. The
rationale is motivated well e.g. in
https://medium.com/doing-things-right/platform-specific-gitconfigs-and-the=
-wonderful-includeif-7376cd44994d
where platform-specific credential managers, editors, diff highlighters
that work only in certain setups, and work vs personal environments are
mentioned.

So as long as Git offers ways to discern between the mentioned
environments by including environment-specific configuration files, we
solve the problem.

Bonus points if we can do that without getting ever deeper into a pretty
contentious discussion about naming.

The strategy chosen in above-mentioned article uses the presence of
certain directories as tell-tales for the Operating System in which
Git is called: Linux, macOS or Windows. Concretely, it suggests this:

	[includeIf "gitdir:/Users"]
		path =3D ~/.gitconfig-macos
	[includeIf "gitdir:C:"]
		path =3D ~/.gitconfig-windows
	[includeIf "gitdir:/home"]
		path =3D ~/.gitconfig-linux

Now, the presence of directories like `/home/` might work well to discern
Linux from macOS, but this is not the correct way to identify Linux in
general (a `/home/` directory exists in many Unices, too). And it only
works when the _gitdir_ is in those directories, too. That's why I thought
that Git could do better.

In many cases, though, the presence of directories is probably "good
enough" to address the need described in above-mentioned article.

What triggered me to write this here patch was the report that those
`/home/` and `/Users` paths in the Git config ran into the warning that
Git for Windows no longer treats paths starting with a slash as relative
to the runtime prefix. This warning was introduced when the `%(prefix)/`
feature was upstreamed, superseding Git for Windows' original handling of
paths starting with a slash. The warning was introduced in November '21
(virtually together with Git for Windows v2.34.0):
https://github.com/git-for-windows/git/commit/28fdfd8a41836f49666c65e82d92=
de9befea2e69

So while I still think that something like `includeIf.os:<name>` would
make for a better way to address the concern in question, I realize that
the path of least resistance is simply to drop the now-deprecated feature
from Git for Windows (including the warning that was the reason for the
original report): https://github.com/git-for-windows/git/pull/4389

This still leaves Git in the somewhat unsatisfying state where there is no
better way to discern between Operating Systems than to work around by
detecting the presence of certain directories. But I do not see any viable
way to reach consensus about the `includeIf.os:<name>` patch, so I'll
leave it at that.

Ciao,
Johannes
