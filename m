From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH] shortstatus v1
Date: Tue, 10 Feb 2009 12:29:40 +0100
Message-ID: <49916524.4000400@drmicha.warpmail.net>
References: <1234227067-56666-1-git-send-email-tuncer.ayaz@gmail.com> <20090210110330.GB12089@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Tuncer Ayaz <tuncer.ayaz@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 10 12:31:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWqq3-0000Vz-TD
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 12:31:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751731AbZBJLaN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 06:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbZBJLaM
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 06:30:12 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:43803 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750790AbZBJLaL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Feb 2009 06:30:11 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id AC9142908F5;
	Tue, 10 Feb 2009 06:29:46 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 10 Feb 2009 06:29:47 -0500
X-Sasl-enc: Grs01bPEUQkSFCNTjc4CSWs1TQO+jziRZlyXRQX5cedz 1234265385
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8389418B46;
	Tue, 10 Feb 2009 06:29:44 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090209 Shredder/3.0b2pre
In-Reply-To: <20090210110330.GB12089@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109209>

Jeff King venit, vidit, dixit 10.02.2009 12:03:
> On Tue, Feb 10, 2009 at 01:51:07AM +0100, Tuncer Ayaz wrote:
...
>   3. What advantage does this have over just doing:
> 
>        (git diff --name-status;
>         git diff --cached --name-status) | sort -k2

That is fine, except that it can't list untracked files.

> What options are available? It looks like this is intimately tied with
> "commit", which I think is one of the _shortcomings_ of the current
> status. It means the command line options are non-intuitive for what
> people generally want to say: "what is changed, possibly limiting to
> some path".

Right now, "git status" is basically "git commit --dry-run", which may
or may not be good, but certainly is not what people coming from other
vcs expect. I would suggest having "git commit -n" replace "git status"
if I hadn't done so already or if I dared to (I can't remember ;) ).

The softer approach was naming "shortstatus" what those people would
expect for "status".

The "git diff" based solution does almost everything, but back then it
wasn't clear how to get at the untracked and ignored files. In fact,
that would have the benefit that output from "git diff --name-status
commitA commitB" is guaranteed to stay consistent with "git diff
--name-status HEAD WORKTREE", "git diff --name-status INDEX WORKTREE"
and the three-way diff between HEAD, INDEX and WORKTREE which
shortstatus really is (WORKTREE meaning full wt with untrcaked/ignored
files).

"git ls-files" may do but has a different set of mode characters. I
think that sums up what preceeded Junio's patch from October.

Michael
