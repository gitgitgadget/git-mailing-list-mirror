From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: git push (mis ?)behavior
Date: Fri, 28 Sep 2007 08:52:47 +0200
Message-ID: <9D61974D-E08D-49F6-9C88-6BE446D53C74@zib.de>
References: <20070927130447.GH10289@artemis.corp> <7v3awzvrpr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 08:54:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ib9k9-0003xz-2t
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 08:54:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756596AbXI1Gy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 02:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756797AbXI1Gy0
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 02:54:26 -0400
Received: from mailer.zib.de ([130.73.108.11]:61348 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755088AbXI1GyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 02:54:25 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l8S6pDwB003993;
	Fri, 28 Sep 2007 08:51:13 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db106c4.pool.einsundeins.de [77.177.6.196])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l8S6pCpk010071
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 28 Sep 2007 08:51:12 +0200 (MEST)
In-Reply-To: <7v3awzvrpr.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59372>


On Sep 27, 2007, at 9:22 PM, Junio C Hamano wrote:

>
> So what's the desired semantics?
>
> The current semantics is:
>
>    "git push" says "you do not say to which repository?" and
>    consults "branch.<current>.remote" but defaults to 'origin'
>    if unconfigured.
>
>    "git push <name>" (or using the <name> determined as above)
>    says "you do not say which branches?" and consults
>    "remote.<name>.push" to find branches to push out, but
>    defaults to 'matching branches' if unconfigured.
>
> What you would want to change is the fallback behaviour for
> unconfigured "remote.<name>.push".  I think it is sensible to
> have an option to make it push only the current branch.

I'm not sure that changing the fallback behaviour for unconfigured
"remote.<name>.push" is sufficient.

When "remote.<name>.push" is set I'd expect "git push" to
choose only the 'right' remote.<name>.push lines, that is
the lines that have the current branch as the local ref.
"git push" would only push the current branch, which could be pushed
to 0 or more branches on the remote side. If no "remote.<name>.push"
contains the current branch as a local ref nothing would happen
(maybe a warning?). If several "remote.<name>.push" have the current
branch as the local ref the branch would be pushed to several
remote branches. But other branches than the current branch
would _never_ be pushed if no argument is given to 'git push'.

	Steffen
