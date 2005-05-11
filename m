From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Core and Not-So Core
Date: Thu, 12 May 2005 00:40:59 +1000
Message-ID: <2cfc4032050511074038d66089@mail.gmail.com>
References: <2cfc40320505100800426d38ca@mail.gmail.com>
	 <4281EAB5.3020006@peralex.com>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 11 16:38:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVsKB-0002C4-Bc
	for gcvg-git@gmane.org; Wed, 11 May 2005 16:36:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVEKOnR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 10:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbVEKOmk
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 10:42:40 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:57401 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261968AbVEKOk7 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 10:40:59 -0400
Received: by rproxy.gmail.com with SMTP id j1so100473rnf
        for <git@vger.kernel.org>; Wed, 11 May 2005 07:40:59 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R2g+RwQzxR4yins0w/aNuGIscaAPhRJVcUQnZ6v3A+MSAjDECXY7jb8VLx+TBI+anOPtShJU5qHA0mjzBcQ472B93ONsZk4Kjx9LtHEeWI5Eyum17GdmjyI76rjY5z+EngD8kvG0aeyhqbAdGXF9TvWU9YhniLZQEMLnwK+n97c=
Received: by 10.38.89.72 with SMTP id m72mr466568rnb;
        Wed, 11 May 2005 07:40:59 -0700 (PDT)
Received: by 10.38.104.59 with HTTP; Wed, 11 May 2005 07:40:59 -0700 (PDT)
To: Noel Grandin <noel@peralex.com>
In-Reply-To: <4281EAB5.3020006@peralex.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 5/11/05, Noel Grandin <noel@peralex.com> wrote:
> Hi
> 
> Note that eclipse in particular has a fairly complicated repository
> provider interface.
> The subversion plugin developers (the subclipse project) took quite a
> while to implement their stuff.
> Basing your stuff off of their code would be a good idea.
> 

Noel,

Thanks for the info. I'll certainly have a look at what the subclipse
folks did as I am sure it will be helpful to understand the strategy. 
I do think we are in a slightly different situation here as we don't
quite have a stable library interface to git yet - Brad Roberts work
notwithstanding.

The repository API in pure Java is almost a no-brainer since Linus has
done such a good job in keeping the repository specification simple
and unambiguous.

A Java workspace API can take advantage of the abstraction and GUI
facilities that Java and Eclipse afford so will naturally be different
in form to the existing command line tools for manipulating the git
index. Certainly, there will be similarities - aspects of the 3-way
merge, for example, but there will be differences too - workspace
change detection will be somewhat assisted by the change notification
framework in Eclipse and won't require as much manual intervention.

> Also, they worked in 2 stages - in the first stage, they created
> something called the JavaHL interface, behind which they talked to the
> subversion C libraries using JNI.
> Then they created a pure-java implemenation of the subversion C
> libraries which also implemented the JavaHL interface, allowing them to
> compare and contrast the behaviour.
> 

At this stage, my thoughts are to implement a listener pattern to keep
the git index up to date, and I may well implement that by calling out
the the C git-update-cache executable. This can run in a background
thread so it needn't be a huge drag on interactive user performance.

Anyway, thanks for your input.

jon.
