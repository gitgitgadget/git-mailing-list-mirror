From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 7/7] Windows: Revert to default paths and convert them by RUNTIME_PREFIX
Date: Sun, 21 Sep 2008 23:58:48 +0200
Message-ID: <200809212358.48125.johannes.sixt@telecom.at>
References: <1222014278-11071-1-git-send-email-prohaska@zib.de> <1222014278-11071-7-git-send-email-prohaska@zib.de> <1222014278-11071-8-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Sep 22 00:00:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhWyI-0001hU-Fn
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 00:00:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583AbYIUV6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 17:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752533AbYIUV6v
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 17:58:51 -0400
Received: from smtp3.srv.eunet.at ([193.154.160.89]:54770 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752454AbYIUV6v (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 17:58:51 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp3.srv.eunet.at (Postfix) with ESMTP id DC07710A75B;
	Sun, 21 Sep 2008 23:58:48 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 2DA501D22C;
	Sun, 21 Sep 2008 23:58:48 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1222014278-11071-8-git-send-email-prohaska@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96440>

On Sonntag, 21. September 2008, Steffen Prohaska wrote:
> The RUNTIME_PREFIX mechanism allows us to use the default (absolute) paths
> on Windows too.  Defining RUNTIME_PREFIX explicitly requests for
> translation of paths during runtime, depending on the path to the
> executable.
>
> Signed-off-by: Steffen Prohaska <prohaska@zib.de>
> ---
>  Makefile |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 8181f74..98278f0 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -767,6 +767,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
>  	SNPRINTF_RETURNS_BOGUS = YesPlease
>  	NO_SVN_TESTS = YesPlease
>  	NO_PERL_MAKEMAKER = YesPlease
> +	RUNTIME_PREFIX = YesPlease
>  	NO_POSIX_ONLY_PROGRAMS = YesPlease
>  	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
>  	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/regex
> -Icompat/fnmatch @@ -775,9 +776,6 @@ ifneq (,$(findstring
> MINGW,$(uname_S)))
>  	COMPAT_OBJS += compat/mingw.o compat/fnmatch/fnmatch.o
> compat/regex/regex.o compat/winansi.o EXTLIBS += -lws2_32
>  	X = .exe
> -	gitexecdir = ../libexec/git-core
> -	template_dir = ../share/git-core/templates/
> -	ETC_GITCONFIG = ../etc/gitconfig
>  endif
>  ifneq (,$(findstring arm,$(uname_M)))
>  	ARM_SHA1 = YesPlease

This cannot be the complete patch. The part that sets $(prefix) to the empty 
string is missing, otherwise the runtime prefix discovery would never 
trigger, right? (But see also my comment on [PATCH 1/7].)

-- Hannes
