From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [test failure] Re: t4114 binary file becomes symlink
Date: Sat, 18 Jul 2009 22:17:21 +0200
Message-ID: <20090718201721.GF16708@vidovic>
References: <20090718134551.GC16708@vidovic> <20090718135649.GA6759@sigill.intra.peff.net> <20090718141658.GE16708@vidovic> <200907182106.06776.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Jul 18 22:17:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSGLl-0003Ur-R5
	for gcvg-git-2@gmane.org; Sat, 18 Jul 2009 22:17:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753708AbZGRURa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2009 16:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753682AbZGRURa
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jul 2009 16:17:30 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:63395 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753678AbZGRUR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2009 16:17:29 -0400
Received: by ewy26 with SMTP id 26so1555311ewy.37
        for <git@vger.kernel.org>; Sat, 18 Jul 2009 13:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=U9x9aOJgHJDPE2Me2AShXyVZxs4KCLU1uzysyiQV0RA=;
        b=vM2veXrvG0eNmBcwa9qYBrqADUfFcH3HCyzfwqvIZtGRCzOBIecpyRwJyG0jzAMFPu
         2R7BCsH5kVYB6fZIyZHwTYzonIX5rP8d2onWAdL29h16z+RO7bSZAvXlycBVdCkfa5M5
         HfD5h1VVopgzxeRzFtlkdLxlFypIsYGDke6jY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=QkJVGxdTMzCfnI9KFxn6HximZ4sg5j7jbYYAFoeH1dnZCdUw30OVAzasD89qSi6gyi
         XbXxidXFQA5dWoYQW9dDebRFdAfBzHzaIil33JnRXZB+vEn0W3+GKBNIFNjUZEsYfd8W
         CseK8mp6PH/qr6gSh4ALZDiK27V+q25k2OG40=
Received: by 10.210.65.16 with SMTP id n16mr3085272eba.87.1247948247264;
        Sat, 18 Jul 2009 13:17:27 -0700 (PDT)
Received: from @ (91-164-151-27.rev.libertysurf.net [91.164.151.27])
        by mx.google.com with ESMTPS id 24sm6490180eyx.53.2009.07.18.13.17.23
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 18 Jul 2009 13:17:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200907182106.06776.j6t@kdbg.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123535>

The 18/07/09, Johannes Sixt wrote:
> On Samstag, 18. Juli 2009, Nicolas Sebrecht wrote:
> > ==10807== Process terminating with default action of signal 11 (SIGSEGV)
> > ==10807==  Access not within mapped region at address 0x1
> > ==10807==    at 0x4C22349: strlen (in
> > /usr/lib64/valgrind/amd64-linux/vgpreload_memcheck.so) ==10807==    by
> > 0x5616ED6: vfprintf (in /lib64/libc-2.8.so)
> > ==10807==    by 0x563C159: vsnprintf (in /lib64/libc-2.8.so)
> > ==10807==    by 0x495E90: git_vsnprintf (snprintf.c:38)
> > ==10807==    by 0x48917B: strbuf_addf (strbuf.c:203)
> 
> amd64-linux, and you build with SNPRINTF_RETURNS_BOGUS? Why do you have this 
> option set?

I don't tune any flags myself and

  $ printf "$CC\n $CFLAGS\n $LDFLAGS\n $LIBS\n $CPPFLAGS\n $CPP\n"

is empty. Is there another way to accidentally set a flag other than
environment variables or options to 'make'?

I've tried

  make
  make install

and

  ./configure --prefix=/home/nicolas/bin
  make
  make install

I don't know if it changes anything but both failed with the same error.


-- 
Nicolas Sebrecht
