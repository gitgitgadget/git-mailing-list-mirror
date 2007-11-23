From: "MichaelTiloDressel@t-online.de" <MichaelTiloDressel@t-online.de>
Subject: Re: Adding push configuration to .git/config
Date: Fri, 23 Nov 2007 14:07:13 +0100
Message-ID: <1IvYFV-0vJb1s0@fwd35.aul.t-online.de>
Reply-To: "MichaelTiloDressel@t-online.de" <MichaelTiloDressel@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: prohaska@zib.de
X-From: git-owner@vger.kernel.org Fri Nov 23 14:08:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvYGW-0001xM-VF
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 14:08:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497AbXKWNH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 08:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752285AbXKWNH4
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 08:07:56 -0500
Received: from mailout07.sul.t-online.de ([194.25.134.83]:46961 "EHLO
	mailout07.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752222AbXKWNH4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Nov 2007 08:07:56 -0500
Received: from fwd35.aul.t-online.de 
	by mailout07.sul.t-online.com with smtp 
	id 1IvYG9-0005mG-01; Fri, 23 Nov 2007 14:07:53 +0100
Received: from localhost (rXPGPiZbZha4npmnFAaFM7ZIGP6r7Oh86MaEJyGgryBYnidzRzV9p5dLbGBtM32wkP@[172.20.101.250]) by fwd35.aul.t-online.de
	with esmtp id 1IvYFV-0vJb1s0; Fri, 23 Nov 2007 14:07:13 +0100
X-UMS: email
X-Mailer: TOI Kommunikationscenter V9-1-3
X-ID: rXPGPiZbZha4npmnFAaFM7ZIGP6r7Oh86MaEJyGgryBYnidzRzV9p5dLbGBtM32wkP@t-dialin.net
X-TOI-MSGID: 8a8ba6c4-d8ce-4f05-869e-2e4d40f214c0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65897>


On Nov 22, 2007, at 12:23 PM, Johannes Schindelin wrote:
>You know that I believe the current default is not such a
>choice.

To me the default is not very clear. I read somewhere (I wish I could
find where that was again)
that push will e.g. push all the remotes that do not contain a push line
by default 
(or maybe only in case the remote belonging to the current branch does
not contain a push?).

Anyway the way I try at the moment to have push by default only push the
current branch 
is by setting up a separate remote for each branch even if they belong
to the same remote
subdirectory. In addition I have a remote named origin which contains a
line:
push = nothing:nowhere
which creates an error for the default case that has no explicit remote.

My .git/config looks something like this:

[remote "origin"
        url = git+ssh://myuid@server/gitrepos/myprogit
        fetch = +refs/heads/master:refs/remotes/origin/master
        fetch =
+refs/heads/TopicA_v0.14_Branch:refs/remotes/origin/TopicA_v0.14_Branch
        fetch =
+refs/heads/mypro-v0.31_Branch:refs/remotes/origin/mypro-v0.31_Branch
        push = nothing:nowhere
[remote "master"]
        url = git+ssh://myuid@server/gitrepos/myprogit
        fetch = +refs/heads/master:refs/remotes/origin/master
        push = refs/heads/master:refs/heads/master
[remote "topicA"]
        url = git+ssh://myuid@server/gitrepos/myprogit
        fetch =
+refs/heads/TopicA_v0.14_Branch:refs/remotes/origin/TopicA_v0.14_Branch
        push =
refs/heads/TopicA_v0.14_Branch:refs/heads/TopicA_v0.14_Branch
[remote "mypro-v0.31"]
        url = git+ssh://myuid@server/gitrepos/myprogit
        fetch =
+refs/heads/mypro-v0.31_Branch:refs/remotes/origin/mypro-v0.31_Branch
        push =
refs/heads/mypro-v0.31_Branch:refs/heads/mypro-v0.31_Branch
[branch "master"]
        remote = master
        merge = refs/heads/master
[branch "mypro-v0.31_Branch"]
        remote = mypro-v0.31
        merge = refs/heads/mypro-v0.31_Branch
[branch "TopicA_v0.14_Branch"]
        remote = topicA
        merge = refs/heads/TopicA_v0.14_Branch


Cheers,
Michael
