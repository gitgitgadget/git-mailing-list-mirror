From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] t3411: Fix test 1 for case-insensitive file systems
Date: Tue, 3 Feb 2009 13:42:03 -0500
Message-ID: <34FE2049-0A81-4615-AE3D-46DE35A44011@silverinsanity.com>
References: <1233244816-67565-1-git-send-email-benji@silverinsanity.com> <7vocxqf2sf.fsf@gitster.siamese.dyndns.org> <673CE949-5DF9-4970-A739-AA09FCD26D24@silverinsanity.com> <1E104E1B-BFCC-4CFC-9D53-CE89299C9600@silverinsanity.com> <alpine.DEB.1.00.0902031752230.6573@intel-tinevez-2-302> <2D4586A6-ADAC-4B6E-8B42-2CBD76E0304C@silverinsanity.com> <alpine.DEB.1.00.0902031817260.6573@intel-tinevez-2-302> <5FE034E8-422F-4692-AD37-5633C91A4B98@silverinsanity.com> <alpine.DEB.1.00.0902031918520.9822@pacific.mpi-cbg.de>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 03 19:43:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUQFD-0000km-FW
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 19:43:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622AbZBCSmI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 13:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752586AbZBCSmI
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 13:42:08 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:41220 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521AbZBCSmH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 13:42:07 -0500
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 23E391FFC27F; Tue,  3 Feb 2009 18:42:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb3 (2006-10-05) on 
	silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=4.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.7-deb3
Received: from [192.168.5.44] (nmd.sbx07360.rocheny.wayport.net [98.98.50.102])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id ED1291FFC271;
	Tue,  3 Feb 2009 18:41:59 +0000 (UTC)
In-Reply-To: <alpine.DEB.1.00.0902031918520.9822@pacific.mpi-cbg.de>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108237>


On Feb 3, 2009, at 1:19 PM, Johannes Schindelin wrote:

> $ git grep -l test_commit junio/next -- t/
> junio/next:t/README
> junio/next:t/t1450-fsck.sh
> junio/next:t/t3410-rebase-preserve-dropped-merges.sh
> junio/next:t/t3411-rebase-preserve-around-merges.sh
> junio/next:t/t3412-rebase-root.sh
> junio/next:t/test-lib.sh

I examined all of those files.  I looked at every line that calls  
test_commit.  All of those files except for t34110-rebase-preserve- 
around-merges.sh provide a filename of their own and are therefore  
unaffected by the change

On Jan 29, 2009, at 12:19 PM, Junio C Hamano wrote:

> -	file=${2:-$(echo "$1" | tr 'A-Z' 'a-z')}
> +	file=${2:-$(echo "$1" | tr 'A-Z' 'a-z').t}

Use "git grep" without the -l and you will see that all uses outside  
of t3411 are of the form "test_commit <commit> <filename>".  Only  
t3411 uses the form "test_commit <commit>" (without filename), which  
is when this change would matter.  And t3411 does not use the  
generated filename, only the resultant commits.

I was irritated by your statement that I "did not look far" because _I  
read all those files_.  I gave you the result of reading them which  
you seem to have completely ignored, as it was the part of my last e- 
mail that you did not quote.

If you want to double-check me, fine.  But do not claim I did not do  
the work.

~~ Brian
