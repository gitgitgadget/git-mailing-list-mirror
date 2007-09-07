From: Walter Bright <boost@digitalmars.com>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String   Library.
Date: Fri, 07 Sep 2007 13:40:56 -0700
Organization: Digital Mars
Message-ID: <fbsd0g$gt6$1@sea.gmane.org>
References: <1189004090.20311.12.camel@hinata.boston.redhat.com> <vpq642pkoln.fsf@bauges.imag.fr> <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com> <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org> <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com> <alpine.LFD.0.999.0709070135361.5626@evo.linux-foundation.org> <alpine.LFD.0.999.0709070203200.5626@evo.linux-foundation.org> <fbqmdu$udg$1@sea.gmane.org> <20070907094120.GA27754@artemis.corp> <fbs79k$tac$1@sea.gmane.org> <20070907194115.GA23483@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 07 22:41:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITkda-0003V8-Sg
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 22:41:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758405AbXIGUlF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 16:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758407AbXIGUlE
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 16:41:04 -0400
Received: from main.gmane.org ([80.91.229.2]:44538 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758384AbXIGUlC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 16:41:02 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ITkdN-0008Dj-1F
	for git@vger.kernel.org; Fri, 07 Sep 2007 22:40:57 +0200
Received: from c-24-16-50-251.hsd1.wa.comcast.net ([24.16.50.251])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Sep 2007 22:40:57 +0200
Received: from boost by c-24-16-50-251.hsd1.wa.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Sep 2007 22:40:57 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-16-50-251.hsd1.wa.comcast.net
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20070907194115.GA23483@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58070>

Pierre Habouzit wrote:
>   Well htod does that, but it's very impractical to write them from
> scratch.

True. I haven't tried yet (nobody else seems to care about it as much as 
you do!), but I think this could be automated fairly easily with a template.


> And for that bit-fields are
> a really really fast and simple way to describe things.

I should point out that inline functions are inlined, and there is no 
speed difference in the result.


>   Not to mention that the usual C idiom:
> 
>   union {
>     unsigned flags;
>     struct {
>       // many bitfields
>     };
>   };
> 
>   Would need an explicit copy_flags(const my_struct foo) function to
> work. Not pretty, not straightforward.

I'm not following this. To copy a union, you just copy it with the 
assignment operator:

	U a, b;
	a = b;		// copies all the bit fields, too!


>> D does come with htod, which converts C .h files to D files.
>   Last time I checked it was only available on windows, and closed
> source, both are an impediment for many people.

You're right on both counts. It's because htod is built out of a fork of 
the Digital Mars C compiler. Something similar could be done with gcc, 
but I'm not the person to do it. I should also get off my lazy tail and 
port htod to linux.


> Right now, for D, only
> gdc exists, it lags behind dmd quite a lot afaict, and there is no other
> toolchain helpers yet.

GDC was just released for D 1.020, which is behind D 1.021, but 1.021 
was released just a couple days ago <g>.


>   For the record I wasn't suggesting to rewrite git in D at all. I just
> happened to see your post, and being very interested in where D is going
> because I feel it's an excellent langage, and saw an opportunity to
> mention a few quirks I feel it has, so, well, I answered :)

And it's nice to hear your perspective, which is why I dropped by this 
thread.
