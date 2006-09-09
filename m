From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Change set based shallow clone
Date: Fri, 8 Sep 2006 21:45:27 -0400
Message-ID: <9e4733910609081845u36699865g2cc78e5a08267a86@mail.gmail.com>
References: <9e4733910609071923tf1c49f6o70419e961e9eb66f@mail.gmail.com>
	 <20060908184215.31789.qmail@science.horizon.com>
	 <9e4733910609081413p32456768g280bdc9b232d7902@mail.gmail.com>
	 <Pine.LNX.4.64.0609081600530.27779@g5.osdl.org>
	 <9e4733910609081628w2a59551foc28c689d0538a984@mail.gmail.com>
	 <17666.142.886652.667529@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"linux@horizon.com" <linux@horizon.com>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 09 03:45:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLruW-0002cB-2m
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 03:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbWIIBp3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Sep 2006 21:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWIIBp2
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 21:45:28 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:11941 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751306AbWIIBp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Sep 2006 21:45:28 -0400
Received: by py-out-1112.google.com with SMTP id n25so1066687pyg
        for <git@vger.kernel.org>; Fri, 08 Sep 2006 18:45:27 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QsGzbrTWe+f/9BlMfQv8lmXSdQC8id69TknfZ6IoM/0QXrSeyUpuLXOu6Hpe/p8KdERabfqlq1X7zMoNzWkupjZaKgwYUQMkFirErq250u001d+CE63rD9nxTjTf1zDuRnZ+D5A+HIwKN6QmO9HOjvhawGXPc549WXf71qlYBC8=
Received: by 10.35.10.17 with SMTP id n17mr4039691pyi;
        Fri, 08 Sep 2006 18:45:27 -0700 (PDT)
Received: by 10.35.60.14 with HTTP; Fri, 8 Sep 2006 18:45:27 -0700 (PDT)
To: "Paul Mackerras" <paulus@samba.org>
In-Reply-To: <17666.142.886652.667529@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26729>

On 9/8/06, Paul Mackerras <paulus@samba.org> wrote:
> Jon Smirl writes:
>
> > gitk takes about a minute to come up on the Mozilla repo when
> > everything is in cache. It  takes about twice as long when things are
> > cold. It's enough of delay that I don't use the tool.
>
> How long does it take for git rev-list --topo-order to produce its
> first line of output, in the cache-hot case?  That is, is it just
> gitk's graph layout that is taking the time, or is it git rev-list
> (meaning that gitk needs to stop using --topo-order)?

Cold cache:
jonsmirl@jonsmirl:/opt/t1$ time git rev-list --all --topo-order
--parents >/dev/null

real    0m27.687s
user    0m5.672s
sys     0m0.560s

Hot cache:
jonsmirl@jonsmirl:/opt/t1$ time git rev-list --all --topo-order
--parents >/dev/null

real    0m6.041s
user    0m5.768s
sys     0m0.276s
jonsmirl@jonsmirl:/opt/t1$

I have enough RAM (3GB) that everything fits.

Hot cache, 27 seconds to get first line of display in gitk
It takes about two minutes get everything loaded into the window and
scroll to the head

This a 450MB pack, 250K commits, 2M objects.

-- 
Jon Smirl
jonsmirl@gmail.com
