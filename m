From: Christian Jaeger <christian@jaeger.mine.nu>
Subject: Re: SeLinux integration
Date: Mon, 18 Aug 2008 10:45:10 +0200
Message-ID: <48A93696.6010500@jaeger.mine.nu>
References: <6341D084-1A83-4C0F-8C45-943916612D48@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jens Neuhalfen <JensNeuhalfen@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 18 10:46:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KV0NY-0004p5-6T
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 10:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684AbYHRIpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 04:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751642AbYHRIpP
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 04:45:15 -0400
Received: from ethlife-a.ethz.ch ([129.132.49.178]:55435 "HELO ethlife.ethz.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751369AbYHRIpN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 04:45:13 -0400
Received: (qmail 26341 invoked from network); 18 Aug 2008 08:45:11 -0000
Received: from unknown (HELO elvis-jaeger.mine.nu) (127.0.0.1)
  by localhost with SMTP; 18 Aug 2008 08:45:11 -0000
Received: (qmail 5506 invoked from network); 18 Aug 2008 08:45:10 -0000
Received: from unknown (HELO ?127.0.0.1?) (10.0.5.1)
  by elvis-jaeger.mine.nu with SMTP; 18 Aug 2008 08:45:10 -0000
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <6341D084-1A83-4C0F-8C45-943916612D48@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92688>

Jens Neuhalfen wrote:
> git://www.neuhalfen.name/git-selinux.git

I'm just an end user, too, so this isn't representing any official 
statement, but imho you should clean up your history before you publish 
it (and also, I think it would be a good idea to mention that your git 
repo is really including the upstream git so that people know they 
should use the --reference option to git clone to reuse the contents of 
a local upstream git to avoid pulling everything from your server):

- remove commits that don't make sense like your "XXX" file
- generally look over your history again and rework it so that it makes 
sense for a receiver (which is not necessarily the historic events of 
how you wrote it)
- follow the common commit message format (one line subject, the rest in 
the body and line wrapped)
- probably there's no reason to merge your history with historic events 
of the upstream git, so you should rebase your history onto some point 
of upstream.

You can do this by running

git branch last_upstream 053fd0c1c3da20474c4ff175c56ea4c1d6eeda11
git rebase --interactive last_upstream

(or alternatively (with the advantage that you can open and edit all 
patches at the same time, but the disadvantage that editing diffs is 
more difficult to get right than editing files in snapshots), by first 
creating patch files by running:

git format-patch master...last_upstream

then editing the patch files (and remove those which don't make sense) 
and then switch to the upstream branch and run "git-am --3way 00*patch", 
or replace 00*patch with the patch files in the order you want them 
applied).

Christian.
