From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [PATCH] Use explicit pointers for execl...() sentinels.
Date: Sun, 12 Mar 2006 20:08:12 +0200
Message-ID: <20060312200812.3fb04638.tihirvon@gmail.com>
References: <20060311192954.GQ16135@artsapartment.org>
	<slrne17urp.fr9.mdw@metalzone.distorted.org.uk>
	<7v7j6zgaxx.fsf@assigned-by-dhcp.cox.net>
	<slrne18aae.fr9.mdw@metalzone.distorted.org.uk>
	<20060312171316.39d138f8.tihirvon@gmail.com>
	<slrne18mq3.fr9.mdw@metalzone.distorted.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 12 19:06:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIUxR-0005bY-Fl
	for gcvg-git@gmane.org; Sun, 12 Mar 2006 19:06:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbWCLSGT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Mar 2006 13:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751661AbWCLSGS
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Mar 2006 13:06:18 -0500
Received: from nproxy.gmail.com ([64.233.182.205]:16855 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751049AbWCLSGR (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Mar 2006 13:06:17 -0500
Received: by nproxy.gmail.com with SMTP id m19so757219nfc
        for <git@vger.kernel.org>; Sun, 12 Mar 2006 10:06:15 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=c5Zi+H17tnNY7AOrZAtGGwnGAWkIzo3nn7c1LQACa5p5VBEr5yGJB08SKvaLghmjZZmonnXReNcSrQZYZK2m1hcn+lHpdXCRNZf+XG5D7+fEDxrtaNvcr0YANFC4wE2YfcJOqdTOEo4V1HHVxDSugaNDCiVUEdq2hDn8EHUmlZI=
Received: by 10.49.18.12 with SMTP id v12mr817918nfi;
        Sun, 12 Mar 2006 10:06:15 -0800 (PST)
Received: from garlic.home.net ( [82.128.201.244])
        by mx.gmail.com with ESMTP id c1sm1711434nfe.2006.03.12.10.06.13;
        Sun, 12 Mar 2006 10:06:15 -0800 (PST)
To: git@vger.kernel.org
In-Reply-To: <slrne18mq3.fr9.mdw@metalzone.distorted.org.uk>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.14; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17522>

On Sun, 12 Mar 2006 17:32:51 +0000 (UTC)
Mark Wooding <mdw@distorted.org.uk> wrote:

> Besides, (void *)0 fixes /this particular/ problem, because `void *' and
> `char *' have the same representation (6.2.5#27).  This wouldn't help us
> with a putative function which takes an arbitrary number of `foo *'
> pointers, since nothing guarantees that `void *' and `foo *' have
> similar representations.  You'd have to say `(foo *)0' or `(foo *)NULL'.

NULL pointer does not point to any data, it just says it's 'empty'.  So
it doesn't need to be same type pointer as specified in the function
prototype.  Pointers are just addresses, it doesn't matter from to code
generation point of view whether it is (char *)0 or (void *)0.

> Don't know: didn't look.  0L won't do the right thing with IL32LLP64, if
> anyone was actually crazy enough to specify such an ABI.  The point is,
> there's not much 

sizeof(unsigned long) is sizeof(void *) in real world.

> > How about fixing those systems instead of making the git source code
> > unreadable.
> 
> Because, according to the C and POSIX specs, they're not wrong.

They didn't think of 64-bit architectures back then, I suppose.

> The right fix from the point of view of a C implementation would be to
> define NULL to be some weird __null_pointer token which the compiler
> could warn about whenever it was used in an untyped argument context.

In practice (void *)0 is good enough.

> (Besides, I don't find bare or casted `0' unreadable.  Maybe I'm just
> strange.)

'ugly' would have been better word than 'unreadable'.

-- 
http://onion.dynserv.net/~timo/
