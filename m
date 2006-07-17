From: "Post, Mark K" <mark.post@eds.com>
Subject: RE: git-repack not removing files from $GIT_DIR/objects/[00-ff]
Date: Sun, 16 Jul 2006 22:48:56 -0400
Message-ID: <5A14AF34CFF8AD44A44891F7C9FF410507E43009@usahm236.amer.corp.eds.com>
References: <20060717015149.GB27389@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 17 04:49:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G2JAS-0003q0-2m
	for gcvg-git@gmane.org; Mon, 17 Jul 2006 04:49:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWGQCtE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Jul 2006 22:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbWGQCtE
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Jul 2006 22:49:04 -0400
Received: from ahmler2.mail.eds.com ([192.85.154.72]:16540 "EHLO
	ahmler2.mail.eds.com") by vger.kernel.org with ESMTP
	id S932121AbWGQCtD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Jul 2006 22:49:03 -0400
Received: from ahmlir5.mail.eds.com (ahmlir5-2.mail.eds.com [192.85.154.135])
	by ahmler2.mail.eds.com (8.13.7/8.12.10) with ESMTP id k6H2n18I014641;
	Sun, 16 Jul 2006 22:49:01 -0400
Received: from ahmlir5.mail.eds.com (localhost [127.0.0.1])
	by ahmlir5.mail.eds.com (8.13.7/8.12.10) with ESMTP id k6H2mwXp011346;
	Sun, 16 Jul 2006 22:48:58 -0400
Received: from usahm012.amer.corp.eds.com ([130.175.214.153])
	by ahmlir5.mail.eds.com (8.13.7/8.12.10) with ESMTP id k6H2mwis011341;
	Sun, 16 Jul 2006 22:48:58 -0400
Received: from usahm236.amer.corp.eds.com ([130.175.214.169]) by usahm012.amer.corp.eds.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 16 Jul 2006 22:48:57 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <20060717015149.GB27389@spearce.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git-repack not removing files from $GIT_DIR/objects/[00-ff]
thread-index: AcapQ72Lg8rjAa0EQ7q+Yhq3ju0kYQAB7M+w
To: <spearce@spearce.org>
X-OriginalArrivalTime: 17 Jul 2006 02:48:57.0893 (UTC) FILETIME=[8CF1B550:01C6A94B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23963>

That doesn't generate any error messages, but it also doesn't clean up
the files in the object directory.


Mark Post 

-----Original Message-----
From: spearce@spearce.org [mailto:spearce@spearce.org] 
Sent: Sunday, July 16, 2006 9:52 PM
To: Post, Mark K
Cc: git@vger.kernel.org
Subject: Re: git-repack not removing files from $GIT_DIR/objects/[00-ff]

So try:

  GIT_DIR=/home/git/pub/scm/linux-2.6.git git-prune-packed

On a bare repository you should always set the GIT_DIR environment
variable to the directory of the repository before running the
command.

"Post, Mark K" <mark.post@eds.com> wrote:
> Thanks for the suggestion, but it didn't help.  One reason is that
this
> is a bare repository.  When I ran the command, it aborted with "fatal:
> Not a git repository."  Most likely because bare repositories don't
have
> a .git directory in them.
> 
> 
> Mark Post 
> 
> -----Original Message-----
> From: spearce@spearce.org [mailto:spearce@spearce.org] 
> Sent: Sunday, July 16, 2006 9:22 PM
> To: Post, Mark K
> Cc: git@vger.kernel.org
> Subject: Re: git-repack not removing files from
$GIT_DIR/objects/[00-ff]
> 
> "Post, Mark K" <mark.post@eds.com> wrote:
> > I'm having a problem that just started occurring with git-repack not
> > removing the files from $GIT_DIR/objects/*, and therefore not
removing
> > the directories, since they're not empty.  The command I'm using (as
> the
> > git user) is this:
> > GIT_DIR=/home/git/pub/scm/linux-2.6.git git-repack -a -d -l
> > 
> > This used to work, but then suddenly stopped working.  I ran an
strace
> > -f -F with this same command, and I don't see any attempt being made
> to
> > unlink the files in $GIT_DIR/objects/*/, but I do see the rmdir
> commands
> > failing because the directories are not empty.  All of the files in
> > those directories are owned by git:git.
> 
> Try running `git-prune-packed` after git-repack.  git-repack doesn't
> delete the loose objects.
> 
> I don't remember git-repack ever doing it either.

-- 
Shawn.
