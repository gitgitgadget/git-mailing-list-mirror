Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A02E11F461
	for <e@80x24.org>; Mon,  1 Jul 2019 11:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbfGALwc (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 07:52:32 -0400
Received: from mout.gmx.net ([212.227.17.22]:44107 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728075AbfGALwc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 07:52:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561981944;
        bh=rbwpZMNiH4NnSxagDP/JFpWLCXkokdQWmbXddSaPZAQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DDiQ9+q+ekDugCgcEbX5MgtJiyJx3Lnk6tItsHYOy3hIBsnwYPT1hjraihBuH3zSy
         0n9UgNiz1CGyWK1822jhx7orhz68vG+r8Mw/u1X/4hNk3Fya0NwN3eZes5aO01g1G5
         SYDY3MBWBkt1Pb6xpK4XUOpBj8uK4ToF5QqKQloY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7b6b-1hc8UX1y0r-0084OA; Mon, 01
 Jul 2019 13:52:24 +0200
Date:   Mon, 1 Jul 2019 13:52:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Vas Sudanagunta <vas@commonkarma.org>
Subject: Re: [PATCH 1/1] Let rebase.reschedulefailedexec only affect interactive
 rebases
In-Reply-To: <70648c5b-00ff-d7aa-f1f7-8bb7bf663829@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1907011350210.44@tvgsbejvaqbjf.bet>
References: <pull.253.git.gitgitgadget@gmail.com> <fab124da41858b849ae74dfb1fe403bb834870f1.1561623167.git.gitgitgadget@gmail.com> <xmqqzhm2ang5.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1906281342280.44@tvgsbejvaqbjf.bet> <e332eb5f-0818-763c-9de0-889644446a35@gmail.com>
 <xmqq4l498irq.fsf@gitster-ct.c.googlers.com> <70648c5b-00ff-d7aa-f1f7-8bb7bf663829@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:kEMLeTYEihRefUvHbNI++GKDRMAvNa0xrxNBmDcsH+IrBc98ySv
 mP90V49GiWTl3S4R3YLPcAMi0axykWodTAod3Xk9946rSkgfLP+Xc7dk5IB6U8Hb3jHmlFI
 sFUwPBqOoBvhMPSQDc1dsBBPI/ldX5WuK7+4pAGCC8Vlh1DQEhYGTzzGkzGEfwXQskoCJDO
 Cqdq2r/hZoSRdkaxgrlCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4ILOXleRt8Y=:62BX2mI/vwuz7AJ12LyTaj
 Ex9jtIWoAUTuMGp9l/EWTO1yqaSVuiublxW+KIRof17X30lhh2RXx4ksh9wmW8qYLqORQ0S3k
 7kpkIRa01lCszC6eHcb777ojfQJ80+ADY7HPTJJaRQRJrFohqAOLWvwJKDrMGBhj1wYdlluzC
 ieICPUw+5Yjefi1lArOmH6bBPWdAAH9zjGq0886Y6MR6S8yoPztYwFPjy5vI/XfVSV0u2W+DF
 lQksZtek5ALHgAeI75C1yDP7Jym7HTqOJlOiCkxGkmqjwvzzqMqVDraDjXO4InQoBPQ3gXBjQ
 vEVcxWCQD1czsXIrn8EZF744ZJdbtO92V+NleqWaPbVoXUfZAu2vFh9M8gF0jCPkWXwMFeolN
 jOuq4NpZD0nXyJOQZdcPoJ8+/yMRM3sRSiDDLzradGwQueBQtjv4q9UK5fnbBN0+MMDY8IItJ
 PB03ATnerSzJmtkSMS0DLfvT7KQXw4AsJrJsGWg7E5O2zcZfRpxyX/B4SUlVR6kGQ8E+fgzRS
 DEJJdkvT1dIvKV/Rg0dwj8/5UnA7Wtnisr+SsiLDW0hcf1XQt+glpUK4PAiqV794rnNEPGyHw
 YSj9CHjH+f1AlO2Ol1bb/Dm1wDa4T87Do1C8O7ZV9gVqTNOuDq82YfLBh/WOesZjs7SApTPRH
 s8hppj7sJr2s/mE5L+TPaJcxJG0cOLQQRlSTCi9qGWdSMaEY30Kzckj/0onaAxFjq9NtDc4S7
 QDaUwEn/3exIahiAFgoMakMhBRcXjHRHWcYXd4xQpTbDltHJTNXgqd3iyHff45Fo7sMKNA82Y
 StTLS5MY3cO3U6udtZ0Slqv20TQEZ1j6tabTMJkCHsqUFFaEGv4t2iLUh+m9+bwxWsiqyaWLU
 avbTROR7ExgtPBEG9jOmWk7V6Td411e2R7MTCElTOCY9ay+mHpkuS7+rmb4HtfSPalTUVVLB8
 lrwDc+ONqAXte0+YdNUqpGz8BLs8dXdXRF0gX96NHi2ghLZJi6Iop/Ql6z+xP4D6KkQza7X3R
 NkPe7oCanzcfqqGBadCJjcKQesWEYr6eruLBGJnKvjMzvoiIlu8VmW1a0ZpHsPTcnb1iJ6jD5
 S4bcNI3cTrHM8FtjSn42JdsaXWuTtpkXBHs
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, 30 Jun 2019, Phillip Wood wrote:

> On 28/06/2019 23:08, Junio C Hamano wrote:
> > Phillip Wood <phillip.wood123@gmail.com> writes:
> >
> > > One potential problem is if someone has an alias that always sets
> > > --reschedule-failed-exec but does not always add --exec to the
> > > command line.
> >
> > Such a use case would be hitting this die() already without this
> > topic, wouldn't it?  In which case we can say there is no "someone"
> > with such an alias.
>
> It depends what else the alias includes, if it also includes
> -i/-k/-r/--signoff then it wont have been dying but will if we start
> requiring --exec and they don't set that.

The entire reasoning behind the config variable was that it would allow
changing the behavior just in case that the interactive rebase backend was
in use.

In other words: I tried to introduce that config variable to prevent
people from having afore-mentioned problems with the command-line option.

Therefore, from my perspective, it makes more sense to define such an
alias using `-c ...` than using `--reschedule-failed-exec`, unless the
alias is definitely only intended to launch interactive rebases.

Ciao,
Dscho
