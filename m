From: Marcus Comstedt <marcus@mc.pp.se>
Subject: Re: Bug report: %h for abbreviated hashes broken after 1.7.1
Date: Wed, 25 Aug 2010 08:08:18 +0000 (UTC)
Message-ID: <loom.20100825T095907-907@post.gmane.org>
References: <AANLkTinR6_DFD_MbFRbtyJKPhZG1Os0ro=4TcC2h_xZo@mail.gmail.com> <20100825041440.GH11619@burratino> <AANLkTi=+tGLfs-t6+fjRu68Mt76dJw4sbNCoO9q9+uyp@mail.gmail.com> <20100825062403.GA15858@burratino> <AANLkTimebn+p9dcUWQiUPT8WwC-tuPpTM8M+ptq4Q9uc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 25 10:15:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoB8c-00071I-60
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 10:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752662Ab0HYIPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 04:15:08 -0400
Received: from lo.gmane.org ([80.91.229.12]:45835 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752220Ab0HYIPH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 04:15:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OoB8S-0006sT-SK
	for git@vger.kernel.org; Wed, 25 Aug 2010 10:15:04 +0200
Received: from ua-85-227-1-6.cust.bredbandsbolaget.se ([85.227.1.6])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 10:15:04 +0200
Received: from marcus by ua-85-227-1-6.cust.bredbandsbolaget.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 10:15:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 85.227.1.6 (Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.9.1.9) Gecko/20100428 SeaMonkey/2.0.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154434>

Todd A. Jacobs <tjacobs <at> si2services.com> writes:

> Fair enough. Thank you for taking the time to explain further. I guess
> I still don't understand how both the patch and the tag are both on
> the master branch:
> 
>     $ git branch --contains v1.7.2.2
>     * master
> 
>     $ git branch --contains 35039ce
>     * master

The commit tagged with v1.7.2.2 is on the master branch because
it was merged there.  The tag was not cut from the master branch
but from the maint branch.  You are fooled by git branch here because
you display only your local branches, and you don't have a local
maint branch.  Add -r to the command, and you will see the commits
are in multiple branches at origin.

I'm afraid the git command line tools are rather unhelpful in these
cases (it's hard to find the answer if you don't already know it),
but gitk allows you to see it quite nicely.  Run "gitk origin/master",
and search for 35039ce.  You'll see the commit being made on a topic
branch, which is merged into master (the leftmost track) on 2010-08-18.
You can also clearly see v1.7.2.2 being cut from maint (the track
immediately to the right of master) on 2010-08-20, shortly after which
maint is merged into master (c11969), which is why master "contains"
8c67c3, which is what you're really looking for when you say
"--contains v1.7.2.2".

  // Marcus
