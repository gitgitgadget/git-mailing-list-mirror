Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AB0C54FCB
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 13:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C03F520724
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 13:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="kp/5zdeL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgDYN6L (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 09:58:11 -0400
Received: from mout.gmx.net ([212.227.15.19]:36113 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgDYN6L (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Apr 2020 09:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587823086;
        bh=VOSRCzigO1TSO9kEZi2+Ecu8tpoOErmcE3XszdkPHoY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=kp/5zdeLHbEoY3Kb71ntjarxDzbt3gjKBf2icM9uIV2L+20c85RULIJECDVWPrAmW
         QongEFzBoKgm1Fqjg7SXGs4fkBkf0mZqTBLMXXL+w1SaI+OID8qD5t8carOvZhRn7a
         TnKnVln1moKE6tjN1krb9jc42GolEPn5zqJJnUco=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.212.117]) by mail.gmx.com
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Mplc7-1iqJvs3x7t-00qD7J; Sat, 25 Apr 2020 15:58:06 +0200
Date:   Sat, 25 Apr 2020 15:58:06 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v9 00/10] Reftable support git-core
In-Reply-To: <xmqqblnhg99e.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2004251555240.18039@tvgsbejvaqbjf.bet>
References: <pull.539.v8.git.1585740538.gitgitgadget@gmail.com>        <pull.539.v9.git.1587417295.gitgitgadget@gmail.com>        <xmqqmu74mwaw.fsf@gitster.c.googlers.com>        <CAFQ2z_OhWDzc40WMy=bwUKRJQ4rcvnFmYvk-ga_cTtCjviMoBg@mail.gmail.com>       
 <xmqqftctg9om.fsf@gitster.c.googlers.com> <xmqqblnhg99e.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:86jEeyZixUkAIuMp66/9j2A6Ge+/2hn+uxUEesm6HdaDikBzsYO
 PjJY96z4QN5JLw5dOEAhk6FGdDfqkLsgozG3uXfpb7PkVwgGhBzOELyP/co1J4eIwWDgw/D
 YiDjnPRkgThwzcJ30q+lCu7f6LmYSFS9gdXAX/hHD3aupNefbvct9BLU4+yg6QNwueC99Ca
 3VEwU39Wq3tMQ0BLVNrkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3H5Wi0naroc=:l3iTAjYkMOeU1YsBV1BnBk
 /vbRqF+b/u1BaqMCj8VuZSfQtdndSie3RpfFf7+uaUQ1CMAmP5bz6HdE08N9FFOAr5hx4tro6
 2YB7p0MCABQ+4uwJquHLKE7us6OwkUdw5DKnLpXlCepzLQLD9dhlcTLZNh2SVqvKwBgcVoUk6
 1vekRjQepegv84YkVZx1zaRnFQgKXJirXrJBhpOxj3lmt2aqySg0B5K3hCjzfDIYwiBIj2sC0
 uSedRQVRtBUvWE4NKHaI1y0Bd3C1Sj98vVXbxTY1HYfCooc6T9rqmkbd9QvLAkEoNm+CUe748
 1BUcb7pX7KQtkCwjsrkPb0z4qOL2EovHjLdaTTJv7xLaxqWM17BotFlYWLhCgbKwouYmdG9Fa
 LysgfrhVP0uy5cirYNqzVEQUtTruWAX+8wFvcWBUSAQ23HluC6YIH2T3NXeL9fT69eDgAi/RR
 o1TL+g6XRKa2l9tZ2dP9RHAufbMVm0rzaAE4tXoQQ1yA+tTV3lRZ3rxfwl7Ykg+fZccnRjmhA
 RhdLCrWv/A3t8ZlgCofh+G0vMhcugHpr0ZXohL3i7Intz2aWA5JWvP3ItylTzKTUDtnLtVso4
 whA3rBy0mbhLQwJNqY3PSIKZoli/w71Gia80e+ROWdatzW/p9z+hQER+HhRj2ptSW40kUozm6
 N1oTmxoEAQn5ptx7bq+e7MSQ/4+4BeMFpGy3KAf9TPT0XzoZsA9BmZwi4Euv0XU0sIlfP/Tur
 Yft4D0XTLiWhEiDZhWNrrRb6MoTe6SpnO5h2zR01iljrTOTMYVpsRutWhHTdcpR0FCp/v1jCu
 xGjApoz83YAPpAPpfsJMfsIgKYPeRef31K4MaZEtr2qsxc9soUJLHYen/1XGnhhMtRFNcQx5U
 IXpJEvPu6GlDD3+bGEN2ii+uczeFa87Bv8EnjAKOUhDzkjQxyN03W2WpA94If4dMruxlSjcp9
 1O0uWpDm+bJOQxe1JPDZi5Ie5h0EEB+GG03I4ibnD32o0vAaENixR76w37nFpfzsHcLXuB3qn
 6nIezWCqSpBvWgAouFE4VuiaDvrR+Apx6ZJqq69PjBFgFOSYPR5s46lxL6IJ0t6eV9td1vuJG
 mqzm99ptS4V2+EdngQ9uZGPS0bq0Uw/UPLmFJ2z5f2Qr5ey7mxccK361JMLPn3rVf2r1Vggkh
 bZOnPaJVdRNI9fPhDhx2mS0+jIh35VsYI1ityJ/Elx5scl08lVa6/19WIdvdO+Ot11MW8Jic+
 60QJfPwI/w8zKWy9b
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio & Han-Wen,

On Thu, 23 Apr 2020, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> > Han-Wen Nienhuys <hanwen@google.com> writes:
> >
> >> For example,
> >>
> >> not ok 10 - check rev-list
> >> #
> >> # echo $SHA >"$REAL/HEAD" &&
> >> # test "$SHA" =3D "$(git rev-list HEAD)"
> >> #
> >>
> >> What is the right way to approach this? Should the test use
> >>
> >>   git update-ref HEAD $SHA
> >>
> >> instead of writing to the loose ref?
> >
> > Preferred.
> >
> > I didn't bother checking the context, but if the test is checking
> > "the history leading to $SHA has only one commit, i.e.  $SHA, and
> > rev-list can handle that correctly", certainly that would be a
> > preferred rewrite, rather than skipping the check for reftable,
> > which may risk not noticing that HEAD is broken with reftable.
>
> Now I have.  The test is about various low-level machineries we have
> work correctly even if .git is *not* a directory but is a "gitfile:
> $other location" (which is an underlying mechanism for multiple
> worktree support etc.), and it is making sure "git rev-list"
> understands HEAD in such a repository that uses the gitfile mechanism.
>
> If I didn't know it, I might have said that "if we are interested in
> seeing $SHA is a root commit, we should check it more directly,
> perhaps by making sure 'cat-file commit $SHA' does not say 'parent'
> and that won't need to write to .git/HEAD at all", but the point of
> the test is to ensure 'rev-list' works correctly in such a
> repository, I think "update-ref HEAD $SHA" would be the right "fix"
> for the test.

I believe the common strategy for this kind of thing is to

- introduce a `GIT_TEST_*` variable that is used to change the default
  (follow e.g. GIT_TEST_COMMIT_GRAPH as an example)

- either add a prereq that guards the test cases that cannot handle that
  knob (!REFTABLE in this case), or follow GIT_TEST_COMMIT_GRAPH's example
  again and _force_ its value to 0 for those test cases.

Ciao,
Dscho
