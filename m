From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] fix portability issues with $ in double quotes
Date: Wed, 27 Jan 2010 08:53:42 +0100
Message-ID: <4B5FF106.3070604@viscovery.net>
References: <1264547311-25251-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 08:54:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Na2iu-0005Zo-St
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 08:54:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333Ab0A0Hxr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 02:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164Ab0A0Hxr
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 02:53:47 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:5622 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751123Ab0A0Hxr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 02:53:47 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Na2id-00006F-De; Wed, 27 Jan 2010 08:53:43 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 289801660F;
	Wed, 27 Jan 2010 08:53:43 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1264547311-25251-1-git-send-email-bebarino@gmail.com>
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138112>

Stephen Boyd schrieb:
> Using a dollar sign in double quotes isn't portable. Escape them with
> a backslash or replace the double quotes with single quotes.

The instances you changed look good. I didn't check whether you missed
some. Was this some sort of mechanical change?

I must say that a backslash in front of a $ in a sed expression looks very
distracting:

> +	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
> +	git cat-file commit side@{1} | sed -e "1,/^\$/d" >expect &&

because it is easy to miss that the backslash is taken by the
double-quotes. But since these cases happen in the test suite where the
whole thing is in single-quotes already, I don't think we can do something
about it without making it even more unreadable...

-- Hannes
