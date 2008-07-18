From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Enable git rev-list to parse --quiet
Date: Fri, 18 Jul 2008 12:50:11 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807181246590.3932@eeepc-johanness>
References: <20080718040459.13073.76896.stgit@marcab.local.tull.net> <7v8wvzeojm.fsf@gitster.siamese.dyndns.org> <20080718092001.GD16102@mail.local.tull.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nick Andrew <nick@nick-andrew.net>
X-From: git-owner@vger.kernel.org Fri Jul 18 12:51:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJnXi-0003ld-13
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 12:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700AbYGRKtb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 06:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751571AbYGRKta
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 06:49:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:53214 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751217AbYGRKta (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 06:49:30 -0400
Received: (qmail invoked by alias); 18 Jul 2008 10:49:28 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp033) with SMTP; 18 Jul 2008 12:49:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19E/JE7dyhEfMDMnvxi7EslcThkf4x3fMS1ReLStX
	n59WGJNXz+faxQ
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080718092001.GD16102@mail.local.tull.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89028>

Hi,

On Fri, 18 Jul 2008, Nick Andrew wrote:

> I want to automatically (e.g. in crontab) update a git repo to the 
> latest HEAD from a remote branch ... but with the possibility that the 
> local repo has local changes, and I want no chance of merge failure. In 
> other words, "git fetch remote; git merge origin/master" and only do the 
> merge if it's a fast-forward. If there are any local commits, or local 
> uncommitted changes, then leave the local working tree alone.
> 
> So my idea was to use "git rev-list --quiet master ^origin/master" and 
> check the exit code; if zero do "git merge origin/master". Without a 
> working "--quiet" nor exit code I can pipe the output to "wc -l" but is 
> there a more efficient/reliable way to implement the requirement?

Yes. Check if "$(git rev-parse master)" is different from "$(git rev-parse 
origin/master)" (to avoid unnecessary merging), and then that "$(git 
merge-base master origin/master)" is equal to "$(git rev-parse master)".

Note: this is plumbing, meant for scripting (which is exactly your 
scenario).  Do not teach this to new Git users.

Ciao,
Dscho
