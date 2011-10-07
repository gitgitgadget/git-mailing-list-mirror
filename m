From: Andrew McNabb <amcnabb@mcnabbs.org>
Subject: unexpected behavior with `git log --skip filename`
Date: Fri, 7 Oct 2011 11:15:03 -0600
Message-ID: <20111007171503.GB16607@mcnabbs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 07 19:44:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCETf-0007Z7-C1
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 19:44:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758187Ab1JGRov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 13:44:51 -0400
Received: from komodo.mcnabbs.org ([67.207.145.27]:60846 "EHLO
	mail.mcnabbs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756111Ab1JGRou (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 13:44:50 -0400
X-Greylist: delayed 1785 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Oct 2011 13:44:50 EDT
Received: from maggie.mcnabbs.org (otherlab.cs.byu.edu [128.187.81.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.mcnabbs.org (Postfix) with ESMTP id 0B73DBD76B
	for <git@vger.kernel.org>; Fri,  7 Oct 2011 12:15:05 -0500 (CDT)
Received: by maggie.mcnabbs.org (Postfix, from userid 1000)
	id AABF128D16; Fri,  7 Oct 2011 11:15:03 -0600 (MDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183090>

The "--skip" option to "git log" did not behave as I expected, but I'm
not sure whether this was user error, unclear documentation, or a bug.
Specifically, I ran the following, intending to find the previous
revision of a given file:

git log --skip=1 -n 1 --oneline some-filename

My expectation was that this would behave the same as:

git log -n 2 --oneline some-filename |tail -n 1

Instead, the --skip=1 parameter seemed to be ignored.  After I tried
several different values, it appears that the commits are skipped before
path matching with "some-filename".

Is this the intended behavior?  If so, should the documentation be
clarified by changing "Note that they are applied before commit ordering
and formatting options, such as --reverse" to something like "Note that
they are applied before path matching, commit ordering, and formatting
options, such as --reverse"?

--
Andrew McNabb
http://www.mcnabbs.org/andrew/
PGP Fingerprint: 8A17 B57C 6879 1863 DE55  8012 AB4D 6098 8826 6868
