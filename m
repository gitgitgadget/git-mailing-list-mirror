From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: unexpected git-cherry-pick conflict
Date: Wed, 13 Jun 2007 13:58:51 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706131354250.4059@racer.site>
References: <20070405071615.2915.6837.reportbug@acer>
 <20070607074357.27760.qmail@69aef7b888effd.315fe32.mid.smarden.org>
 <6b8a91420706070252y3fd581a3w427d91e5b982d29d@mail.gmail.com>
 <20070613091624.26463.qmail@353090644b4917.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, 417885@bugs.debian.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Wed Jun 13 15:02:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HySUK-00017L-Qu
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 15:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757531AbXFMNCP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 09:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757410AbXFMNCP
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 09:02:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:50561 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756736AbXFMNCO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 09:02:14 -0400
Received: (qmail invoked by alias); 13 Jun 2007 13:02:13 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp038) with SMTP; 13 Jun 2007 15:02:13 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+aRi9PeJyazv4mTJ9hIyr9KdH3pISWMcCdXe6uZN
	hnKWUS/HVDYJDP
X-X-Sender: gene099@racer.site
In-Reply-To: <20070613091624.26463.qmail@353090644b4917.315fe32.mid.smarden.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50056>

Hi,

On Wed, 13 Jun 2007, Gerrit Pape wrote:

>  $ mkdir repo && cd repo
>  $ git init
>  Initialized empty Git repository in .git/
>  $ echo foo >file
>  $ ln -s dangling link
>  $ git add .
>  $ git commit -mfoo
>  Created initial commit c6a9189: foo
>   2 files changed, 2 insertions(+), 0 deletions(-)
>   create mode 100644 file
>   create mode 120000 link

So, basically your master has a file and a symbolic link.

>  $ git checkout -b branch
>  Switched to a new branch "branch"
>  $ git rm link
>  rm 'link'
>  $ git commit -mremovelink
>  Created commit 2c60f15: removelink
>   1 files changed, 0 insertions(+), 1 deletions(-)
>   delete mode 120000 link

Here, you remove the link from the branch.

>  $ mkdir link
>  $ echo bar >link/file
>  $ git add link
>  $ git commit -m adddir
>  Created commit d3b30b5: adddir
>   1 files changed, 1 insertions(+), 0 deletions(-)
>   create mode 100644 link/file

Here you added a directory of the same name as the symbolic link has in 
master.

>  $ git checkout master
>  Switched to branch "master"
>  $ git cherry-pick 8ddc4d5
>  CONFLICT (file/directory): There is a directory with name link in
>  8ddc4d5... file. Added link as link~HEAD

Here you _still_ have the file in master. So that conflict is really 
expected, since a cherry-pick will only do a three-way merge.

I guess you want to use git-rebase instead.

Ciao,
Dscho
