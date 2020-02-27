Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4486AC11D3D
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 15:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16AF024697
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 15:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="i6/+3fYY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbgB0PmW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 10:42:22 -0500
Received: from mout.gmx.net ([212.227.17.21]:41289 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727592AbgB0PmV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 10:42:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582818137;
        bh=cLyTcQ/1e8RZweKto/SNzXtr9CJMrKXac6jUM3Ycwfo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=i6/+3fYYxfeAHkvbG5SybNFo2I7j/yGnc2Mq2jrUv079bTlcWKBx8ZLeOFHkFvWcT
         PzmM/bOWlnVUoGDq+ZX5yi3WcSj06lVL183sxOVVD4BqEfwMs2AJEmDohNqK7eCAMs
         yJW762K7HWRgqnKtL/ImvmmKhNgQ/Fw+tiXOz9GI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB ([46.114.107.104]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mw9QC-1jNdjZ0hwC-00s28K; Thu, 27
 Feb 2020 16:42:17 +0100
Date:   Thu, 27 Feb 2020 16:42:15 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/3] t/lib-httpd: avoid using BSD's sed
In-Reply-To: <xmqqsgixgfal.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2002271640520.46@tvgsbejvaqbjf.bet>
References: <pull.714.git.git.1582747775.gitgitgadget@gmail.com>        <9900cacbfefb46610114702e6d48d8020f3f2866.1582747775.git.gitgitgadget@gmail.com>        <xmqqimjthz8e.fsf@gitster-ct.c.googlers.com> <xmqqsgixgfal.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Ecb/HRHtRMjQCDkl+tvhKDhSyzY5iE4KTW16zbCyhktzzq4ywFb
 S3eRk+R/fA+HLWO/33VcgNRJBnpmH2XPV328x92ZmM/LeisWWJXD6o1DhJ+SakFLHbei3bz
 g6UetZWJb7358WcuMDX5OqRe9K4yXzh8CvPNYootmxkjIsXG/BY52fXz0ScUXXd4ApWnjDi
 r5410Xm3omvzqrjAO44Pg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:f7LH+gFcLA0=:XKPahwM96NtKuy7mA7fz86
 gnBi6t6WQCVnNGw61c2DsL0K4C0XdI+Y63MaPMBJyy8Zse+4hNE4VydWSdTaQ2q/VbRYlA/qw
 juMgY9ttdi4WSg+2kvfuaIdHvCxFT8bz1bctNL+3bEl9zFJo4u0rTC5Nm3fSCDbo+raEP9K3A
 suFuCqL/tKABYKlc7g/ADNCqTpr9MbX1Sdj9X1vqoftxuwAkuZ8JFhPrvksfze+n8dyCLvA8e
 tP+PR8r/G9sBpUAwyUUYvssgV4EAN0xG2zPkCyro4NqklmXkarF09q89tGlu+RNgb0J1JGN+C
 pScxiWyD9QGlzf5kqVPOp+l6XnDPQJZqRXvyAFhfTow5Q7NLu9Mj1/IA0ABUJD33aV/Fgl+h+
 ZIcZzlnFvBfBqKrEdnp6TT5ESJG1a2HA7adZgZ4eYGoG0st+oqeMcXAsHkQdKiptcOJ5Em926
 8ppWB75ryR63ojzUvg285IxU8judGeIpm51mdTHLptAfplB4T/DhYQfMH4s5TiT4/6j0wGRro
 G6ZLvT6m5lm56y7hmIJbqOzJySym69xrNUH/fuyQsR53wV/e+oyFFiFDdNZUlCZ7WtZ1cB51G
 5CEvE5n+DCpB1+rrk1OAKJfBg59i6MfB1ASwObI5CNQWWWBQNmlclUYLJxsv9cBwJCrKhpjpA
 wJHrXUasZHstHreevYNVu1GY3U8Pg5cS0Hbh0pzeno6d58nCMaytPPsA4uquwJGj+eN3+u1aV
 juKQcm6otCYtVXqMB/gYrrfoa+FwdWK8TsWSVKGiLS1S3aDZLHgIjHwjyBw3O1yGAVzT9ryMf
 TbHBgWxyiB4OHdqso3QUDZMPi8OjyclLw/6S7t/xKnRNdFtRQua3TyTFGS578O0fOkA4+729R
 t98xEFrDVY1JunYR53ONuXgVsjJ9cnjKVQBMGKJlwjZkISaMg9C1jTkvyR7nmc8LphLjqAiIQ
 n6CS9joZBCtX0pv2BpHNfydBB0Sz9bW1FbCiAkkEtVZe4CYS8TEWKUuvvUld4Ewz7smprHIas
 Qp1ohLKNWldTgk4Lp0evIQEE8X8IvzSA4ClyH5pozhOtYWBiA+0k5RiPCgq3++4buJTZOlj0s
 hOPUnuQRwHS8UgjPb/NbyG10SaxGGy9bL8SA5aSg1HKDhctk4a9NDEX3FC7lwl19nuED48Y08
 tr9TaLzQjeOVUc+nEi8iUTYcQM46sM9XvtH3LGo/V+ADlZdoBMJk9LE+2XnvBlpAgMULjXArt
 D5lssGzgbFSx23xwA
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 26 Feb 2020, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> > "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> > writes:
> >
> >> diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
> >> index 9e16512fe31..4f10057e9f1 100755
> >> --- a/t/t5537-fetch-shallow.sh
> >> +++ b/t/t5537-fetch-shallow.sh
> >> @@ -237,7 +237,7 @@ test_expect_success 'shallow fetches check connec=
tivity before writing shallow f
> >>  	git -C "$REPO" config protocol.version 2 &&
> >>  	git -C client config protocol.version 2 &&
> >>
> >> -	git -C client fetch --depth=3D2 "$HTTPD_URL/one_time_sed/repo" mast=
er:a_branch &&
> >> +	git -C client fetch --depth=3D2 "$HTTPD_URL/one_time_perl/repo" mas=
ter:a_branch &&
> >>
> >>  	# Craft a situation in which the server sends back an unshallow req=
uest
> >>  	# with an empty packfile. This is done by refetching with a shorter
> >> @@ -246,13 +246,13 @@ test_expect_success 'shallow fetches check conn=
ectivity before writing shallow f
> >>  	printf "$(test_oid sed)" \
> >
> > Hmm, shouldn't the test-oid token "sed" whose value is set up in the
> > setup section of this test script also be renamed to "perl"?

Ooops...

> > Or, if we are actively taking advantage of the fact that the syntax of
> > the replacement operator is the same between the languages, perhaps
> > "sed" is better renamed to something more language agnostic and
> > reflects the purpose/reason why we extend the packet header by two
> > bytes with the one-time munging process?
> >
> >>  	       "$(git -C "$REPO" rev-parse HEAD)" \
> >>  	       "$(git -C "$REPO" rev-parse HEAD^)" \
> >> -	       >"$HTTPD_ROOT_PATH/one-time-sed" &&
> >> +	       >"$HTTPD_ROOT_PATH/one-time-perl" &&
> >
> > Other than that, this step looked quite sensible.  Thanks.
>
> Hmm, is it because you wanted to backport this down to 'maint'
> (otherwise, your tests will start failing in a month) that you left
> the "test_oid sed" thing untouched?  If so, that makes sort-of
> sense.

That's a good point. I target `maint` in v2, and offered an add-on patch
meant to be applied on top of the merge into `master` (or `next`, or
`pu`).

> I expect that the series will be rerolled, if only for s/BSD/macOS/
> mentioned elsewhere in the thread, but in the meantime, I'll rebase
> them on 'maint' "as a practice" while queuing.

Thanks ;-)

Ciao,
Dscho
