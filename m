Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134DEC43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 14:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D904220775
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 14:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="NgsFmTPF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgCZO12 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 10:27:28 -0400
Received: from mout.gmx.net ([212.227.15.19]:54587 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727831AbgCZO12 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 10:27:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585232838;
        bh=Z2AqDkrlqGoGUundUM/FjylEKZOisppXykxOkajg6x0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NgsFmTPF/8dIYZHkql3ATxaUzDH9bp0s4qq9IbfIyaVGOrpLgpXqu8QzrUaEaIyWP
         8tbtisX+5tPuqYYLFMVcG1OJ/I2YCGHQQol2fsdCzIFhaEqqc70rHIn94y8abe5JZJ
         BywurCGHFbZQI3C/UIUDZhfqpcIiWbC+7iTPn0bs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([213.196.212.82]) by mail.gmx.com
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MtfJd-1jWWO91X9b-00v83k; Thu, 26 Mar 2020 15:27:18 +0100
Date:   Thu, 26 Mar 2020 15:27:19 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/5] tests: turn GPG, GPGSM and RFC1991 into lazy
 prereqs
In-Reply-To: <20200326083519.GD2200716@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2003261450590.46@tvgsbejvaqbjf.bet>
References: <pull.728.git.git.1584968990.gitgitgadget@gmail.com> <pull.728.v2.git.git.1585114881.gitgitgadget@gmail.com> <85457a7b61874e8e9f3af9c231451df0aba7a7b5.1585114881.git.gitgitgadget@gmail.com> <20200326083519.GD2200716@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MsM+chlEXS6UuoeB1ra0i81ugUbD6Vt0oLYsFADIsW07GlvjTHv
 JjRq1raRqfiMDjwRE4r+wolySl1lZmu/tpQCuXJIX2LosJF5NWcjZU2mVEsGq47TMyMHwaW
 VNmaRa4H7Sh4BHSGDHpoLwB1ViuSRUEA3CRUEK940+hHH2mHblLhNibuVe4ucunivpJzA/d
 1gIGk6XSWjnsYyLDxmXvw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eqElVHdzbpk=:myXJpfTxmhEtgv70C7SEsT
 v6y/KZqelebQOs1zYRXI28zk1TJbgOfFm5ZJluMdWZTltgYeE5MZQBE9jZ4V67h6+uI5Rn/WD
 iC5S0b/Z9aMaiRpDEZa8Eq9ljAHquE3NUHxbscu0/Od0DPc/Tg31OdCCZYSog/s4Dk2Jco5lc
 Oo3cva9oKbKHrPafx08JVMg7oFKIX+0OVJDhyLHuEowEhs5oeHTwmwyviyJt/ePCD++71lFcX
 IPnI7eAL1pkF8WfP91T5KJczlTwLpGYdvzUf8qKnHfFr9FMu14rE6Fy9LtR8VTM3RDqBRXGYm
 29FX9NzsPamBacZVJGaWtBbYnjvF3+KoMyoMXCpLCp6M/mubpy9R4iP42jffafRTBIOHB0Qlt
 jNtbrE0ORag1LKoIcr4hT7mhQMd/+fLc4oouz6+yEPPIpdNyFX3wXNJ1KixqsTWpK1xciA9Gr
 Ip7xnKDmpdTjkWfAvz/KtH4XiiliJqWFSL2+PRmqzOewdroi4fsswM4c1j1yLeVZ+DUFxjwjR
 u2EU8xpOUV2cWlZi0EyTzIAn+AqqgEeh4AKPwrR8OePz9jLBidgSpUocQcNwU5BkMqFBgHc4P
 u3w4+yp0O8BgC2TJKfq3hL/Ke9LhJJ5DGgt+lhze9/Vi0vMgcmUGOa1O1lV6MTvEGyl+YZV1b
 gDEum8oBxReeE3EvQY7LGEOUR4kDqeHmhO0pGjLGq2UqGSTkiXxf+21zZrhxAc4EAEPhT+NPA
 TUvNZnu/jGBmi7lQf/zPApQnlRB89ToKgDyqybFp+WOYvKYSXnUWFu9wMIh4K5JwYaPFiiwnN
 DiwCVG6oBYUhNV+hLMRcx3kVjOIScTE7mVt17i6agKnKcE0F7O8PbVKHfrxsYsYQgD8qY3NRH
 ABexqqvnMDSfQcczZHiDvU495EGzlJaqR8yyvL82eXLF2vEiOkTKT/6p06uC3wUciAdNDtTvC
 /BOOz/jA2XgbO0VWIwismJva2lKbvQK1NOw18/2AiTdQrl6AbH9zgpPA3NzM/O2HqI2XJQ84r
 tj0MD7abpJ9J8WA682qCnQKP+21KzwypX8SxkDacmTfaO+dYzIavqeIURE2vU8DwjhrpuCZKs
 4MA53tEBFt46Hz2V/IDUmvNV3qR799IbOdKGlKUbN7S/2UEHt3EZDYq484H3aOoZ9RN1D0dEb
 GaYMyNhLHbrE0WlbZ5E8YdB7X9i1vpL4ls5TVCD/C8MJhj7xM8NDy4wR2ufGpPkfm4myZEWb9
 TkGZ9uygGiJvHs7Bd
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 26 Mar 2020, Jeff King wrote:

> On Wed, Mar 25, 2020 at 05:41:19AM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
>
> > In preparation for fixing that, let's move all of this code into lazy
> > prereqs.
>
> OK. This looks good, even if I cannot help feel that my earlier patch
> was perfectly sufficient. ;)

The mistake is all mine. I had totally missed that you turned GPG into a
lazy prereq. So I had my patch finalized already before you pointed my
nose at that fact.

Sorry about that.

> > Side note: it was quite tempting to use a hack that is possible becaus=
e
> > we do not validate what is passed to `test_lazy_prereq` (and it is
> > therefore possible to "break out" of the lazy_prereq subshell:
> >
> > 	test_lazy_prereq GPG '...) && GNUPGHOME=3D... && (...'
>
> No, it is not tempting at all to me to do something so gross. :)

Well, maybe it was not tempting to _you_, but to _me_, it was so tempting
that I had implemented and committed it before I made up my mind and
changed it again.

> > +test_lazy_prereq GPG '
> > +	gpg_version=3D$(gpg --version 2>&1)
>
> One thing I observed while doing my patch is that lazy_prereq blocks do
> not get run through the &&-chain linter. So this is OK, but I wonder if
> we should be future-proofing with braces. I don't care _too_ much either
> way, though.

I actually like that the prereq blocks are exempt from this && chain
linting, and would like to refrain from adding braces "just because".

> > +	test $? !=3D 127 || exit 1
>
> I have a slight preference for "return 1" here. The "exit 1" works
> because test_lazy_prereq puts us in an implicit subshell. But I think
> this sets a bad example for people writing regular tests, where there is
> no such subshell (and "return 1" is the only correct way to do it).

There are two reasons why I did not use `return` here:

- To me, prereq code is very distinct from writing tests. Just like we do
  not &&-chain all the shell functions that live outside of tests, I don't
  want to &&-chain all the prereq code.

  The point of the tests' commands is not to fail. The point of prereq's
  code is to fail if the prereq is not met.

- Since this code is outside of a function, `return` felt like the wrong
  semantic concept to me. And indeed, I see this (rather scary) part in
  Bash's documentation of `return` (I did not even bother to look at the
  POSIX semantics, it scared me so much):

      The return status is non-zero if `return` is supplied a non-numeric
      argument, or is used outside a function and not during execution of
      a script by `.` or `source`.

  So: the `1` is totally ignored in this context. That alone is reason
  enough for me to completely avoid it, and use `exit` instead.

> >  	case "$gpg_version" in
> > -	'gpg (GnuPG) 1.0.6'*)
> > +	"gpg (GnuPG) 1.0.6"*)
> >  		say "Your version of gpg (1.0.6) is too buggy for testing"
> > +		exit 1
>
> Ditto here.
>
> > @@ -25,55 +38,54 @@ then
> >  		# To export ownertrust:
> >  		#	gpg --homedir /tmp/gpghome --export-ownertrust \
> >  		#		> lib-gpg/ownertrust
> > -		mkdir ./gpghome &&
> > -		chmod 0700 ./gpghome &&
> > -		GNUPGHOME=3D"$PWD/gpghome" &&
> > -		export GNUPGHOME &&
> > +		mkdir "$GNUPGHOME" &&
> > +		chmod 0700 "$GNUPGHOME" &&
>
> Compared to mine this keeps the mkdir in the prereq. That seems fine to
> me. Other prereqs do depend on the directory existing, but they all
> depend on GPG itself, so they'd be fine.

Yes. And conceptually, I like that the prereq is responsible for creating
that directory.

> > +test_lazy_prereq GPGSM '
> > +	test_have_prereq GPG &&
>
> In mine I put the test_have_prereq outside the lazy prereq.

That makes it essentially a non-lazy prereq.

> I don't think it really matters either way (when we later ask if GPGSM
> is set, there is no difference between nobody having defined it, and
> having a lazy definition that said "no").

The difference is when running a test with `--run=3D<n>` where `<n>` refer=
s
to a test case that requires neither GPG nor GPGSM or RFC1991. My version
will not evaluate the GPG prereq, yours still will.

Ciao,
Dscho
