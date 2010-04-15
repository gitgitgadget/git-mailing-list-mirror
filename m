From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git fetch over http:// left my repo broken
Date: Thu, 15 Apr 2010 11:58:27 +0200
Message-ID: <4BC6E343.2030105@drmicha.warpmail.net>
References: <g2y8c627c4f1004150251l3dc2ad17n352b149ac739d309@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jan.sievers@sap.com,
	"Sohn, Matthias" <matthias.sohn@sap.com>,
	Shawn Pearce <spearce@spearce.org>
To: Christian Halstrick <christian.halstrick@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 15 12:01:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2Lt9-0001WC-7W
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 12:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836Ab0DOKBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 06:01:30 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:43909 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751632Ab0DOKB3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Apr 2010 06:01:29 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id DC3DEEAE70;
	Thu, 15 Apr 2010 06:01:28 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 15 Apr 2010 06:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=coJQsd/ncYnLZIuevGw4qehPFXU=; b=GiT3uCCwepMl1jTNQh1OxbMN37Xy8ibmgIOKz6VQ+RcGvSK5JmWcBfL13X0yh0y8iQ2FdMxq+kWsNuTNSCNZ6U8vOrRz9hrBipCk0EAuIkrLu12QPqAz6PLgDmYioG5iWOl4rhhEPOAxsFagH4hp8P++tMt46/NzB3fpyToPois=
X-Sasl-enc: 6T1anOIn7DKOoHEqUSaX011KV0rdvoKPeQMAXLa1blCG 1271325688
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id F00524AF854;
	Thu, 15 Apr 2010 06:01:27 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100414 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <g2y8c627c4f1004150251l3dc2ad17n352b149ac739d309@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144969>

Christian Halstrick venit, vidit, dixit 15.04.2010 11:51:
> Hi,
> 
> some days back I fetched from a github repo with http protocol and
> afterwards my local repo was broken. Since the fetch was done by a
> cronjob I don't know whether the fetch reported an error. Problem is
> that one pack file was corrupted because the github servers put the
> repo I wanted to clone into some maintenance mode while I was
> fetching. The pack file includes at the end the html source code -
> which makes these files clearly corrupted.
> 
> Git should detect this error and let the fetch fail, right?

Right. And Github should not pull your repo away from under your feet.

But still, Git should be able to deal with broken servers. The problem
is: If the server does not report any problem but simply serves a broken
pack (with correct header), how should Git notice? It would require a
fsck before accepting any new pack.

If you move away the broken pack, do you get any dangling refs?

Michael
