From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Allow "git remote --mirror" to mirror stashes
Date: Sun, 30 Mar 2008 17:19:21 -0700
Message-ID: <7vve33vj7a.fsf@gitster.siamese.dyndns.org>
References: <1205499956.7589.4.camel@gentoo-jocke.transmode.se>
 <1205604534.7589.20.camel@gentoo-jocke.transmode.se>
 <7vbq4z4bl1.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0803281124240.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, joakim.tjernlund@transmode.se
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Mar 31 02:20:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jg7lE-0004ja-DQ
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 02:20:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753995AbYCaATi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2008 20:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753960AbYCaATh
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 20:19:37 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41748 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753953AbYCaATh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2008 20:19:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AAEFD1C5F;
	Sun, 30 Mar 2008 20:19:35 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 0A63C1C5D; Sun, 30 Mar 2008 20:19:29 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78536>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Thu, 27 Mar 2008, Junio C Hamano wrote:
>
> Maybe it shouldn't do any filtering here, and instead do it in 
> cmd_fetch_pack?

I dunno.  How would the code look like?

> This is also true, although I'm not too sure that we won't want to do 
> things like having "refs/default" in a public repository be the 
> repository's suggestion for the default branch (to replace "HEAD", 
> because, in a world where people use lots of branches, the "current 
> branch" idea and the "default branch" idea aren't really the same idea, 

In a public repository with many branches to serve people with different
interests, I do not think a single refs/default in addition to HEAD would
help that much.  We would _not_ want to have more magic refs like HEAD.

Quite the opposite.  In such a repository, HEAD means even less, and
instead of giving an extra layer of indirection, you tell people which
branches are what in your repository.  "If you are interested in only the
bugfixes without any new features since the last feature lease no matter
how solid and tested they are, use 'maint' branch.  If you want solid and
tested features, and do not mind new features, use 'master'.  Etc.".

And just like a good API names its functions sensibly, you give meaningful
names to your branches, so that you do not _need_ that extra layer of
indirection refs/default would incur.
