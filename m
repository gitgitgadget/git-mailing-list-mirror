From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: Working with remotes; cloning remote references
Date: Tue, 28 Oct 2008 12:27:50 -0400
Message-ID: <49073D86.40507@xiplink.com>
References: <48F7852F.109@xiplink.com>	 <eaa105840810161220k26eebd48q8de606597f2be055@mail.gmail.com>	 <48F7A42E.70200@xiplink.com> <eaa105840810161345r69c9f05j66bb850085f561e7@mail.gmail.com> <48F7BBAC.2090907@xiplink.com> <48F83FD0.90606@drmicha.warpmail.net> <48F8A4E8.8070008@xiplink.com> <48F8AA5E.6090908@drmicha.warpmail.net> <48F8ECA2.3040208@xiplink.com> <48FC8624.9090807@fastmail.fm> <48FCB6B8.6090708@xiplink.com> <48FDA5A0.8030506@drmicha.warpmail.net> <48FDF28A.9060606@xiplink.com> <48FF3FEE.8020209@drmicha.warpmail.net> <49061C6D.2070407@xiplink.com> <4906C957.9010304@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Peter Harris <git@peter.is-a-geek.org>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Oct 28 17:28:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KurQn-0001jd-Ph
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 17:28:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107AbYJ1Q1U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 12:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752101AbYJ1Q1T
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 12:27:19 -0400
Received: from smtp132.iad.emailsrvr.com ([207.97.245.132]:52726 "EHLO
	smtp132.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016AbYJ1Q1T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 12:27:19 -0400
Received: from relay3.r3.iad.emailsrvr.com (localhost [127.0.0.1])
	by relay3.r3.iad.emailsrvr.com (SMTP Server) with ESMTP id C350444D2EC;
	Tue, 28 Oct 2008 12:27:17 -0400 (EDT)
Received: by relay3.r3.iad.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTP id 322B644D239;
	Tue, 28 Oct 2008 12:27:17 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
In-Reply-To: <4906C957.9010304@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99303>

Michael J Gruber wrote:
>
>> That downside is a bit disappointing.  I might as well just make "git 
>> remote export" simply generate a script of "git remote add" commands 
>> based on the contents of .git/config, and check that script in.  Then I 
>> could run the script in a clone to recreate the origin's remotes.
> 
> Yes, if you feel okay about running a script repeatedly which may change
> due to being versioned; rather than running a script/command which uses
> versioned input.

Either way it's a two-step process: "git pull; git remote import" vs. 
"git pull; ./import-remotes.sh".

>> It also seems awkward to have an export step in the origin repository. 
>> I don't really see a need for an export step (except as an artifact of 
>> the above implementation).
> 
> I had the impression that you want to configure as much as possible on
> the "central", and have clones follow automatically. It's very likely
> that you want your clones to see only a subset of central's remotes.
> Both (individually) imply that there has to be a step on central which
> determines which (if any) central remotes appear in clones automatically.

I actually don't care to limit what the clones can see.  I understand 
the reasoning behind such control, but in my case it just doesn't apply.

>> It seems to me that this would be more natural if our hypothetical "git 
>> remote import <X>" could just grab the remotes from repository <X> (or 
>> the origin, if <X> is unspecified).  I assume that would involve 
>> lower-level changes than what you described, but to me it seems like the 
>> more usable approach.  (But then I know nothing of Git's internals, so 
>> maybe this kind of change would be too much work?)
> 
> Feel free to hack the protocol and remote commands... Implementing
> anything which exposes "server's" .git/config on the client without
> interaction on the server side will most probably be rejected, though.

Point taken, but I think I will start with no origin-side controls, 
since I have no need for them anyway.  If/when I cobble together a patch 
hopefully at that point we'll be able to have a wider discussion about 
such controls.

> My suggestions were meant to be a minimal effort attempt within and
> following (see submodules) current infrastructure. I guess now it's up
> to you to pick the approach you deem most appropriate in your scenario
> and follow through with it.

Many thanks for taking the time to discuss this.  Now I've got to roll 
up my sleeves!

(BTW, any pointers to descriptions or overviews of git's code base?)

		Marc
