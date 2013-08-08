From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] pull: Allow pull to preserve merges when rebasing.
Date: Thu, 8 Aug 2013 23:20:10 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1308082314320.24252@s15462909.onlinehome-server.info>
References: <1375983492-32282-1-git-send-email-stephen@exigencecorp.com> <1375983492-32282-2-git-send-email-stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, avarab@gmail.com
To: Stephen Haberman <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Thu Aug 08 23:20:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7Xd4-0005OP-PT
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 23:20:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966683Ab3HHVUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 17:20:13 -0400
Received: from mout.gmx.net ([212.227.15.18]:56938 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966669Ab3HHVUM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 17:20:12 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0LbMb0-1VsRu41xaE-00kzmQ
 for <git@vger.kernel.org>; Thu, 08 Aug 2013 23:20:10 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <1375983492-32282-2-git-send-email-stephen@exigencecorp.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:DYTc/4h9k+UZroGO/Z9O9n1eQFOSzhh5WY+WoHhM5SA/+qhMJSF
 IVu4z0sY1v6nAb/6LWjzFqvuTCY4j+q1OZlRbj1o4qjtVprOZlZqcyDrgcCnFp0rJBS9ghe
 S9XMc7qj39OxWrw5xEl3fNV0o1GncLV0Mln3Wi7hpa7aB+Yr8KIZm97TO7KRX1tBonO4Jdg
 w5Nrf2Pyxqg4kcIAUzNgA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231934>

Hi Stephen,

On Thu, 8 Aug 2013, Stephen Haberman wrote:

> If a user is working on master, and has merged in their feature branch,
> but now has to "git pull" because master moved, with pull.rebase their
> feature branch will be flattened into master.
> 
> This is because "git pull" currently does not know about rebase's
> preserve merges flag, which would this behavior, and instead replay on
> the merge commit of the feature branch onto the new master, and not the
> entire feature branch itself.
> 
> Add a -p/--preserve-merges, to pass along git rebase if --rebase is in affect.

ACK!

> Also add a new pull.preserve-merges config setting, to enable this
> behavior as the default.

This should probably be added to config.txt and
Documentation/git-pull.txt, too, right?

FYI I started to rewrite the complete --preserve-merges support for the
interactive rebase some time ago, based on the experience of the merging
rebases:

	https://github.com/msysgit/git/commit/b733454b

(part of the rebase-i-p branch). The idea is to use the 'exec' command of
the interactive rebase to do a much better job, and to allow reordering
(and in particular fixup commits) even when trying to preserve merges.

Unfortunately, the resulting branches look slightly differently now,
breaking the (horribly complicated -- my fault!) unit tests, and due to an
utter lack of time I had to stall that project.

Feel free to play with it if you want!

Ciao,
Johannes
