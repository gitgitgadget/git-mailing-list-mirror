From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Convert open("-|") to qx{} calls
Date: Fri, 24 Feb 2006 14:27:58 +0100
Message-ID: <81b0412b0602240527v5d617111sc33e627ff3e1641c@mail.gmail.com>
References: <Pine.LNX.4.63.0602231532470.29635@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0602230738s3445bd86h2d1d670e0ef5daed@mail.gmail.com>
	 <86hd6qgit5.fsf@blue.stonehenge.com>
	 <7v1wxuhsgw.fsf@assigned-by-dhcp.cox.net>
	 <863bi9hq6u.fsf@blue.stonehenge.com>
	 <Pine.LNX.4.63.0602232039160.30630@wbgn013.biozentrum.uni-wuerzburg.de>
	 <86lkw1g647.fsf@blue.stonehenge.com>
	 <20060223211403.GB5827@steel.home> <43FE9771.4030206@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 24 14:28:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCczN-0003Tf-Tq
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 14:28:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbWBXN2A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 08:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbWBXN2A
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 08:28:00 -0500
Received: from nproxy.gmail.com ([64.233.182.194]:27032 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751034AbWBXN2A convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2006 08:28:00 -0500
Received: by nproxy.gmail.com with SMTP id x30so210346nfb
        for <git@vger.kernel.org>; Fri, 24 Feb 2006 05:27:58 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BequeueRxSaGR1okXdPyBpRMHerDUr5cmLTAeco4kQ0py4uzkn0sSfLHyU2AyX9tu5SObBISeoQFIoN7VBLrjmQR71xyoPQErZGD7ZzDoYIGnD95ff+6DeEe3ZZTxnfKEva+j8d1Nx38uuEtmKGpx69eR4DHUj2rrag+OgYpJkc=
Received: by 10.48.47.3 with SMTP id u3mr2760951nfu;
        Fri, 24 Feb 2006 05:27:58 -0800 (PST)
Received: by 10.49.88.16 with HTTP; Fri, 24 Feb 2006 05:27:58 -0800 (PST)
To: "Rogan Dawes" <discard@dawes.za.net>
In-Reply-To: <43FE9771.4030206@dawes.za.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16702>

On 2/24/06, Rogan Dawes <discard@dawes.za.net> wrote:
> Alex Riesen wrote:
> > Randal L. Schwartz, Thu, Feb 23, 2006 21:41:44 +0100:
> >> Johannes> Now that our local Perl guru joined the discussion, may I ask what
> >> Johannes> is, and what is not quoted when put inside qx{}?
> >>
> >> Nothing is quoted.  Your string acts as if it was XXX in:
> >>
> >>         sh -c 'XXX'
> >>
> >
> > Not so for ActiveState. It'll just run the first non-whitespace word
> > passing the rest of the line in its command-line.
> > It's not even worse then to pass it all to cmd/command :)
> >
>
> Not true.
>
>  > type t
> #!perl -w
>
> print qx{echo joe & echo joe}."\n";
>  > perl t
> joe
> joe
>

Does not seem to be the case here (and yes, I check build 815 too):

$ perl -v

This is perl, v5.8.6 built for MSWin32-x86-multi-thread
(with 3 registered patches, see perl -V for more detail)

Copyright 1987-2004, Larry Wall

Binary build 811 provided by ActiveState Corp. http://www.ActiveState.com
ActiveState is a division of Sophos.
Built Dec 13 2004 09:52:01
...

$ perl -e 'print qx{echo joe & echo joe}."\n";'
joe & echo joe
