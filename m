From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: What's cooking in git.git (Jun 2009, #01; Fri, 12)
Date: Fri, 12 Jun 2009 13:38:09 -0500
Message-ID: <rSzubjF8CnevXkwWDxaenB5zuhD67OB8uzhVcZ-gVR8YYXa1S1h2tg@cipher.nrlssc.navy.mil>
References: <7v1vppbyud.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 20:38:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFBdu-0005NU-JN
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 20:38:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755507AbZFLSiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 14:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755034AbZFLSiM
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 14:38:12 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:33247 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289AbZFLSiL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 14:38:11 -0400
Received: by mail.nrlssc.navy.mil id n5CIc93J029713; Fri, 12 Jun 2009 13:38:10 -0500
In-Reply-To: <7v1vppbyud.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 12 Jun 2009 18:38:09.0834 (UTC) FILETIME=[EF3B00A0:01C9EB8C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121440>

Junio C Hamano wrote:

> [Will merge to "master" soon]
> 
> * bc/solaris (Sun Jun 7 07:40:29 2009 +0200) 10 commits
>  - configure: test whether -lresolv is needed
>  + Makefile: insert SANE_TOOL_PATH to PATH before /bin or /usr/bin
>  + git-compat-util.h: avoid using c99 flex array feature with Sun
>    compiler 5.8
>  + Makefile: add section for SunOS 5.7
>  + Makefile: introduce SANE_TOOL_PATH for prepending required
>    elements to PATH
>  + Makefile: define __sun__ on SunOS
>  + git-compat-util.h: tweak the way _XOPEN_SOURCE is set on Solaris
>  + On Solaris choose the OLD_ICONV iconv() declaration based on the
>    UNIX spec
>  + Makefile: add NEEDS_RESOLV to optionally add -lresolv to compile
>    arguments
>  + Makefile: use /usr/ucb/install on SunOS platforms rather than
>    ginstall
> 
> We saw some success report with Sun's c99 compiler, which would allow us
> to include the last remaining patch from Brandon with updates.

No additional updates are necessary.  The report that we saw from Sun's
v5.9 c99 compiler confirmed that it correctly handled the flex array as
used by diff-delta.c/delta.h.  So, we only have to treat compilers older
than v5.9 specially, which is what 203ee91f 'avoid using c99 flex array
feature with Sun compiler 5.8' does.  So I think all of that is ready to
go.

> I lost
> track of the status of the tip patch for autoconf.  Is it ready to go?
> Comments from Solaris folks are appreciated.

I can't test it.  No autotools on these machines.

Ralf said it was all pretty mechanical and with what little autoconf
experience I have, his patch looks like it would do the trick, even
if it would add -lresolv unnecessarily sometimes (i.e. for any Solaris
not requiring NO_IPV6).

-brandon
