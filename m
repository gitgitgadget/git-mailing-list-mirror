From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] run-command: prettify -D_FORTIFY_SOURCE workaround
Date: Wed, 16 Mar 2011 10:17:14 +0100
Message-ID: <4D80801A.1000208@viscovery.net>
References: <d2e97e801001291438k21a652cakb05ec34fc8bee227@mail.gmail.com> <20110316035135.GA30348@elie> <7v7hbzaan9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Wookey <michaelwookey@gmail.com>,
	Markus Heidelberg <markus.heidelberg@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 10:17:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzmr4-00032S-Oc
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 10:17:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234Ab1CPJRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 05:17:18 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:35204 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921Ab1CPJRR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 05:17:17 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Pzmqx-0007rk-Dr; Wed, 16 Mar 2011 10:17:15 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 297881660F;
	Wed, 16 Mar 2011 10:17:15 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <7v7hbzaan9.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169122>

Am 3/16/2011 6:37, schrieb Junio C Hamano:
> It certainly is _not_ "ok" to see errors from write(2); we are _ignoring_
> the error because at that point in the codepath there isn't any better
> alternative.  The unusual "if ()" whose condition is solely for its side
> effect, with an empty body, is a strong enough sign to any reader that
> there is something fishy going on, and it would be helpful to the reader
> to hint _why_ such an unusual construct is there.  It would be much better
> for the longer term maintainability to say at least "gcc" in the comment,
> i.e.
> 
> 	if (write(...))
>         	; /* we know we are ignoring the error, mr gcc! */

And what about compilers that warn:

	';' : empty controlled statement found; is this the intent?

That's from MSVC. Perhaps:

	if (write(...))
		(void)0; /* we know we are ignoring the error, mr gcc! */

-- Hannes
