From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: submodules workflow aches
Date: Mon, 19 May 2008 15:56:49 +0100
Message-ID: <320075ff0805190756x3adf1684i3980aac15e2ddb88@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 19 17:00:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jy6o5-0002T6-4O
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 16:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbYESO4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2008 10:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751617AbYESO4w
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 10:56:52 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:25313 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404AbYESO4w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2008 10:56:52 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1674164fgg.17
        for <git@vger.kernel.org>; Mon, 19 May 2008 07:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=8eR8uKBDLr7wlxecULM8lOya5iQbCTK4ptifXLI0GsI=;
        b=g+7sMwjzLMxEd9WA2eUa6cwG5KHzLvUJjAcBa4OoqxQfbxnllsZa6SCDXyk0LuGH3wYZP7ee4XubjTKejY3tKJ4jjjg27EAAK5h2o5dh7/UDL+Blg9+BXzaYDXBTtScdD6mo89L1ySmZUQxh0Keoe5ccg3Avxko/eRS1MzZtrG4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=bm5VBKFvELNF9ZrNt+OOM6JqDvj1h25opO+VeVPhpuEkfRCWdJlmlaRIGXgmweF1tXFKBTSD2g0tKaPkUfsK946aponkOwqz0MSENiZakjfHNODo0SRfp8XWG+Fe9FqVdKcPtP07NP3rd5jdzDHOAyEZVysLn984RbcQyHxAmVk=
Received: by 10.82.178.3 with SMTP id a3mr931278buf.12.1211209010013;
        Mon, 19 May 2008 07:56:50 -0700 (PDT)
Received: by 10.82.168.20 with HTTP; Mon, 19 May 2008 07:56:49 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82433>

We've been using submodule support for a few months (and I've been
checking out the list to see what other people are doing); it works
well, but there's a couple of ache points (in the sense that if I'm to
convince SVN users to migrate, they're liable to point and laugh).

The first nuisance is the 'get me up to date' stanza of 'git pull &&
git submodule update' always leaving you on (no branch), even if you
were on [master] before, and the head commit now is also equal to
[master]. Having to remember to go into several submodules and do 'git
checkout master' to get you back to ready-to-do-work mode isn't nice
(and is worse if you're on autopilot, and someone has committed a
submodule on a different branch

The second nuisance is around conflicts in submodules. If I make a
(non-conflicting) change to a submodule, merge with the head and
commit, then when I do a 'git pull' in the superproject readiness to
do a push, I get a conflict. This is presumably because it doesn't
know that the submodule change is a fast-forward. It'd be nice if it
could figure that out, and not conflict?

Are people writing their own wrapper scripts for this? I find I have a
hard time explaining why it's all necessary to svn users who just (by
and large) do 'svn up' and 'svn ci' on projects..
