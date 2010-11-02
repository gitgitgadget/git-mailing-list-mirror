From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Restart submodule update --recursive
Date: Tue, 02 Nov 2010 12:08:53 +0100
Message-ID: <4CCFF145.1060300@web.de>
References: <loom.20101028T090353-376@post.gmane.org> <20101028181515.GB14212@burratino> <loom.20101029T085153-262@post.gmane.org> <20101029091202.GA26442@burratino>, <4CCAB20A.1000408@prevac.pl> <212962199.646095.1288423075790.JavaMail.fmail@mwmweb046> <4CCFC94B.2010708@prevac.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Lukasz Palczewski <l.palczewski@prevac.pl>
X-From: git-owner@vger.kernel.org Tue Nov 02 12:11:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDElw-0003jQ-PT
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 12:11:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752395Ab0KBLLX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Nov 2010 07:11:23 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:50913 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549Ab0KBLLV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Nov 2010 07:11:21 -0400
Received: from smtp07.web.de  ( [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 739971739F1B6;
	Tue,  2 Nov 2010 12:08:56 +0100 (CET)
Received: from [93.246.52.168] (helo=[192.168.178.29])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #24)
	id 1PDEjY-0000MS-00; Tue, 02 Nov 2010 12:08:56 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <4CCFC94B.2010708@prevac.pl>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX195RNOcL2VYF7Nk2gAcoPDegMvmSVH2W7ST88xU
	M9m0Z/N+LC0yT6v8ODL0QLcvRxG0tL/BU0MX/NbhvH91xwV6mN
	1lvp1+KS20AqGnvExvwA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160516>

Am 02.11.2010 09:18, schrieb Lukasz Palczewski:
> Well I will wait for it and see if it does, but it will not solve all the problems.

Thanks, as we are moving more submodule functionality into the git
commands I would rather avoid adding new stuff to git-submodule.sh
unless it is something not handled by that move.

> Once I had a problem, when someone forgot to push a commit in the
> submodule, but pushed a commit in the main repository.

Yes, this is a common problem. We'll add a test for that in "git push"
soon, then it won't be possible to do that by accident anymore.

> Becouse of it, I could not update that repository. If this problem
> occours, I will have to update all the submodules with the one
> command "git submodules update --recursive" (when someone finally
> pushes the submodule). If the "git checkout" updates the rest
> ( not updated) submodules, but not check the ones, that were updated
> earlier, then it will work for me.

As the functionality which is now done by "git submodule update"
will be split into recursive fetch and recursive checkout, you would
have to issue a "git fetch --recurse-submodules" to retrieve the
missing commits. But that shouldn't be necessary when "git push"
tests for all submodule commits to be pushed too before it pushes
the superproject.
