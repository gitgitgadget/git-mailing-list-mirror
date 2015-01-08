From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Probably a bug with "~" symbol in filenames on Windows 7 x64 in
 git 1.9.5
Date: Thu, 8 Jan 2015 11:06:18 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1501081100570.21312@s15462909.onlinehome-server.info>
References: <CADb7K9rELHWgy_NYJWrSr9gZn7pcMvETv93d0j+u2fXinj5iTg@mail.gmail.com> <CAPc5daVddkaMkx=43nCeQKbbkrV6nExOqvEBJNyugzDQB2n6kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Dmitry Bykov <pvrt74@gmail.com>, msysgit@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 11:07:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y99z8-00008h-3E
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 11:06:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756137AbbAHKG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2015 05:06:27 -0500
Received: from mout.gmx.net ([212.227.15.19]:49258 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751141AbbAHKGX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2015 05:06:23 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx002) with ESMTPSA (Nemesis) id 0LrNIC-1XfZLi44b6-0133jy;
 Thu, 08 Jan 2015 11:06:19 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <CAPc5daVddkaMkx=43nCeQKbbkrV6nExOqvEBJNyugzDQB2n6kQ@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:RcFTXwlQyo41+AFAF4ODMR7hZkCgK23ZZEKVeNI/siUVRtBuowl
 86NgohxKzJEQYRJsVsUYpSAAstPYvM+p3O+zZITuoKkrEg67I960s/4wvmdOV4HyAkq618F
 vPaekQuzGUhm8ABNXvsqAknPU6/X892cUXXEd+/Vmhbu0A08lHVOsukK/iJ/TmwmI8Am+c+
 egFNDuXDFJ450FdW8uwUQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262188>

Hi Junio,

On Wed, 7 Jan 2015, Junio C Hamano wrote:

> Dscho, this sounds to me like the additional "8.3 ambiguity
> protection" (which is only in Git for Windows) in action. Any
> thoughts?

First thought: the Git for Windows mailing list should be Cc:ed (I was
traveling yesterday and somebody else might have been able to address
Dmitry's problem).

Second thought below:

> On Wed, Jan 7, 2015 at 3:26 PM, Dmitry Bykov <pvrt74@gmail.com> wrote:
> >
> > Recently I installed 1.9.5 git version and faced the problem that one
> > of the files in my cloned repository with a name ICON~714.PNG is
> > marked as deleted even repository was freshly cloned. Trying to do
> > anything with that file resulted in constant "Invalid Path" errors.
> > Reverting back to 1.9.4. fixed that problem.

ICON~714.PNG is a valid short name for a long name (such as
'icon.background.png') because it fits the shortening scheme (8.3 format,
the base name ends in ~<n>). As this can clash with a validly shortened
long name, Git for Windows refuses to check out such paths by default.

If you want the old -- unsafe -- behavior back, just set your
core.protectNTFS to false (this means that you agree that the incurred
problems are your own responsibility and cannot be blamed on anybody else
;-))

Ciao,
Johannes
