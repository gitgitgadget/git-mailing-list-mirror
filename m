From: bdowning-oU/tDdhfGLReoWH0uzbU5w@public.gmane.org (Brian Downing)
Subject: Re: [PATCH v2] compat: Add simplified merge sort
 implementation from glibc
Date: Tue, 5 Feb 2008 20:47:32 -0600
Message-ID: <20080206024732.GR26392@lavos.net>
References: <20080205211044.GP26392@lavos.net> <alpine.LSU.1.00.0802052220500.8543@racer.site>
Reply-To: bdowning-oU/tDdhfGLReoWH0uzbU5w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Edgar Toernig <froese-Mmb7MZpHnFY@public.gmane.org>, Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>
To: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Wed Feb 06 03:48:10 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.246])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMaKW-0006vN-IP
	for gcvm-msysgit@m.gmane.org; Wed, 06 Feb 2008 03:48:10 +0100
Received: by wa-out-0708.google.com with SMTP id n36so4679475wag.21
        for <gcvm-msysgit@m.gmane.org>; Tue, 05 Feb 2008 18:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:x-ironport-av:received:x-ironport-anti-spam-filtered:x-ironport-anti-spam-result:x-ironport-av:received:received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent:from:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=VsD3JkoEGwoYuVUFDMaHifMBaOPJKTYbVNTK4ERcr6w=;
        b=Ow050Cx1dGeeJjYbeWM5pLqoILrS1uA0/aR3RDh7fY++VA8z4rofQ0w/wfsbGHCj8U0N/ZdTt2XgfgNf79FxQgqMcDfR4RVnw3XV0Cl+s5f19e7uPZAuKFGPVIz6jZBrDF7+R9Isls1Gjv9yZnRmYvQYh/YpvNDYZeYtdLkVD2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:x-ironport-av:x-ironport-anti-spam-filtered:x-ironport-anti-spam-result:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent:from:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=KgG4ZWlU7m1bPaUClHXxq+QkU7wqvgxbbRegb1K23DsTcc/rBdzh14s2POiTf++958LlQGUsJ5Ql948FANuCqZTJug8ALS7hyryzAV6qBLGCNT7S/T/ai5i5Jvg3qUf0WIEGjPwb9zYF+zoKL7B7AxcWzpLcbsoBwLF8FI19OVo=
Received: by 10.115.110.6 with SMTP id n6mr696000wam.12.1202266054775;
        Tue, 05 Feb 2008 18:47:34 -0800 (PST)
Received: by 10.106.191.30 with SMTP id o30gr1633prf;
	Tue, 05 Feb 2008 18:47:34 -0800 (PST)
X-Sender: bdowning-oU/tDdhfGLReoWH0uzbU5w@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.14.4 with SMTP id r4mr22660326pyi.2.1202266054452; Tue, 05 Feb 2008 18:47:34 -0800 (PST)
Received: from mxsf08.insightbb.com (mxsf08.insightbb.com [74.128.0.78]) by mx.google.com with ESMTP id a28si3576549pye.0.2008.02.05.18.47.34; Tue, 05 Feb 2008 18:47:34 -0800 (PST)
Received-SPF: neutral (google.com: 74.128.0.78 is neither permitted nor denied by best guess record for domain of bdowning-oU/tDdhfGLReoWH0uzbU5w@public.gmane.org) client-ip=74.128.0.78;
Authentication-Results: mx.google.com; spf=neutral (google.com: 74.128.0.78 is neither permitted nor denied by best guess record for domain of bdowning-oU/tDdhfGLReoWH0uzbU5w@public.gmane.org) smtp.mail=bdowning-oU/tDdhfGLReoWH0uzbU5w@public.gmane.org
X-IronPort-AV: E=Sophos;i="4.25,309,1199682000";  d="scan'208";a="234884433"
Received: from unknown (HELO asav02.insightbb.com) ([172.31.249.124]) by mxsf08.insightbb.com with ESMTP; 05 Feb 2008 21:47:33 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah4FAD6uqEdKhvkY/2dsb2JhbACBWKxb
X-IronPort-AV: E=Sophos;i="4.25,309,1199682000";  d="scan'208";a="199155533"
Received: from 74-134-249-24.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.249.24]) by asav02.insightbb.com with ESMTP; 05 Feb 2008 21:47:33 -0500
Received: by mail.lavos.net (Postfix, from userid 1000) id B49B1309F21; Tue,  5 Feb 2008 20:47:32 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0802052220500.8543-OGWIkrnhIhzN0uC3ymp8PA@public.gmane.org>
User-Agent: Mutt/1.5.9i
Sender: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org;
	contact msysgit-owner-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <mailto:msysgit-help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72749>


On Tue, Feb 05, 2008 at 10:21:58PM +0000, Johannes Schindelin wrote:
> On Tue, 5 Feb 2008, Brian Downing wrote:
> > diff --git a/compat/qsort.c b/compat/qsort.c
> > new file mode 100644
> > index 0000000..8663889
> > --- /dev/null
> > +++ b/compat/qsort.c
> > @@ -0,0 +1,60 @@
> > +#include "../git-compat-util.h"
> > +
> > +/* This merge sort implementation is simplified from glibc's. */
> > +static void msort_with_tmp(void *b, size_t n, size_t s,
> 
> Didn't you forget to include the original copyright, as well as yours?

I (perhaps naïvely) assumed the "from glibc" would be enough.  If not,
the original is:

/* An alternative to qsort, with an identical interface.
   This file is part of the GNU C Library.
   Copyright (C) 1992,95-97,99,2000,01,02,04 Free Software Foundation, Inc.
   Written by Mike Haertel, September 1988.

   The GNU C Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   The GNU C Library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with the GNU C Library; if not, write to the Free
   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
   02111-1307 USA.  */

(That was from glibc-2.3.6/stdlib/msort.c.  I'm not sure of the exact
version I referenced for the implementation, but it was a lot closer to
2.3.6 than the current 2.7.)

As far as my copyleft, I was just planning on it being under Git's
blanket copyleft.  I really only pruned and reformatted code; there's
really nothing substantial to claim ownership of.

> BTW if these 60 lines have code that is really faster than Microsoft's 
> implementation of a sort, it is really fascinating to me.

Well, it's faster for us, but I bet our (usually mostly-sorted) tree
input is just better for a sort like a merge sort rather than a
quicksort.

-bcd
