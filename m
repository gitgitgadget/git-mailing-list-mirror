From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC PATCH 2/2] MSVC: Fix an "incompatible pointer types" compiler
 warning
Date: Fri, 04 Dec 2009 08:44:39 +0100
Message-ID: <4B18BDE7.3050004@viscovery.net>
References: <4B1806FB.2050401@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Dec 04 08:44:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGSqR-0007rl-5F
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 08:44:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752923AbZLDHoj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 02:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752684AbZLDHoj
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 02:44:39 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:9885 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751864AbZLDHoi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 02:44:38 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NGSqG-0007jd-Fc; Fri, 04 Dec 2009 08:44:40 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id F00D61660F;
	Fri,  4 Dec 2009 08:44:39 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4B1806FB.2050401@ramsay1.demon.co.uk>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134500>

Ramsay Jones schrieb:
> In order to avoid the compiler warning, we use the appropriate
> structure type names (and function names) from the msvc headers.
> This allows us to compile with -D_USE_32BIT_TIME_T if necessary.

"if necessary"? Who defines when -D_USE_32BIT_TIME_T is necessary?

> Also, I added the "&& defined(_stati64)" in the hope that it would work with
> older msvc/sdk versions.

I think that this is an unnecessary complication and I did wonder why you
added this extra check. Anybody doing some serious development with MS's
tools is using VS2005 at least. But isn't the .vcproj file made for VS2008
anyway?

> The reason for the RFC is:
> 
>     - maybe we don't need the flexibility of compiling with/without the 32-bit
>       time_t definition (which *works* BTW) and can revert to the original patch?

Indeed I'm wondering why we should cater for 64 bit time_t. It is an
unnessary complication as long as MinGW gcc supports only 32 bit time_t
and the old MSVCRT.DLL.

>     - I *think* this will work with older msvc, but I can't test it!

This should not be a concern, IMHO.

>     - I've tried to be careful not to break the MinGW build, but again I can't
>       test it. (I will be shocked if I have ;-)

It compiles without warnings and doesn't break t/t[01]* ;)

-- Hannes
