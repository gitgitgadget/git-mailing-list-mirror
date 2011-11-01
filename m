From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: add hook to allow modifying the subversion
 commit message
Date: Tue, 1 Nov 2011 20:28:06 +0000
Message-ID: <20111101202806.GB29769@dcvr.yhbt.net>
References: <1319228708-9052-1-git-send-email-michi@icosahedron.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Lutz <michi@icosahedron.de>
X-From: git-owner@vger.kernel.org Tue Nov 01 21:28:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLKwQ-0006rA-4y
	for gcvg-git-2@lo.gmane.org; Tue, 01 Nov 2011 21:28:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292Ab1KAU2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Nov 2011 16:28:08 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:47030 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752787Ab1KAU2H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2011 16:28:07 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id B98382EE3A1;
	Tue,  1 Nov 2011 20:28:06 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1319228708-9052-1-git-send-email-michi@icosahedron.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184587>

Michael Lutz <michi@icosahedron.de> wrote:
> Sometimes modifying the commit message git-svn creates for a subversion
> commit can be useful, for example if the original message contains meta
> information not needed in the git clone or information from svn properties
> should be stored visibly in the commit message.
> 
> This change adds a hook 'git-svn-msg' analogue to the 'commit-msg' hook.
> Additionally to the commit message, the hook is passed the git-svn meta
> data by an environment variable.

I'm not convinced this is a good feature to support.  We already have
--no-metadata to remove git-svn-id: lines and I hate that feature
because it introduced extra variables for testing/debugging/recovery.

Metadata in the commit message is important, if you want to remove
it after-the-fact, there's git-filter-branch.

When dealing with repositories that have been through several systems
(e.g. (CVS|Perforce) -> SVN -> git), it's useful to be able to refer to
old mailing list archives that only refer to the original system (since
neither SVN nor git existed at the time the email was sent).
