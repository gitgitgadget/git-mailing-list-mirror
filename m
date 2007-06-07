From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] [RFC] Generational repacking
Date: Thu, 07 Jun 2007 09:38:30 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0706070932000.12885@xanadu.home>
References: <11811281053874-git-send-email-sam.vilain@catalyst.net.nz>
 <56b7f5510706061704r34692c49v994ff368bbc12d05@mail.gmail.com>
 <46676D44.7070703@vilain.net>
 <alpine.LFD.0.99.0706062314410.12885@xanadu.home> <466793EB.2060102@vilain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Thu Jun 07 15:38:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwICR-0001Ru-H0
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 15:38:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752790AbXFGNip (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 09:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755347AbXFGNip
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 09:38:45 -0400
Received: from relais.videotron.ca ([24.201.245.36]:59913 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752790AbXFGNio (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 09:38:44 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JJ900GM6PW8JQA0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 07 Jun 2007 09:38:32 -0400 (EDT)
In-reply-to: <466793EB.2060102@vilain.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49368>

On Thu, 7 Jun 2007, Sam Vilain wrote:

> Nicolas Pitre wrote:
> >>   2. repack takes too long to run very regularly; it's an occasional
> >>      command.
> > It doesn't take long at all when you don't use -a.
> 
> Well that depends how many loose objects there are :)  I heard about on
> Windows a case where packing 30k loose objects took over an hour.

And your patch cannot change anything to that, right?
You shouldn't wait until 30k loose objects accumulate before repacking.

> >> What I'm aiming for is something which is light enough that it might
> >> even win back the performance loss you got from 1), and to solve the
> >> perception problem of 3).
> > 
> > Run git-repack without -a from some hook.  You can even launch it in the 
> > background.
> > 
> > Or what am I missing?
> 
> If you repack every 100 objects without -a, sure it will be fast, but
> you'll end up with too many packs.

You just need to adjust this treshold of 100 objects.

And latest GIT behaves _much_ better with lots of packs, almost like if 
there was only one pack.  See the test results I posted to the list.


Nicolas
