From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Problem with pack
Date: Fri, 25 Aug 2006 11:12:00 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608251104410.28360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <44EEB8AD.5080703@arces.unibo.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 25 11:13:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGXjn-0007hs-8A
	for gcvg-git@gmane.org; Fri, 25 Aug 2006 11:12:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbWHYJMG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Aug 2006 05:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWHYJMF
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Aug 2006 05:12:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:35764 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932321AbWHYJMC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Aug 2006 05:12:02 -0400
Received: (qmail invoked by alias); 25 Aug 2006 09:12:01 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp001) with SMTP; 25 Aug 2006 11:12:01 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Sergio Callegari <scallegari@arces.unibo.it>
In-Reply-To: <44EEB8AD.5080703@arces.unibo.it>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25993>

Hi,

On Fri, 25 Aug 2006, Sergio Callegari wrote:

> git verify-pack -v pack-ebcdfbbda07e5a3e4136aa1f499990b35685bab4.idx
> fatal: failed to read delta-pack base object 2849bd2bd8a76bbca37df2a4c8e8b990811d01a7

Eeeh! Not good.

> 1) I am working on both a pc and a notebook, syncing the two everytime I move
> from one to the other.

So, you still have one "good" version? Please make a backup immediately. 
(If only to reproduce the problem.)

> On the PC I have git 1.4.2, on the notebook git 1.4.0. I am using "unison" as
> a syncing tool.
> Might the data loss have something to do with...
> - the version of git I am using or the mixing of two versions?

We tried very hard to maintain backward compatibility. So, it should be 
fine.

> - the syncing? I have noticed that after a sync, git is not immediately in a
> happy state...

That is okay. The "index" (remember, git has a staging area called 
"index") stores ctimes and mtimes, and these are not synced.

> 2) git unpack-objects seems to be able to extract some objects from the pack,
> but at a certain point it dies.
> - does it die on the first error or does it try to extract everything that is
> possible to extract after the error?

Since unpack-objects does not use the index, it cannot extract anything 
after the first error. We _could_ enhance unpack-objects to be nice and 
optionally take a pack-index to try to reconstruct as many objects as 
possible.

BTW I'd recommend not syncing with unison, but with the git transports: If 
your PC and Laptop are connected, you could do something like

	git pull laptop:my_project/.git

(Of course, you have to adjust it for your setup.) This would sync your 
repository on the PC with the one on the laptop.

Hth,
Dscho
