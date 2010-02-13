From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 2/2] git-svn: support fetch with autocrlf on
Date: Sat, 13 Feb 2010 04:25:32 -0800
Message-ID: <20100213122532.GA31653@dcvr.yhbt.net>
References: <1265997155-3592-1-git-send-email-kusmabite@gmail.com> <1265997155-3592-2-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Feb 13 13:26:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgH4t-0001Wh-5o
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 13:26:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754321Ab0BMMZe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 07:25:34 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:36411 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753884Ab0BMMZd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 07:25:33 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id D73991F68C;
	Sat, 13 Feb 2010 12:25:32 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1265997155-3592-2-git-send-email-kusmabite@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139793>

Erik Faye-Lund <kusmabite@googlemail.com> wrote:
> If I enable core.autocrlf and perform a "git svn rebase" that fetches
> a change containing CRLFs, the git-svn meta-data gets corrupted.
> 
> Commit d3c9634e worked around this by setting core.autocrlf to "false"
> in the per-repo config when initing the clone. However if the config
> variable was changed, the breakage would still occur. This made it
> painful to work with git-svn on repos with mostly checked in LFs on
> Windows.
> 
> This patch tries to fix the same problem while allowing core.autocrlf
> to be enabled, by disabling filters when when hashing.
> 
> git-svn is currently the only call-site for hash_and_insert_object
> (apart from the test-suite), so changing it should be safe.
> 
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> ---
> 
> With this patch applied, I guess we can also revert d3c9634e. I didn't
> do this in this series, because I'm lazy and selfish and thus only
> changed the code I needed to get what I wanted to work ;)
> 
> I've been running git-svn with these patches with core.autocrlf enabled
> since December, and never seen the breakage that I saw before d3c9634e.

Hi Erik,

How does reverting d3c9634e affect dcommit?  I've never dealt with (or
even looked at) autocrlf, so I'll put my trust in you and Dscho with
anything related to it.

-- 
Eric Wong
