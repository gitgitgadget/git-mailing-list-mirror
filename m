From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Small rerere in rebase regression
Date: Sat, 28 May 2016 08:39:48 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605280839170.4449@virtualbox>
References: <57434572.6030306@kdbg.org> <xmqqy4708ss0.fsf@gitster.mtv.corp.google.com> <57437693.3030106@kdbg.org> <xmqqk2ik77cr.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1605241510370.4449@virtualbox> <5744B00D.4020006@kdbg.org>
 <alpine.DEB.2.20.1605250710340.4449@virtualbox> <574875A5.9040303@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat May 28 08:40:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6Xv0-0008Ib-Ai
	for gcvg-git-2@plane.gmane.org; Sat, 28 May 2016 08:40:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbcE1GkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 May 2016 02:40:13 -0400
Received: from mout.gmx.net ([212.227.15.15]:50928 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750814AbcE1GkL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2016 02:40:11 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MS5xC-1aw7nK2Eoc-00TG0M; Sat, 28 May 2016 08:39:48
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <574875A5.9040303@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:teZ9IHBEzTwp8TDQMlJwHI/1lkXC8uFjphVAqhYH8SmYCYopZXN
 DDZ2JCGR7A0F1wR950Q3KaBzo/7TMB00mEDJfkddumo9S5Ssk7yAv3sCO/sTrBdiSSuCJ8t
 QUKr9kTDQF3jUUvhR4LWZL4KNtQZMRUY2CguiL+f75SQSQc3r8PCknf48r602naiu+52mag
 prPI92RwVVWFWeLTAM7cA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GaRELSRejXs=:agRKIf996p/5Yaetniy1nz
 NKLQ8/oZlBSP0a8BGn3u/wIqv4NHx91hXUZnoSnch3eMmuojVsYHmFlrcChVhkQTXQEudMmr2
 /PciamlJexMRKEigE2yOKI6ZuEyyqBBjDZ7+Tvjm34an62XFqBc3T+KaEvsE13jKnF4fNlAwF
 Pri5A8gMmPxLqEnzJBQ8JIQX+tz85Q2DzAVlhXI/Wwy99zyudCsyNMbYzl2ZP/iD5yQ9jEuMK
 x/hKhRxN3vGW1dOy/Ujg07sZ6HFcB5k0dmoRIZcvCGpRlwtHi3mCr4C4H56S1mYzagcfw6BhC
 gHtHxwA89EBkXvFyNL1JyJ8fmXW7Jjxg00Px2nx6VMUebnVbGVZRhHH7InplQkrwwYN4MmB+Y
 PAvRL8uMqnT33jJBOMTcHZesM6wNpW4H9fwYlaajrQyBVNGDvzvsptgdCeIUvb2HnnQCuwqfg
 s1YH+IBMugeHWvAb49XXbN8M8m8GEg1zBc5ZlYaEanl2Bo9VYjVU2d1RT4dYRcok9hDL938Ol
 v++mOhtfDJPy0bnvA9lNRRilcq+GuZCN8qIBXXHYEz1ZVa+CGyKi2tyOim9QRtXd9h08oiVj4
 8xOsPrW+5qZcOM5FmO2ip/1v5/AdEkhdGPnJW1pMyG3/irV1r3jh+eOTM+O6uebTOt7hGe4OX
 7HmtaRjKhWdvgoa4uvUEfGakHZ13wtSBMx04X9FZnr2L86gPk7cfgWMMv1xLig0kLdOOG/QLZ
 O4BbsaJwuoJE0XB6GhQrTQ8M6ae/ExJ9X/+rONNtWWSsTDHhDUpCiz6I42oysQ4LH9RPe1Ik 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295803>

Hi Hannes,

On Fri, 27 May 2016, Johannes Sixt wrote:

> Subject: [PATCH] rebase -i: remove an unnecessary 'rerere' invocation
> 
> Interactive rebase uses 'git cherry-pick' and 'git merge' to replay
> commits. Both invoke the 'rerere' machinery when they fail due to merge
> conflicts. Note that all code paths with these two commands also invoke
> the shell function die_with_patch when the commands fail.
> 
> Since commit 629716d2 ("rerere: do use multiple variants") the second
> operation of the rerere machinery can be observed by a duplicated
> message "Recorded preimage for 'file'". This second operation records
> the same preimage as the first one and, hence, only wastes cycles.
> Remove the 'git rerere' invocation from die_with_patch.
> 
> Shell function die_with_patch can be called after the failure of
> "git commit", too, which also calls into the rerere machinery, but it
> does so only after a successful commit to record the resolution.
> Therefore, it is wrong to call 'git rerere' from die_with_patch after
> "git commit" fails.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>

ACK

Ciao,
Dscho
