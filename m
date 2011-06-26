From: Christof =?ISO-8859-1?Q?Kr=FCger?= <git@christof-krueger.de>
Subject: Re: Deleted file is back - how to investigate?
Date: Sun, 26 Jun 2011 23:12:24 +0200
Message-ID: <1309122744.11860.121.camel@oxylap>
References: <20110626103218.GQ30255@genesis.frugalware.org>
	 <1309097423.11860.76.camel@oxylap>
	 <20110626202532.GS30255@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Miklos Vajna <vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 26 23:16:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qawgf-0001Ib-Ga
	for gcvg-git-2@lo.gmane.org; Sun, 26 Jun 2011 23:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754050Ab1FZVNP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jun 2011 17:13:15 -0400
Received: from vserver.localhost.li ([85.214.46.152]:53079 "EHLO
	mail.localhost.li" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754921Ab1FZVM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2011 17:12:29 -0400
Received: from p5794cbe3.dip.t-dialin.net ([87.148.203.227]:45282 helo=[192.168.0.126])
	by mail.localhost.li with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <git@christof-krueger.de>)
	id 1Qawd0-0007Jq-KT; Sun, 26 Jun 2011 23:12:27 +0200
In-Reply-To: <20110626202532.GS30255@genesis.frugalware.org>
X-Mailer: Evolution 2.30.3 
X-Spam-Score: 0.0 (/)
X-Spam-Report: none
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176334>

On So, 2011-06-26 at 22:25 +0200, Miklos Vajna wrote:
> Hi Chris,
> 
> Great, --graph indeed lists two merge commits, and if I check the tree
> objects manually, I can see which one introduced the file. But I still
> don't really understand --name-status why don't show the addition of
> those files, given that I hoped this counts as an "evil merge".

As I understand it, --name-status doesn't play any role in choosing the
commits that are interesting for the "git log <path>" command.

To speak in the terminology used in the history simplification section
of "man git":  What you want is to show all commits that are NOT
TREESAME to _at least_ one parent, whereas git gives you only commits
that are NOT TREESAME to ANY parent.
 
From my current understanding of history simplification, I don't see any
way to directly achieve this. The default mode does not include merge
commits if at least one parent is TREESAME. The --full-history option
only changes which parents are followed, but doesn't change whether a
merge is included or not. Parent rewriting unconditionally includes all
merges, even the ones that are TREESAME wrt all parents.

So do i conclude correctly, that this is a missing feature in git? Is
there something I have overlooked?

Regards,
  Chris
