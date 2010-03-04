From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: How do I get the correct modification status after running git
 diff?
Date: Thu, 04 Mar 2010 17:34:41 +0100
Message-ID: <4B8FE121.6040807@drmicha.warpmail.net>
References: <27782430.post@talk.nabble.com> <27782895.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: jateeq <jawad_atiq@hotmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 04 17:37:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnE3A-0000mp-Oh
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 17:37:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755506Ab0CDQhS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Mar 2010 11:37:18 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:60910 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755369Ab0CDQhQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Mar 2010 11:37:16 -0500
Received: from compute1.internal (compute1 [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 24F0CE3D24;
	Thu,  4 Mar 2010 11:37:16 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 04 Mar 2010 11:37:16 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=t/3Id5ok0XAj9AbDH8nURjUJNy4=; b=mF9o+WFO9IPetZWW0n5iSNQn5dyLMxkGG7wBphmGW0OK8Jep1FdCBTsfa2tUFgrQAKbLDwIaK9KQFAc9fGEm0knBmzC28J/+370A8mvfRAITigdnrybbpy1ydjf5Yeb4qN09t1YsujCg2/5pKTLchUTuUJeaUOFq0ecFwfmFHtE=
X-Sasl-enc: DvWL12IIoat6joGCzAguSA/05hKUI9nL4DeOHa/wujOw 1267720635
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7C8134A306F;
	Thu,  4 Mar 2010 11:37:15 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9pre) Gecko/20100301 Lightning/1.0b2pre Shredder/3.0.3pre
In-Reply-To: <27782895.post@talk.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141532>

jateeq venit, vidit, dixit 04.03.2010 17:11:
> 
> Ok, so I think I know what I was doing wrong... i wasn't comparing the
> working tree with the last commit (HEAD), although I still don't know what
> exactly I was comparing the working tree with. On reading the manual a

You were comparing the working tree with the index (staging area).

> little more carefully, I realised the command should have been: 
> 
> git diff -M --name-status HEAD
> 
> This solves the problem of newly added files, but doesn't show 'R' for
> renamed files even after I ask git to detect renamed files - just shows that
> the renamed file was deleted (doesn't detect that the new renamed file was
> added). So I would still appreciate some input here.
> 
> Renaming flie:
> mv randomfile.xml random.xml
> 
> Diffing:
> git diff -M --name-status HEAD
> 
> Output:
> D      randomfile.xml

git doesn't know about random.xml here, which you can change like so:

git add -N random.xml

Then git diff -M --name-status HEAD will show the rename.

Alternatively, you could have used "git mv randomfile.xml random.xml"
which would have staged that move in the index already. (More exactly:
the content changes, not the move as such)

Michael
