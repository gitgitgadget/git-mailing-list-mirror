From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Change set based shallow clone
Date: Sun, 10 Sep 2006 10:56:25 -0400
Message-ID: <9e4733910609100756r1ece1e22m38054536a2909dd4@mail.gmail.com>
References: <9e4733910609071923tf1c49f6o70419e961e9eb66f@mail.gmail.com>
	 <20060908184215.31789.qmail@science.horizon.com>
	 <9e4733910609081413p32456768g280bdc9b232d7902@mail.gmail.com>
	 <Pine.LNX.4.64.0609081600530.27779@g5.osdl.org>
	 <9e4733910609081628w2a59551foc28c689d0538a984@mail.gmail.com>
	 <17668.2019.732961.855446@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"linux@horizon.com" <linux@horizon.com>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 10 16:56:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMQjj-0006h6-V6
	for gcvg-git@gmane.org; Sun, 10 Sep 2006 16:56:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWIJO41 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 10:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbWIJO41
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 10:56:27 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:24492 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932191AbWIJO4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Sep 2006 10:56:25 -0400
Received: by py-out-1112.google.com with SMTP id 57so1583347pya
        for <git@vger.kernel.org>; Sun, 10 Sep 2006 07:56:25 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Uq1e41crohw3ZNKMjF8vFvODyCQA5hvWPp5cPO3ZQ3C84oBZ01KLZjdDFP+aDUn3J6fUVcU81mi6OGUg52F2Z1y7M0AiQgqvdChH212KMrTc4UOgeo4ewlAAJmNkg5reaHxYDhpRdI9uneYD4hvFXzwvC7ssf+VINcxdj+JkpEk=
Received: by 10.35.40.10 with SMTP id s10mr6937317pyj;
        Sun, 10 Sep 2006 07:56:25 -0700 (PDT)
Received: by 10.35.60.14 with HTTP; Sun, 10 Sep 2006 07:56:25 -0700 (PDT)
To: "Paul Mackerras" <paulus@samba.org>
In-Reply-To: <17668.2019.732961.855446@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26796>

On 9/10/06, Paul Mackerras <paulus@samba.org> wrote:
> Jon Smirl writes:
>
> > gitk takes about a minute to come up on the Mozilla repo when
> > everything is in cache. It  takes about twice as long when things are
> > cold. It's enough of delay that I don't use the tool.
>
> I've been doing some timing measurements with Jon's repo.  The results
> are interesting.

Using the Mozilla repo you downloaded is not a normal situation since
it is 100% packed. Most people are going to have a few thousand loose
objects floating around too. Loose objects really slow things down.

You noticed too that forks of small apps are relatively slow. The
first pass of the import tools used fork for everything and took a
week to run with 60% of the time spent in the kernel. There may be
some work to do on fork in the kernel. Does mapping the kernel into
the top 1G slow down fork of these small apps? Or are they dynamically
linked to something that is bringing in millions of pages? When I was
doing oprofile all of the time was in the actual fork call and page
table copying.

-- 
Jon Smirl
jonsmirl@gmail.com
