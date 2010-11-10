From: Stephen Bash <bash@genarts.com>
Subject: Understanding git cherry-pick
Date: Wed, 10 Nov 2010 09:04:29 -0500 (EST)
Message-ID: <28509694.654669.1289397869374.JavaMail.root@mail.hq.genarts.com>
References: <10192863.654644.1289397257054.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 10 15:04:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGBI1-0000h7-AY
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 15:04:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756125Ab0KJOEg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 09:04:36 -0500
Received: from hq.genarts.com ([173.9.65.1]:29982 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755816Ab0KJOEg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 09:04:36 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 58C211E26905
	for <git@vger.kernel.org>; Wed, 10 Nov 2010 09:04:35 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QGQ7Srm0qMZ3 for <git@vger.kernel.org>;
	Wed, 10 Nov 2010 09:04:29 -0500 (EST)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 700151E2636A
	for <git@vger.kernel.org>; Wed, 10 Nov 2010 09:04:29 -0500 (EST)
In-Reply-To: <10192863.654644.1289397257054.JavaMail.root@mail.hq.genarts.com>
X-Mailer: Zimbra 6.0.7_GA_2473.UBUNTU8 (ZimbraWebClient - SAF3 (Mac)/6.0.7_GA_2473.UBUNTU8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161152>

Hi all-

In helping a coworker yesterday with a git cherry-pick operation, I found my mental model of cherry-pick seems to be flawed.  Our goal was to cherry-pick one commit from the current development branch back to the stable release branch (we're still training everyone on the *correct* way to do maintenance fixes).  Here's what happened:

$ git checkout release-branch
$ git cherry-pick 8815f3a0c2c248db223e41b0538f0c48b45fe52d
warning: too many files (created: 237 deleted: 2558), skipping inexact rename detection
Automatic cherry-pick failed.  After resolving the conflicts, mark the corrected paths with 'git add <paths>' or 'git rm <paths>' and commit the result with:
   git commit -c 8815f3a0c2c248db223e41b0538f0c48b45fe52d

git status reported the actual change we wanted from the commit applied cleanly; the conflicts were all added/deleted files between the two branches.  The commit only modifies a single file, and the file exists with the same name on both branches.

So what's actually going on here?  If the one changed file in the commit merged cleanly, why did the automatic cherry-pick fail?  Why does cherry-pick even care about file differences between the two branches that aren't modified by the commit in question?  Or is it user error?

Thanks,
Stephen
