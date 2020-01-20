Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31352C2D0DB
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 12:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E94208E4
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 12:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="DKhFSuzQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgATMCJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 07:02:09 -0500
Received: from mout.gmx.net ([212.227.17.22]:47741 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726573AbgATMCJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 07:02:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579521714;
        bh=gmix3ps6on/3ccoEkWV9haOwH27QBWE4ot+QHiJmsiA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DKhFSuzQwx6V5YPFyCo+VjyXzvP2NFUBBQYTFAVkEWvCocP+UyTFjwu3LxIBY8ZRR
         V9VBnCKMZJsUaKs2OHA/fFFe0VZzNm4TsWvAvgcBfaCBVUw9nRVfb8uCstlrjtiPpV
         HpYIULcPRuOv7WOB7iTsb8e4L1/L2OzwjA3jwru0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7sDq-1iyRQh3hAI-0051EN; Mon, 20
 Jan 2020 13:01:53 +0100
Date:   Mon, 20 Jan 2020 13:01:54 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Christoph Groth <christoph@grothesque.org>
cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Stat cache in .git/index hinders syncing of repositories
In-Reply-To: <87d0bgs9o4.fsf@drac>
Message-ID: <nycvar.QRO.7.76.6.2001201248480.46@tvgsbejvaqbjf.bet>
References: <87v9p9skjz.fsf@drac> <xmqq7e1od41x.fsf@gitster-ct.c.googlers.com>        <87pnfgshxu.fsf@drac>        <20200118194204.GC6570@camp.crustytoothpaste.net> <87d0bgs9o4.fsf@drac>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-170324354-1579521715=:46"
X-Provags-ID: V03:K1:o/1a1uTMVz2UgJMgk2/0tsSXbCWSLl2N9gES4BP50tWqTNh/5h6
 1IfwYGlmSzYa0jmjPOhYUPX9Pa0YyctjYBFVCd0xWv/a3NwTvSO+NqEo357HqAMNdPM6BNm
 VlKR9vEC5RyIvGFAC9ZOrHXSSrKE3eemLtZ+htKBOK9Hjt+Q6XUidkMvBDqootmuc3uYrqa
 av+NEGjktSS2mEMWKie+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2YCFZ3Kop3Y=:Gdy1rZzpcQIxuAeWkd0NYT
 ZhRwsJxwrudbyjKDHrpQCCIEhXFo9qiDqQoH3vh3SW9Z4L6bC08qtqKkUlra4ioPJpEHskTZJ
 AG0/mSsr4h/dpTfPFM6zbKxLiuR2egwP0a713PvE8GjvpiL9iFJCqL71K7TpsmJvJWewW97Me
 iNf1qVstSPnhLA6aDEJFqUvHEaHPzqKjrH7JBsSyZoyONGs02p1d3Yr+xdwvIUY2Sqa6+OcGQ
 CPe5wIYW5ILjW9LA+xFpF0bHjUpa/RLo7MJlt4hAp/88M4V3dJlHvIVJqxxkHmvlnFPKeM0rb
 //jn+p2oYFTDxUl2a/st7ab6YrOtIRhEXxYzuUm/ytymJ6RoVY2tLZi5M6vbRhECTICJ3EbnQ
 fjcPRyCSse/KXnyQ+PcU0FfaIdTK7MlA16kRVcHLLyWRkBfA3o/RD9nENsphTFbwwY4Vrr8kI
 T1YNyX/7tKuDD5pvO03AL0fWkZmsKWVoRNZxcktlIwBlq0Vl3SE4ADCiWlaHvuwlB7CRo7BAG
 e118r/xikf3fi/CE7Cs/pSCOE7fOX5lBAqmP05jkK6nHXS4jgnv1szT6YEOLU+J6KpgYWGkJ1
 2S1yG4WADTdxhP49QQx2nOw4/4U8lvq3acaJuYgAF2Cw4GvDO5uhDZWcsn/gLqD+0AfqlOP/Q
 GqtDDb13NiXbmiTh5vOrC2VLUKHScgRUZwIKCjhiU6HDYO2YnTS+6TFH0VSCH2WpIkFrg5vLL
 pDgfklgIBJV/xTazP7djFzSc2nlj3hRKZSx84luteiPcNSnOCLUGtNG7SdoXkS3TSeno05jVL
 bcmVvU0fcrsh2066ffqtsGPCWsnM8n/9xV9HbqKEBymd2IDxWPzg4N/OuqNc/1IcytWSGU8UH
 I1vp0lDzPbTnagJuT4cRWec2n/M7w/oG+EKozjDuKSCrFZilH3nHiEOdTeIamNXES92eEkVYf
 2tuoxvYw9madS0xM0wxF+AsqLW3Z7HxGS0v1fM6YcnGCb2sYz4IPJrRk+WuVwsFGe1Bwnm2iB
 CHpYQQjR96MgQTO7A1XS0XAe3bzhThdY6bCnclhq6alG7QZ4efeFK+FeRYVHJRxWep/it8XwE
 DDl9ZvKGPI2vq2Mum2oGPahYSgk4XzwAYqMMiqNVs3GEDqFIzsvhU928cOHFXQLHhafKx6pcc
 3+PJXXMTEOGpIS2Ij/h7YO8aq+mwpjYpYLm+totwhzTNGmk0BLCBJt7tYgCQ8VHY3qPHGp89w
 zIPe5UnAsXtsvglBAV3uXc1iirr2ccaE0jh8ZuQXbm/PZvrTi4/imdXKtaR0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-170324354-1579521715=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Sat, 18 Jan 2020, Christoph Groth wrote:

> brian m. carlson wrote:
> > On 2020-01-18 at 19:06:21, Christoph Groth wrote:
> > > But if the above is not feasible for some reason, would it be
> > > possible to provide a switch for disabling stat caching
> > > optimization?
> >
> > Git is going to perform really terribly on repositories of any size if
> > you disable stat caching, so we're not very likely to implement such
> > a feature.  Even if we did implement it, you probably wouldn't want to
> > use it.
>
> OK, I see.  But please consider (one day) to split up the index file to
> separate the local stat cache from the globally valid data.

I am sure that this has been considered even before Git was publicly
announced, and I would wager a guess that it was determined that it would
be better to keep all of Git's private data in one place.

Now, you are totally free to disagree, and even to work on a patch series
to separate the stat cache and offer a compelling argument why this change
should be made. If I were you, I would not expect any other person to be
interested in working on this.

> (By the way, even after 12 years of using Git intensely I am confused
> about what actually is the index.  I believed that it is the "staging
> area", like in "git-add - Add file contents to the index".  But then the
> .git/index file reflects all the tracked files, and not just staged
> ones.  This usage is also reflected by the command "git update-index".)

The concept of the Git index is slightly different from what is actually
stored inside `.git/index`. You should consider the latter to be an
implementation detail that is of concern only if you want to work on
internals. Otherwise the description of the index as a staging area is a
pretty good image.

The staging area contains of course more than just the stages you changed.
It contains the entire tree that is staged in order to become the next
commit.

If you asked a worker at a theater to make a minor change to the stage,
you would not expect the staging area to be empty, either.

> > However, there are the core.checkStat and core.trustctime options
> > which can control which information is used in the stat caching.  You
> > can restrict it to the whole second part of mtime and the file size if
> > you want.  See git-config(1) for more details.
>
> Thanks a lot, that did the trick!  I=E2=80=99ve been already syncing mti=
mes.
> Setting both core.checkStat and core.trustctime to the "weak" values
> made the spurious modifications go away.

And of course now you have a less performant setup because files have a
much better chance of being "racily clean", i.e. their mtime could be
identical to the `.git/index` file, in which case Git has to assume that
the file might have changed, and the index has to be refreshed.

Just saying that what you think of as a silver bullet comes at a price.

> Still, this is a workaround, and the price is reduced robustness of file
> modification detection.

You misunderstand how Git detects whether a file is modified or not.

A file is re-hashed if its mtime is newer than, _or equal to_, the mtime
of `.git/index`.

So no, it is not the robustness that is the problem. It is no less robust.
The problem is that you force re-hashing where it would not be necessary
otherwise.

In general, I am not sure that you are using the right tool for
synchronizing. If you cannot guarantee that a snapshot of the directory is
copied, you will always run the risk of inconsistent data, which is worse
than not having a backup at all: at least without a backup you do not have
a false sense of security.

Ciao,
Johannes

--8323328-170324354-1579521715=:46--
