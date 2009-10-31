From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Don't create the $GIT_DIR/branches directory on init
Date: Sat, 31 Oct 2009 11:09:20 -0700
Message-ID: <20091031180920.GN10505@spearce.org>
References: <1256923228-18949-1-git-send-email-robin.rosenberg@dewire.com> <200910311011.31189.trast@student.ethz.ch> <200910311902.48317.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	sasa.zivkov@sap.com
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 19:12:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4IQl-0001f0-T4
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 19:12:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932806AbZJaSJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2009 14:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932755AbZJaSJQ
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Oct 2009 14:09:16 -0400
Received: from george.spearce.org ([209.20.77.23]:44416 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932652AbZJaSJP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2009 14:09:15 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 9EE44381D3; Sat, 31 Oct 2009 18:09:20 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200910311902.48317.robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131847>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> >   * a remote in the git configuration file: `$GIT_DIR/config`,
> >   * a file in the `$GIT_DIR/remotes` directory, or
> >   * a file in the `$GIT_DIR/branches` directory.
> 
> I, and a few other people, it seems. Seems the purpose of these
> files is a bit different. Git does look in these directories (both)
> when fetch is run. Seems remotes is not created by init though.

Since remotes isn't created by init, branches shouldn't be either.
Cogito is dead, and that was the main customer who wanted branches
to be present in a repository.

I think its safe to remove branches from the template repository
and stop creating it, but continue to read from branches and
remotes if they exist.

We might want to consider dropping support for them in 1.7.0
or 1.8.0, because any new tools largely focus on config.
E.g. git-remote probably can't edit branches or remotes, git-gui
probably doesn't use them, JGit doesn't use them.

-- 
Shawn.
