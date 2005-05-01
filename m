From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: Re: How to get bash to shut up about SIGPIPE?
Date: Sun, 01 May 2005 11:51:44 -0400
Message-ID: <4274FB10.6090600@dwheeler.com>
References: <E1DSDER-0000kS-00@gondolin.me.apana.org.au>
Reply-To: dwheeler@dwheeler.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ryan Anderson <ryan@michonline.com>, torvalds@osdl.org,
	rene.scharfe@lsrfire.ath.cx, git@vger.kernel.org, pasky@ucw.cz
X-From: git-owner@vger.kernel.org Sun May 01 17:49:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSGgk-0003p5-LU
	for gcvg-git@gmane.org; Sun, 01 May 2005 17:48:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbVEAPyS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 11:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbVEAPuo
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 11:50:44 -0400
Received: from aibo.runbox.com ([193.71.199.94]:53451 "EHLO cujo.runbox.com")
	by vger.kernel.org with ESMTP id S261689AbVEAPtT (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 May 2005 11:49:19 -0400
Received: from [10.9.9.9] (helo=fetch.runbox.com)
	by greyhound.runbox.com with esmtp (Exim 4.34)
	id 1DSGgt-0005DA-3n; Sun, 01 May 2005 17:49:07 +0200
Received: from [70.18.249.32] (helo=[192.168.2.73])
	by fetch.runbox.com with asmtp (uid:258406) (Exim 4.34)
	id 1DSGgs-00065M-MN; Sun, 01 May 2005 17:49:07 +0200
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Herbert Xu <herbert@gondor.apana.org.au>
In-Reply-To: <E1DSDER-0000kS-00@gondolin.me.apana.org.au>
X-Sender: 258406@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Herbert Xu wrote:
> This issue has been around for years.  The discussion that led to
> Debian setting this option may be helpful in understanding it:
> 
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=10494

Thanks for the pointer.  That discussion points
to some alternative fixes that may be more useful
(instead of installing a repaired shell).

One approach is to install a trap for SIGPIPE in
non-terminating command in a pipeline where the
later items might not process all the data, e.g.:
   (trap {} SIGPIPE; find .) | head -1

<rant>
THIS IS A REALLY, REALLY BAD DECISION BY THE BASH TEAM.
Why should the default be "create annoying spurious error report?".
This should at least be a run-time settable option,
with the OPPOSITE default.
</rant>

Which is sad, bash is generally reasonably good.
I guess now I have to say "bash, once properly configured
using DONT_REPORT_SIGPIPE, is reasonably good."


--- David A. Wheeler
