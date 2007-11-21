From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Partial checkouts / submodules
Date: Wed, 21 Nov 2007 01:04:11 +0100
Organization: At home
Message-ID: <fhvslp$9jr$1@ger.gmane.org>
References: <20071120155922.GA6271@pvv.org> <20071120173350.GA2261MdfPADPa@greensroom.kotnet.org> <20071120181932.GA20705@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 21 01:04:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iud59-000345-O2
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 01:04:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753066AbXKUAE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 19:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752004AbXKUAE0
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 19:04:26 -0500
Received: from main.gmane.org ([80.91.229.2]:48551 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750765AbXKUAEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 19:04:25 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Iud4k-0005vx-Ea
	for git@vger.kernel.org; Wed, 21 Nov 2007 00:04:18 +0000
Received: from abvf224.neoplus.adsl.tpnet.pl ([83.8.203.224])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Nov 2007 00:04:18 +0000
Received: from jnareb by abvf224.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Nov 2007 00:04:18 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvf224.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65583>

Finn Arne Gangstad wrote:

> I'll try to boil this down to the simplest case possible. If
> submodules can do this I'll be really happy :)
> 
> Developer A makes a change in submodule1 and in submodule2
> Developer B makes a change in submodule2 and in submodule3

And committed changes to submodules and supermodule, I guess,
so developer A has submodule1 in state 1a, submodule2 in state 2a.
sumbodule3 in state 3, and supermodule in state [1a, 2a, 3], while
developer B has submodule1 in state 1, submodule2 in state 2b, 
submodule3 in state 3b, and supermodule in state [1, 2b, 3b].
 
> A and B don't know about eachother. They send their modifications
> somewhere (push to a shared repository with a well chosen branch name,
> for example), or send a mail "please pull from my repo" to the patch
> queue manager.
> 
> It is absolutely crucial that for each developer, either both their
> modifications go in, or none of them. Git should make picking only
> one of their modifications hard.

Git treats submodules as whole, so merging A and B supermodules will result
in [1a, CONFLICT(2a/2b), 3b]. 2a/2b _might_ resolve cleanly to 2ab,
but this requires submodule2 to be checked out. I'm not sure what git does
in such case, but it is not much different from the case when both sides A
and B modified the same file, but it merges on file-level cleanly; here we
have subprojects and tree-level in-subproject clean merge.

[...]

By the way, submodules in supermodule should be thought as on 
'detached HEAD'.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
