From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 04/14] msvc: Fix macro redefinition warnings
Date: Sat, 4 Dec 2010 22:04:51 +0100
Message-ID: <201012042204.52002.j6t@kdbg.org>
References: <4CFA8FE3.1050009@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"GIT Mailing-list" <git@vger.kernel.org>, sschuberth@gmail.com
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sat Dec 04 22:05:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POzHy-000251-O6
	for gcvg-git-2@lo.gmane.org; Sat, 04 Dec 2010 22:05:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756046Ab0LDVE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Dec 2010 16:04:57 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:37028 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755945Ab0LDVE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Dec 2010 16:04:57 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 9956EA7EB2;
	Sat,  4 Dec 2010 22:04:33 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 499CA19F653;
	Sat,  4 Dec 2010 22:04:52 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <4CFA8FE3.1050009@ramsay1.demon.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162914>

On Samstag, 4. Dezember 2010, Ramsay Jones wrote:
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -14,12 +14,6 @@ typedef int socklen_t;
>  #define S_ISLNK(x) (((x) & S_IFMT) == S_IFLNK)
>  #define S_ISSOCK(x) 0
>
> -#ifndef _STAT_H_

Instead of removing the macros, wouldn't we be much safer with just

#ifndef S_IWUSR

? I suggest S_IWUSR because it is used inside #ifdef WIN32 brackets in 
test-chmtime.c and seems to be more important than the others :-)

> -#define S_IRUSR 0
> -#define S_IWUSR 0
> -#define S_IXUSR 0
> -#define S_IRWXU (S_IRUSR | S_IWUSR | S_IXUSR)
> -#endif
>  #define S_IRGRP 0
>  #define S_IWGRP 0
>  #define S_IXGRP 0

-- Hannes
