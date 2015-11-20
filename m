From: alan@clueserver.org
Subject: Odd issue with Git-am
Date: Fri, 20 Nov 2015 13:02:42 -0800
Message-ID: <7df90d19cfa7e987a23a22b5cd90fe6a.squirrel@clueserver.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 20 22:02:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzspT-0003Uc-Jx
	for gcvg-git-2@plane.gmane.org; Fri, 20 Nov 2015 22:02:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895AbbKTVCn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2015 16:02:43 -0500
Received: from clueserver.org ([65.102.45.174]:43287 "EHLO clueserver.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751156AbbKTVCn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2015 16:02:43 -0500
Received: from clueserver.org (localhost [127.0.0.1])
	by clueserver.org (Postfix) with ESMTP id 5EF56600292
	for <git@vger.kernel.org>; Fri, 20 Nov 2015 13:02:42 -0800 (PST)
Received: from 134.134.137.75
        (SquirrelMail authenticated user alan)
        by clueserver.org with HTTP;
        Fri, 20 Nov 2015 13:02:42 -0800
User-Agent: SquirrelMail/1.4.22-14.fc20
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281535>

The following describes bad behavior, but it is bad behavior that git-am
does not flag as bad. It just drops data silently.

I have a developer who has a patch that I am importing into git with
git-am.  (Currently they have a quilt-like setup that is full of bad and
incomplete patches.)

At some point in the past, someone hand edited the patch and added two
lines. They did not, however, change the @@ references in the patch for
the line count.

The patch added a file. The line that contained the length of the file was
"@@ -0,0 +0,1155 @@" instead of "@@ -0,0 +0,1157 @@". The result was that
when the patch was applied it silently dropped the last two lines of the
file.

My assumption is that it should either apply the full file and/or throw an
error. This just drops data silently.

Yes people should not be editing patches by hand. This migration is part
of the effort to get them to stop doing that.

Shouldn't git-am detect that the patch data and the meta data do not match
and warn the user or am I just being too damn picky here?
