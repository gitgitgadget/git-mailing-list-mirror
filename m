From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: git pull works remotely but not locally
Date: Thu, 27 May 2010 19:57:00 +0300
Message-ID: <20100527165700.GA9909@LK-Perkele-V2.elisa-laajakaista.fi>
References: <4BFE750B.5030007@llaisdy.com>
 <AANLkTikmrBQ1aUQeAZKB8pdgwXjureozZOzEHq8CF4kb@mail.gmail.com>
 <4BFE83A7.4020604@llaisdy.com>
 <AANLkTinn_D2nrZDoczHqvAFKdCxxubK0N0jHr-nE94JP@mail.gmail.com>
 <4BFE8A99.5060906@llaisdy.com>
 <20100527151514.GB18590@coredump.intra.peff.net>
 <4BFE8DF8.8050301@llaisdy.com>
 <20100527153812.GA23484@coredump.intra.peff.net>
 <4BFE9C1E.7050308@llaisdy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Ivan Uemlianin <ivan@llaisdy.com>
X-From: git-owner@vger.kernel.org Thu May 27 18:59:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHgQT-0001BK-D8
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 18:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437Ab0E0Q6h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 12:58:37 -0400
Received: from emh05.mail.saunalahti.fi ([62.142.5.111]:54681 "EHLO
	emh05.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932132Ab0E0Q6g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 12:58:36 -0400
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh05-2.mail.saunalahti.fi (Postfix) with SMTP id A12838BD2C;
	Thu, 27 May 2010 19:58:34 +0300 (EEST)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A018CD9DD27; Thu, 27 May 2010 19:58:34 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 6AB9E4042;
	Thu, 27 May 2010 19:58:32 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <4BFE9C1E.7050308@llaisdy.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147888>

On Thu, May 27, 2010 at 05:21:50PM +0100, Ivan Uemlianin wrote:
> On 27/05/2010 16:38, Jeff King wrote:
> >Then the next thing to try is probably (assuming you are running Linux):
> Well, kind of: it's CentOS, which I'm finding quite recalcitrant
> (e.g. I had to install strace).
> >   strace -f -e execve git pull
> >
> >Though I suspect we may just see:
> >
> >   execve("/opt/libexec/git-core/git-core/git-pull", ...) = -1 EACCES (Permission denied)
> >
> >which doesn't help much. I just want to be sure that is the source of
> >the problem.
> No, the output is interesting.  The permissions denied is from the
> erroneous /root install (see separate email):
> 
>     [pid  3485] execve("/root/libexec/git-core/git-pull",
> ["git-pull"], [/* 18 vars */]) = -1 EACCES (Permission denied)
> 
> It looks in /opt/bin, but not /opt/libexec.
 
That looks like you are either running wrong git binary (one in /root/bin?)
or the git installation is busted.

No, the git libexec directory SHOULD NOT be in PATH (git will add it there
when needed).

-Ilari
