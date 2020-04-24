Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3A6C54FD0
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 21:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8513F20781
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 21:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="RHSNq5VT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbgDXVMS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 17:12:18 -0400
Received: from mout.gmx.net ([212.227.15.15]:51323 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgDXVMQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 17:12:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587762732;
        bh=LvcvOWFsaTR8d99zzokls6ItMsERkGw3fWMmKjWHV74=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=RHSNq5VTTt73+enaESUUwzOJSFLyeQ2KRI0TQlQTTS0XCB7tuha7oN9qo114IejCz
         Dc3lfhLgAsOrCxzwBpGFwNqM20MVttoI6oHYR9/tTOvQT17igjB99I2jy71exPFIJG
         n6zdueNTG1n6K8fiuaUUAo62Wdt4R3b+cv9DzUHo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([213.196.212.1]) by mail.gmx.com
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Mwwdl-1jGKEJ0CF9-00yQTQ; Fri, 24 Apr 2020 23:12:12 +0200
Date:   Fri, 24 Apr 2020 23:12:11 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ci: fix GitHub workflow when on a tagged revision
In-Reply-To: <xmqqlfmkbob4.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2004242306450.18039@tvgsbejvaqbjf.bet>
References: <pull.619.git.1587748660308.gitgitgadget@gmail.com> <xmqqlfmkbob4.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:H9G/N219QnOpol3jCz4bLteAqMtGQkHoj2Nj+qb743YUOnqLA82
 AAXb3ES8DGuJTLziH+fBcQaPIHsRmDRGQsQpjEyH+SZZuOJhIrh2l3r570Vak25S/UuooJV
 X7JFwPu27OtiCzWtxHoeLFQAvElV6K22XsAODHrv8K/jtQZwLeIhL1exRh7Cf0QPSd4lNEL
 e5w3zZh/4vUJ04E64XrgA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:K4rb96MYe/E=:KiWHwuYO1sK13OvUW/1geP
 bI/RKYVVuon1s8flX5+h43vsESekOhKx3S+ehkGxORESrEynrCj1MJCQ4VxUKh3K99OG/9BnF
 Bg73I6j4/SuDq9BZI22Ej1iUS6kr3v/rhs4sYzb9QMyeRNc+IaY+y0k+CoR1H6PeRNmN1pDuT
 WPkZaa0c6HFo7wdWXGp016rAl5VJzZ8jhR/5JMfn4DHOdlNlcM7O4uVcg6vYFBLbfA+fLyWHm
 WOau6NKvBpJfzZ8klrlB7ZFJJ+WerQJ6wg2VbM23c6CRjzRpQIhvPR1BlIYBdBwblbdux3WCU
 A++KO/UDr1tNG2Fufj8yCBbQ3+j0hm/5QnQbOYys2T5HIpqcMh8adXtr+2zgM77SVCknC22W4
 XsD288g1Dj27OELXY8qTdUUGCsPe30tCdqBhjeHXzw+fS2vUtIkGS8IPaiNPMFWOSWtLXhWY/
 Stevg1yqmn4N1jndd9LIZjgcysptHHFEpXIqgAvIHwi7nkkWFvgcHvPUsYAlImqaQdDG2Jx37
 1E5bDz5UBsSXNFc7Xw1auvYp+OF9vk+cW47J+Mx6++vsGfaRe+D1Law9uL8ufuE2JfKVvB5gA
 a7aLZkUCGYujR83g89Po8WF8knt/JXOYyFv8HWwfCLNudeE889RuwVe8dSau2b4YTi8hKTYfe
 mxj2tXMl+M1Rj3DxWTIPNc7dOE/ZfyI1evZMZFAfYxlZIJ1EKy5jj/ImiqeM/s267aZ/CjS4z
 OcUz0ByuLrNOUxKtec8hrMQBTN6g4byYkZql4P7nWL6rla6iHXjX9K+Q2f/ZPeUFqt8ZaIN7m
 8MBlY7ErKdkDIsUug/baA2qJkRoxVpNfL97+wywta3KajcmHaSqpUcuDR7lD3p/QAZ6x8MBRv
 9oCGOINq/2vWlEafmFd2wEd2urzZCKYOEtCdT7E/QBuUO/YQG9JHZrY68G771WRF5YAhHDpyS
 LHTiW8IukohOYPXBjLa3vQd2rofvHPrXy94Ru2fqWlVZaTXwlanptpMGq6X8M4UpuDpl+VpDi
 GB1VhAd/mJ2Bu9SRzkSD4SmLJTHHJSXmdMJn1KG+NuZirZoA1YCqcWNGnx/CQbBju+HHh1daS
 h+2d0rmx788INP3nubypHo/pdztuc3EDHSTQz5QR98sEOlS3008H+4DL1U6WQPYMJaN7g6Sn6
 aj2KXXPRf3pInvDbynC0m+moyomTB/x4zU4kSdStJBjyykEKNKYdVdse3JdeRVO9M6Sa8Wqo2
 dCvZ+zXRvaWhXQj+8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 24 Apr 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > However, our GitHub workflow does not trigger on tags, therefore, this
> > logic results in a missing build for that revision.
>
> Thanks for noticing.  The arrangement we had, which essentially said
> "we know we will always build tagged version, so a push of a branch
> that happens to have a tagged version at the tip can be ignored",
> served us wonderfully.  Now the maintainers of projects (not just
> this one) are forbidden from tagging the tip of master, queue
> something else on top and push the result out, as it won't build or
> test the tagged version, which is a bit sad.

Nobody forbids this... ;-)

And I was wrong, our current GitHub workflow _is_ triggered by tags. See
e.g. https://github.com/git-for-windows/git/actions/runs/83103626 which
was triggered by v2.26.2.windows.1.

However, you also see that it failed due to the reason I described in the
commit message.

I guess that we should either go with this patch (which would trigger full
runs also on tags), or we could alternatively trigger only on branch
pushes (and not tag pushes)?

Ciao,
Dscho

>
> >  ci/lib.sh | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/ci/lib.sh b/ci/lib.sh
> > index dac36886e37..f151e2f0ecb 100755
> > --- a/ci/lib.sh
> > +++ b/ci/lib.sh
> > @@ -1,6 +1,7 @@
> >  # Library of functions shared by all CI scripts
> >
> >  skip_branch_tip_with_tag () {
> > +	test -z "$DONT_SKIP_TAGS" || return 0
> >  	# Sometimes, a branch is pushed at the same time the tag that points
> >  	# at the same commit as the tip of the branch is pushed, and buildin=
g
> >  	# both at the same time is a waste.
> > @@ -151,6 +152,7 @@ then
> >  	CC=3D"${CC:-gcc}"
> >
> >  	cache_dir=3D"$HOME/none"
> > +	DONT_SKIP_TAGS=3Dt
>
> Quite straight-forward.  Thanks, will queue.
>
> >  	export GIT_PROVE_OPTS=3D"--timer --jobs 10"
> >  	export GIT_TEST_OPTS=3D"--verbose-log -x"
> >
> > base-commit: f72f328bc57e1b0db380ef76e0c1e94a9ed0ac7c
>
>
