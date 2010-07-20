From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Automatically exclude hunks from the commit
Date: Tue, 20 Jul 2010 11:26:20 +0200
Message-ID: <4C456BBC.8010203@drmicha.warpmail.net>
References: <4C4511C8.8090405@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Tue Jul 20 11:26:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ob95f-0002v3-Ur
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 11:26:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758485Ab0GTJ0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 05:26:14 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:48405 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758462Ab0GTJ0N (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jul 2010 05:26:13 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 0F5F016F7D6;
	Tue, 20 Jul 2010 05:26:10 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 20 Jul 2010 05:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=lXPMDrg58Ut1rnjtxR6qGMWbAgA=; b=ldxuASNPoWNQpMA5cTWKBhTUq0Sw5gwe1cOZvwNuVbPL/pFw7RxLidOCrX820TLU2u+lxWJx6HoWeyronaITtd5IyixGZHErjO/4B6afjTnMjpuBc3YWrbzt6VlZTxqnmEPpxo8KWv1j7WwvmAr9n+/U/bxclgYZPeHCj0EGjzk=
X-Sasl-enc: 64LxJRwc3V305hyMT/WUQz0pZIY7BrrxPUv0tar4UTpJ 1279617969
Received: from localhost.localdomain (p54859B2A.dip0.t-ipconnect.de [84.133.155.42])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4FF474F7C91;
	Tue, 20 Jul 2010 05:26:09 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.8pre) Gecko/20100714 Lightning/1.0b2pre Lanikai/3.1.2pre
In-Reply-To: <4C4511C8.8090405@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151309>

Joshua Jensen venit, vidit, dixit 20.07.2010 05:02:
>   I have some files I update frequently where I have some normally 
> commented out debug code purposely uncommented during development.  
> Git's hunk-level staging saves the day.  I can stage everything but the 
> debug code without issue.
> 
> This got me to thinking.  Is there a better way?  Is there a facility in 
> Git where I could mark a hunk as 'permanently frozen unstaged'?  
> Anything marked as such would never be staged for commit.  I could rest 
> assured I would never accidentally commit my debug code, be it extra 
> printfs or a development server or a password or so on.
> 
> Thanks for the help.
> 
> Josh

If you don't want to deal with the branch approach suggested by the
other Joshua you could (ab)use the clean&smudge filters (see "filter" in
gitattributes(5)):

Define a clean filter such as "fgrep -v GITIGNORE" and mark every source
line which you want to ignore with a comment:

printf("Happy we got this far but I have no clue why"); // GITIGNORE

You can do more clever things with awk or sed, of course. "GITIGNORE" is
just some hopefully unused string.

Note that a "checkout" would overwrite your debug lines!

Cheers,
Michael
