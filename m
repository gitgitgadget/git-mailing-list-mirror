From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: re-running merge on a single file
Date: Thu, 11 Mar 2010 21:29:52 +0100
Message-ID: <201003112129.52596.markus.heidelberg@web.de>
References: <a038bef51003111054n5bcecd2eud531dcc80509f952@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: GIT <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 11 21:29:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Npp0v-0006s5-31
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 21:29:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756879Ab0CKU3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 15:29:44 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:43442 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756791Ab0CKU3n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 15:29:43 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 885FF143B8BE1;
	Thu, 11 Mar 2010 21:29:42 +0100 (CET)
Received: from [91.19.0.202] (helo=pluto.localnet)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #314)
	id 1Npp0o-00012k-00; Thu, 11 Mar 2010 21:29:42 +0100
User-Agent: KMail/1.12.4 (Linux/2.6.30-gentoo-r8; KDE/4.3.5; i686; ; )
In-Reply-To: <a038bef51003111054n5bcecd2eud531dcc80509f952@mail.gmail.com>
Jabber-ID: markus.heidelberg@web.de
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/L78FDzMoT92RGumyOTWXIPGDjP8XWf0hqh2k4
	3LjLOqw+dPhA6h0A0/3xclWLUaw9fA91nFTbX4NmfdmKLJIFKQ
	KDe5sigWGPlEDky+MkeQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141997>

Chris Packham, 2010-03-11 19:54:
> In other cases I'm actually thinking
> that it'd be easier to ask git to try the merge again on that one
> file. I can ask git difftool to show me the pre-merge differences with
> 'git difftool master..vendor <file>' but what I'd really like to do is
> ask git mergetool to do something similar so I can re-do my manual
> merging.

Not mergetool, but checkout:
git checkout --merge -- file

> Alternatively I could manually drive and external merge tool like
> kdiff3 if I had a recipe for getting the common ancestor revision.
> Something like
> 
> git checkout <magic pathspec> -- file
> mv file file.base

git cat-file blob :1:file > file.base

> 
> git checkout master -- file

git checkout --ours -- file

> mv file file.ours

or
git cat-file blob :2:file > file.ours

> git checkout vendor -- file

git checkout --theirs -- file

> mv file file.theirs

or
git cat-file blob :3:file > file.theirs

> kdiff3 file.base file.ours file.theirs -o file


See the manpages of git-checkout and git-merge for these syntaxes.

Markus
