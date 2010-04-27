From: Jeremiah Foster <jeremiah.foster@pelagicore.com>
Subject: Re: Unable to coax hooks into working
Date: Tue, 27 Apr 2010 11:08:42 +0200
Message-ID: <EA3DE148-CDC8-4FA3-8C97-74379E91B495@pelagicore.com>
References: <B65E8227-B3C0-4AB8-A225-4A5661523CAD@pelagicore.com> <v2u8c9a061004261111l429b0c8cs73cf7e1afea3d39f@mail.gmail.com> <FAF218B9-D2DB-4081-88CB-BEBA08DF1229@pelagicore.com> <4BD6A5BC.3010708@drmicha.warpmail.net>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 27 11:08:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6gmh-00036M-BJ
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 11:08:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703Ab0D0JIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 05:08:45 -0400
Received: from av6-2-sn3.vrr.skanova.net ([81.228.9.180]:42972 "EHLO
	av6-2-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828Ab0D0JIp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Apr 2010 05:08:45 -0400
Received: by av6-2-sn3.vrr.skanova.net (Postfix, from userid 502)
	id 762DA37EDB; Tue, 27 Apr 2010 11:08:43 +0200 (CEST)
Received: from smtp3-2-sn3.vrr.skanova.net (smtp3-2-sn3.vrr.skanova.net [81.228.9.102])
	by av6-2-sn3.vrr.skanova.net (Postfix) with ESMTP id 5401337E47
	for <git@vger.kernel.org>; Tue, 27 Apr 2010 11:08:43 +0200 (CEST)
Received: from [10.8.36.139] (194-237-7-146.customer.telia.com [194.237.7.146])
	by smtp3-2-sn3.vrr.skanova.net (Postfix) with ESMTP id 4ADA537E4D
	for <git@vger.kernel.org>; Tue, 27 Apr 2010 11:08:43 +0200 (CEST)
In-Reply-To: <4BD6A5BC.3010708@drmicha.warpmail.net>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145887>


On Apr 27, 2010, at 10:52 AM, Michael J Gruber wrote:
> Jeremiah Foster venit, vidit, dixit 27.04.2010 10:33:
>> 
>> On Apr 26, 2010, at 8:11 PM, Jacob Helwig wrote:
>>> 
>>> You want one of the receive, or update hooks, if you're putting
>>> this in a central place, where it needs to be triggered by someone
>>> doing a push in to the repo.
>> 
>> Thanks Jacob. I'd just like to confirm that I am, in fact, using the
>> update hook. I logged into the server holding the git repo, cd'd to
> 
> That used to be different ;) update hook on the server is good.
> 
>> the .git/hooks/ directory. Moved the update.sample to update. Changed
>> the code to something trivial that would echo back to the client for
>> testing. I checked permissions, checked ownership, ran the code as
>> the git repo owner. I logged out, did a trivial change in the client
>> repo, ran git commit -a -m "foo" and expected that the trivial update
>> script to run on the server would produce output to the client. This
> 
> But this is the same problem backwards. Again: Please try to understand
> what commit does, and what push does, in terms of where (local repo vs.
> server) a change happens:

I think I do. The commit pushes the change onto the index. The index is local. It gets pushed to the remote server when I do a git push. I should have been more explicit - I am in fact pushing the code to the remote server in such a manner that git-receive-pack is run. My understanding from the documentation is that this is the trigger which update gets called. Yet no information from that update script is produced in the logs or in the client.
> 
> As long as you only commit in your local repo nothing changes on the
> server (remote repo), so no hook is triggered there.
> 
>> never occurred. I further tested the client hooks which also did not
>> run.
> 
> Which ones?
> 
> committing locally triggers post-commit on your local repo.

These did not work.

> pushing to remote triggers post-update (and others) on the remote
> server's repo.

These also did not work. In short, the triggers that the documentation defines for both client and remote hooks fail to produce information in the client. Any idea on why?

Jeremiah