From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] pack-objects: Add runtime detection of online CPU's
Date: Tue, 12 Feb 2008 03:27:34 -0500
Message-ID: <20080212082734.GC24004@spearce.org>
References: <47B156CD.1010209@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@cam.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Feb 12 09:28:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOqVa-0004jb-G6
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 09:28:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761534AbYBLI1z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 03:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761440AbYBLI1z
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 03:27:55 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60339 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140AbYBLI1y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 03:27:54 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JOqUJ-0000qt-3D; Tue, 12 Feb 2008 03:27:35 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D423420FBAE; Tue, 12 Feb 2008 03:27:34 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <47B156CD.1010209@op5.se>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73641>

Andreas Ericsson <ae@op5.se> wrote:
> diff --git a/thread-utils.h b/thread-utils.h
> new file mode 100644
> index 0000000..53754b3
> --- /dev/null
> +++ b/thread-utils.h
> @@ -0,0 +1,19 @@
> +#ifndef THREAD_COMPAT_H
> +#define THREAD_COMPAT_H
> +
> +#include "cache.h"
> +
> +#ifdef THREADED_DELTA_SEARCH
> +#include <pthread.h>
> +# ifdef _WIN32
> +#  define WIN32_LEAN_AND_MEAN
> +# include <windows.h>
> +# endif
> +# if defined(hpux) || defined(__hpux) || defined(_hpux)
> +#  include <sys/pstat.h>
> +# endif
> +#endif

Do we have to expose this mess of namespaces to those who include
thread-utils.h?  Seems like we don't, as online_cpus has a pretty
simple definition:

> +
> +extern int online_cpus(void);
> +
> +#endif /* THREAD_COMPAT_H */
> -- 
> 1.5.4.rc5.11.g0eab8

-- 
Shawn.
