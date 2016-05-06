From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [git-for-windows] [PATCH] exec_cmd.c, sideband.c, Makefile: avoid
 multiple PREFIX definitions
Date: Fri, 6 May 2016 08:18:11 +0200
Message-ID: <572C3723.8010508@kdbg.org>
References: <1462483733-3496-1-git-send-email-philipoakley@iee.org>
 <1462483733-3496-2-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git-for-windows <git-for-windows@googlegroups.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri May 06 08:18:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayZ5e-0005iA-H0
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 08:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbcEFGSO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 02:18:14 -0400
Received: from bsmtp2.bon.at ([213.33.87.16]:38107 "EHLO bsmtp2.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751054AbcEFGSO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 02:18:14 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 3r1M5w0PlRz5tlH;
	Fri,  6 May 2016 08:18:11 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 7D40551EA;
	Fri,  6 May 2016 08:18:11 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <1462483733-3496-2-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293744>

Am 05.05.2016 um 23:28 schrieb Philip Oakley:
> The short and sweet PREFIX can be confused when used in many places.
>
> Rename both usages to better describe their purpose.
>
> Noticed when compiling Git for Windows using MSVC/Visual Studio which
> reports the conflict beteeen the command line definition and the
> definition in sideband.c

You should describe the circumstances better under which you notice a 
conflict, because there is no conflict when Git is built with the 
Makefile and 'make':

> diff --git a/Makefile b/Makefile
> index 33b0f76..bcdd3ec 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1973,7 +1973,7 @@ exec_cmd.sp exec_cmd.s exec_cmd.o: GIT-PREFIX
>   exec_cmd.sp exec_cmd.s exec_cmd.o: EXTRA_CPPFLAGS = \
>   	'-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' \
>   	'-DBINDIR="$(bindir_relative_SQ)"' \
> -	'-DPREFIX="$(prefix_SQ)"'
> +	'-DEXEC_PREFIX="$(prefix_SQ)"'

Notice that PREFIX is set only for a small subset of .c files. 
sideband.c is not among them.

-- Hannes
