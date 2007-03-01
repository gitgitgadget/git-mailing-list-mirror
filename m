From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Memory overrun in http-push.c
Date: Thu, 1 Mar 2007 22:43:00 +0100
Message-ID: <81b0412b0703011343je4de3b6ra5c1d577da041dcf@mail.gmail.com>
References: <200703011040.35971.andyparkins@gmail.com>
	 <20070228151516.GC57456@codelabs.ru>
	 <200702281541.41164.andyparkins@gmail.com>
	 <20070301051323.GG57456@codelabs.ru>
	 <81b0412b0703010015l5c91c68pd4748ae379db98bb@mail.gmail.com>
	 <7vslcpux62.fsf@assigned-by-dhcp.cox.net>
	 <20070301120042.GD63606@codelabs.ru>
	 <Pine.LNX.4.63.0703011802130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Eygene Ryabinkin" <rea-git@codelabs.ru>,
	"Junio C Hamano" <junkio@cox.net>,
	"Andy Parkins" <andyparkins@gmail.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 01 22:43:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMt3O-0007zF-TE
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 22:43:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030306AbXCAVnH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 16:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030314AbXCAVnH
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 16:43:07 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:14732 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030306AbXCAVnF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 16:43:05 -0500
Received: by ug-out-1314.google.com with SMTP id 44so487510uga
        for <git@vger.kernel.org>; Thu, 01 Mar 2007 13:43:01 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ik9k+qjDmmamD00O5DZNnBfIfjdyo8mUCb7KQW1sG4hSLCAVhvA0FsPJf8+445qrJfgZOVkRzjuivqaMANF/geOEfS0VM0+fNEuEivmRKrhO2S8AhHtTqBWfcjd3OinGWg2NqYh4AvgxSlCPAQEfJdzyRFsu/GvwlLLb4xqJzrU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AIFfjcIsEuIgZ+GZbEU5ZO6bZgNZiyAPHF8NYq9a61BHSP3CaHYaabBoElBSgSQwvN7m4FOVDuzWGR4/F9ZQHQwql8ofNUM9VgarEeLAocq8NOKuk+TTpWhR2tU4l8m5NXdXBXRaVW9z+D01QLdRsrWzvP7Gepx6umOOY7TzIAo=
Received: by 10.78.180.18 with SMTP id c18mr203439huf.1172785380662;
        Thu, 01 Mar 2007 13:43:00 -0800 (PST)
Received: by 10.78.139.9 with HTTP; Thu, 1 Mar 2007 13:43:00 -0800 (PST)
In-Reply-To: <Pine.LNX.4.63.0703011802130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41130>

On 3/1/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > By the way, I am missing one thing: the Id keyword in the file. The
> > problem is that when some user is telling me: there is a bug in the
> > function a() that is inside the file b.c, then I can ask him to give me
> > the $Id$ tag of the file and I will have the full information about the
> > file version.
>
> The problem is: Git does not track files, but rather trees. So, there is
> no sane way to add an Id.
>
> But all is not lost! If your colleague sends you the offending file, you
> can calculate the object name from it by
>
>         $ git-hash-object -t blob <filename>
>

Wont work. The ids in question are really strings embedded into object.
Something like:

  $Id 1.2 user filename.c$

They can be found, extracted from the binary and sent to developer
with a bug report. It's more of a build signature.
IOW, the colleague in question has to have the source, which,
I suspect, he wont.

Of course, it's very simple to embed the HEAD into build and
tell the tester to send the SHA-1 in case of bug report.
