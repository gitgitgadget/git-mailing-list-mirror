From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Why Git is so fast
Date: Thu, 30 Apr 2009 21:33:59 +0200
Message-ID: <200904302134.00569.jnareb@gmail.com>
References: <46a038f90904270155i6c802fceoffc73eb5ab57130e@mail.gmail.com> <m3fxfqnxn5.fsf_-_@localhost.localdomain> <alpine.LFD.2.00.0904301401120.6741@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Apr 30 21:34:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lzc1P-0003DF-3g
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 21:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbZD3TeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 15:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbZD3TeG
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 15:34:06 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:46583 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbZD3TeD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2009 15:34:03 -0400
Received: by fxm2 with SMTP id 2so2015909fxm.37
        for <git@vger.kernel.org>; Thu, 30 Apr 2009 12:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=M2kjEJtXF+IpLhGx++DXkEse+ZS4lU6WdVEPCrvlGzk=;
        b=DvZ9H7M/5FuVpRoHMMwyEonky/TVKbb0x9DmeCObDtSJajcDUkhZm7bF/wsqJYRfFc
         Z6gP0yW5pxkAdeIVsVa76Of5VOkpcrpS5QgMl4ouKcpb5lNb5g5fT6hX6gST4BV0/ZWG
         pcIS86zqQul2qGAh7nVzVcg5UHOOlu+iAdvg4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=IjVo7Rtr706YwHo4OIsg+tzU6yvJNhlX6y1/C5yhhJ0lgS5EKzqDTUnF/6CI05d5JH
         zHmyl7hiZUXoVeIPsoKZ6DnWb4x9LWD8T0VE+d/wxclifCe21cp6e0xxDnFt5vp3/dwq
         t7faxx4pZx4dEBisEFjc3cDDcefb1J/1P8UVk=
Received: by 10.86.36.11 with SMTP id j11mr2201608fgj.22.1241120042173;
        Thu, 30 Apr 2009 12:34:02 -0700 (PDT)
Received: from ?192.168.1.13? (abwf75.neoplus.adsl.tpnet.pl [83.8.229.75])
        by mx.google.com with ESMTPS id 4sm4180348fgg.18.2009.04.30.12.34.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 30 Apr 2009 12:34:01 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LFD.2.00.0904301401120.6741@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118041>

On Thu, 30 Apr 2009, Nicolas Pitre wrote:
> On Thu, 30 Apr 2009, Jakub Narebski wrote:
> > Jakub Narebski <jnareb@gmail.com> writes:

> > es> Maybe Git is fast because every time they faced one of these "buy
> > es> vs. build" choices, they decided to just write it themselves.
> > 
> > I don't think so.  Rather the opposite is true.  Git uses libcurl for
> > HTTP transport.  Git uses zlib for compression.  Git uses SHA-1 from
> > OpenSSL or from Mozilla.  Git uses (modified, internal) LibXDiff for
> > (binary) deltaifying, for diffs and for merges.
> 
> Well, I think he's right on this point as well.  [...]
> The fact that libxdiff was made internal is indeed to have a better 
> impedance matching with the core code, otherwise it could have remained 
> fully external just like zlib.  And the binary delta code is not 
> libxdiff anymore but a much smaller, straight forward, and optimized to 
> death version to achieve speed over versatility (no need to be versatile 
> when strictly dealing with Git's needs only).

Hrmmmm... I have thought that LibXDiff was internalized mainly for ease
of modification, as my impression is that LibXDiff is single developer
effort, while Git from beginning have many contributors (and submodules
didn't exist then).  If I remember correctly the rcsmerge/diff3 algorithm
was added first in internalized git's xdiff... was it added to LibXDiff
proper, anyway?

BTW. I wonder what other F/OSS version control systems: Bazaar,
Mercurial, Darcs, Monotone use for binary deltas, for diff engine,
and for textual three-way merge engine.  Hmmm... perhaps I'll ask
on #revctrl

-- 
Jakub Narebski
Poland
