From: ecloud <shawn.t.rutledge@gmail.com>
Subject: storing pre-computed fine-grained diffs
Date: Wed, 7 Mar 2012 15:41:43 -0800 (PST)
Message-ID: <1331163703976-7353466.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 08 00:41:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5QUP-0002A9-Gb
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 00:41:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758882Ab2CGXlp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Mar 2012 18:41:45 -0500
Received: from sam.nabble.com ([216.139.236.26]:33947 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755457Ab2CGXlo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2012 18:41:44 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <shawn.t.rutledge@gmail.com>)
	id 1S5QUJ-0005bZ-Vp
	for git@vger.kernel.org; Wed, 07 Mar 2012 15:41:43 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192507>

The thing about git, as well as all version control systems I have known so
far which store diffs, is that computing the diff means post-analyzing a
saved file.  That is, you use any editor you like, and after making a whole
batch of changes you manually commit to the repository, and the diff
algorithm figures out what you changed.  Some information is already lost
about what order you made the changes and what the logical chunks actually
were.  But what if there was an editor that could save each individual
change as a separate version?  You put the cursor at one point in the file,
and type some text; then you click elsewhere, and the editor does a "git
commit this-file" automatically.  Then you select some other text and delete
it, and it does a commit again.  It would be nice in that case to avoid
doing the diff at all, because the editor already knows exactly what the
change was.  Would it be possible to store these fine-grained changes
directly in a packfile, efficiently?  Or would it require a different
storage format?  I know the diff algorithm used is already much smarter than
a line-by-line diff, but is the storage format capable of representing
changes over ranges of characters without "extra context" like the
line-by-line diffs usually have?

--
View this message in context: http://git.661346.n2.nabble.com/storing-pre-computed-fine-grained-diffs-tp7353466p7353466.html
Sent from the git mailing list archive at Nabble.com.
