From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Finding a commit
Date: Wed, 21 Oct 2009 14:37:37 +0200
Message-ID: <200910211437.39166.trast@student.ethz.ch>
References: <4ADEF095.3020406@box.net> <9accb4400910210530k75a763cbtbc9294d937de9242@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Daniele Segato <daniele.bilug@gmail.com>,
	Soham Mehta <soham@box.net>
X-From: git-owner@vger.kernel.org Wed Oct 21 14:40:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0aSe-0005eV-2V
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 14:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172AbZJUMia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 08:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751949AbZJUMia
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 08:38:30 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:2036 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751479AbZJUMi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 08:38:29 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 21 Oct
 2009 14:38:32 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 21 Oct
 2009 14:38:12 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.27.29-0.1-default; KDE/4.3.1; x86_64; ; )
In-Reply-To: <9accb4400910210530k75a763cbtbc9294d937de9242@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130910>

Daniele Segato wrote:
> On Wed, Oct 21, 2009 at 1:29 PM, Soham Mehta <soham@box.net> wrote:
> > Because SHA1 can change if a commit is cherry-picked around, I cannot just
> > grep for that SHA1 from git-rev-list or git-log on 'y'. I need a way to know
> > if a commit with identical changes (as in 'x') is also present in 'y'.

man git-patch-id (online at http://git.or.cz/man/git-patch-id).

Note that if the cherry-pick conflicted, you'll get a different
patch-id.

> I'm really not an expert of git..
> 
> but A commit is something like:
> 
> Commit -> Tree ---> Blob1, Blob2, Blob3
> 
> Commit, Trees and Blobs are all identified by sha1
> the commit should keep information on the author, the "parent"
> commit(s) and so on..
> the tree should just keep the "snapshot" of the data..
> 
> so I think that if you search for the SHA-1 of the tree you should be fine..

Not if you really want to find out if X was cherry-picked into this
repository, because the tree is the *final state* at that commit,
which of course includes all preceding changes.

So suppose you have two patches A.diff and B.diff introducing files of
the same name; then if you combine them into history as

  A -- B

the tree state at B has both files, and hence is different from the
tree state of B' in

  B' -- A'

because there it only has the file B.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
