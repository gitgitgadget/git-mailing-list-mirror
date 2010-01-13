From: chombee <chombee@lavabit.com>
Subject: Syncing a git working tree with Dropbox?
Date: Wed, 13 Jan 2010 23:57:18 +0000
Message-ID: <20100113235718.GA7033@dulip>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 00:57:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVD5t-0007Xx-A9
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 00:57:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756698Ab0AMX5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 18:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756692Ab0AMX5e
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 18:57:34 -0500
Received: from karen.lavabit.com ([72.249.41.33]:38522 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756180Ab0AMX5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 18:57:25 -0500
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id C554511B924
	for <git@vger.kernel.org>; Wed, 13 Jan 2010 17:57:24 -0600 (CST)
Received: from dulip (77-44-113-77.xdsl.murphx.net [77.44.113.77])
	by lavabit.com with ESMTP id 0WDWVF9SCFY0
	for <git@vger.kernel.org>; Wed, 13 Jan 2010 17:57:24 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=o6EEV0c7XD53cz+HFymykaRGziZPwdt39v2K/UA2rNSW+GFfCHdpLmmNliIqyIuUqknimsiRz91PQq+/AaDPr8GXNuunX9A50qyR0mUVAG6ICpQw5AlzDECwEPt59igCJWCuspqH1CpRKYPBhtOT1pjAAxB4z5sx3KpiGLY96qs=;
  h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition:User-Agent;
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136899>

I've heard of people keeping a bare repo in their Dropbox folder
(https://www.dropbox.com/) and pushing to and pulling from it, letting
Dropbox sync the bare repo between their machines. In other words using
Dropbox as a form of hosting for a private git repo. What I want to do
is sort of the other way around.

I keep on getting into the following mess: I have some changes in my
working tree on machine A, I stop working on machine A and don't commit
and push the changes (to my remote, 'central' bare repo) either because
they're not ready yet, or I forget to commit or push. Later on I arrive
at machine B which has its own clone of the same repo, but because I
didn't commit and push the changes on machine A I don't have access to
them on machine B and I can't continue working on them. The two machines
are physically located far away from each other and they're not
accessible over the internet. Argh!

Dropbox is a proprietary sync service that gets around this problem
because it automatically syncs your files whenever you save them. But I
still want to keep my project in a git repo. I'm assuming that keeping
the actual .git folder in a Dropbox folder, so that when git makes
changes inside the .git folder Drobox syncs them, would be a bad idea.
It seems like taking two different synchronisation systems and mashing
them into each other. But what about just the working tree?

My idea is that I keep my .git folder safely outside of my Dropbox
folder, but my git repository has a detached working tree that is
located in the Dropbox folder. On machine B it would be the same setup.
So the two machines each have their own clone of the git repo and these
are synchronised by git push and git pull with a 'central' remote repo.
But the two clones share the same working tree, or more accurately their
working trees are synced by Dropbox.

The working tree is just files, I don't see how it's different from
Dropbox syncing any other files. Dropbox and git ought not to collide in
any way. So this should work fine shouldn't it?

This way I don't need to commit and push my changes until they're
ready/I remember to, but whenever I move from machine A to machine B my
uncommitted changes will still be available to me because Dropbox has
synced my working tree automatically.
