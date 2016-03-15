From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC/GSoC 09/17] rebase-common: implement
 cache_has_unstaged_changes()
Date: Tue, 15 Mar 2016 15:15:46 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603151515030.4690@virtualbox>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com> <1457779597-6918-10-git-send-email-pyokagan@gmail.com> <alpine.DEB.2.20.1603142151230.4690@virtualbox> <CACsJy8BOZsPcEgOLiBo4u4SAEzDVmFd_XgU3yq4P+rBGRyJx8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Paul Tan <pyokagan@gmail.com>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, sam.halliday@gmail.com
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 15:16:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afplQ-00076s-G7
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 15:16:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbcCOOP4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 10:15:56 -0400
Received: from mout.gmx.net ([212.227.15.19]:59535 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754106AbcCOOPz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 10:15:55 -0400
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MGBdv-1adNiu1Ivf-00FBSZ; Tue, 15 Mar 2016 15:15:47
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CACsJy8BOZsPcEgOLiBo4u4SAEzDVmFd_XgU3yq4P+rBGRyJx8w@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:LFoJGKTz6/PjmhuHIlnu8KJ8cvfgr+1nFDrgwAhpGZr7wPZnMsc
 o9sIk5iazZbL1Qp04CC30u5zbbny03f9sZ4Nul6e2HWgKYHZAnEInoz5lff9Uq7nMzYeDEd
 HsrUkTEA2Rj0w9OPf4h+ZoNkVK5Ph0fcL/orTPIua5EH+HuVZyPyAoVNN5IXjgVN+5AvvHJ
 I/WnIt6b9FRB01TE/bhRg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:t9g/luBYOuM=:fLeqJj1rmYtfSp5KaXHuyW
 JZmUlf+E96nUoUMYGAs1alcCRh1rrWo88Z7SLQAV4rofYd4aN+HACVRim4LYSme6BmLXrbYAN
 LtdtyhSDxHQTHABfvlikQ/qEVZ9whVZ4OSbuY4yDBCfRAFo954HY9L9ghR48tz7FGc7N5vZi0
 kD51/2j2ngTS8FQ+OOlt2D7vo/rhxl4ZE485c5er63gJI3gjXpl178E3o3bhEQnEM688XH21i
 LwUjgLBbO7WuFDzwV7zCMTxFgrCf3MfkBbcUxWUvz3VbfarAsNqP2HjUksnMed+AxEc3aJi5n
 JTNrnrOA4W4xdHwVofFRuIGojrkGhbWF6fbf3HZTGuAWW0WAaqEnNXoXfPXSKlT7h3pkH2ifM
 RqIWOt5ZiC9nIswUBvIcUJWP5gsewtLKGFsz6vF/y6RwqAD0ICJLgFDFiwuovtIYgsnmv9d2m
 JGroWOb3ZWKQKVU4HWh6Js6Vn2P+Ss2NtUL0cV6ZpIIRuwVg5J1jsWv/TT+o92MhBRD7QGLAH
 oXnvMnXg96+X1onthg9NCVZoLPbGObOTolygcdrlZbgYbm5bOd3+s+xE8WN9leT/ErKMlXqep
 jKjgcPOrdweuuOnuy1gcEAR+Q5YlD71D9m9PGMH03xVvaM4pQmVYpQ7C+110Kia6szudnGaUz
 iG8kGDHQYOYSE6umDt8wqoIble4U4iInefwjIIsSt8PGLkNNofsR4utECYva7IercCIsd3PNG
 e952G5CGCteQBbBbn4+623PchPVCFpeLiiBw6OIf76QHQEF/U/wJ8PBW0ngXsJFBiBHOwAQU 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288855>

Hi Duy,

On Tue, 15 Mar 2016, Duy Nguyen wrote:

> On Tue, Mar 15, 2016 at 3:54 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > In my 'interactive-rebase' branch...
> 
> 64 commits! Maybe next time we should announce wip branches like this
> when we start doing stuff so people don't overlap. Of course these
> branches do not have to be perfect (and can be force pushed from time
> to time, even).

Much of this is cleanup in the beginning. And I tried to split out a patch
I thought was uncontentious, and promptly ran into a philosophical
discussion I did not seek ;-)

Ciao,
Dscho
