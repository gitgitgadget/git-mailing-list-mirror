From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] don't use mmap() to hash files
Date: Sun, 14 Feb 2010 03:07:17 -0800 (PST)
Message-ID: <m3fx5484ci.fsf@localhost.localdomain>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>
	<20100213121238.GA2559@progeny.tock> <20100213133951.GA14352@Knoppix>
	<201002131539.54142.trast@student.ethz.ch>
	<20100213162924.GA14623@Knoppix>
	<37fcd2781002131409r4166e496h9d12d961a2330914@mail.gmail.com>
	<20100213223733.GP24809@gibbs.hungrycats.org>
	<20100214011812.GA2175@dpotapov.dyndns.org>
	<alpine.DEB.1.00.1002140249410.20986@pacific.mpi-cbg.de>
	<20100214024259.GB9704@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 14 12:07:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgcK0-0004aZ-M4
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 12:07:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754309Ab0BNLHX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 06:07:23 -0500
Received: from mail-fx0-f227.google.com ([209.85.220.227]:34914 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754099Ab0BNLHV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 06:07:21 -0500
Received: by fxm27 with SMTP id 27so178105fxm.25
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 03:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=itf+HDO8pPUREnq1xicsz+2mV43UB1DeLvExpA+Rp2Q=;
        b=RrTo5mscNVZNX2fJB1BnHqa+PewRtDLzKZZgg6u9wYdwO2HQ0atmit1u4v0FFKz1ip
         5ju99pBj5ftFP0vOQ/RjmQ9hIfbazUUA7V9bOR4kQCEP/JwdH7aDa6fqnr5+MCB00Je4
         YqzI9om3vmUHAbhrZMyfFpimLRQaNJrk1OriQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=hauXsgb73rRfE/UtI8AJHaTv2G82uiLkCr2Lbj9CiA2JA73oPqH+M1irFwXp10l1uK
         eJyhu3BLRI4kY+E4V77z9siqsvhF0xi0Jxpkqv/XE7LN+8jaJVztLRRTvHRtCZI07Ru1
         g6UT/S/zsFgLeJuV+bWIpCUZnztGaDlLuAoyU=
Received: by 10.103.80.34 with SMTP id h34mr2765947mul.20.1266145639064;
        Sun, 14 Feb 2010 03:07:19 -0800 (PST)
Received: from localhost.localdomain (abvf8.neoplus.adsl.tpnet.pl [83.8.203.8])
        by mx.google.com with ESMTPS id 23sm27946349mun.8.2010.02.14.03.07.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Feb 2010 03:07:17 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o1EB6Ggb007422;
	Sun, 14 Feb 2010 12:06:26 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o1EB5XeN007410;
	Sun, 14 Feb 2010 12:05:33 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20100214024259.GB9704@dpotapov.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139895>

Dmitry Potapov <dpotapov@gmail.com> writes:
> On Sun, Feb 14, 2010 at 02:53:58AM +0100, Johannes Schindelin wrote:
> > On Sun, 14 Feb 2010, Dmitry Potapov wrote:
> > 
> > > +	if (strbuf_read(&sbuf, fd, 4096) >= 0)
> > 
> > How certain are you at this point that all of fd's contents fit into your 
> > memory?
> 
> You can't be sure... In fact, we know mmap() also may fail for huge
> files, so can strbuf_read(). Perhaps, mmap() behaves better when you
> want to hash a huge file that does not fit in free physical memory, but
> I do not think it is an important use case for any VCS, which mostly
> stores small text files and a few not so big binary files. Git is not
> design to store your video collection. (probably, Git can be improved to
> handle big files better but I leave that exercise to those who want to
> store their media files in Git).

Something like git-bigfiles: http://caca.zoy.org/wiki/git-bigfiles ?

(found via http://blog.bitquabit.com/2010/02/10/fightings-been-fun-and-all-its-time-shut-and-get-along/
 found via http://tomayko.com/, entry for 10 Feb 2010).
-- 
Jakub Narebski
Poland
ShadeHawk on #git
