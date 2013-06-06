From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: [PATCH] git-gui: bring Wish process to front on Mac
Date: Thu, 6 Jun 2013 19:12:07 +0200
Message-ID: <1l424u5.uk987q18u3oxfM%lists@haller-berlin.de>
References: <CABNJ2G+h3zh+=wLA0KHjUn8TsfhqUK1Kn-1_=6hnXVRJUPhuuA@mail.gmail.com>
Cc: paulus@samba.org (Paul Mackerras),
	git@vger.kernel.org (Git Mailing List)
To: patthoyts@gmail.com (Pat Thoyts)
X-From: git-owner@vger.kernel.org Thu Jun 06 19:12:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkdjS-0005tM-Il
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 19:12:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818Ab3FFRMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 13:12:09 -0400
Received: from server90.greatnet.de ([83.133.96.186]:60436 "EHLO
	server90.greatnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147Ab3FFRMI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 13:12:08 -0400
Received: from [192.168.0.42] (nat1.ableton.net [217.110.199.117])
	by server90.greatnet.de (Postfix) with ESMTPA id B58763B0F19;
	Thu,  6 Jun 2013 19:12:06 +0200 (CEST)
In-Reply-To: <CABNJ2G+h3zh+=wLA0KHjUn8TsfhqUK1Kn-1_=6hnXVRJUPhuuA@mail.gmail.com>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.8.4 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226512>

Pat Thoyts <patthoyts@gmail.com> wrote:

> On 6 June 2013 09:17, Stefan Haller <stefan@haller-berlin.de> wrote:
> > +## On Mac, bring the current Wish process window to front
> > +
> > +if {[tk windowingsystem] eq "aqua"} {
> > +       exec osascript -e [format {
> > +               tell application "System Events"
> > +                       set frontmost of processes whose unix id is %d to true
> > +               end tell
> > +       } [pid] ]
> > +}
> 
> Seems fine to me. I can't test this as I have no access to this
> platform. Possibly you should run this in a catch statement so it can
> ignore any errors and I would tend to use the 'auto_execok' command to
> ensure that osascript actually exists. Something like
> 
>   set arg [format {tell application......}]
>   catch {exec {*}[auto_execok osascript] -e $arg [pid]}
> 
> but possibly this is guaranteed to exist on all macs which would make
> the above redundant. What I'm thinking is you dont want the app to
> exit just because something goes wrong in this call.

I don't think we need auto_execok here, as osascript is available on
every Mac system. We might even specify the exact path, it's always
/usr/bin/osascript. Is that preferable?

I agree that "catch" might be a good idea though. It raises two
questions though:

1) Should we make the same change in gitk then? It already has the same
   code without the catch (released in 1.8.3 already, btw).

2) Should we think about some way of sharing code between gitk and
   git gui, so that these kinds of changes don't have to be made twice?


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
