From: apodtele <apodtele@gmail.com>
Subject: Re: [PATCH 1/2] diff --stat: use asymptotic scaling in graph
Date: Fri, 13 Oct 2006 09:25:09 -0400
Message-ID: <d620685f0610130625o2d5f70c5p7cb41f567093df32@mail.gmail.com>
References: <d620685f0610121237k458665c5m7bbde2d565d7ef81@mail.gmail.com>
	 <20061012201646.GC10922@admingilde.org>
	 <d620685f0610121437m38eb454g7597b2a93010b023@mail.gmail.com>
	 <452EBF99.5020108@gmail.com> <20061012222703.GA31152@admingilde.org>
	 <452EC625.7050301@gmail.com>
	 <Pine.LNX.4.64.0610122038330.2435@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "A Large Angry SCM" <gitzilla@gmail.com>,
	"Martin Waitz" <tali@admingilde.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 13 15:25:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYN2g-0001zV-5h
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 15:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWJMNZN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Oct 2006 09:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWJMNZN
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Oct 2006 09:25:13 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:24454 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750731AbWJMNZK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Oct 2006 09:25:10 -0400
Received: by wx-out-0506.google.com with SMTP id s14so858975wxc
        for <git@vger.kernel.org>; Fri, 13 Oct 2006 06:25:10 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eWlwXdg0c69rAPd6BaJioecsTEWGJblKsMvLb8LhioHhm89LgrllqOfTeZaZJTaQuJuyWyTjIeMwUgC68R5iF9Q1LTixvHAuUErni1DM0rvZPhgagzt+SSG/auq9VRcRls8Zqx+x2LZJ1bC5k9WLQC6C3XhiJ2UOdb6zd46FD3U=
Received: by 10.90.83.14 with SMTP id g14mr2182242agb;
        Fri, 13 Oct 2006 06:25:10 -0700 (PDT)
Received: by 10.90.95.6 with HTTP; Fri, 13 Oct 2006 06:25:09 -0700 (PDT)
To: "Nicolas Pitre" <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0610122038330.2435@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28844>

Hi!

On 10/12/06, Nicolas Pitre <nico@cam.org> wrote:
> On Thu, 12 Oct 2006, A Large Angry SCM wrote:
> > Martin Waitz wrote:
> > > On Thu, Oct 12, 2006 at 03:20:09PM -0700, A Large Angry SCM wrote:
> > > > > +    if (it)
> > > > > +        return it * width / (it + width) + 1;
> > > > > +    else
> > > > > +        return 0;
> > > > No conditional needed:
> > > >
> > > >  return it * width / (it + width - 1)
> > >
> > > But then it would start scaling much earlier
> > > (for width 10: at 2 instead of 4).
> > > This is not bad per se, but different...
> > >
> >
> > OK:
> >       return (it * width + (it + width)/2)) / (it + width - 1)
> >
> > Now it's back at 4. ;-)
>
> Sure, but at this point the original conditional is probably more
> efficient.
>

Don't make me use
            return it * width / (it + width) + !!it;
