From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH/RFC] reflog: silence -O3 -Wuninitialized warning
Date: Wed, 16 Mar 2011 10:09:58 +0100
Message-ID: <4D807E66.40504@viscovery.net>
References: <20110316024959.GA24932@elie> <7vfwqnabbi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 10:10:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzmkD-0008TI-FW
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 10:10:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752383Ab1CPJKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 05:10:04 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:27881 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751636Ab1CPJKD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 05:10:03 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Pzmju-0000HE-R8; Wed, 16 Mar 2011 10:09:59 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 8B9591660F;
	Wed, 16 Mar 2011 10:09:58 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <7vfwqnabbi.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169121>

Am 3/16/2011 6:22, schrieb Junio C Hamano:
> I am not suggesting to work this around on the caller side, but I wonder
> what effect the usual workaround to tell the compiler that we know it
> doesn't understand the validity of this variable by saying:
> 
> 	unsigned long expire = expire;
> 
> have on this?

Well, perhaps the compiler followed the C standard more closely than it is
good? By the law, the assignment above provokes undefined behavior, and
the compiler is allowed to do anything.

I think it's time that you accept patches that turn this into

	unsigned long expire = 0;

-- Hannes
