From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [test failure] Re: t4114 binary file becomes symlink
Date: Sat, 18 Jul 2009 23:13:45 +0200
Message-ID: <20090718211345.GI16708@vidovic>
References: <20090718134551.GC16708@vidovic> <20090718135649.GA6759@sigill.intra.peff.net> <20090718141658.GE16708@vidovic> <200907182106.06776.j6t@kdbg.org> <20090718201721.GF16708@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Sat Jul 18 23:13:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSHEE-0005J1-49
	for gcvg-git-2@gmane.org; Sat, 18 Jul 2009 23:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753723AbZGRVNv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2009 17:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753689AbZGRVNu
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jul 2009 17:13:50 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:61641 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753644AbZGRVNt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2009 17:13:49 -0400
Received: by ewy26 with SMTP id 26so1570688ewy.37
        for <git@vger.kernel.org>; Sat, 18 Jul 2009 14:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=+JROddOs7FrIAoBBuPFZi5ZK4Ne2YU9TLIqrCZKH8bY=;
        b=d9bRFwRpu+sRgx2CZwr9PhZFLRn8JGE5Tbi6hZbdXnjoHLjzkVC08k3eXmesUoHfnY
         VE8i6OC7Y7rnNgtc/NSZ6hGPLMfqPJAcBKq/F9ok6v7uK6/FBfnq9NOWuSlxqx8oWSc2
         fJKMDwceoa031e+MoKVdk9TSushC8yOFxrHsg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=IluuqhLE2UlneMxQALmnxhtXIvN13e8RCBkN68BG8Iq2ALbajrv4DjW9YRsMJOlAFx
         lQEILn3m/Co2O4wMQO3ukBe1XJzIiDd4NbYhoiiyWiiipQ4M4K/gTxw+By8c1sIj7Xc7
         tERbpWnKJMSxd7njAekqsdPPTPQlgyiuMDrHU=
Received: by 10.210.11.17 with SMTP id 17mr1558806ebk.38.1247951628494;
        Sat, 18 Jul 2009 14:13:48 -0700 (PDT)
Received: from @ (91-164-151-27.rev.libertysurf.net [91.164.151.27])
        by mx.google.com with ESMTPS id 5sm1871037eyf.57.2009.07.18.14.13.47
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 18 Jul 2009 14:13:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090718201721.GF16708@vidovic>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123537>

The 18/07/09, Nicolas Sebrecht wrote:
> The 18/07/09, Johannes Sixt wrote:
> > On Samstag, 18. Juli 2009, Nicolas Sebrecht wrote:
> > > ==10807== Process terminating with default action of signal 11 (SIGSEGV)
> > > ==10807==  Access not within mapped region at address 0x1
> > > ==10807==    at 0x4C22349: strlen (in
> > > /usr/lib64/valgrind/amd64-linux/vgpreload_memcheck.so) ==10807==    by
> > > 0x5616ED6: vfprintf (in /lib64/libc-2.8.so)
> > > ==10807==    by 0x563C159: vsnprintf (in /lib64/libc-2.8.so)
> > > ==10807==    by 0x495E90: git_vsnprintf (snprintf.c:38)
> > > ==10807==    by 0x48917B: strbuf_addf (strbuf.c:203)
> > 
> > amd64-linux, and you build with SNPRINTF_RETURNS_BOGUS? Why do you have this 
> > option set?
> 
> I don't tune any flags myself and
> 
>   $ printf "$CC\n $CFLAGS\n $LDFLAGS\n $LIBS\n $CPPFLAGS\n $CPP\n"
> 
> is empty. Is there another way to accidentally set a flag other than
> environment variables or options to 'make'?

Hum, 'rm configure ; make configure ; ./configure' give

 checking whether snprintf() and/or vsnprintf() return bogus value... yes

WTF?

-- 
Nicolas Sebrecht
