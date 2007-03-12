From: Xavier Maillard <zedek@gnu.org>
Subject: Re: What's the best method between merging and rebasing ?
Date: Mon, 12 Mar 2007 20:14:52 +0100
Organization: GNU's Not UNIX!
Message-ID: <200703121914.l2CJEqW0031669@localhost.localdomain>
References: <200703121139.l2CBdcUL022906@localhost.localdomain> <20070312120820.GE18952@mad.intersec.eu> <200703121634.l2CGYtGx027263@localhost.localdomain> <20070312173727.GC30489@mad.intersec.eu>
Reply-To: Xavier Maillard <zedek@gnu.org>
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Mar 12 20:17:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQq1f-0001Hm-Ah
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 20:17:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340AbXCLTRk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 15:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752366AbXCLTRk
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 15:17:40 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:36124 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752340AbXCLTRj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 15:17:39 -0400
Received: from zogzog.home (chn51-3-88-163-173-156.fbx.proxad.net [88.163.173.156])
	by smtp5-g19.free.fr (Postfix) with ESMTP id E4FAD7D8F;
	Mon, 12 Mar 2007 20:17:37 +0100 (CET)
Received: from localhost.localdomain (IDENT:1001@localhost [127.0.0.1])
	by zogzog.home (8.13.8/8.13.8) with ESMTP id l2CJErBR031672;
	Mon, 12 Mar 2007 20:14:53 +0100
Received: (from zedek@localhost)
	by localhost.localdomain (8.13.8/8.13.8/Submit) id l2CJEqW0031669;
	Mon, 12 Mar 2007 20:14:52 +0100
X-Authentication-Warning: localhost.localdomain: zedek set sender to zedek@gnu.org using -f
In-reply-to: <20070312173727.GC30489@mad.intersec.eu> (madcoder@debian.org)
Jabber-ID: zedek@im.lolica.org
User-Agent: Rmail in GNU Emacs 23.0.51.1 on GNU/Linux
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42062>

Hi,

   From: Pierre Habouzit <madcoder@debian.org>

   On Mon, Mar 12, 2007 at 05:34:55PM +0100, Xavier Maillard wrote:

   > So it seems to be cherry-picks + rebase master on new HEAD but I
   > am not sure at how things are doing :)

     okay then I got this right, you don't want to rebase master on new
   HEAD because you would keep the commits you don't want (I guess). What

     you start from:

   orig master -> A -> B -> C (master)
	       \
		-> D -> E -> F topic

     let's say you want to keep A and C from master. here is what I'd do:

     $ git checkout topic     # topic will be the new master
     $ git cherry-pick A C    # we want to keep A and C

Got it for this one :)

     we now have:

   orig master -> A -> B -> C  (master)
	       \
		-> D -> E -> F -> A' -> C' (topic)

     $ git branch -D master

For historical reasons, I have to keep my master around so I
won't delete it completely. Maybe there is a way to tell that a
branch is considered "dead" thus indicating there won't be any
new developement onto it. I will check this.

As I have been told privately, what I want in reality is a reset
of master onto my new HEAD.

I think I have misunderstood reset behaviour.

So this is how I end up now (from my new master branch):

$ git cherry-pick <commits>
$ git rebase master~NUM
$ git reset master HEAD

There I would need something to tell old master is dead but it is
optionnal (a single tag will do that).

Does that make sense for you ?

Regards,

P.S: I have problems reading your posts, my mail buffer is full
of =20 here and there
-- 
Xavier
