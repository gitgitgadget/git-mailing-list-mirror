From: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>
Subject: Re: [PATCH] gitweb: Use config file or file for repository owner's
	name.
Date: Tue, 5 Feb 2008 12:28:10 -0200
Message-ID: <20080205142809.GA6226@c3sl.ufpr.br>
References: <1201670898-15076-1-git-send-email-ribas@c3sl.ufpr.br> <7vwsprj0sv.fsf@gitster.siamese.dyndns.org> <20080131023629.GB7778@c3sl.ufpr.br> <7vsl0eg16c.fsf@gitster.siamese.dyndns.org> <7vabmmg0cb.fsf@gitster.siamese.dyndns.org> <20080205044121.GA13263@c3sl.ufpr.br> <m34pcn67nu.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 15:29:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMOnK-0003ta-EY
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 15:29:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752294AbYBEO2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 09:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752257AbYBEO2d
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 09:28:33 -0500
Received: from mx.inf.ufpr.br ([200.17.202.3]:44150 "EHLO urquell.c3sl.ufpr.br"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751921AbYBEO2c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 09:28:32 -0500
Received: from localhost (unknown [189.1.136.222])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: ribas)
	by urquell.c3sl.ufpr.br (Postfix) with ESMTP id 114CD700003C6;
	Tue,  5 Feb 2008 12:28:26 -0200 (BRST)
Content-Disposition: inline
In-Reply-To: <m34pcn67nu.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72661>

On Tue, Feb 05, 2008 at 02:04:51AM -0800, Jakub Narebski wrote:
> Bruno Cesar Ribas <ribas@c3sl.ufpr.br> writes:
> 
> > On Wed, Jan 30, 2008 at 07:06:44PM -0800, Junio C Hamano wrote:
> > > If the config reading interface is too slow (somebody has to
> > > bench it on a large set of repositories), maybe we would need to
> > 
> > I made a simple bench as follows.
> > 
> > dd= 'dd if=/dev/zero of=/home/bruno/dds/$i bs=1M count=400000'
> 
> This was to provide load, and check how it works under load, isn't it?

Yes, it was to provide high disk IO. Running a test with system 100%idle is
not satisfatory because time is almost satisfatory.
> 
> > Machine: 4*opteron 2.8GHz
> >      32GB ram
> >      14*750GB RAID0 sata2 /home
> >      
> > Generated a 1000 projects [ too much?! git.debian.org has 668]
> > For each test a 'echo 2 > /proc/sys/vm/drop_caches' was done before running
> > it.
> > 
> > command: time gitweb.cgi > /dev/null
> 
> Didn't you mean
> 
>   time GATEWAY_INTERFACE="CGI/1.1" HTTP_ACCEPT="*/*" \
>        REQUEST_METHOD="GET" QUERY_STRING="" gitweb.cgi
> 
> here (or some wrapper thereof)?

I thought so, but running it without any arguments generated a clean project
list page.

> 
> I wonder what would ApacheBench show... 
> 
> Note also that there are operating systems (MS Windows, MacOS X) where
> fork is much slower than on Linux.

Problem is wunning it with MsWindows an MacOS (happily I removed it from my
macbook)

Running an ApacheBench should be unde high disk IO AND multiple requests at
once.

It could be done under linux, but what concerns me more is the generation of
ONE page without apache. And that using gitweb.descripton (and probably
gitweb.owner) is better than using single-lined-isolated-files.

> 
> 
> -- 
> Jakub Narebski
> Poland
> ShadeHawk on #git
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Bruno Ribas - ribas@c3sl.ufpr.br
http://web.inf.ufpr.br/ribas
C3SL: http://www.c3sl.ufpr.br 
