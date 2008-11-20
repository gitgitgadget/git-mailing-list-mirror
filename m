From: Andreas Ericsson <ae@op5.se>
Subject: Re: Cygwin error?
Date: Thu, 20 Nov 2008 09:57:13 +0100
Message-ID: <49252669.7060304@op5.se>
References: <200811191857.30793.nadim@khemir.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: nadim khemir <nadim@khemir.net>
X-From: git-owner@vger.kernel.org Thu Nov 20 09:59:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L35NS-0000N6-2D
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 09:59:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754049AbYKTI5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 03:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754034AbYKTI5o
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 03:57:44 -0500
Received: from mail.op5.se ([193.201.96.20]:45538 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754036AbYKTI5n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 03:57:43 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id E454724B000D;
	Thu, 20 Nov 2008 09:52:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W+WEDEPG+uDs; Thu, 20 Nov 2008 09:52:15 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 2B92A24B000C;
	Thu, 20 Nov 2008 09:52:15 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <200811191857.30793.nadim@khemir.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101395>

nadim khemir wrote:
> Hi, Given:
> 
> $ git pull
> remote: Counting objects: 46, done.
> ...
> Updating b80286d..a543dae
> error: Untracked working tree file 'xxx.txt' would be overwritten by merge.
> 
> 
> This is due to a rename of xxx.txt to Xxx.txt. I  understand that this is due 
> to files being just case preserving on Cycwin/Win32.
> 
> The only I found was to remove the xxx.txt localy and do a pull. The 
> interresting thing is that Xxx.txt is no present in my file system. I can 
> check it out from HEAD though.
> 
> What did I missunderstood and do wrong?
> 

You ran into a corner-case. Git expects the "Xxx.txt" and "xxx.txt" to be
different. Cross-OS projects should never, ever rename files so that they
end up with case ambiguity. Since they did, the only thing you can really
do is this:

git fetch
rm xxx.txt
git reset --hard origin/master; # or whatever branch you're interested in

I'm afraid you'll have problems with this until all the branches you're
interested in have this change.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
