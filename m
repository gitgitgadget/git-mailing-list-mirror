From: Jeremiah Foster <jeremiah.foster@pelagicore.com>
Subject: Re: Unable to coax hooks into working
Date: Tue, 27 Apr 2010 10:33:13 +0200
Message-ID: <FAF218B9-D2DB-4081-88CB-BEBA08DF1229@pelagicore.com>
References: <B65E8227-B3C0-4AB8-A225-4A5661523CAD@pelagicore.com> <v2u8c9a061004261111l429b0c8cs73cf7e1afea3d39f@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 27 10:33:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6gEP-0006C5-1V
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 10:33:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292Ab0D0IdT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 04:33:19 -0400
Received: from av11-2-sn2.hy.skanova.net ([81.228.8.184]:40184 "EHLO
	av11-2-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828Ab0D0IdS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Apr 2010 04:33:18 -0400
Received: by av11-2-sn2.hy.skanova.net (Postfix, from userid 502)
	id 9EEE437E45; Tue, 27 Apr 2010 10:33:16 +0200 (CEST)
Received: from smtp4-1-sn2.hy.skanova.net (smtp4-1-sn2.hy.skanova.net [81.228.8.92])
	by av11-2-sn2.hy.skanova.net (Postfix) with ESMTP id B86EA37E45
	for <git@vger.kernel.org>; Tue, 27 Apr 2010 10:33:15 +0200 (CEST)
Received: from [10.8.36.139] (194-237-7-146.customer.telia.com [194.237.7.146])
	by smtp4-1-sn2.hy.skanova.net (Postfix) with ESMTP id 9E34D37E54
	for <git@vger.kernel.org>; Tue, 27 Apr 2010 10:33:13 +0200 (CEST)
In-Reply-To: <v2u8c9a061004261111l429b0c8cs73cf7e1afea3d39f@mail.gmail.com>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145883>


On Apr 26, 2010, at 8:11 PM, Jacob Helwig wrote:

> On Mon, Apr 26, 2010 at 11:04, Jeremiah Foster
>> 
>> 
>> Can I confirm that hooks work with this type of transport?
> 
> The real problem is that you're using a post-commit hook (or at least
> everything you said in your original email implies you are).
> post-commit hooks are only triggered in your _local_ repository, since
> this is the only place you actually commit.  Doesn't matter which
> transport you're using, post-commit will never be triggered by a push.
> 
> You want one of the receive, or update hooks, if you're putting this
> in a central place, where it needs to be triggered by someone doing a
> push in to the repo.

Thanks Jacob. I'd just like to confirm that I am, in fact, using the update hook. I logged into the server holding the git repo, cd'd to the .git/hooks/ directory. Moved the update.sample to update. Changed the code to something trivial that would echo back to the client for testing. I checked permissions, checked ownership, ran the code as the git repo owner. I logged out, did a trivial change in the client repo, ran git commit -a -m "foo" and expected that the trivial update script to run on the server would produce output to the client. This never occurred. I further tested the client hooks which also did not run. 

I wonder if git is not seeing the scripts or if the backend mechanism has changed in some manner from one version of git to another? Any insight is welcome. I'll run the  hooks in the client with strace to see if I can get any information on what is happening.

Jeremiah