Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937F5C43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 18:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB0020675
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 18:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="GASRlEpj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbgC3SjY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 14:39:24 -0400
Received: from mout.gmx.net ([212.227.17.22]:44413 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgC3SjX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 14:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585593549;
        bh=yjQFN/K5qL7oqznLzTKK1VqhzkTR7GEwaUBwOVbvHlI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GASRlEpjy2ntWtTnqhNICjHJXY5gmyxKVTZ4Yj7sPIXx3NXU4OznKRiCd9e4uhtkx
         2UrGMqzromNwlyHwVC8Gpznj38ZDEBUUJwRtDiKeDd7Ku37jgnRgnsGXOso70/JfHV
         2Jiw/EInZYtutWUdIuqCohdK4wqzbE5iRsih0C2I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.214.151]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MzhnN-1j6Fky1Pd3-00vhn2; Mon, 30 Mar 2020 20:39:09 +0200
Date:   Mon, 30 Mar 2020 20:39:08 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/5] tests: turn GPG, GPGSM and RFC1991 into lazy
 prereqs
In-Reply-To: <20200327091004.GA610157@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2003302027240.46@tvgsbejvaqbjf.bet>
References: <pull.728.git.git.1584968990.gitgitgadget@gmail.com> <pull.728.v2.git.git.1585114881.gitgitgadget@gmail.com> <85457a7b61874e8e9f3af9c231451df0aba7a7b5.1585114881.git.gitgitgadget@gmail.com> <20200326083519.GD2200716@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2003261450590.46@tvgsbejvaqbjf.bet> <20200327091004.GA610157@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Y9ut1ZxMxx9N5YQ9OdxwUQJ/P+bZw9aFgbIi+kXAc3Cq5tZ0sFg
 6StMt7vGX4q18G306pT6dc+eV4oC47N/ozhOqd/75mU4+64k4DAmiQ+w1CThQkKGcUvHSkC
 WnuRfDjW9wElf9od/NqGsba5gXdRKWC8JTQAQF0ERv+Lylt6Pyb8U4g4Zl2FrCQM7Wcyli7
 d6ygictawgPbqARBZ+GXQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AczXaWGt3H0=:Dy13iSu5j3x4RkENIO4TdX
 +w1+TDcYO48ypWAC8Xx54VklyYFlTBeoKUXabzCvAwdl1IH6dj0lvlCpikMkIT79o9x5lufiF
 O1OF8Q4OJ0lVJu04VqrfGSb/NqHX9OsdNrdcQ6QXSCv9GuKXXI2Y5EEfqdOG3SaIzqGwxD63/
 qJW/fSPnRXVyvR2+T0bQZFBBiOmzmrDBPHzt43xzHWrRSuTRkHJPJMC7g1a8SyGaYhq/TW9N8
 Q/ETKjjRxG3J53XcdwteuAxD7EbBOAry1WLfg8W32S/lPgc2YlVwd9EPVMjHlqNUvFnSmcPkX
 GHr4M5VVArHoLjkVjdvGJnsRVEgVd6/xnSz7+k6SldTnOn0yvQ7Sfat3Z2OE3NAOHNusQSNix
 3xUBJWTRMc+hmCEOQkBLC6bHMwz3H/APgpiGEY8KmRpCNiIea8qGerRrWtv9b0NHJi3mEnSdG
 bpGBp5esgw3NJdMeBwz4zcG2IfaNdjDWU6sagHqN8U3cMvwt7jL3kFBhTk39RYtsm7xTQdel9
 k356i5nBeAAfOWYmcmfMR+z9J51QqMrd478H1qxL/wxYO638fpf50ps0jecHhmaj7tc69Xgxn
 2snZVXNSouTqk4ae6rgN2osd+TRVx4dCS4CPW5BR/2wMLtPuB8vPI4JGE26vfPaO4Z+JxfB22
 OxNxSFMN7mUgkUMRYavMFfNcoAIEBvuKpGNh3Sq9pr+oKvKM4oN0azXUSlM0bVTUCfHICvlSZ
 phGBDyQG0hXChZE0wr5Py5JKwcPtktn/185hDJkdhvCj8G4SALzlAKkMCeejfd+YOSncfHwlb
 klGHvhcNsoIc8ZnmJJG8BU1bIV3zCTj5WsIT+zMG5/MTYG8FhUHMlptSN4v3euYJRav3Bm9jD
 hPherbfSGrSRsQruBRAQf45jvg93v99BtD/S5RqDqMwJPgn5C23Yu3VVP/7phJhC3bamSyZ3B
 WExjRkYG/IgOA59IJjFH2dWfUHOeWlCOI4csuAPidLSJXJe7iVAQmItzRi3aDpd00HEvpi60x
 8pfi3ysl1DOPNbKzPw3xXebW/QV46KZMqqmOOhN+edDKnjiabnCriAIcUHGo3Qoh65vliPw7e
 VrshEWFwPwEJU4DhaOfYmn49VnKW8NFGjXx48oUUCf0RgRYkI7Yn7juXhW8xTTqX4144CrulN
 KsJfx4jRnkQJZhRykYEWfGA4U7axKMeDYYc0qsOc9L/Kv4XJCoGpMQbysLCBWa0mL79F3e4Cu
 JQW0vN1OzhJWpiDG/
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 27 Mar 2020, Jeff King wrote:

> On Thu, Mar 26, 2020 at 03:27:19PM +0100, Johannes Schindelin wrote:
>
> > > OK. This looks good, even if I cannot help feel that my earlier patc=
h
> > > was perfectly sufficient. ;)
> >
> > The mistake is all mine. I had totally missed that you turned GPG into=
 a
> > lazy prereq. So I had my patch finalized already before you pointed my
> > nose at that fact.
> >
> > Sorry about that.
>
> No problem. And I hope my review didn't sound too passive-aggressive
> with the "well, in MY version we did this...".

FWIW I failed to interpret anything in your reply as passive-aggressive,
probably because I am just too used to receive competent, helpful and
friendly replies from you.

> I focused on the differences because those were the parts that were new
> (and therefore interesting) to me. But I don't think any of them are too
> important either way.

To me, it all sounded like a constructive discussion we had, and since you
already had a working patch that did something very similar to mine, it
made sense to look at their differences.

> > - Since this code is outside of a function, `return` felt like the wro=
ng
> >   semantic concept to me. And indeed, I see this (rather scary) part i=
n
> >   Bash's documentation of `return` (I did not even bother to look at t=
he
> >   POSIX semantics, it scared me so much):
> >
> >       The return status is non-zero if `return` is supplied a non-nume=
ric
> >       argument, or is used outside a function and not during execution=
 of
> >       a script by `.` or `source`.
> >
> >   So: the `1` is totally ignored in this context. That alone is reason
> >   enough for me to completely avoid it, and use `exit` instead.
>
> I agree the portability rules there are scary, but none of that applies
> because we _are_ in a function: test_eval_inner_(). This behavior is
> intentional and due to a7c58f280a (test: cope better with use of return
> for errors, 2011-08-08). I thought we specifically advertised this
> feature in t/README, but I can't seem to find it.
>
> So my perspective was the opposite of yours: "return" is the officially
> sanctioned way to exit early from a test snippet, and "exit" only
> happens to work because of the undocumented fact that lazy prereqs
> happen in a subshell. But it turns out neither was documented. :)

Can a subshell inside a function cause a `return` from said function? I
don't think so, but let's put that to a test:

	function return_from_a_subshell () {
		echo before
		(echo subshell; return; echo unreachable)
		echo after $?
	}

Let's run that.

	$ return_from_a_subshell
	before
	subshell
	after 0

To me, the fact that that `return` does not return from the function, but
only exits the subshell, in my mind lends more credence to the idea that
`exit` is more appropriate in this context than `return`.

For shiggles, I also added that `$?` because I really, _really_ wanted to
know whether my reading of GNU Bash's documentation was correct, and it
appears I was mistaken: apparently `return` used outside a function does
_not_ cause a non-zero exit code.

> > > In mine I put the test_have_prereq outside the lazy prereq.
> >
> > That makes it essentially a non-lazy prereq.
> >
> > > I don't think it really matters either way (when we later ask if GPG=
SM
> > > is set, there is no difference between nobody having defined it, and
> > > having a lazy definition that said "no").
> >
> > The difference is when running a test with `--run=3D<n>` where `<n>` r=
efers
> > to a test case that requires neither GPG nor GPGSM or RFC1991. My vers=
ion
> > will not evaluate the GPG prereq, yours still will.
>
> Yes. Part of the reason I kept mine as it was is because it matched the
> original behavior better (and I was really only using a lazy prereq
> because we didn't have a non-lazy version). But there's really no reason
> _not_ to be lazy, so as long as it isn't breaking anything I think
> that's a better way forward. (And if it is breaking something, that
> something should be fixed).

I'm glad you agree!

Thanks,
Dscho
