From: Hagen Paul Pfeifer <hagen@jauu.net>
Subject: Re: Bisect limited to Merge Commits
Date: Thu, 28 Apr 2016 08:19:30 +0200
Message-ID: <20160428061929.GA11322@virgo.localdomain>
References: <20160427204551.GB4613@virgo.localdomain>
 <xmqq8tzy93ed.fsf@gitster.mtv.corp.google.com>
 <57213041.5070506@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Apr 28 08:19:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avfIY-0004n2-Dp
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 08:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbcD1GTe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 02:19:34 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:41979 "EHLO mx2.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750809AbcD1GTe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 02:19:34 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx2.mailbox.org (Postfix) with ESMTPS id C1FC3420FD;
	Thu, 28 Apr 2016 08:19:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
	by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
	with ESMTP id r9iGvpeT2XdZ; Thu, 28 Apr 2016 08:19:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <57213041.5070506@kdbg.org>
X-Key-Id: 98350C22
X-Key-Fingerprint: 490F 557B 6C48 6D7E 5706 2EA2 4A22 8D45 9835 0C22
X-GPG-Key: gpg --recv-keys --keyserver wwwkeys.eu.pgp.net 98350C22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292846>

* Johannes Sixt | 2016-04-27 23:33:53 [+0200]:

Hey Junio, hey Hannes,

> git bisect start
> git rev-list --first-parent --boundary origin..origin/pu |
>   sed -ne s/-//p | xargs git bisect good
> git bisect bad origin/pu
>
>and it starts bisecting among the 50-something first-parent commits between
>origin and origin/pu.

just for clarification: contributors rebase their work before pushing it on
master. The integrator simple merges --no-ff the individual branches. Just a
regular workflow, nothing special - except that many contributor commits will
not build. ;(

The idea is just to skip the contributor commits during bisect and focus on
the merge commits (the ones with more than one ancestors) because they are
likely build and testable.

One possible approach is probably to sort out all non-merge commits before
bisecting and bisect only on a this set of commits. The advantage is that the
first bad commit is the merge commit introduced the regression. Mmmh, any
comments?

hgn
