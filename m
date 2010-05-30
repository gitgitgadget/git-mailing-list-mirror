From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] compat: Add another rudimentary poll() emulation
Date: Sun, 30 May 2010 15:40:44 -0500
Message-ID: <20100530204044.GB32728@progeny.tock>
References: <1274948384-167-1-git-send-email-abcd@gentoo.org>
 <AANLkTikezlVaX8ARkRw8kEk9wL9RL_5I6X3vK83nzFUl@mail.gmail.com>
 <20100530003718.GA27024@progeny.tock>
 <201005302119.30340.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kusmabite@gmail.com, Jonathan Callen <abcd@gentoo.org>,
	git@vger.kernel.org, mduft@gentoo.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	msysGit <msysgit@googlegroups.com>,
	Marko Kreen <markokr@gmail.com>,
	Albert Dvornik <dvornik+git@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun May 30 22:40:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIpJ5-0001yp-EP
	for gcvg-git-2@lo.gmane.org; Sun, 30 May 2010 22:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754458Ab0E3UkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 May 2010 16:40:07 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:64581 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753545Ab0E3UkG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 May 2010 16:40:06 -0400
Received: by gwaa12 with SMTP id a12so2231001gwa.19
        for <git@vger.kernel.org>; Sun, 30 May 2010 13:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=z0BII4h3hmikqdvV/u+TBwEVlIVt+L+vJGu8qWKMafc=;
        b=jaYXZ1tfJMADOrUsrRl0TtM4sabJJHc4dJuciXl8hbhHTNbBIfPEh6g4u/PlhZI7oH
         UZ5eHHCFhVtW6vANwBDGSVmWLKFhHzLHVbZ6b4RoNxIRxnXopefC7jEBidQNLUfIKaPO
         IfX5s8IHduYs3lyyE+xIHvAjtpzPd9ePDr+gA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=jO59AAYooDh+PYcYW5bmohn0X5HaAuWFpbCpfWjPFN40pmnYbJRrFQeyTguRXVseer
         68uAMdcjU9ZoVwXJvmskBtRLs+VKZumbJvFUkLQRareU3PsUNVj910BnxVl+pqbCAOl9
         XLrAdc0gbJRGr42nIVmNGnB5tCcD0jXEgJIaw=
Received: by 10.231.184.73 with SMTP id cj9mr4580487ibb.1.1275252004636;
        Sun, 30 May 2010 13:40:04 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id a8sm22685899ibi.23.2010.05.30.13.40.02
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 30 May 2010 13:40:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201005302119.30340.j6t@kdbg.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148016>

Johannes Sixt wrote:

> It cannot work on msysgit because
> 
> - on Windows, select() works only for sockets, but we poll() on pipes, too;
> 
> - in our emulation layer, fds that are sockets must be unpacked with 
> _get_osfhandle() before they can be passed to FD_SET() because (as Paolo has 
> pointed out) FD_SET() must be populated with handles, not fds.

Thanks for the explanation.  Alas.

>From <http://www.suacommunity.com/man/2/select.2.html> I get the
impression that FD_SETSIZE on Interix might not be so small after all
(good).  Apparently older versions of Interix (5.3?) do not obey
timeouts properly, so the poll() in compat/poll.c should probably use
usleep() instead (meh).

Anyway, I leave it to developers on that platform to take it from here
if they so wish.

Ciao,
Jonathan
