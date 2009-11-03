From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 4/4] win32: Improve the conditional inclusion of WIN32
 API   code
Date: Tue, 03 Nov 2009 08:41:17 +0100
Message-ID: <4AEFDE9D.6060200@viscovery.net>
References: <4AE746C6.9060409@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Nov 03 08:41:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5E1U-0002Q4-O0
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 08:41:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbZKCHlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 02:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbZKCHlQ
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 02:41:16 -0500
Received: from lilzmailmt02.liwest.at ([212.33.55.12]:18943 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932186AbZKCHlP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 02:41:15 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1N5E0z-00071n-KX; Tue, 03 Nov 2009 08:41:17 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 50DB66D9; Tue,  3 Nov 2009 08:41:17 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4AE746C6.9060409@ramsay1.demon.co.uk>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131951>

Ramsay Jones schrieb:
> After experimenting with several win32 compilers, it is clear
> that the _WIN32 macro should be used to guard the inclusion
> of the main WIN32 API header files, particularly in the main
> git-compat-util.h header. In addition, the cygwin build should
> restrict the use of the WIN32 API to compat/cygwin.c
> 
> In order to avoid mistakes with the use of WIN32 and _WIN32
> macros, define a new WIN32_API macro, with a single point of
> definition in git-compat-util.h, to isolate WIN32 specific
> code.

IMO, the name "WIN32_API" is very misleading. It suggests that it can be
used to protect sections of code that use the API. But in fact all places
outside (and even some places in) the compatibility layer use "WIN32" to
protect *platform* specific code (as opposed to the API specific code).

In this light, the name "WIN32" isn't to the point, either, but it does at
least not pretend that the code is about API.

Therefore, I think that a better change would be to treat _WIN32 and WIN32
as synonyms, and to make sure that both are defined if at least one of
them is defined.

It may be that I understand something incorrectly; but then I blame the
justification that you gave. In this case, it would be helpful to reword
the commit message, and perhaps add some results from your experiments.

-- Hannes
