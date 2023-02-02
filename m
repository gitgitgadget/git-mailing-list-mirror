Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37853C61DA4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 10:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjBBKO4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 05:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjBBKOy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 05:14:54 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF594486
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 02:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1675332876; bh=SnYjo27GZXPcqybnlZnSzXrNULkr2KEv8t2nwoXygIg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=qozM6JAF7B7DLhbAIyycofGEvwoUdbWkA5CHeaskFVJO1BjhIZrtSuSlRyG6JG8BL
         8pcQVXB93rFP7afK6XdJx85ef2jXIKUyF2bn7doPlvOq7CoexK0EI3cQXWtmr5GFV/
         3OLdDRsXFIxh143dIzzDqWrIIAcyajZV7mytq2mMOOuJ0eNDfGY9ehwKxaO2j2+v5c
         LPGxrcw1cN+idDVfRedWWAL5M8W/E4eQUkBsA3maN2YLk4jl8M0xwBpRZxTCoNMMYp
         qAC/4SQL5CEAgk1xJ3ZgyZ6Nj1aFYkDl4LZ7j/BnvxBDHi6BpRfuO5+Qh6CIZbpnp6
         aMkFqVo34IAtw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.128.75] ([89.1.215.7]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N9dwd-1obvoX0wnl-015ZUx; Thu, 02
 Feb 2023 11:14:36 +0100
Date:   Thu, 2 Feb 2023 11:14:33 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>, Victoria Dye <vdye@github.com>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v7 00/12] Enhance credential helper protocol to include
 auth headers
In-Reply-To: <xmqqfsbxcmdd.fsf@gitster.g>
Message-ID: <6f83ed25-a7e1-06dd-f180-d70c7e1b1973@gmx.de>
References: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>        <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>        <e57c1ca3-c21c-db41-a386-e5887f46055c@github.com>        <xmqqwn5bg695.fsf@gitster.g>        <Y9JkMLueCwjkLHOr@coredump.intra.peff.net>
 <xmqqfsbxcmdd.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:A0Nqy+yUWtcIpd5QRGOwaT5OaKN1PWzxKjWzwJjA5tdgRfXlq5h
 oCJ3OKYmViNmN1woAOSENAl16c1PNazELrFOO+QzJAhYVWU+5B8gzq7pFJP+qPun+wFA5mL
 JmNovxsh5Ml6FqPsrf8gJMuUNr1sMrtcnIx2SnvSE01fhnpQQIhUCSDiTC5wIftWPZxp5uK
 oGCHXN1v6mBLcET7G4bCA==
UI-OutboundReport: notjunk:1;M01:P0:oCxKYvLh3fQ=;jH41wZ4jJP3vV+Pktkf/TjFinPI
 rPLlCB1jhJU8cM4K61RwcJ4N+RPTFYQHNxjDPn0VFb6G6FsvCq2poH57MKSPyyRurJxrYcNYT
 FM/8xkySpcG7q9dXKD4tr53ZRpVYubq5hhLenCQca0EAITst/UD2WuAMMBircMj9twamNuNud
 31JJCDME6CDHtR3ZaPRwMuyGgnpjSZFVVr+D1hqf0k4rd936DF/5PVIkc60h0UAkQ0WfIuQrv
 FrZ40X13x3jM4DIX35bCkIOesI3kozMQusFpbOHAZc+nUKc62IWQQKPtA2/LHIj5jWD+spipG
 PKv4dDbS0Q1lAgYsK9gX5rZb9B8Nn+BAwV5TuSWqhPJ13RlCdlxKdGR3eLTeZXUWXGoy8avqs
 4NpSbGKKgwQmY9nrc3yPCIKJuhmZd1wbSw6TQEBvmCRdH6UVoXyq+wdl+syjpoKHnA4jCscUa
 vK6sU0zBY/WBu6EHnnpf26aPCO2n9u3W+H7n7jDpbiKlLybg2pkBOa4u0QcLdSmdqnBOBGs3/
 WEmWUEp/JTF6f8tyH+iYprdf8mGVIXDLfCzTnKFetxEU2yyCJyBBszkoBRd08FKYftmWag6AI
 bpyqexBYh8Ypeqs+P2LB9eXlzEIha83OjafrxcFqSCLIxm+hPJW9J46c0RvGg2c0nSOXD9epy
 tmm5qQv4utCvOA5zWTJ9KtJGS+qnCxNNLMpGjiLnaL7Assc2BwkNmaJQKVOtNITVqM2OeQh25
 98HaEPmvMYmoKhDrcRnMempFEhGT/FLLTMSLKkXImb+Q5ZIejT98XsfYlfqv7dAJNfN6MzcrV
 WWkYmAaxozuvMPEQ/MrsMmWW50XPsQcFwRDruhw7yQngYEdWfOM4oFYwB1K+06mSmYnWyvRXm
 Yy9e2il9G3UnjLuxJeUDxJqOQLYVlBYjojO+Q0LKil6Hg/z/ssfyvEyZUCX2Ao4tIKyNuqOqu
 chtAtc6mM3Rp8vm/S4q1hZ2jmiY=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio & Peff,

On Thu, 26 Jan 2023, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
> >> Thanks, both.  Let's merge it down.
> >
> > Sorry, I'm a bit late to the party, but I left some comments just now
> > (this topic had been on my review backlog for ages, but I never quite
> > got to it).
> >
> > Many of my comments were small bits that could be fixed on top (tiny
> > leaks, etc). But some of my comments were of the form "no, do it total=
ly
> > differently". It may simply be too late for those ones, but let's see =
if
> > Matthew finds anything compelling in them.
>
> I do not mind reverting the merge to 'next' to have an improved
> version.  Your "do we really want to add a custom server based on
> questionable codebase whose quality as a test-bed for real world
> usage is dubious?" is a valid concern.

Except.

Except that this code base would have made for a fine base to potentially
implement an HTTPS-based replacement for the aging and insecure
git-daemon.

That code base (which is hardly as questionable codebase as you make it
sound because it has been in use for years in a slightly different form)
would have had the opportunity to mature in a relatively safe environment:
our test suite. And eventually, once robust enough, it could have been
extended to allow for easy and painless yet secure ad-hoc serving of Git
repositories, addressing the security concerns around git-daemon.

And now that we're throwing out that code we don't have that opportunity,
making the goal to deprecate the git-daemon and replace it by something
that is as easy to set up but talks HTTPS instead much, much harder to
reach.

In addition, it causes a loss of test coverage because Apache is not
available in all the setups where the "questionable" code would have had
no problem being built and validating the credential code.

Windows, for example, will now go completely uncovered in CI regarding the
new code.

Ciao,
Johannes
