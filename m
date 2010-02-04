From: Sitaram Chamarty <sitaram@atc.tcs.com>
Subject: Re: [gitolite] symlink hooks instead of copying them
Date: Thu, 4 Feb 2010 06:58:40 +0530
Message-ID: <20100204012840.GC497@atcmail.atc.tcs.com>
References: <20100203204723.GA30157@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Teemu Matilainen <teemu.matilainen@iki.fi>
To: martin f krafft <madduck@debian.org>
X-From: git-owner@vger.kernel.org Thu Feb 04 02:29:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcqWy-0005s1-U8
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 02:29:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933040Ab0BDB3O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 20:29:14 -0500
Received: from atcmail.atc.tcs.co.in ([203.200.212.145]:51487 "EHLO
	atcmail.atc.tcs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932991Ab0BDB3M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 20:29:12 -0500
X-Greylist: delayed 606 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Feb 2010 20:29:12 EST
Received: from atcmail.atc.tcs.com (atcmail.atc.tcs.com [127.0.0.1])
	by atcmail.atc.tcs.com (8.14.2/8.14.2) with ESMTP id o141SeaI002579;
	Thu, 4 Feb 2010 06:58:40 +0530
Received: (from sitaram@localhost)
	by atcmail.atc.tcs.com (8.14.2/8.14.2/Submit) id o141SesJ002578;
	Thu, 4 Feb 2010 06:58:40 +0530
Content-Disposition: inline
In-Reply-To: <20100203204723.GA30157@lapse.rw.madduck.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/10354/Wed Feb  3 16:33:21 2010 on atcmail.atc.tcs.com
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
	FH_DATE_PAST_20XX autolearn=no version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on atcmail.atc.tcs.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138925>

On Thu, Feb 04, 2010 at 09:47:23AM +1300, martin f krafft wrote:
> Dear Sitaram, dear Teemo, dear gitolite-fans,
> 
> Gitolite currently copies hooks to repositories. For upgrades, it
> must thus ensure that all hooks are also upgraded.
> 
> It occurs to me that this might be easier done using symlinks, or
> with a file that includes the master hook(s) in
> ~/.gitolite/src/hooks. Then, the hooks just have to be upgraded in
> one place.
> 
> Do you see a reason not to do this via symlinks?

If you mean just the gitolite-specific hooks (the update
hook for all repos, and the post-update hook for the admin
repo) then no problem.

The other hooks I'd rather not assume anything about.  The
current scheme forces an overwrite of the gitolite-specific
hooks, as well as any hooks given in src/hooks, each time an
"install" is done.  It does not touch any *other* hooks,
which allows the admin to (via command line) place specific
hooks in specific repos manually if he wishes to.

I'm ok with symlinking stuff; a couple of "cp" commands
would change to "ln" :)  Let me try it out (and make sure it
works for upgrades also...)
