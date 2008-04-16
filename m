From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: fsck --full is Ok, but clones are not, "missing commits"?!
Date: Wed, 16 Apr 2008 17:22:22 +0200
Message-ID: <480619AE.8010506@viscovery.net>
References: <200804161626.44174.brian.foster@innova-card.com> <a537dd660804160804t252d2900j33e30a01dc58979c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Dmitry Potapov <dpotapov@gmail.com>
To: Brian Foster <brian.foster@innova-card.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 17:36:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jm9Tf-0004wv-SM
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 17:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757211AbYDPPW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 11:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757645AbYDPPWZ
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 11:22:25 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:43114 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754901AbYDPPWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 11:22:25 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Jm9Sp-0005Ka-9p; Wed, 16 Apr 2008 17:22:23 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 143076C4; Wed, 16 Apr 2008 17:22:23 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <a537dd660804160804t252d2900j33e30a01dc58979c@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 2.2 (++)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5, PLING_QUERY=0.514
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79713>

Brian Foster schrieb:
>  at toplevel of a (not-bare) clone, with  info/grafts  in-place,
>  and a happy `fsck -full' (same machine so same git version):
> 
> 	$ git filter-branch --tag-name-filter cat -- --all  # at not-bare toplevel
> 	Rewrite 7df30811617517bc4d5ec7c190a435667228320c (168/168)
> 	Ref 'refs/heads/master' was rewritten
> 	Ref 'refs/remotes/origin/HEAD' was rewritten
> 	WARNING: Ref 'refs/remotes/origin/master' is unchanged
> 	Ref 'refs/tags/linux-2.6.15' was rewritten
> 	error: Ref refs/tags/linux-2.6.15 is at \
> 		26a33413c95dfda6c70ca4a83da49cddb7b236b9 but expected \
> 		2dcaaf2decd31ac9a21d616604c0a7c1fa65d5a4
> 	fatal: refs/tags/linux-2.6.15: cannot lock the ref
> 	Could not rewrite refs/tags/linux-2.6.15
> 	$

Actually, I don't know how to overcome this situation; maybe forget about
the tags and remove the '--tag-name-filter cat' part. They wouldn't have
been rewritten correctly anyway (annotated tags loose the message and
become unannotated).

>  as such, is there some way of adding them back to the bare
>  repository (if that even makes sense?), or whatever?  (i.e.,
>  that have not been lost, is it possible to take advantage
>  of that fact?)
> 
>  also (sorry!), does anyone recognise the development process
>  that apparently was used?  (the one pre-existing clone has
>  few-to-no clews, since it was used for some fairly trivial
>  local development, not for the "merging" (if I can call it
>  that) with linux-mips repository.)

In this case you might be able to salvage missing objects by cloning
linux-mips. Just copy the objects/pack/* from that clone into your
objects/pack, remove info/grafts, and maybe things "just work"?

-- Hannes
