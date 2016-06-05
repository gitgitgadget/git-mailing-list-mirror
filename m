From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 2/6] worktree.c: find_worktree() learns to identify
 worktrees by basename
Date: Sun, 5 Jun 2016 09:15:16 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1606050909240.27293@virtualbox>
References: <20160522104341.656-1-pclouds@gmail.com> <20160530104939.28407-1-pclouds@gmail.com> <20160530104939.28407-3-pclouds@gmail.com> <xmqqh9de5d6e.fsf@gitster.mtv.corp.google.com> <CACsJy8CmdTapWsst-PuwFNH8Uy3Vgow+fKWzQ+tGYPSc=aZsXg@mail.gmail.com>
 <xmqqr3cgycjl.fsf@gitster.mtv.corp.google.com> <CACsJy8B+j2im7XOV==tBtki=tOCN4k3ZHz6Jp4fq4qjqarb+ew@mail.gmail.com> <xmqqfusvv8lq.fsf@gitster.mtv.corp.google.com> <CACsJy8BF_KKXdMNW_aOs522wBbW9BQhbrZ_0hx+f2MCW-VPUzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Reto_Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 05 09:15:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9SHb-0007jA-8o
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jun 2016 09:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbcFEHPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jun 2016 03:15:34 -0400
Received: from mout.gmx.net ([212.227.17.22]:62936 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751458AbcFEHPe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2016 03:15:34 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MSMr9-1b20S62wyB-00TWDj; Sun, 05 Jun 2016 09:15:17
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CACsJy8BF_KKXdMNW_aOs522wBbW9BQhbrZ_0hx+f2MCW-VPUzg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:XIIEtTzfM06sxT83Cj/YvVNmX/MFSI9tQWOeRS+aX9YT2vxuOSV
 iEZ91kf1KpcO980WBYBfVvhAJChiR2QgUPt60EkPtYWGIAPtDrQBolS3JEjQC28i9TM8O4X
 zWkGvewBcX66BoQvZEXE7Bua8c8Q6uNtQkeN96L52JglW5d3pN9+yF5CoLQxyNM7WUCvGMf
 QfDyuPDEYPIZd7/cHtHMg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:r20//N35nWo=:nhsOs2IClWOtieYzKKSUAI
 f4mvvmOrcst67DYnl25JM5qN1UXrISYXtmpOPewx4F7flHyegRrMgfTtmm3bS4dEp5wOkyxRm
 6x2vR9d/LgC/q/H29j6n5LCEMzlNfNhR+QiUcjL1HMgNZrK/NV9nRMecFO3scEWoxXmSTxY1R
 OzRpDUcc2hkzTjR1+MgIkjcrjPiyJ+bWRh0V+uIRo6K3hnt2QHkAKPcdmz+wNJrzvyvL0LuZz
 w/JLIKoHIvrT5KWJJ1pg+535VJkbZuM32iNipR/si228GuoTgbPY1mKJGBt2N4fSUWTyBV+e9
 elY2vxpFCzHcNW+jRvE4JLgugw3BcEtxXzqLwg1ZymnebTfbBbN9p1oAYMNI3RLBOUfM+uJsR
 ag0F0XFrhc/IHb+Oj4WEGdsb03cevvtlCx+KoNMpJu1vA/218yfF70OiWhbCPxiyRlhZRiA/j
 hneaSdNbIXEjFPL/17kxMWlTOA2JiUWFwUfpC5KLK2bn7qjYcWXkw+W8z9bqHF1gsKfB4CNBz
 KpsRuff/5ySkcvhdHcCJJYuPLwg8syZXyAv1od6hbAOA1orRaloYpBzFkMYO1p8SSj9zagHyA
 r/pThHJS1o8JT918WMGsqxuliKRg/X8HiOYtnJxVzzkRKANvFSZRdg8thOtaY4G8K37qhQLXe
 /FEhXEPvjOj7VD24TReA5MGW53o2SMGfDveT2JgDGm5Xf9Do5Gi750K0utMLcLdCiLPOpAYUN
 ac1192E+qlBm9DMhY+zc66D+f9RI4QbgV0No8g7oGYxcbWA6hxcZtc1aBOtn9q4vC3ldbO9V 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296468>

Hi,

On Fri, 3 Jun 2016, Duy Nguyen wrote:

> On Thu, Jun 2, 2016 at 11:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> > Does "basename()" used here know '/' and '\' can both be a directory
> > separator, or does worktree->path have a normalized representation of
> > the path, i.e. '/' is the only directory separator?
> 
> basename() does (or I think so because Windows has its own version).
> worktree->path always uses '/' but the command line option can come with
> either '/' or '\'. Probably safest to accept both.

It is very easy to see what the Windows version of basename() does by
looking at our very own test code:

	https://github.com/git/git/blob/v2.8.3/test-path-utils.c#L71-L110

Short answer: basename() knows that both '/' and '\' are directory
separators.

Ciao,
Dscho
