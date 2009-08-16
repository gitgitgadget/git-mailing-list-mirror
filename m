From: Jon Jensen <jon@endpoint.com>
Subject: How to stop sharing objects between repositories
Date: Sat, 15 Aug 2009 18:04:58 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0908151756150.29215@nhtr.ovalna.fjrygre.arg>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 16 02:22:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McTW2-0001sn-Qw
	for gcvg-git-2@gmane.org; Sun, 16 Aug 2009 02:22:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752789AbZHPAWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 20:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752337AbZHPAWT
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 20:22:19 -0400
Received: from mail.endcrypt.com ([74.205.105.202]:42989 "EHLO
	mail.endcrypt.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901AbZHPAWT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2009 20:22:19 -0400
X-Greylist: delayed 1051 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 Aug 2009 20:22:19 EDT
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.endcrypt.com (Postfix) with ESMTP id CEEFA30D7E
	for <git@vger.kernel.org>; Sun, 16 Aug 2009 00:04:49 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126046>

Hello.

Situation: I used "git clone -s" to share objects between repositories. 
That creates .git/objects/info/alternates, which points to the other 
repository. Later I need to remove the dependency and make the dependent 
repository self-sufficient, i.e. it should have all the objects internal 
to itself.

I've looked around for a way to do that but haven't found either tools or 
instructions.

I came up with this manual way, copying over the unique remote objects and 
then removing the alternate repository pointer:

(cd /path/to/alternate/repo.git/objects && tar cp .) | (cd .git/objects && tar xvpk)
# some objects will already exist and be skipped, leading to an error on exit, which is fine
rm .git/objects/info/alternates
# or if there's more than one and you're only removing one, edit the alternates file and remove only that pointer

(With GNU tar -C the copy is a little simpler.)

I posted this to the wiki:

http://git.or.cz/gitwiki/GitFaq#Howtostopsharingobjectsbetweenrepositories.3F

If there's a better or built-in way to do this with Git tools, I'd like to 
learn it, and I'd be happy to update the wiki accordingly.

Thanks,
Jon

-- 
Jon Jensen
End Point Corporation
http://www.endpoint.com/
