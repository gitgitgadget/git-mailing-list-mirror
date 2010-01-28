From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] Windows: improve performance by avoiding a static
 dependency on ws2_32.dll and advapi32.dll
Date: Thu, 28 Jan 2010 10:09:19 +0100
Message-ID: <4B61543F.6020904@viscovery.net>
References: <1264666525-4956-1-git-send-email-michael.lukashov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Lukashov <michael.lukashov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 10:09:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaQNa-0003CJ-PP
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 10:09:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755993Ab0A1JJZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 04:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755990Ab0A1JJZ
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 04:09:25 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:23735 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755771Ab0A1JJX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 04:09:23 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NaQNM-0007GR-Cu; Thu, 28 Jan 2010 10:09:21 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 1C4841660F;
	Thu, 28 Jan 2010 10:09:20 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1264666525-4956-1-git-send-email-michael.lukashov@gmail.com>
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138234>

Michael Lukashov schrieb:
> ws2_32.dll is used by limited subset of git commands, such as pull,
> push, fetch, send-email, ... By looking up functions that we need
> at runtime, we can avoid the startup costs of this DLL.
> As a result, we can remove static dependency on advapi32.dll too.
> 
> A call to "git status" loaded
> 
> before:  8 DLL
> after:   4 DLL

Thanks. Due to the size of the change, I would acknowledge it only if you
have a proof that the reduced startup costs are noticable, for example, by
running the test suite.

What's the deal with bswap? Isn't it an unrelated change? It needs some
better justification. It is unobvious because it is not straight-forward
"use pointer to function that was looked up instead of function".

Will the result not break the MSVC build?

-- Hannes
