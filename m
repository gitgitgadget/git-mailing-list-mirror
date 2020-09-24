Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C01C4363D
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 10:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A305C2399A
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 10:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="OlZr/qWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgIXKGs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 06:06:48 -0400
Received: from mout.gmx.net ([212.227.15.18]:46319 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgIXKGs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 06:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600942005;
        bh=sFimeTyAUez2s0HRpRhgnQSgORTxBq99x7MTq7hMw10=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=OlZr/qWt3KL0rZKCT/GX2sEo2GUrMlpkC1f0GKKKqfLZf/x7Zn8JV3L9unu4EqiKx
         NZkmMWBRnkhaivQlO/j14Q50f52TZQ1jNnJXmqPW7q3BqjB7Zq5cx5EcAsgGe4JPfB
         CaEX+JM6ST5/m4jgZ6I7wauuo/cWIpvaPAculY4A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.89.169] ([89.1.214.175]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQe5k-1k7a7P2ylK-00NiHf; Thu, 24
 Sep 2020 12:06:45 +0200
Date:   Thu, 24 Sep 2020 09:56:38 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Christian Couder <christian.couder@gmail.com>
cc:     "Miriam R." <mirucam@gmail.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH v7 00/13] Finish converting git bisect to C part 2
In-Reply-To: <CAP8UFD1fXBChG3691HrKmbN-4vThCE7=0bL+Ty8-u4FFGTn2tQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2009240952300.5061@tvgsbejvaqbjf.bet>
References: <20200831105043.97665-1-mirucam@gmail.com> <nycvar.QRO.7.76.6.2009031403510.56@tvgsbejvaqbjf.bet> <CAN7CjDDVp_i7dhpbAq5zrGW69nE6+SfivJQ-dembmu+WyqKiQQ@mail.gmail.com> <nycvar.QRO.7.76.6.2009231647370.5061@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.2009232316570.5061@tvgsbejvaqbjf.bet> <CAP8UFD1fXBChG3691HrKmbN-4vThCE7=0bL+Ty8-u4FFGTn2tQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+mXzJKPoW6qy8sknWJ71fmhGY7vNc+4ie+98hzk3Ii/eZl1xQlJ
 II09OE4Pf9j+18oxg44c1TtR3AUXDB2dFHUQMMXAnSekkVjqi+HLMs1Ozc3tmJplgUyUfTP
 meOR/KKCPUdJCGkzRgXQ4yl0yuMCBCa4Ay7KDliNqEQefqh/bLQYsdTaH/2mi0U8wKKhiQ9
 pyXpfLDYcwNPdCX0mFD+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k90ZGxXy3XE=:zk6arLTaRsmQETmgk805C9
 vb/yxEjeLI5MzfhSPk+/XkWED6TP37+HN7YgWYA9OLveYRkwTJn3IYDlEWJ04UHWf/yHBKWcW
 TY/QzaPnSCB6Ilgf2msyrcl728LP/H4xSIytemYuw08HSNLDOYs5Xi6K9EdK/ryBT7BdGqf9W
 HSQ9Th5lutoQ0nSerSai0RFt6VZhyThn1ORk5Bj1FRtpr2wRKBB9MJZ6RLD5TAIGzjwt+JfhN
 x/XXTXgUj941Qb3t27/GCsCQ0O9J/EKavHbs5HXRLwf6hQLt0j7NnG+GXvSZV4asIwLoMlI6p
 DDPAXL55LomH5dLWoRmcALQ9kt8AeyNpc+7eGv4VVXNDnFyaxQ6rup062auEoDIy1CLaQl7le
 rTEN7uMJ3jthe0sLScBg409wnayxsC/+djrZZ1d7v8xMPl8mdvpQ5G4NlVMwXAyJHNQx3Gstz
 B/BAUXXfgKW2cO22r+aSfP/Yz21zNBMVbPjw5ohlgLUM0vy2NO1+mhC64iv3al7R3uK4nhkdl
 FDvx1OEm+/J0eKnyI9PNd4BFmMbuZoEEErKESsK7lR0uEkhoO4QqdbRMpD8rO5ZP1GWgjWMk7
 B2JUFdg6whapFUSpYAWXvVsQi0og40Cexs4Gi9Ov1EwVDiwa+J+aOhpQOGvVf57E8HjpS5SIs
 0YuNi/+pOh0aidFueqnQfYoosYPJaBPUGIZ2WGlQD+2rFuwxGUIUGQUEXX32hmljJeZiaWTk3
 wssiiaXd38wFPVY5eMVRBF/0t0AMI8W5IIFllQ1CnLemY2rHaiKcBy7AjNPh6xkz2er9Mq4q1
 6nQmhkv8iyZE2sEcdJfu5Ckwf8FGB9VScaM2/xMkH0Odj4EkdT2Aa9VXzdhJXJukE3hVwem1r
 W9QUIBuEDR5dI6vFG3cUn6SFCICu09yblb901Rxz/2FY5/UhpCgeIUPamd6zmTiI2Ps6VMvWV
 IcGnt3ToVfkSObFpA8G2nrTwTiyD/FlujjLFdXI//bz7PwJG5V8CcOPMYburfpuhRJ9Z/aSoz
 ZN2EYLlUg/vZUiNhLwyTHbyRPXjNc5IYRw+vr1po7hdUSNtI9mCwCeXtrLtzhPjtdh5/MxfN4
 v7+DBPt9dUqUCf8DiTDEphgu8tQn5fuiTpvYNyeIiF2KK9sqxDZkqQQVWX2vGGvrrUQoTA/U4
 /YDbVuQ6J7MLNFnWIEFbK9WXvHHxoDl5UBYwEodTi4GBsEsp5TFTi/D5w6ZeSHGNTDhDBWy22
 SFLB7+LXPlJh9qxwAY/744fkqGIuNFTtKx1S3nA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

On Thu, 24 Sep 2020, Christian Couder wrote:

> On Wed, Sep 23, 2020 at 11:26 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > On Wed, 23 Sep 2020, Johannes Schindelin wrote:
> >
> > > On Wed, 23 Sep 2020, Miriam R. wrote:
> > >
> > > > Applying some of your suggestions related to removing some 'eval' =
in
> > > > git-bisect shell script, a bug has appeared. It seems it is relate=
d to
> > > > a previous code merged before my internship.
> > >
> > > Now you got me curious: what bug did you see?
> >
> > I found your fork and ran the test, and this is the first symptom:
> >
> > -- snip --
> > [...]
> > ++ git bisect skip
> > Bisecting: 1 revision left to test after this (roughly 1 step)
> > [32a594a3fdac2d57cf6d02987e30eec68511498c] Add <4: Ciao for now> into =
<hello>.
> > ++ git bisect good
> > ++ grep '3082e11d3a0f2edca194c8ce1eb802256e38e75e is the first bad com=
mit' my_bisect_log.txt
> > 3082e11d3a0f2edca194c8ce1eb802256e38e75e is the first bad commit
> > ++ git bisect log
> > ++ git bisect reset
> > Previous HEAD position was 32a594a Add <4: Ciao for now> into <hello>.
> > Switched to branch 'other'
> > ok 22 - bisect skip: add line and then a new test
> >
> > expecting success of 6030.23 'bisect skip and bisect replay':
> >         git bisect replay log_to_replay.txt > my_bisect_log.txt &&
> >         grep "$HASH5 is the first bad commit" my_bisect_log.txt &&
> >         git bisect reset
> >
> > ++ git bisect replay log_to_replay.txt
> > error: update_ref failed for ref 'refs/bisect/bad': cannot update ref =
'refs/bisect/bad': trying to write ref 'refs/bisect/bad' with nonexistent =
object 10006d020000000068986d020000000054f65f00
> > error: last command exited with $?=3D1
> > not ok 23 - bisect skip and bisect replay
> > #
> > #               git bisect replay log_to_replay.txt > my_bisect_log.tx=
t &&
> > #               grep "$HASH5 is the first bad commit" my_bisect_log.tx=
t &&
> > #               git bisect reset
> > -- snap --
> >
> > So I dug a little bit further (and applied Christian's patch in the
> > meantime), and it turns out that the `eval` has nothing to do with wha=
t I
> > originally thought it would be required for: I thought that it wanted =
to
> > prevent `exit` calls from actually exiting the script.
> >
> > Instead, those `eval` calls are required because the arguments are
> > provided in quoted form. For example, during the execution of t6030.68=
,
> > the `eval` would expand the call
> >
> >         eval "git bisect--helper --bisect-start $rev $tail"
> >
> > to
> >
> >         git bisect--helper --bisect-start '--term-old' 'term2' '--term=
-new' 'term1'
>
> Yeah, that was also what I found (along with the bug I sent a patch for)=
.

I suspected that you had found that out, but I really wanted a record on
the Git mailing list about our findings.

It might be a good idea to add a paragraph to the respective patches,
along these lines:

	Note that the `eval` in the changed line of `git-bisect.sh` cannot be
	dropped: it is necessary because the `rev` and the `tail`
	variables may contain multiple, quoted arguments that need to be
	passed to `bisect--helper` (without the quotes, naturally).

> > Therefore, the `eval` really needs to stay in place (also the other `e=
val`
> > I had originally suggested to remove, for the same reason).
> >
> > I would still recommend appending `|| exit`, even if it just so happen=
s
> > that we will eventually abort when the `bisect--helper` command failed
> > anyway, because the next command will then fail, and abort. But it's
> > cleaner to abort already when this invocation failed rather than relyi=
ng
> > on that side effect.
>
> Yeah, I think it's a good solution.

Excellent. I think we can actually move forward with the entire patch
series now, not just the first subset, right?

Ciao,
Dscho
