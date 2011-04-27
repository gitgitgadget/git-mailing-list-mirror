From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH] handle_alias: provide GIT_CWD to !alias
Date: Wed, 27 Apr 2011 08:47:11 +0200
Message-ID: <4DB7BBEF.8010409@drmicha.warpmail.net>
References: <4DA59B27.50506@ge.infn.it> <e8c9aa9160f922f728d56387e5e86eb50220774f.1302699792.git.git@drmicha.warpmail.net> <7v1v0od557.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Matej Batic <matej.batic@ge.infn.it>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 08:47:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEyWs-00055S-Q5
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 08:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865Ab1D0GrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 02:47:13 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:35611 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751813Ab1D0GrN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2011 02:47:13 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.messagingengine.com (Postfix) with ESMTP id CC0CE204F9;
	Wed, 27 Apr 2011 02:47:12 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute5.internal (MEProxy); Wed, 27 Apr 2011 02:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=4Xe2oeS6rRCdn9k6NYhlUNfCkh4=; b=kXEUiDuD4QXv9GgXxPDC+M2d8rSlNPxywHCyY6PyZ7/u0CyD7OXcCx6FBL2gQQHJaOStFPJ0Rzvmqf7WXR9dqI8ur5hBKmg155NnBwKvSodaazbeLa17P8CIdV8+8n+QZFSLJakicAFgpNIjrdObiZoSkO+RjxC0NkV9VjIZXkU=
X-Sasl-enc: PrVKoSE5YUvz8P24gfBmkNTZtUz95+Ftrlvv5K73DIJ2 1303886832
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 39841401972;
	Wed, 27 Apr 2011 02:47:12 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <7v1v0od557.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172180>

Junio C Hamano venit, vidit, dixit 27.04.2011 00:22:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Provide an environment variable GIT_CWD which contains the subdirectory
>> from which a !alias was called since these cd to the to level directory
>> before they are executed.
> 
> Isn't this what we usually call "prefix", though?

In code it is called "prefix". But I have to ask: So what? Are you
suggesting GIT_PREFIX? User expectation is probably more tied to CWD,
unless a user knows "rev-parse --show-prefix". I don't care about the
name, and GIT_PREFIX may be more systematic.

A more important point is the prefix-less case (i.e. we are in topdir):
Should GIT_YOUNAMEIT be empty then? I would say yes (just like
"rev-parse --show-prefix"), Duy said no. We need a third vote :)

Also, we may want to scrap this altogether and do !!-aliases instead
(without chdir).

Michael
