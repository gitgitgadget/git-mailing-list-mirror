From: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
Subject: GIT BISECT old/new (fix/unfixed)
Date: Mon, 1 Jun 2015 16:24:18 +0200 (CEST)
Message-ID: <1363968792.246885.1433168658027.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1762682958.245864.1433168080478.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	remi.lespinet@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	matthieu.moy@grenoble-inp.fr, christian.couder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 01 16:23:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzQd8-0003nc-KU
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 16:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354AbbFAOXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 10:23:50 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:36208 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753326AbbFAOXs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Jun 2015 10:23:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 671722773;
	Mon,  1 Jun 2015 16:23:47 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w+xPvvpYohdT; Mon,  1 Jun 2015 16:23:47 +0200 (CEST)
Received: from zm-int-mbx4.grenet.fr (zm-int-mbx4.grenet.fr [130.190.242.143])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 567E225D4;
	Mon,  1 Jun 2015 16:23:47 +0200 (CEST)
In-Reply-To: <1762682958.245864.1433168080478.JavaMail.zimbra@ensimag.grenoble-inp.fr>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF10 (Linux)/8.0.9_GA_6191)
Thread-Topic: GIT BISECT old/new (fix/unfixed)
Thread-Index: JtKTIsCcxqG/l+0kP+6atjKsMxxcng==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270415>

Hi,

git bisect old/new is an alternative to good/bad, which can be confusing to use 
in some situations. 

A work on it was done a few years ago, it is partially working but there are a 
lot of issues. 

We based on Christian Couder's github: 
https://github.com/chriscool/git/commits/boldnew2 

We're currently working on it again. Older discussions lead to this state: 

>Some commands are still not available for old/new: 
> 
> * git bisect start [<new> [<old>...]] is not possible: the commits 
> will be treated as bad and good. 
> * git rev-list --bisect does not treat the revs/bisect/new and 
> revs/bisect/old-SHA1 files. 
> * thus, git bisect run <cmd> is not available for new/old. 
> * git bisect visualize seem to work partially: the tags are displayed 
> correctly but the tree is not limited to the bisect section. 

We did some testing with git bisect old/new and found that it was quite 
working, returning the commit that introduces the fix. 

We noticed an other error once the bisection is finished : 
fatal: 'refs/bisect/bad' - not a valid ref 

We did not understand why git bisect run is supposed not to work with old/new. 
The only thing is that the script has to return 0 if the version is old, which 
seems to work like in good/bad mode. This should be modified if the user wants 
to use the same script to find a fix or a regression (without changing the 
return value each time). 

Antoine D 
