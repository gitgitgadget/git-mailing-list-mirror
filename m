Return-Path: <SRS0=9bkr=2Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746AFC32771
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 20:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B64022B48
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 20:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="WDUmWBU4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgADUax (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jan 2020 15:30:53 -0500
Received: from mout.gmx.net ([212.227.17.21]:46551 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgADUaw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jan 2020 15:30:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578169844;
        bh=6IKT1Bdoa8Q1Ds9036avBtoESPFlq1O+cvxgpBYH7wQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WDUmWBU4HsCjRXnK0sg0WUWs8LImUa48JX45e8STkOuHGhc2sEa1c0cLUJ8wifeGe
         iVny0P0Qlq1yp3dCLG6bI65kitCBSXzc+wJczQB6BGO87mCLIvWa6Mts8XxSSBHL2Z
         SeSyZYbEXIpfcs4nAp67qh/rBJ9gT4wg9eu+w/Do=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MqaxU-1jRFLQ1wJs-00mZm0; Sat, 04
 Jan 2020 21:30:44 +0100
Date:   Sat, 4 Jan 2020 21:30:28 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Matthew DeVore <matvore@comcast.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        Matthew DeVore <matvore@google.com>, git@vger.kernel.org,
        Matthew DeVore <matvore@gmail.com>, jonathantanmy@google.com,
        jrnieder@gmail.com, steadmon@google.com
Subject: Re: [RFC] xl command for visualizing recent history
In-Reply-To: <xmqqk168cjn0.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2001042115550.46@tvgsbejvaqbjf.bet>
References: <20191029003023.122196-1-matvore@google.com> <20191031003929.GA22855@google.com> <nycvar.QRO.7.76.6.1910310851300.46@tvgsbejvaqbjf.bet> <20200103201423.GA20975@comcast.net> <xmqqk168cjn0.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:4cfUkB2HObBu6urhEuA8HTivjYAxgOlWaTgofIUek0bLwloYdwp
 KpkOUP2e3SrUc3LUQHUyuxEJ6CFLYjY/c0sBwpjrMFEYi9+d6nP6wMq5+AiVHPJlMpYdfsN
 aARhoyTGB5IQ6W8dcrQE6ghZQZlE3S5dqjAGieNNGVYwbI6iDNlKkN2VwnFlluGRpzb5uFd
 2WXXYh9GxagoWIgih53kw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iTdqH3zwFgI=:CyAi9hsoklmXk+Bovsknl+
 HJLbpbvh9u2o3r7ZVIL+KFJ21r5puwMKjvEuhJI2ZkQVzvJzHbjl0n+GYNZDEMz3lzlEyzdqY
 6YLAXPuft/H3FpU28p2UgFLwb2201xadZoYAlzzJwkZnAamMzF+4yeNj8DgvciiZXe8/MwUWw
 /QvVjWpGSvQcgHnRZBUygoT+TVBj4pM1xlQlg3D7J8thuM+tfdrFEe1mdNjPihuOhmwlyMoqv
 B2VHjVwkYdboeP2FODQqyXxyrBR5B8ta5ftN0I/B+lF4wtDssCPtOOYFOGin+pzaMwcaiG8rn
 h7pCb4d9jucqD5rvXvla1JD0PLH4HiPBJcNJyeLQLy9x3de8/yQhqnp9oC3JyW81N0yFbTmsK
 nPrGY5oeEg3xOcfgAUd1z3BzvsJmDJFu+P1SpgZexHnshdpTPcq/IukDcl/4bWf6DugTaraHw
 UZAx8xUnLa/yZ4Sd+BaSwJCE9K/5ulu9nI2m2W3vAknyAxuybDjJ0blq+naTPZ3fv8WriiCH8
 xS4J0IGOEvcbkhTaGzQ0wl0bg8dkqpJpYkx4fYE0AcCPN4Ul2m3HEV2L8xwd5gbIcODWbtGiH
 kHBHxPfv8dkQEhc+6IrUBmv3b73UR4z2DKfGg1zfZV+fBlz2qH57j8uDG7PjIxjLT04/hE30M
 8etdhsdcs2Ec5VYbvwmcvtAHafzYHJHaGgzZ1SF1jMlqVXMOJlLmx2mKHEB/H7S55aDHlikzG
 /CWN9pvIDXLZ7PUcCDCEfrbh5TU+FXIseZuWSAlr0XCDOM7xcGxQ68ZMJfQvLQ1wnUoC82jZQ
 APUehfLPBV0iwwX27kUts16O472/uFWFCdl+oC9yVGjue16KLFFHLc+Zh4DptKgzfvGpmkMu5
 7+qjArgKEG+UwL2IgJYImUXhgH1CpeNPJXkBlrcpiC1KshfsmoavCzHBoyXDIMgULURJwyqIV
 cwNokZ5enPqR66PV5eurGHDwhEXHFIfXTuVPNXUofMZz6/PTYMPOOaIiEqErbk7Ubh/ORmwkb
 AQimosWTYfy3egrQGDF/BJK1oozul54430zfIdNISB4678chWlcRuujt1TVyMUHh4m5JOekd2
 tL5t6NgeKjulSwHukioZXWugnPDWM2WaM1R2lXSOoAE1R1+d0I53OlO+ljJYmCcHIV3CXGWnm
 kDbCm4q83ujIu4sH/JNfv85gI0ayqKoL4g+PfPK5a7R334hSLKDyz5SRSkaj4n7budpVSrI25
 7IQ4WOzkwTrnWUG3fMXKc1kmPFyO+YCeC6WwqV85rVKWIFmeHgO0GZvNYLqM=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 3 Jan 2020, Junio C Hamano wrote:

> Matthew DeVore <matvore@comcast.net> writes:
>
> > On Thu, Oct 31, 2019 at 09:26:48AM +0100, Johannes Schindelin wrote:
> >>
> >> am stands for "apply mbox", and I think that the only reason it is no=
t
> >> called `git apply-mbox` is that the Linux maintainer uses it a lot an=
d
> >> wanted to save on keystrokes.
>
> No need to give an incorrect speculation if you do not know the
> history in this discussion.

Oh, but where would be the fun in _not_ speculating???

:-)

> Back then, the command to apply mbox contents existed and was called
> "git applymbox".  "am" was invented as a better replacement with more
> rational behaviour and set of command line arguments.

Now that you mention it, I vaguely remember reading about it. But even
back then, I was not so much enthused with the idea of exporting Git
history into emails and then turning those emails back into Git history
(now with "New And Improved!" commit names), so I did actually not pay
much attention.

As you might recall, I was also a fervent opponent of `git rebase` (which
I think was based on `git am` from the get-go), claiming that history
should not be rewritten. Well, what did I know. I went on to write
`git-edit-patch-series.sh` which you accepted into Git as `git rebase
=2D-interactive`, so there.

> >> Having said that, I do agree that `xl` is not a good name for this.
> >> It is neither intuitive, nor is it particularly easy to type (on a
> >> US-English keyboard, the `x` and the `l` key are far apart), and to
> >> add
> >
> > There is a subjective element to this, but I would consider it easy to
> > type since it is using two different hands....
>
> Give descriptive name to the command, define an alias of your choice and
> use it privately.  Nobody would be able to guess what "git xl" or "git
> extra-long" command would do ;-)

I thought I made the point already that such short names are prone to be
already used by users' aliases, and that shorter command names are very
likely to break someone's setup.

While I do not have any `xl` alias defined, I have 20 custom two-letter
aliases, and I would be utterly surprised if there were less than a
thousand Git users who defined `xl` to mean something already (by now,
there are _a lot_ of Git users out there, and it would be foolish to
assume that less than even the tiny fraction of a percent that translates
into a thousand users didn't use this alias). While one might say that
forcing a thousand users to adjust is not a big deal, I would counter that
we should not, unless really necessary.

And in this case, I deem it totally not necessary at all.

But again, I was wrong before (see e.g. the `git rebase` comment above),
so what do I know.

In any case, as stated before, I would like to see this feature be
implemented as a `git log` (or even `git rev-list`) option before
implementing a dedicated command.

In other words, this new feature should be treated as a _mode_ rather than
a new command. The command can come later, just like `git whatchanged`
is essentially a special-case version of `git log`.

Ciao,
Dscho
