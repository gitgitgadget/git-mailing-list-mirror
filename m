From: Andreas Krey <a.krey@gmx.de>
Subject: BUG: 'error: invalid key: pager.show_ref' on 'git show_ref'
Date: Fri, 6 Feb 2015 13:45:28 +0100
Message-ID: <20150206124528.GA18859@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 06 13:45:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJiHw-0003gK-5P
	for gcvg-git-2@plane.gmane.org; Fri, 06 Feb 2015 13:45:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755477AbbBFMpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2015 07:45:32 -0500
Received: from continuum.iocl.org ([217.140.74.2]:50154 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754516AbbBFMpb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2015 07:45:31 -0500
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id t16CjSo19200;
	Fri, 6 Feb 2015 13:45:28 +0100
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263416>

Hi all,

there seems to be a regression in the behaviour of 'git show_ref'
(note the underscore). In v2.0.3-711-g586f414 it starts to say:

  $ ./git show_ref
  error: invalid key: pager.show_ref
  git: 'show_ref' is not a git command. See 'git --help'.

and somewhere (probably two commits, judging the diffs)
later that changes again to:

  $ git show_ref
  error: invalid key: pager.show_ref
  error: invalid key: alias.show_ref
  git: 'show_ref' is not a git command. See 'git --help'.

Apparently we need to squelch this message from
within git_config_get_* in this case?

Still present in 2.3.0.

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
