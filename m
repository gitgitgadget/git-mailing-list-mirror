From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: encrypted repositories?
Date: Fri, 17 Jul 2009 18:06:00 +0200
Message-ID: <4A60A168.2060105@drmicha.warpmail.net>
References: <op.uw7wmbr41e62zd@balu.cs.uni-paderborn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthias Andree <matthias.andree@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 17 18:06:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRpx6-0007uC-M9
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 18:06:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbZGQQGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 12:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbZGQQGS
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 12:06:18 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:38149 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964855AbZGQQGS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jul 2009 12:06:18 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 63D583BC2E9;
	Fri, 17 Jul 2009 12:06:17 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 17 Jul 2009 12:06:17 -0400
X-Sasl-enc: rIMG8c/hkW4H1DQXype3A7GhD4OugPA/jfFHXb4Lv7jY 1247846777
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C60194BF39;
	Fri, 17 Jul 2009 12:06:16 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.1pre) Gecko/20090717 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <op.uw7wmbr41e62zd@balu.cs.uni-paderborn.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123470>

Matthias Andree venit, vidit, dixit 17.07.2009 17:14:
> Greetings,
> 
> I have a rather special usage scenario.
> 
> Assume you have a repository where you want to work on embargoed  
> information, so that not even system administrators of the server you're  
> pushing to can get a hold of the cleartext data.
> 
> "Server" would be a central reference repository that I can push to.
> "Client" would by my working computer that has a clone of the crypted  
> repo, and an unencrypted checkout of it. Perhaps the client would also  
> need an unencrypted copy of the repo (for performance reasons, I'm not  
> sure about that) that gets encrypted on the fly when pushing and decrypted  
> when fetching.
> 
> Examples of use might be press releases of upcoming products, written  
> exams for students, whatever.
> 
> Requirements:
> - "client" that is about to push must encrypt the data before pushing it  
> to the server.
> - all data (including file names, log messages,
> 
> Allowed restrictions:
> - "server" limited to bare repositories
> - initial version limited to symmetric encryption with pre-shared secret
> 
> In a later step, some key management and asymmetric crypto would be  
> useful, but that's not crucial now. In my current scenario, those who are  
> working on the embargoed material would trust one another.
> 
> 
> How would one go about this from the user side? I sincerely doubt I have  
> the resources (time!) to actually implement this in Git.

If the server can not decrypt anything then it can not serve anything,
at least not as a git server. Note that if you're really fussy about
security then you should not allow the server to see even the DAG (which
would be the case if you encrypt blobs only), which makes it impossible
to do any smart serving.

So, why not share some form of remote storage on which you have an
encrypted luks partition? That way you can even set up multiple access
keys and revoke them when necessary.

Michael
