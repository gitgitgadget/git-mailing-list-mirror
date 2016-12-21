Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71C6B1FF40
	for <e@80x24.org>; Wed, 21 Dec 2016 17:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761271AbcLUR4t (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Dec 2016 12:56:49 -0500
Received: from mout.gmx.net ([212.227.15.19]:55236 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761214AbcLUR4s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2016 12:56:48 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Md3ZK-1c1XUO31M2-00IEbD; Wed, 21
 Dec 2016 18:56:42 +0100
Date:   Wed, 21 Dec 2016 18:56:41 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH 1/1] mingw: intercept isatty() to handle /dev/null as
 Git expects it
In-Reply-To: <xmqqh963snhs.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1612211854530.155951@virtualbox>
References: <cover.1481454992.git.johannes.schindelin@gmx.de>        <42ddc270ea04e01e899cc479063e5d602e4a4448.1481454992.git.johannes.schindelin@gmx.de>        <129f000c-49c1-0e75-26b3-c96e9b442443@kdbg.org>        <xmqqy3zfsq4q.fsf@gitster.mtv.corp.google.com>
        <5977e71d-da58-7cb0-bc69-343bb3a1341d@kdbg.org> <xmqqh963snhs.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:czVwaRvOV3gLluRng8ioy8V9kTRIy2YBZ5Aj58wosJ0pi2eS9Qh
 xrUDIOR8uT6AgJWk3rP2gAXw0XqekWNTUopXGRgAxY8WgOH6I03CiHg3mXh4jQvpJkje3rv
 XIeqCXMnNgM9yAVGIZL8Su7oawOHZlgn7VgZBXVm/W7Qb+YZwgwr0vbRwNYMiP/5YwyrGLw
 PYYRvu4PWqJjdZNaIIhcg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eTMiZIr8VlQ=:Zplg8WVzvFuGbSVLVDWhLf
 U6SJDpWAHz9s00JMGyf5ys+LkHDvQgheBNnN83jg4ZhpsXcBVM+nwSRnBJP7t3S2ckL0pWMTH
 R9oZtNJZdOhX1Po/IjMYQfWLyFGRnRPQfRBSdmmXAeAULAK78wPQKy1GrN4zcRFOgR09C73bQ
 6CyaSr+B/ghFo7UhwPfw8DtNRhZzUx//8sZFcbHdqONO5l6HPoHOtL12SL7eT07YnTRRAgyiv
 Ms5IoqCek0XNxKgSn7fAWD02HG7PiUJnvrA6gC8v5RzsdO9uCoALGh0RkhIy5miYY3oyPzKEK
 NTE3ad1F3NzH0RnTmXOT83kgsd66vE6b86gYm/M62By1kyTKfDgBBSWXbytCmi/qeC9q95NoA
 ERDNkiVkHuoB+EJu8XIiuQ7GeqNty0r+ZhUfbyb2oW3RKtYXWPWqcYIYrhBdt7kKqTFaoPrTX
 Nw1lsqh4O7ar4Zbi/2jhavSB/sde21rjuKEzanHuvcxRAPgBABR16dS+1V97c378kfh0uDVA2
 UVKbLLtYhWiJG1F0WeCKyafUud5tjg6zWPU3BuXGOA14I0YdSc0aYq8mDquT/9MGWtnLhc2Yq
 2o/UiNt7JO7ffNEl3L7sfIrR7tWQRnDZDen3prHNsL6RTrXwWCFPQsUYEw0MuS58bgFizFrQ2
 XGTxcnHFDHcQnfm/aEufqvEaO6VHJ0wzAqkekcAns9rIUXxqwV8TRGkojdckUWJJdxIEj+bMq
 NYvQ29Gs/mo0UmiX0t8yyoSH6VU4fb7uZGG5mTGpGKcJlyvnLdUAgU2euH0xJoetlpn7v1udP
 5FWRa5n
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 16 Dec 2016, Junio C Hamano wrote:

> Johannes Sixt <j6t@kdbg.org> writes:
> 
> > Am 16.12.2016 um 19:08 schrieb Junio C Hamano:
> >> Sorry for not having waited for you to chime in before agreeing to
> >> fast-track this one, and now this is in 'master'.
> >
> > No reason to be sorry, things happen... Dscho's request for
> > fast-tracking was very reasonable, and the patch looked "obviously
> > correct".
> 
> Oh, I do agree it was reasonable and looked obviously correct.  And
> I suspect that it did not make anything worse, either, so there is
> not much harm done, other than that I now have to remember not to
> merge it down without further fixes to 'maint' and declare the NUL
> thing fixed ;-)

Actually, due to having way too many worktrees I managed to test the exact
wrong build product and failed to notice that the patch I asked to
fast-track broke paging in Git for Windows' Git Bash, too, not only in
CMD.

Bummer.

> > Unfortunately, I'm away from my Windows box over the weekend. It will
> > have to wait until Monday before I can test this idea.
> 
> Thanks.

I just sent out a fixer-upper patch series, hopefully I got it right this
time.

Hannes, it would be very nice if you could beat on it for a bit.

Happy holidays,
Dscho
