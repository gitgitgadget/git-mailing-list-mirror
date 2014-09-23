From: Daniel Brockman <daniel@brockman.se>
Subject: Passing tar(1) options via git-archive(1)
Date: Tue, 23 Sep 2014 20:57:19 +0200
Message-ID: <87bnq6jhbk.fsf@brockman.se>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 23 21:06:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWVQA-00070N-G0
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 21:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755528AbaIWTGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 15:06:38 -0400
Received: from brockman.se ([188.226.237.105]:33012 "EHLO brockman.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751735AbaIWTGh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 15:06:37 -0400
X-Greylist: delayed 555 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Sep 2014 15:06:36 EDT
Received: from brockman.se (localhost [127.0.0.1])
	by brockman.se (Postfix) with ESMTPS id 540E8120CE3
	for <git@vger.kernel.org>; Tue, 23 Sep 2014 20:57:20 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257432>

Some background from the git-archive(1) man page:

    git-archive behaves differently when given a tree ID versus when
    given a commit ID or tag ID.  In the first case the current time is
    used as the modification time of each file in the archive.  In the
    latter case the commit time as recorded in the referenced commit
    object is used instead.

Would it make sense to add an --mtime option to git-archive(1) to enable
explicitly setting the mtime for all files in the archive?  It could
just pass through to the tar(1) --mtime option.

My use case is `git archive HEAD | docker build -`, in which the Docker
cache is prevented from working because the mtime keeps getting bumped
on all files.  I would like to have the mtime always be the same.

See, e.g., <https://github.com/deis/deis/issues/1334>.

Otherwise, how about a generic way to pass options to tar(1)?

Thanks,
Daniel
