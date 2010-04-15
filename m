From: Chris Webb <chris@arachsys.com>
Subject: Re: [PATCH v3] Replace hard-coded path with one from <paths.h>
Date: Thu, 15 Apr 2010 13:40:43 +0100
Message-ID: <20100415124043.GH12365@arachsys.com>
References: <20100406163643.GG15306@arachsys.com>
 <n2u40aa078e1004070357m143cfaccvdc754a3bc5fe1ae1@mail.gmail.com>
 <20100408105850.GD2146@arachsys.com>
 <m2x40aa078e1004080426u98fbe6b2zfa9a2726172f725@mail.gmail.com>
 <20100408115706.GE2077@arachsys.com>
 <z2o40aa078e1004080508z17c5e71by371bbe6e1cdb8c50@mail.gmail.com>
 <20100409054536.GB2151@arachsys.com>
 <20100413090604.GB770@arachsys.com>
 <20100413090713.GC770@arachsys.com>
 <m3hbncgaxu.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, kusmabite@gmail.com,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 15 14:41:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2ONX-0004F0-Vk
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 14:41:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752897Ab0DOMku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 08:40:50 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:46708 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692Ab0DOMkt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 08:40:49 -0400
Received: from [83.104.159.199] (helo=miranda.arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.52)
	id 1O2OND-00008V-KL; Thu, 15 Apr 2010 13:40:48 +0100
Content-Disposition: inline
In-Reply-To: <m3hbncgaxu.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144977>

Jakub Narebski <jnareb@gmail.com> writes:

> All other such variables are described at the top of main Makefile,
> for example:
> 
>   #
>   # Define NO_LIBGEN_H if you don't have libgen.h.
> 
> I think that HAVE_PATHS_H should also have such one-line description.
> By the way it the very first variable with HAVE_* rather than NEEDS_*
> or NO_* name.

To be honest, I used the name suggested to me earlier in the thread without
a great deal of checking to see how consistent it was with existing naming
convention.

Blacklisting OSes with a NO_PATHS_H #define feels like a mistake, as unknown
OSes will fail rather than assuming a safe (if slightly untidy) default. I
got caught out assuming that Windows was sane in this regard, for instance.

To me, NEEDS_PATH_H hints that a system with paths.h would break if it
weren't included, rather than that this is an extra feature available on
this OS. But if NEEDS_* is used elsewhere to enable optional extras on
systems which support them, I agree we should change to NEEDS_PATH_H to be
consistent.

> Why not
> 
>   +#ifdef HAVE_PATHS_H
>   +#include <paths.h>
>   +#endif
>   +#ifndef _PATH_DEFPATH
>   +#define _PATH_DEFPATH "/usr/local/bin:/usr/bin:/bin"
>   +#endif
> 
> This way you are covered if some other header provides _PATH_DEFPATH.

Yes, makes sense, although I think _PATH_DEFPATH is very unlikely to be
provided outside of <paths.h>.

Best wishes,

Chris.
