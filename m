Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D00C2D0E8
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 13:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5ED220787
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 13:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="XK0Y9EFX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgCZNqG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 09:46:06 -0400
Received: from mout.gmx.net ([212.227.17.22]:35749 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728048AbgCZNqF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 09:46:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585230353;
        bh=z+DrtFZem/oDHlNLpJY3EfTh6hzK1N/6gyo0qwRml8s=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=XK0Y9EFXlHAklf7RAQ6ZA50GmefxizgUP+uJ20rKkqIQR1SKNg1HIEznpMXQ4sk2n
         YYFenGPHYN1qyBDifmyrFYUkmOc+/y4m55fP5Kh7eHv+YU8dG5nOF2vgbLvnMRwjA1
         Lxvg4H07WW8VWki0c1wZjcVQGXMnUFi+6laM3JDs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([213.196.212.82]) by mail.gmx.com
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MI5QF-1j3wRS0q5n-00FCg7; Thu, 26 Mar 2020 14:45:53 +0100
Date:   Thu, 26 Mar 2020 14:45:53 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/5] tests: do not let lazy prereqs inside `test_expect_*`
 turn off tracing
In-Reply-To: <xmqqwo78wdq9.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2003261443550.46@tvgsbejvaqbjf.bet>
References: <pull.728.git.git.1584968990.gitgitgadget@gmail.com> <pull.728.v2.git.git.1585114881.gitgitgadget@gmail.com> <0767c8b77c820cfc03bbc617da4dc9f20ba4a46a.1585114881.git.gitgitgadget@gmail.com> <xmqqwo78wdq9.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1564349786-1585230355=:46"
X-Provags-ID: V03:K1:CiXzuhg6ZfB8zSnJWuo6vmL1gLWiA1koglNhmT6Cu0SO2aVA90U
 b8skAMvQcUBnOTNQZqWDmU0782w4rqHqTuS2965CCkcLVaTNheKfv+rxVtfXxL1UEDnVx1n
 Y0JrxIRDEira/PN4oSnDR0+DZU1dLwIm67SG7rqBHMHusCpXOZDQK7Y4E9ue4PwIo1XoKxO
 JYV1NdXWfarpwQ+j/HiAw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tfg3cBZs9yA=:VCin9i7sAmDQQPR6rpRBby
 0iQLCzjJK18uySKwfzxxGDT1MApLF97nTgPxMpDybFSHKasQ/1DPk9J/7LSnsFBRi32OmK1as
 KXwvaDe1vWVtt/evBLRN8zw17vb++lr7YENRoFj6QT9iy3dEC3nh/r5a+xcVoQbTYn0le9vC8
 Ta2r7DcDGkDADOZNQn+Huje2ub2FQ58zbEPjctQ0YDr7AXcu8b+cCTdag1kWZbrOfolTN5FNZ
 DEGAvxLiYLqc7DVaAi0dEWqnUM1wlz+L8ZIW+6M17og2mTaVsGNIL34trwX2wQiPPIIk3TNB3
 pPSBUN6LBN8Dj72hI2JoCX5CLZb3yi+lVHi4OjZKhV4BS5BZ6/GytglGK2bZZM5Rh8jxoYlEZ
 sYy4EIzMQXjD5+zf/6IGLRMS6EWajAMd/odAp3KYIWh6iqF3sV9qGqNoyx4Yb7zNwgau5y5ws
 GFCwI1wXQ7wgwlRtDflSD6zTvsd8yoIMoVF12KoUEYjdbkbGkFSNtejbhf8OVCqvQJVbXFLHj
 mqnMbZnysEUHKDMpD9J/JOwbyjtqM8UPRGNJ/k8uXo36DaosUmR5SkUQ7EiyIHuo5tT2RgW4v
 2iewxOnSbzT+g1fyJ0rPe8xAKGq0bckAi+fzy0dc5rktX9549zkaNXeaTwKlFihurPWXFsT8X
 sEQYhJAJ3cgTxU0abKfyqEkGxhCc+vxtpJJd0SHnXqS6SRiWLknsalLfoIaF3IZTS6aPXhP8m
 HvFggD8PYp7T80EXYP9M/EQlLQljtTJlBh2b99JWn/zSY3IY0SBEQ/fDo7o8wlIuzXLqnhW2d
 V1Nfdtep53KJ1vc+POUE5gAHIF5awNgf0yT+Gvcw54T6Zvu/tmRA6IFAzxN3BuMagXq4qg9QT
 F9TqCWcNDjx9lL8WZ54OFrHw1wwbwfeMST8o/gbJSIx21nTpOyqBFMILf6PjzIwII9V32ta4u
 g5xKJ+GDheFnRYU/jpyxNJ+c0dsZQw2VKb2r6swePK++KQijeNqbrNalEFE10KgbEYbsLC0sV
 mujt2VOXt/zt1zIL8cR7QRsQ12aAITFVU7BjdCpcXNUN3NrkOktCIpP1b5bRLucpg2CDIAxOS
 e/t04rY/2Fd58yTlxeemFPKzyCGp43OQ5PdMDullgrB9YU1D0rwp1RkNvAwI5GJp9V7zSbV1o
 GVmNnZlVQvvYkBQ4jzdEFwBz6EKZQf/QQfd8RLB+Blk5T3rTiByt7f7O2CoGA+2fAQ2wl78hJ
 CtPXC7IB78dFXWBCD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1564349786-1585230355=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Wed, 25 Mar 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > The `test_expect_*` functions use `test_eval_` and so does
> > `test_run_lazy_prereq_`. If tracing is enabled via the `-x` option,
> > `test_eval_` turns on tracing while evaluating the code block, and tur=
ns
> > it off directly after it.
> >
> > This is unwanted for nested invocations.
>
> Nice finding.

Heh. I found this ages ago, and mistook it for "all prereqs turn off
tracing" when I reported it, but G=C3=A1bor pointed out that that is incor=
rect.

That was a long time ago, maybe even a year, and I finally used this patch
series as an excuse to finally dig deep on this.

> > As we will introduce just such a scenario with the GPG, GPGSM and
> > RFC1991 prereqs, let's fix that by introducing a variable that keeps
> > track of the current trace level: nested `test_eval_` calls will
> > increment and then decrement the level, and only when it reaches 0, th=
e
> > tracing will _actually_ be turned off.
>
> Doesn't this explanation urge us to reorder these patches?  It
> sounds to me that it argues to have this step before 3/5.

Yes, that's where I had meant to put this patch. Sorry for the confusion.

> Other than that, both the explanation and the code look correctly
> done.  It looks to me that the surrounding code favors trailing "_"
> instead of leading one for private names, so we might want to rename
> the variable to $trace_level_ but that is minor.

Good point, I had missed that. Will be fixed in the next iteration.

Ciao,
Dscho

>
> Thanks.
>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  t/t0000-basic.sh | 13 +++++++++++++
> >  t/test-lib.sh    |  6 ++++--
> >  2 files changed, 17 insertions(+), 2 deletions(-)
> >
> > diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> > index 3e440c078d5..b8597216200 100755
> > --- a/t/t0000-basic.sh
> > +++ b/t/t0000-basic.sh
> > @@ -833,6 +833,19 @@ then
> >  	exit 1
> >  fi
> >
> > +test_expect_success 'lazy prereqs do not turn off tracing' "
> > +	run_sub_test_lib_test lazy-prereq-and-tracing \
> > +		'lazy prereqs and -x' -v -x <<-\\EOF &&
> > +	test_lazy_prereq LAZY true
> > +
> > +	test_expect_success lazy 'test_have_prereq LAZY && echo trace'
> > +
> > +	test_done
> > +	EOF
> > +
> > +	grep 'echo trace' lazy-prereq-and-tracing/err
> > +"
> > +
> >  test_expect_success 'tests clean up even on failures' "
> >  	run_sub_test_lib_test_err \
> >  		failing-cleanup 'Failing tests with cleanup commands' <<-\\EOF &&
> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > index 0ea1e5a05ed..dbf25348106 100644
> > --- a/t/test-lib.sh
> > +++ b/t/test-lib.sh
> > @@ -882,6 +882,7 @@ maybe_setup_valgrind () {
> >  	fi
> >  }
> >
> > +_trace_level=3D0
> >  want_trace () {
> >  	test "$trace" =3D t && {
> >  		test "$verbose" =3D t || test "$verbose_log" =3D t
> > @@ -895,7 +896,7 @@ want_trace () {
> >  test_eval_inner_ () {
> >  	# Do not add anything extra (including LF) after '$*'
> >  	eval "
> > -		want_trace && set -x
> > +		want_trace && _trace_level=3D$(($_trace_level+1)) && set -x
> >  		$*"
> >  }
> >
> > @@ -926,7 +927,8 @@ test_eval_ () {
> >  		test_eval_ret_=3D$?
> >  		if want_trace
> >  		then
> > -			set +x
> > +			test 1 =3D $_trace_level && set +x
> > +			_trace_level=3D$(($_trace_level-1))
> >  		fi
> >  	} 2>/dev/null 4>&2
>

--8323328-1564349786-1585230355=:46--
