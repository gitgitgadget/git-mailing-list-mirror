From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Fix update-index --refresh for submodules if stat(2)
   returns st_size 0
Date: Tue, 22 Jul 2008 09:17:16 +0200
Message-ID: <4885897C.8010401@viscovery.net>
References: <20080721173511.GB5387@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Jul 22 09:18:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLC8i-00058a-Bd
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 09:18:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842AbYGVHRU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 03:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751844AbYGVHRU
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 03:17:20 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:56781 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751842AbYGVHRT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 03:17:19 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KLC7Y-0003n4-GF; Tue, 22 Jul 2008 09:17:16 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 276546D9; Tue, 22 Jul 2008 09:17:16 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080721173511.GB5387@steel.home>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89455>

Alex Riesen schrieb:
> Can MSys folks please try it? I noticed it when the test
> t2103-update-index-ignore-missing.sh (the 5th case) started failing.

I tested it. mingw.git does suffer from the problem, and this fixes it.

But!

> +	if ((changed & DATA_CHANGED) && (ce->ce_size != 0 || S_ISGITLINK(ce->ce_mode)))

Does this mean that ce->ce_size is non-zero for gitlinks, at least on
Unix? Is this value useful in anyway? I don't think so. Then it shouldn't
be a random value that lstat() happens to return.

-- Hannes
