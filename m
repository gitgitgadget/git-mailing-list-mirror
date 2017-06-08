Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6ABC81F8CF
	for <e@80x24.org>; Thu,  8 Jun 2017 10:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751252AbdFHKBU (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 06:01:20 -0400
Received: from mout.gmx.net ([212.227.15.15]:62214 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751587AbdFHKBT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 06:01:19 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MhRUQ-1dWk8J0VFq-00MZKo; Thu, 08
 Jun 2017 12:00:57 +0200
Date:   Thu, 8 Jun 2017 12:00:56 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Brandon Williams <bmwill@google.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/9] discover_git_directory(): avoid setting invalid
 git_dir
In-Reply-To: <20170607174529.GB110638@google.com>
Message-ID: <alpine.DEB.2.21.1.1706081143010.171564@virtualbox>
References: <cover.1496851544.git.johannes.schindelin@gmx.de> <300d32d72b67f8c12b6cc91c36a5735a77f5ed89.1496851544.git.johannes.schindelin@gmx.de> <20170607174529.GB110638@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:M0K3XVNOEKx+kvt67n5OJm635/M8ytqrgC1myNvUIhAdPBh+FvJ
 GV/0ItAeWGbImRraUM7ei0q0IfWQT2CpMi6P9nuflMZ9YmMsyk3Qfbr2bgf26UTgVwnoiNZ
 5dWX1aBVVWlHeSXKk6Jzdmeh4A95VN43PMSPGh0Hk7FOu6GXorIxvVw2prwjY0wpsrgL6QX
 JGzfX3dpbmy1zyeyUxnkg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:byvDI2Zm92I=:hLR7MIW3kXtcLrltwOV8jU
 H4GYlzSoy84HoJcPUbjMwwE2dA1/XtXsaUFHKhT5whrFnBjf4JMvpWyZV2KIfY962MPUmetGx
 j4on4MY7Kuakc8TI5CRQrC67qhN/MINX6UwhffTgpPDn29r15i3YT0MTSJwR2ZR1Mtf5KgAly
 sqN3ZS8gtuC50f4byboLlAf5SOzR0haY3eZJ1XJpmYMCVfgfQ/Ft+hdCkhtwFo8Dx1idN6p81
 q+PHviBFjNJ7GsdFBnxejXiu0CRiAsVuAs665GbtcagYSUKSuMancKZf90eSEkVfX/+mDjaTJ
 TXcG5c+KG8+hBhfgDAJAZqvTepR254T7OQ+7GJ8dcZkaT8MgJ1ctMrKWMNcBb3QtUdMBs909j
 EHIT+URB5+CYZW3yoHkqyr8aLPCq7g2fLho/zxpEsANSRI2RJTK6AZdnU+b2aWIh+4qRaL6rD
 Fo1ItdEmJWJe3hoiKAllHoRYx/mSCkkcIiqI60wBkpax32BCHluHgaWNnZC9ZVT0HGSHV0t2D
 QBNcobHjHhyKbXzAyzetipkpf+8WVWGKjyGuM1GnGlTs7dlJlN/e12jWm4HHPVHuw3Bnj9lX7
 praxLL2VJboqsuwomNg1lvfj9QYlHE1B0hfcNmhAMGxVy/v7zwoyBjOreiYHcUbFLaK1eOGPW
 za1pgd3GgNI5zLY1oA6d99gMXNi1hMYMoHHzq9zr57Y7GjjrTyo66o8Y13RA0amVL3UzSretc
 avovlUhVNJmEZ5V0Q2dIp2tEianYudasRGgDoKajrHN/zFmw2JAz88fd3jcfjuj0NeLpcs9Kb
 CUvkO9j
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brandon,

On Wed, 7 Jun 2017, Brandon Williams wrote:

> On 06/07, Johannes Schindelin wrote:
>
> > diff --git a/setup.c b/setup.c
> > index e3f7699a902..2435186e448 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -982,6 +982,7 @@ const char *discover_git_directory(struct strbuf *gitdir)
> >  		warning("ignoring git dir '%s': %s",
> >  			gitdir->buf + gitdir_offset, err.buf);
> >  		strbuf_release(&err);
> > +		strbuf_setlen(gitdir, gitdir_offset);
> >  		return NULL;
> 
> There is another part of this function that returns NULL (which isn't
> shown by this diff) after performing 'setup_git_dir_gently_1', do we
> need to worry about anything that 'setup_git_dir_gently_1' has
> potentially appended to 'gitdir' upon 'setup_git_dir_gently_1' failing?

The setup_git_dir_gently_1() function used to set the git_dir variable
directly in case of success, and leave it unchanged in case of error. My
work to allow an early config did not change that, with the exception that
it is the gitdir parameter that is changed instead of git_dir.

In other words: that `return NULL` is safe, as it returns due to an error
reported by the setup_git_directory_gently_1() function (meaning that the
gitdir strbuf has not been touched).

I amended the commit message accordingly, and force-pushed the result.
Meaning: v2 will have that change.

Ciao,
Dscho
