From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Working with remotes; cloning remote references
Date: Tue, 28 Oct 2008 09:12:07 +0100
Message-ID: <4906C957.9010304@drmicha.warpmail.net>
References: <48F7852F.109@xiplink.com>	 <eaa105840810161220k26eebd48q8de606597f2be055@mail.gmail.com>	 <48F7A42E.70200@xiplink.com> <eaa105840810161345r69c9f05j66bb850085f561e7@mail.gmail.com> <48F7BBAC.2090907@xiplink.com> <48F83FD0.90606@drmicha.warpmail.net> <48F8A4E8.8070008@xiplink.com> <48F8AA5E.6090908@drmicha.warpmail.net> <48F8ECA2.3040208@xiplink.com> <48FC8624.9090807@fastmail.fm> <48FCB6B8.6090708@xiplink.com> <48FDA5A0.8030506@drmicha.warpmail.net> <48FDF28A.9060606@xiplink.com> <48FF3FEE.8020209@drmicha.warpmail.net> <49061C6D.2070407@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Peter Harris <git@peter.is-a-geek.org>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Tue Oct 28 09:13:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kujhh-0003pw-HJ
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 09:13:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752312AbYJ1IMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 04:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752205AbYJ1IMN
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 04:12:13 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54559 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752149AbYJ1IML (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Oct 2008 04:12:11 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 58534186A77;
	Tue, 28 Oct 2008 04:12:10 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 28 Oct 2008 04:12:10 -0400
X-Sasl-enc: BSKTXd73P5WWwZgUGQ/v/+ZdTvCl4TL7DAPzO0x/u4c8 1225181529
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 89B242DF94;
	Tue, 28 Oct 2008 04:12:09 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080914)
In-Reply-To: <49061C6D.2070407@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99280>

Marc Branchaud venit, vidit, dixit 27.10.2008 20:54:
> Michael J Gruber wrote:
>> Downside is that .gitremotes is tracked would show up as a file in the
>> repo, but I can't come up with a better way which is as simple as the
>> above. .gitremotes could be stored in a specially named branch, though.
> 
> That downside is a bit disappointing.  I might as well just make "git 
> remote export" simply generate a script of "git remote add" commands 
> based on the contents of .git/config, and check that script in.  Then I 
> could run the script in a clone to recreate the origin's remotes.

Yes, if you feel okay about running a script repeatedly which may change
due to being versioned; rather than running a script/command which uses
versioned input.

> It also seems awkward to have an export step in the origin repository. 
> I don't really see a need for an export step (except as an artifact of 
> the above implementation).

I had the impression that you want to configure as much as possible on
the "central", and have clones follow automatically. It's very likely
that you want your clones to see only a subset of central's remotes.
Both (individually) imply that there has to be a step on central which
determines which (if any) central remotes appear in clones automatically.

> It seems to me that this would be more natural if our hypothetical "git 
> remote import <X>" could just grab the remotes from repository <X> (or 
> the origin, if <X> is unspecified).  I assume that would involve 
> lower-level changes than what you described, but to me it seems like the 
> more usable approach.  (But then I know nothing of Git's internals, so 
> maybe this kind of change would be too much work?)

Feel free to hack the protocol and remote commands... Implementing
anything which exposes "server's" .git/config on the client without
interaction on the server side will most probably be rejected, though.
My suggestions were meant to be a minimal effort attempt within and
following (see submodules) current infrastructure. I guess now it's up
to you to pick the approach you deem most appropriate in your scenario
and follow through with it.

Michael
