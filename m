From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Add compat/vsnprintf.c for systems that returns -1 on
 maxsize reached
Date: Tue, 04 Mar 2008 17:28:57 +0100
Message-ID: <47CD78C9.80003@viscovery.net>
References: <200803041459.29000.michal.rokos@nextsoft.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: GIT <git@vger.kernel.org>
To: Michal Rokos <michal.rokos@nextsoft.cz>
X-From: git-owner@vger.kernel.org Tue Mar 04 17:30:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWa1K-0006Ba-MG
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 17:29:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757888AbYCDQ27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 11:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762851AbYCDQ27
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 11:28:59 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:31021 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757783AbYCDQ27 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 11:28:59 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JWa03-0006Sj-1S; Tue, 04 Mar 2008 17:28:19 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 523B0546; Tue,  4 Mar 2008 17:28:57 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <200803041459.29000.michal.rokos@nextsoft.cz>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76119>

Michal Rokos schrieb:
> If anybody could think of some better define than BROKEN_VSNPRINTF, I'm all 
> ears.

CLUELESS_OVERFLOWN_VSNPRINTF?

Because we have the same issue on Windows where vsnprintf returns -1 on
overflow.

But there is also another complication: The size parameter of the system's
vsnprintf must not count the trailing NUL, i.e. the buffer must actually
have space for one extra byte, whereas the POSIX version must count NUL.
Can you check whether your vsnprintf has this flaw, too? If it doesn't, we
would need another configuration variable so that we can distinguish these
two kinds of brokenness.

-- Hannes
