From: Sylvain Joyeux <sylvain.joyeux@dfki.de>
Subject: Re: [PATCH] better git-submodule status output
Date: Wed, 9 Jul 2008 12:13:30 +0200
Message-ID: <20080709101330.GA3525@joyeux>
References: <20080701150119.GE5852@joyeux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 09 12:14:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGWgy-0007yK-Hc
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 12:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753363AbYGIKNe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 06:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753350AbYGIKNe
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 06:13:34 -0400
Received: from smtprelay08.ispgateway.de ([80.67.29.8]:38786 "EHLO
	smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753314AbYGIKNd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 06:13:33 -0400
Received: from [134.102.219.50] (helo=joyeux)
	by smtprelay08.ispgateway.de with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <sylvain.joyeux@dfki.de>)
	id 1KGWfz-0006FG-Vb
	for git@vger.kernel.org; Wed, 09 Jul 2008 12:13:32 +0200
Content-Disposition: inline
In-Reply-To: <20080701150119.GE5852@joyeux>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Df-Sender: [pbs]640670
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87863>

Here is a (tentative) summary of the whole discussion:

* doing fetch in status is EVIL. Therefore, status should only report
  whatever information is available.
* nonetheless, having a "peek" mode seem to be accepted as a useful
  feature not only by me.
* changing the output format of git-submodules is not right either,
  because it would break existing tools which parses it at the moment.

Proposal
- remove fetch from status, and make the new output enabled when
  --verbose is set (can also be set in the config file I guess).

  On the symbols side, I propose:
    > submodule commit is a direct descendant of the commit in the
      superproject
    < submodule commit is a direct ancestor of the commit in the
      superproject
    + no direct relation between submodule commit and commit in the
      superproject
    ? the commit in the superproject cannot be found in the submodule
      (replaces the initial '!' in my patch)

  A 'M' is appended if the submodule has uncommitted changes

- define a git-submodule 'fetch' subcommand which call fetch in each
  submodule and runs the verbose mode of git-status (can be disabled by
  a --quiet option).

Comments ? (I'm sure there are some ...)

Sylvain
