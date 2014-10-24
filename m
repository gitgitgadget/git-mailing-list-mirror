From: "R. David Murray" <rdmurray@bitdance.com>
Subject: Fatal: <hash> is corrupted can be caused by wrong permissions
Date: Fri, 24 Oct 2014 09:48:02 -0400
Message-ID: <20141024134802.93466250E0D@webabinitio.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 24 15:56:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XhfLf-0000Ug-8B
	for gcvg-git-2@plane.gmane.org; Fri, 24 Oct 2014 15:56:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756733AbaJXN4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2014 09:56:07 -0400
Received: from 173-13-127-166-NewEngland.hfc.comcastbusiness.net ([173.13.127.166]:41532
	"EHLO webabinitio.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756658AbaJXN4F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2014 09:56:05 -0400
X-Greylist: delayed 482 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Oct 2014 09:56:05 EDT
Received: from localhost (mailhost.webabinitio.net [127.0.0.1])
	by webabinitio.net (Postfix) with ESMTP id 93466250E0D
	for <git@vger.kernel.org>; Fri, 24 Oct 2014 09:48:02 -0400 (EDT)
X-Virus-Scanned: amavisd-new at example.com
Received: from webabinitio.net ([127.0.0.1])
	by localhost (mailhost.webabinitio.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id oR5QlZzBVDBV for <git@vger.kernel.org>;
	Fri, 24 Oct 2014 09:48:02 -0400 (EDT)
Received: from session.bitdance.com (unknown [192.168.0.103])
	by webabinitio.net (Postfix) with ESMTP id 23F25250D5E
	for <git@vger.kernel.org>; Fri, 24 Oct 2014 09:48:02 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A quick search of your mailing list didn't turn up any good hits (not the most
searchable terms and gmane search doesn't seem to support phrases), so I'm
reporting this.

On git 1.7.1 I ran into the Fatal corruption error in one of my projects.  For
reasons that are irrelevant I was operating on the repo as user X, a member of
group Z, but the files were all owned by Y:Z, with (I thought) -rw-rw---
permissions.  After a bunch of head banging I finally figured out that the
Fatal error wasn't because the object files were corrupted, but because three
objects (for reasons unknown to me that are probably lost in the early history
of the setup of this particular repo...one of the blobs was the first commit)
were -rw-----.  So it seems to me that the error message could be improved to
indicate that the reason the object couldn't be used was a permission error.
That's  a different thing from the contents being corrupted.

--David
