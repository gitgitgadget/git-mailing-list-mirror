From: alan@clueserver.org
Subject: Problem with duplicated commits due to a merge
Date: Thu, 7 Apr 2016 13:22:07 -0700
Message-ID: <5a7a3f4ea2636191c6a42d72b9bb34ab.squirrel@clueserver.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 07 22:31:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoGaA-0004ik-T2
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 22:31:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbcDGUbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 16:31:09 -0400
Received: from clueserver.org ([65.102.45.174]:36170 "EHLO clueserver.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932205AbcDGUbI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 16:31:08 -0400
X-Greylist: delayed 540 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Apr 2016 16:31:08 EDT
Received: from clueserver.org (localhost [127.0.0.1])
	by clueserver.org (Postfix) with ESMTP id C05D56001F8
	for <git@vger.kernel.org>; Thu,  7 Apr 2016 13:22:07 -0700 (PDT)
Received: from 192.55.54.40
        (SquirrelMail authenticated user alan)
        by clueserver.org with HTTP;
        Thu, 7 Apr 2016 13:22:07 -0700
User-Agent: SquirrelMail/1.4.22-15.fc21
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290985>

I help manage a Linux kernel repo for a large company. I have encountered
an odd problem that I think should not exist, but does.

At one point a merge was done from the development repo to the local
branch. Two of the existing commits have the same change to the same
location. At first glance they appear to be the same commit. The have the
same author and the same timestamp, but the comments are different and one
patch has an additional change.

It looks like an annotate was done to the comments of the local commit,
with an additional change picked up in the index. Then they did a git-pull
which merged in all the new commits, as well as the one old commit.

I didn't think that you could do a merge like that without a merge conflict.

The state of the files at HEAD seem correct, but the double commit causes
problems with using git-format-patch. (Both commits show up and wedge when
they get applied.)

Is this expected behavior? If so, why?

We have customers that expect to receive a collection of patches instead
of a git repo. (Yeah, I know. I am trying to convince them otherwise.)

What should happen in this case?
