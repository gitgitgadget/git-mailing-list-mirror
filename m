From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/6] Facilitate debugging Git executables in tests with
 gdb
Date: Fri, 30 Oct 2015 14:30:09 -0700
Message-ID: <20151030213009.GJ7881@google.com>
References: <cover.1445865176.git.johannes.schindelin@gmx.de>
 <082d6474a31c405b16087f76de7bc5d01faba529.1445865176.git.johannes.schindelin@gmx.de>
 <20151026191724.GE7881@google.com>
 <alpine.DEB.1.00.1510271036100.31610@s15462909.onlinehome-server.info>
 <xmqqr3kge0d3.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.1.00.1510301925360.31610@s15462909.onlinehome-server.info>
 <xmqqlhakky0e.fsf@gitster.mtv.corp.google.com>
 <20151030190256.GI7881@google.com>
 <20151030195611.GC5486@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 30 22:30:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsHFb-0006ci-Sx
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 22:30:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759721AbbJ3VaN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 17:30:13 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34724 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759646AbbJ3VaM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 17:30:12 -0400
Received: by padhk11 with SMTP id hk11so84999457pad.1
        for <git@vger.kernel.org>; Fri, 30 Oct 2015 14:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=T4/p22uaqa3CC7ovjYm0qnLugL0PgKIaFKPCaMTBJMY=;
        b=Kicbh2QGq1ASkL+2UUR22p6qKW5wj0ge7Qg5JXJFftO9URt14gdqjWT0bgMj3L/BVD
         mBoJb5D2XUW3yG38ctG1FZVVhT3CyDkhQxRu6oWcH8ja1V5x+aOzMvq5pTruxZGELXHs
         I+4cAdUGOTtB2yPJPQc3ayjMEWcicdAvLCimgX88G6AqCZwRdAaIIwgo+SnRe57xts4l
         jO+tDFktI+9TD7jpy/DrvW1l5nDG1bXBWk9M/w86Feoq95dX/FWFkR9JPz1pt+UfzxOE
         yrUe76CXaetVzQNXUkZRWsufkYaz8XatT5bXWptfRTlABsulHvBvYZskmB0ZX4Ir4umz
         eeRg==
X-Received: by 10.67.1.34 with SMTP id bd2mr10804267pad.45.1446240611930;
        Fri, 30 Oct 2015 14:30:11 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:c1d3:800a:733a:d60a])
        by smtp.gmail.com with ESMTPSA id an5sm9938007pbd.45.2015.10.30.14.30.10
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 30 Oct 2015 14:30:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20151030195611.GC5486@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280544>

Jeff King wrote:

> Somebody suggested elsewhere that the name "gdb" be configurable. We
> could stick that in the same variable, like:
>
>   test "$GIT_TEST_GDB" = 1 && GIT_TEST_GDB=gdb
>   exec ${GIT_TEST_GDB} --args ...
>
> but that does not play well with the "debug" function, which does not
> know which value to set it to. I guess we would need GIT_TEST_GDB_PATH
> or something.

*nod* I think having a separate variable like GIT_TEST_GDB_COMMAND
would be fine.

An interested person could also replace 'gdb --args' with 'lldb --' if
they want to.
