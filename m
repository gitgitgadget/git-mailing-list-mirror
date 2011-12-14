From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: t0090-cache-tree fails due to wc whitespace
Date: Wed, 14 Dec 2011 16:41:33 +0100
Message-ID: <4EE8C3AD.9050605@viscovery.net>
References: <7F1792D2-8ED4-4546-8ED4-52B95E0AE9FC@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Thomas Rast <trast@student.ethz.ch>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Wed Dec 14 16:41:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Raqxq-00046I-Fr
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 16:41:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757424Ab1LNPlj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 10:41:39 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:34499 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757385Ab1LNPli (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 10:41:38 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Raqxa-0008Ed-CQ; Wed, 14 Dec 2011 16:41:34 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 202081660F;
	Wed, 14 Dec 2011 16:41:34 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <7F1792D2-8ED4-4546-8ED4-52B95E0AE9FC@silverinsanity.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187132>

Am 12/14/2011 15:35, schrieb Brian Gernhardt:
> It's time for my periodic complaint:  People assuming `wc -l` outputs
> just a number.  wc on OS X (and perhaps other BSD-like systems) always
> aligns the output in columns, even with the -l flag.  Generally this
> results in a quick patch from me to remove some unneeded quotes.
> However, this time it's used in a more complex manner:
> 
> 	echo "SHA " \
> 	    "($(git ls-files|wc -l) entries, 0 subtrees)" >expect &&
> 	cmp_cache_tree expect

I'd solve it by moving the command substitution outside the quoted string:

 	printf "SHA (%d entries, 0 subtrees)\n" \
		$(git ls-files | wc -l) >expect &&

Other proposed solutions add another process. I don't like that on Windows ;)

-- Hannes
