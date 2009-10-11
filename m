From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: combine git repo historically
Date: Sun, 11 Oct 2009 12:11:55 +0200
Message-ID: <200910111211.56011.chriscool@tuxfamily.org>
References: <20091009012254.GA3980@debian.b2j> <200910110436.52653.chriscool@tuxfamily.org> <20091011040659.GB9021@debian.b2j>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: bill lam <cbill.lam@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 11 12:13:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwvR3-0004fo-Ob
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 12:13:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756324AbZJKKKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 06:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756212AbZJKKKt
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 06:10:49 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:50491 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756177AbZJKKKs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 06:10:48 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id A11F98180D5;
	Sun, 11 Oct 2009 12:10:06 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id B6CF981813C;
	Sun, 11 Oct 2009 12:10:03 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20091011040659.GB9021@debian.b2j>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129913>

On Sunday 11 October 2009, bill lam wrote:
> On Sun, 11 Oct 2009, Christian Couder wrote:
> > $ git checkout -b repo1-branch1 remote/repo1/branch1
> > $ git checkout N -- .
> > ...
> > If everything is ok then you can use:
> >
> > $ git replace N HEAD
>
> Thanks for detail instruction, I tested it ok except that when trying
> to checkout it reported an error
>
>   $ git checkout -b repo1-branch1 remote/oldjproject/master
>   fatal: git checkout: updating paths is incompatible with switching
> branches. Did you intend to checkout 'remote/oldjproject/master' which
> can not be resolved as commit?
>
> but it ran ok by omitting that 'remote/'
> $ git checkout -b repo1-branch1 oldjproject/master
>
> Does it need to purge the file system tree before
>   git checkout N -- .
>
> so that there will be no artifact leaved by M?

Yeah, perhaps, I forgot that there could be some files added and other files 
removed between M and N.

If you remove everything (except the .git directory of course), then doing:

$ git checkout N -- .
$ git add .
$ export GIT_AUTHOR_NAME=<author name of commit N>
$ export GIT_AUTHOR_EMAIL=<author email of commit N>
$ export GIT_AUTHOR_DATE=<date of commit N>
$ git commit

should do the trick if I am not missing something which may very well be the 
case.

So perhaps it is easier to use Jakub's suggestion instead.

> I found that it is necessary to do a
>    git reset --hard (original HEAD)
>
> to complete the story. Is it correct?

Yes, you should go back to your orginal branch at the end.

Regards,
Christian.
