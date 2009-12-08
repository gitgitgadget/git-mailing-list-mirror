From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC PATCH v2 2/2] MSVC: Fix an "incompatible pointer types" compiler warning
Date: Tue, 8 Dec 2009 21:31:43 +0100
Message-ID: <200912082131.44498.j6t@kdbg.org>
References: <4B1997A0.9000004@ramsay1.demon.co.uk> <200912051257.21386.j6t@kdbg.org> <4B1EAD9A.3090205@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Marius Storm-Olsen" <mstormo@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"GIT Mailing-list" <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Dec 08 21:32:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI6jJ-00077Y-TV
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 21:32:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937321AbZLHUcE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 15:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936711AbZLHUcC
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 15:32:02 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:62262 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S936476AbZLHUcB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 15:32:01 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id DD1D8CDF8C;
	Tue,  8 Dec 2009 21:32:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 9774619F5C4;
	Tue,  8 Dec 2009 21:31:44 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <4B1EAD9A.3090205@ramsay1.demon.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134910>

On Dienstag, 8. Dezember 2009, Ramsay Jones wrote:
>     30	#define stat _stat64
>     31	int mingw_lstat(const char *file_name, struct stat *buf);
>     32	int mingw_fstat(int fd, struct stat *buf);
>     33	#define fstat mingw_fstat
>     34	#define lstat mingw_lstat
>     35	#define _stat64(x,y) mingw_lstat(x,y)
>     36	#define ALREADY_DECLARED_STAT_FUNCS
>     37
>     38	#include "compat/mingw.h"
>     39
>     40	#undef ALREADY_DECLARED_STAT_FUNCS
>
> This works fine, *provided* you do not need to compile with
> -D_USE_32BIT_TIME_T, which would produce this warning:
>
>     ...mingw.c(223) : warning C4133: 'function' : incompatible types - \
>     from '_stat64 *' to '_stat32i64 *'
>
> This would actually be *worse* than the original code, since the struct
> _stat64 would not have the same "shape" as the struct _stat32i64; ...

To cut this short: According to your explanations, using -D_USE_32BIT_TIME_T 
with MSVC is bad. Please reroll without references to _USE_32BIT_TIME_T.

-- Hannes
