From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/8] compat: make gcc bswap an inline function
Date: Wed, 16 Mar 2011 10:21:42 +0100
Message-ID: <4D808126.8070706@viscovery.net>
References: <20110316024959.GA24932@elie> <20110316065256.GA5988@elie> <20110316070049.GC5988@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@cam.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 10:21:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzmvR-0004s8-MV
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 10:21:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752389Ab1CPJVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 05:21:47 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:39477 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752370Ab1CPJVp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 05:21:45 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PzmvH-00086m-Bw; Wed, 16 Mar 2011 10:21:43 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 1D91D1660F;
	Wed, 16 Mar 2011 10:21:43 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <20110316070049.GC5988@elie>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169123>

Am 3/16/2011 8:00, schrieb Jonathan Nieder:
> +static inline uint32_t git_bswap32(uint32_t x)
> +{
> +	uint32_t result;
> +	if (__builtin_constant_p(x))

Can this predicate ever be true? Isn't it false even if the function is
inlined?

> +		result = default_swab32(x);
> +	else
> +		__asm__("bswap %0" : "=r" (result) : "0" (x));
> +	return result;
> +}

-- Hannes
