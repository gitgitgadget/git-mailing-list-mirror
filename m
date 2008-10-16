From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [BUG] git status doesn't handle submodules properly on OSX
Date: Thu, 16 Oct 2008 13:39:56 +0200
Message-ID: <48F7280C.3080205@viscovery.net>
References: <c60a85c1297be6446ad92a3e7723ddc8.squirrel@webmail.highteq.net>    <5D0481A4-D173-4CF8-B855-5E58978210F8@ai.rug.nl>    <6ca24750ca8d7bd9e995d023e78e0d71.squirrel@webmail.highteq.net>    <524C98C8-C3A5-4501-932A-2F0ACDE2886A@simplicidade.org> <3520b7a9009f072cfc3aeb82ae205e6b.squirrel@webmail.highteq.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Pedro Melo <melo@simplicidade.org>,
	Pieter de Bie <pdebie@ai.rug.nl>, Jeff King <peff@peff.net>,
	Git Mailinglist <git@vger.kernel.org>
To: Lars Hoss <lars@woeye.net>
X-From: git-owner@vger.kernel.org Thu Oct 16 13:41:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqREK-0000Nw-98
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 13:41:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753383AbYJPLkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 07:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752828AbYJPLkI
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 07:40:08 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:19507 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752578AbYJPLkH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 07:40:07 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KqRCu-000113-G4; Thu, 16 Oct 2008 13:39:56 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 29D736EF; Thu, 16 Oct 2008 13:39:56 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <3520b7a9009f072cfc3aeb82ae205e6b.squirrel@webmail.highteq.net>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98369>

Lars Hoss schrieb:
> Ok, I compiled several git versions from the git repo with the following
> results:
> 
> v1.5.6.5 works
> v1.6.0.2 fails
> v1.6.0 fails
> v1.6.0-rc0 fails
...
> So something between 1.5.6.5 and 1.6.0-rc0 broke it for me.
> A quick diff between the two version revealed a lot of changes. Thus
> tracking down the issue might not be easy for someone who is not involved
> in the code.

Start with:

$ git bisect start v1.6.0-rc0 v1.5.6.5 v1.6.0~6^2 v1.6.0.2~16^2  # [*]

and test the version that this command gives you. Then say either

$ git bisect good  # if the version works
$ git bisect bad   # if the version fails

Test again and repeat until the command tells you "First bad revision
is..." and report back. (Finally, say 'git bisect reset' to get you back
to where you started.)

[*] The revisions v1.6.0~6^2 v1.6.0.2~16^2 are from gitk and git-gui,
which we assume are good.

-- Hannes
