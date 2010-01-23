From: Marc Weber <marco-oweber@gmx.de>
Subject: Re: cherry picking several patches at once
Date: Sat, 23 Jan 2010 01:24:06 +0100
Message-ID: <1264205767-sup-4547@nixos>
References: <20100121161157.GA3628@gandalf> <94a0d4531001221557n7a892f03u5e5d1c5e5ba5fea0@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 23 01:26:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYTpJ-0001sL-Vg
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 01:26:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755282Ab0AWAYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 19:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371Ab0AWAYq
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 19:24:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:56391 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756263Ab0AWAYL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 19:24:11 -0500
Received: (qmail invoked by alias); 23 Jan 2010 00:24:07 -0000
Received: from mawercer.at.xencon.net (EHLO mail.gmx.net) [83.246.111.127]
  by mail.gmx.net (mp008) with SMTP; 23 Jan 2010 01:24:07 +0100
X-Authenticated: #9006135
X-Provags-ID: V01U2FsdGVkX1+WNJQ58jaWxJfUITOJ+E9/Dlk7aGin/BPdyA4rRJ
	LYv2Ugx72rEiuj
Received: by mail.gmx.net (sSMTP sendmail emulation); Sat, 23 Jan 2010 01:24:06 +0100
In-reply-to: <94a0d4531001221557n7a892f03u5e5d1c5e5ba5fea0@mail.gmail.com>
User-Agent: Sup/git
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68999999999999995
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137796>

Hi,

I like both ideas. I fact I had both my self.
Cherry-picking a range can be implemented using a simple shell script.
So that is not that important.

> I think that would not be possible because of the challenges when
> dealing with conflicts.
If cherry-picking to a not checkout branch causes conflicts it could be
rejected. It's that simple.

The use case is: You have many topic-branches. Of course you develop on
the big temporary merge. However you want to push your changes to the
topic branches. You may be working on multiple topics at the same time.
Some of the topics may quick hacks to make a porject work on your system
such as patching shebang lines, change PHP require lines etc.

Currently you have to
git checkout topic1; git cherry-pick big-merge
git checkout topic2; git cherry-pick big-merge~2
git checkout big-merge

compare this to

git cherry-push HEAD    topic1
git cherry-push HEAD~2  topic2

not much typing.

Very often there are no conflicts and you know that there are none.

If you have conflicts you can still fallback going the slow way.
Maybe the command could behave this way:

git cherry-push-checkout-on-failure hash other-branch

I'd be very happy about such a git cherry-push-checkout-on-failure
command. I'm not sure whether the command should be renamed. I did so
for fun.

Marc Weber
