From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v4 0/5] Re: {checkout,reset,stash} --patch
Date: Sun, 9 Aug 2009 23:42:28 +0200
Message-ID: <200908092342.31733.trast@student.ethz.ch>
References: <200907271210.40001.trast@student.ethz.ch> <200908091844.43107.trast@student.ethz.ch> <20090809212831.GA12932@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Sun Aug 09 23:42:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaGAJ-000421-DQ
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 23:42:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753515AbZHIVms (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 17:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753477AbZHIVms
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 17:42:48 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:10377 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753416AbZHIVmr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 17:42:47 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.1.375.2; Sun, 9 Aug
 2009 23:42:46 +0200
Received: from thomas.localnet (77.56.221.170) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Sun, 9 Aug
 2009 23:42:46 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.25-0.1-default; KDE/4.3.0; x86_64; ; )
In-Reply-To: <20090809212831.GA12932@vidovic>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125388>

Nicolas Sebrecht wrote:
> The 09/08/09, Thomas Rast wrote:
> > 
> > Since you can't say 'git reset --hard -- file', you have to do 'git
> > checkout HEAD -- file' to achieve this effect.  So this usage is
> > covered by 'git checkout -p HEAD'.
> 
> So, we can discard a hunk from the index with 'git reset -p' without
> touching the WT. And we can discard a hunk from the WT with 'git
> checkout -p' without touching the index. But we can't discard a hunk
> from both the index and the WT.

Yes, you can, precisely as I wrote:

> > covered by 'git checkout -p HEAD'.
                                ^^^^

I figured this makes sense:

  git checkout -- file         # copy file from index to worktree
  git checkout -p [file]       # copy hunks from index to worktree
  git checkout HEAD -- file    # copy file from HEAD to index&worktree
  git checkout -p HEAD -- file # copy hunks from HEAD to index&worktree

Note that the patch application stage has no guarantees that what you
picked will also apply to the index; it tries first, and if it
doesn't, it asks if it should apply to the worktree anyway (and leave
the index unchanged).

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
