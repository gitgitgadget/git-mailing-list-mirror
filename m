From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: Working with remotes; cloning remote references
Date: Fri, 17 Oct 2008 10:44:56 -0400
Message-ID: <48F8A4E8.8070008@xiplink.com>
References: <48F7852F.109@xiplink.com>	 <eaa105840810161220k26eebd48q8de606597f2be055@mail.gmail.com>	 <48F7A42E.70200@xiplink.com> <eaa105840810161345r69c9f05j66bb850085f561e7@mail.gmail.com> <48F7BBAC.2090907@xiplink.com> <48F83FD0.90606@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Peter Harris <git@peter.is-a-geek.org>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Oct 17 16:46:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kqqac-0002xe-1U
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 16:46:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754517AbYJQOo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 10:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754052AbYJQOo4
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 10:44:56 -0400
Received: from smtp122.iad.emailsrvr.com ([207.97.245.122]:45976 "EHLO
	smtp122.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753919AbYJQOoz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 10:44:55 -0400
Received: from relay2.r2.iad.emailsrvr.com (localhost [127.0.0.1])
	by relay2.r2.iad.emailsrvr.com (SMTP Server) with ESMTP id EB3D944D144;
	Fri, 17 Oct 2008 10:44:54 -0400 (EDT)
Received: by relay2.r2.iad.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTP id BEF5A44CB20;
	Fri, 17 Oct 2008 10:44:54 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
In-Reply-To: <48F83FD0.90606@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98479>

Thanks for joining the thread, Michael!

Michael J Gruber wrote:
> 
> I don't think there is a direct gittish way for transferring the remote
> config from one repo to a clone (other than copying what git submodule
> does with .gitmodules etc.).

That's my impression, too, so I'm suggesting that the clone/push/pull 
commands get an option to work with remotes in config.

> Would it be sufficient for you if a clone could trigger the main repo to
> update its remotes (i.e. git remote update)?

Hmmm, I'm not sure...  How would the overall 
merge-in-changes-from-upstream process work in that case?

Say the main repo has the code for "ThingOne" merged under a top-level 
thing-one/ directory:

main/$ git remote add -f ThingOne git://thing/ThingOne.git
main/$ git merge -s ours --no-commit ThingOne/master
main/$ git read-tree --prefix=thing-one/ -i ThingOne/master
main/$ git commit -m "Merged ThingOne into /thing-one/"

Then the ThingOne folks update their code, so we want to incorporate 
their changes into our version of their code.  I think you're suggesting 
that we might make a clone of the main repo then trigger a "git remote 
update" in the clone's origin:

clone/$ make-origin-do-git-remote-update

What's not clear to me is how to proceed from here.  At this point I'm 
hoping there's some way I could do some work in the clone to merge the 
changes the ThingOne folks did into our code.  I'm too new to git to 
know if there is a way forward -- is there?

(With the subtree merge pattern I'd run "git pull -s subtree ThingOne 
master" in the main repo -- is there an equivalent achievable in the 
clone if the main has done a "git remote update"?)

Thanks,

		Marc
