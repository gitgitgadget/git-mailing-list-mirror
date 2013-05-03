From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] lookup_object: prioritize recently found objects
Date: Fri, 03 May 2013 07:59:09 +0200
Message-ID: <5183522D.5060405@viscovery.net>
References: <20130501203449.GA12535@sigill.intra.peff.net> <51820B37.8010503@viscovery.net> <20130502064630.GA15208@sigill.intra.peff.net> <5182101D.4050807@viscovery.net> <20130502154618.GA18462@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 03 07:59:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UY91b-0000l2-UO
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 07:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762174Ab3ECF7Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 01:59:16 -0400
Received: from so.liwest.at ([212.33.55.13]:45706 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761387Ab3ECF7P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 01:59:15 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UY91S-00065B-2l; Fri, 03 May 2013 07:59:10 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id B0BD61660F;
	Fri,  3 May 2013 07:59:09 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <20130502154618.GA18462@sigill.intra.peff.net>
X-Enigmail-Version: 1.5.1
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223281>

Am 5/2/2013 17:46, schrieb Jeff King:
> On Thu, May 02, 2013 at 09:05:01AM +0200, Johannes Sixt wrote:
>> BTW, do you notice that the function is now modifying an object (the hash
>> table) even though this is rather unexpected from a "lookup" function?
> 
> I think this is fine. The function is conceptually constant from the
> outside; callers don't even know about the hash table. They just know
> that there is some mapping. It's similar to the way that lookup_commit
> will lazily allocate the "struct commit". The callers do not care
> whether it exists already or not; they care that at the end of the
> function, they have a pointer to the commit. Everything else is an
> implementation detail.

Can we be sure that the function is never invoked in concurrently from
different threads? I attempted to audit code paths, but quickly gave up
because I know too little about this machinery.

-- Hannes
