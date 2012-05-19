From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 2/2] submodule: fix handling of supermodules with relative
 origin URLs
Date: Sat, 19 May 2012 20:56:15 +0200
Message-ID: <4FB7ECCF.9020403@web.de>
References: <1337402403-7546-1-git-send-email-jon.seymour@gmail.com> <1337402403-7546-2-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 19 20:56:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVopH-0006pk-3s
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 20:56:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758144Ab2ESS4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 May 2012 14:56:22 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:47060 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757648Ab2ESS4V (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2012 14:56:21 -0400
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate01.web.de (Postfix) with ESMTP id BFB451AE8BE62
	for <git@vger.kernel.org>; Sat, 19 May 2012 20:56:19 +0200 (CEST)
Received: from [192.168.178.48] ([91.3.152.157]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0LgYi5-1Rht9Y40mr-00nwnV; Sat, 19 May 2012 20:56:18
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <1337402403-7546-2-git-send-email-jon.seymour@gmail.com>
X-Provags-ID: V02:K0:PexDR31BlI/5X0bDqGp5brd2xpYPD5IJftKi3qZKoJd
 35pAB2nKmqacXCqIIMocN0lY3f3edRSG4dSoydInPKU3zj2VlE
 IW2GSjIKZ3LtYhhGLxvD4Xd3QY4YWUZyji/zDqsXiLiSigS97I
 smTcwSXWerLdjHwtGNyh4bAuToMdyZK2XpExXSBeLYU8dUxRwT
 yY2NcNHIFC89jN7MvZlnQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198038>

Am 19.05.2012 06:40, schrieb Jon Seymour:
> Prior to this change, an operation such as git submodule add, init or
> sync produced the wrong result when the origin URL of the supermodule
> was itself a relative URL.
> 
> The issue arises in these cases, because the origin URL of
> the supermodule needs to be prepended with a prefix that navigates
> from the submodule to the supermodule so that when the submodule
> URL is concatenated, the resulting url is relative to the working tree
> of the submodule.

Just a small nit: I'd prefer to replace the 4 occurrences of the term
"supermodule" with "superproject".


BTW, what happened to the following comment in you other email?

>> +                               remoteurl="${up_path%/}/${remoteurl%/*}"
>
> Meant up_path%/ to be up_path%/*

The '*' is not there (but the test suite runs fine no matter if I add
a '*' there or not). Thinking about it not adding the '*' should be
correct, as you just want to chop off a trailing '/' from $up_path
here, right?

So no objection on the code changes from my side.
