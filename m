From: Kannan Goundan <kannan@cakoose.com>
Subject: Make "git checkout" automatically update submodules?
Date: Thu, 15 Oct 2015 22:50:05 +0000 (UTC)
Message-ID: <loom.20151016T001449-848@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 16 00:55:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmrQm-0006bM-Cx
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 00:55:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752345AbbJOWzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 18:55:16 -0400
Received: from plane.gmane.org ([80.91.229.3]:59542 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751401AbbJOWzP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 18:55:15 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ZmrQO-0006IF-0E
	for git@vger.kernel.org; Fri, 16 Oct 2015 00:55:04 +0200
Received: from 205.189.0.114 ([205.189.0.114])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 16 Oct 2015 00:55:03 +0200
Received: from kannan by 205.189.0.114 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 16 Oct 2015 00:55:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 205.189.0.114 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:41.0) Gecko/20100101 Firefox/41.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279712>

Git submodules seem to be a great fit for one of our repos.  The biggest
pain point is that it's too easy to forget to update submodules.

1. I often forget since most repos don't need it.
2. Infrequent users of our repo almost never know to update submodules and
end up coming to us with strange build errors.
3. Existing scripts that work with Git repos are usually not built to handle
submodules.

In the common case of the submodule content having no local edits, it would
be nice if "git checkout" automatically updated submodules [1].  If there
are local edits, it could error out (maybe override with
"--ignore-modified-submodules" or something).

I'm not a Git expert, though.  Is there a reason something like this isn't
already implemented?  Maybe there's an existing write-up or mailing list
thread I can read to get some background information?

Thanks!

[1] Our post-checkout procedure is:

    git submodule sync
    git submodule update --init
    git submodule foreach --recursive \
      'git submodule sync ; git submodule update --init'

(Not sure if this is correct.  Different articles/blogs suggest a slightly
different set of commands.)
