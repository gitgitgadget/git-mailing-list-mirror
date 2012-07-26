From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: Re: [RFC 01/16] Implement a remote helper for svn in C.
Date: Thu, 26 Jul 2012 10:02:03 +0200
Message-ID: <1707449.hNcpMgVJxF@flomedio>
References: <1343287957-22040-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <1343287957-22040-2-git-send-email-florian.achleitner.2.6.31@gmail.com> <20120726074607.GA4455@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 10:02:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuJ1Z-0000Zi-AN
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 10:02:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895Ab2GZICM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 04:02:12 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:46660 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630Ab2GZICJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 04:02:09 -0400
Received: by bkwj10 with SMTP id j10so1082059bkw.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 01:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=ZjX4LeTF3kTzKpqIM5J34G/nRj8qfuBEGSE5+zBltW0=;
        b=HCI7WRm7JzV7nx+pvb5L1Re0skFIxhJFd3HE9bBzEWkRKd9Ow8Nz9Aj7YgR6XqCuah
         6iLu11CAzIFJ6CvsRMomW2FubgDwbmPMGEZFdSCKw+b9eJSWM8Sn0qpqkFtqx+m3sQvG
         t/yNTo6otH0lLnKBgpB4ll+bjlBk7aZTdXdYDjDPAD/nqL5jE0FGmle/UqtnwGBFaPWz
         nEHWXRrYyAsBmmS+1b+GXUWB5j+KDd6qy3fF3TDJMyDb2sjBuCajukg6EbA1bxna7IWP
         mKExYmha8UnGZH/qxGl1oR8c8TBIP3THc08qgx+BwDUbL5yA3/LjOFz1gzW+r259mfdz
         C2mg==
Received: by 10.204.152.15 with SMTP id e15mr13194244bkw.18.1343289727871;
        Thu, 26 Jul 2012 01:02:07 -0700 (PDT)
Received: from flomedio.localnet (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id 14sm13921077bkq.12.2012.07.26.01.02.05
        (version=SSLv3 cipher=OTHER);
        Thu, 26 Jul 2012 01:02:06 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.2.0-26-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <20120726074607.GA4455@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202248>

On Thursday 26 July 2012 02:46:07 Jonathan Nieder wrote:
> Hi,
> 
> Florian Achleitner wrote:
> > --- /dev/null
> > +++ b/contrib/svn-fe/remote-svn.c
> > @@ -0,0 +1,219 @@
> > +
> > +#include "cache.h"
> > +#include "remote.h"
> > +#include "strbuf.h"
> > +#include "url.h"
> > +#include "exec_cmd.h"
> > +#include "run-command.h"
> > +#include "svndump.h"
> > +#include "argv-array.h"
> > +
> > +static int debug;
> > +
> > +static inline void printd(const char *fmt, ...)
> 
> I remember reviewing this before, and mentioning that this could be
> replaced with trace_printf() and that would simplify some code and
> improve the functionality.  I think I also remember giving some other
> suggestions, but I don't have it in front of me so I can't be sure
> (should have more time this weekend).
> 
> Did you look over that review?  Did you have any questions about it,
> or was it just full of bad ideas, or something else?
> 
> It's silly and vain of me, but I'm not motivated by the idea of
> spending more time looking over this without anything coming of it.
> (Rejecting suggestions is fine, but sending feedback when doing so is
> important because otherwise reviewers get demotivated.)

Yes, I incorporated your review in the new version, as far as applicable. But 
I didn't send you an answer on the detailed points. 
I will send an answer to the previous review ..

> 
> Hope that helps,
> Jonathan
