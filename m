From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: How to resolve conflict: Moved away vs. created new file with
 same   name
Date: Tue, 19 Jan 2010 12:55:23 +0100
Message-ID: <4B559DAB.9030605@viscovery.net>
References: <4B559328.2010206@cedarsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Johannes Schneider <mailings@cedarsoft.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 12:55:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXCgG-0004RE-6D
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 12:55:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754462Ab0ASLz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 06:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753747Ab0ASLz1
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 06:55:27 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:45176 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752130Ab0ASLz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 06:55:26 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NXCg8-0006DQ-6i; Tue, 19 Jan 2010 12:55:24 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id E8FB81660F;
	Tue, 19 Jan 2010 12:55:23 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4B559328.2010206@cedarsoft.com>
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137449>

Johannes Schneider schrieb:
> TopicA:
> 
> created a directory "client" containing a pom.xml and several source files.
> 
> 
> TopicB:
> 
> created a directory "client" containing a pom.xml (different file than
> the one in TopicA).
> Created several subdirectories (client1, client2).
> 
> ...
> So I am trying to mimic the change in TopicA:
> 
> cd client
> mkdir client3
> mv pom.xml client3
> mv src client3
> ...commit...

Did you do this during the merge? If not, go back to TopicA and redo it;
then you avoid the conflict during the merge.

> Okay, so far so good. Now I try to merge TopicA and TopicB which fails.
> Of course Git doesn't understand that "client/pom.xml" in TopicA and
> TopicB are not related.
> I want to end with to the file from TopicA ending in
> "client/client3/pom.xml" and the file from TopicB in "client/pom.xml".

During the merge without the fixup suggested above:

git rm -f client/client3/pom.xml
git checkout TopicA -- client/pom.xml
git mv client/pom.xml client/client3/pom.xml
git checkout TopicB -- client/pom.xml

but it leaves you with an ugly history, and it would be far better to fix
up TopicA before the merge.

-- Hannes
