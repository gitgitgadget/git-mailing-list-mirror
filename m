From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] mingw: disable Python
Date: Fri, 08 Jan 2010 09:07:50 +0100
Message-ID: <4B46E7D6.3080702@viscovery.net>
References: <40aa078e1001071400j21900ed1n415394491d469b8c@mail.gmail.com> <1262902037-4420-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 09:07:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NT9t0-0000vW-3a
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 09:07:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753130Ab0AHIHy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 03:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753092Ab0AHIHx
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 03:07:53 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:65371 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753076Ab0AHIHx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 03:07:53 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NT9ss-0001jW-JT; Fri, 08 Jan 2010 09:07:50 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 5168E1660F;
	Fri,  8 Jan 2010 09:07:50 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1262902037-4420-1-git-send-email-kusmabite@gmail.com>
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136421>

Erik Faye-Lund schrieb:
> Python is not commonly installed on Windows machines, so
> we should disable it there by default.
> 
> --- a/Makefile
> +++ b/Makefile
> @@ -1027,6 +1027,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
> +	NO_PYTHON = YesPlease

I'm worried that with this solution it is impossible to re-enable Python
in config.mak (how do you undefine a Makefile variable?); it would be
necessary to hack Makefile.

Wouldn't it be superior to set

	PYTHON_PATH =

in the MinGW section[*]. It works because there is this heuristic later:

ifeq ($(PYTHON_PATH),)
NO_PYTHON=NoThanks
endif

To enable Python, the user would have to set PYTHON_PATH in config.mak.

[I have only Python 1.6 to test (doh!), so I can only tell that it gets
used during 'make', but this fails due to missing modules, so I cannot
tell whether there would be a usable result if Python were sufficiently
recent.]

[*] You should probably set the MSVC section as well, even if you cannot
test it. The effect of the change is predictable enough, I think.

-- Hannes
