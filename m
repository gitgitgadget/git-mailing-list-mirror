From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Zero padded file modes...
Date: Thu, 05 Sep 2013 13:09:34 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309051302570.14472@syhkavp.arg>
References: <CAEBDL5W3DL0v=TusuB7Vg-4bWdAJh5d2Psc1N0Qe+KK3bZH3=Q@mail.gmail.com>
 <20130905153646.GA12372@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: John Szakmeister <john@szakmeister.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 05 19:09:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHd3r-0005kM-En
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 19:09:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752753Ab3IERJf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 13:09:35 -0400
Received: from relais.videotron.ca ([24.201.245.36]:61939 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704Ab3IERJf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 13:09:35 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSN007YLWZYA360@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Sep 2013 13:09:34 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id 2EF202DA0547; Thu, 05 Sep 2013 13:09:34 -0400 (EDT)
In-reply-to: <20130905153646.GA12372@sigill.intra.peff.net>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233970>

On Thu, 5 Sep 2013, Jeff King wrote:

> There are basically two solutions:
> 
>   1. Add a single-bit flag for "I am 0-padded in the real data". We
>      could probably even squeeze it into the same integer.
> 
>   2. Have a "classic" section of the pack that stores the raw object
>      bytes. For objects which do not match our expectations, store them
>      raw instead of in v4 format. They will not get the benefit of v4
>      optimizations, but if they are the minority of objects, that will
>      only end up with a slight slow-down.

That is basically what I just suggested.  But instead of a special 
section, simply using a special object type number would do it.

I'm even wondering if that couldn't be used for fixing a thin pack 
instead of the special provision I just added last night.


Nicolas
