From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Fix resource leaks in wrapper.c
Date: Tue, 27 Oct 2009 12:44:32 +0100
Message-ID: <4AE6DD20.6000308@drmicha.warpmail.net>
References: <1256615635-4940-1-git-send-email-djszapi@archlinux.us>	 <4AE69DA7.6030704@viscovery.net>	 <4AE6AEC8.4040800@drmicha.warpmail.net> <a362e8010910270335g106024e6if3f016c271ab55d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Laszlo Papp <djszapi2@gmail.com>, git@vger.kernel.org
To: Laszlo Papp <djszapi@archlinux.us>
X-From: git-owner@vger.kernel.org Tue Oct 27 12:44:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2kTj-0004V7-Do
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 12:44:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753918AbZJ0Lod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 07:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753915AbZJ0Lod
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 07:44:33 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:48060 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753659AbZJ0Loc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Oct 2009 07:44:32 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 05F82B8A54;
	Tue, 27 Oct 2009 07:44:36 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 27 Oct 2009 07:44:36 -0400
X-Sasl-enc: CiweoRgTgp7eSwtkTKnANbyzFLaCHoV/Ra/9gDQJUo2h 1256643876
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D56572CD677;
	Tue, 27 Oct 2009 07:44:35 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5pre) Gecko/20091027 Lightning/1.0pre Shredder/3.0pre
In-Reply-To: <a362e8010910270335g106024e6if3f016c271ab55d6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131327>

Laszlo Papp venit, vidit, dixit 27.10.2009 11:35:
> 
> 
> On Tue, Oct 27, 2009 at 9:26 AM, Michael J Gruber
> <git@drmicha.warpmail.net <mailto:git@drmicha.warpmail.net>> wrote:
> 
>     Johannes Sixt venit, vidit, dixit 27.10.2009 08:13:
>     > Laszlo Papp schrieb:
>     >> @@ -266,7 +266,7 @@ int odb_mkstemp(char *template, size_t limit,
>     const char *pattern)
>     >>      fd = mkstemp(template);
>     >>      if (0 <= fd)
>     >>              return fd;
>     >> -
>     >> +    close(fd);
>     >
>     > Sorry, where is here a resource leak? You are "closing" something
>     that was
>     > never opened because fd is less than zero.
>     >
>     > Ditto for the other case.
> 
>     I guess it's about silencing some challenged code analysis tool. I
>     recall that last time we had something like this we decided that coders
>     are smarter than tools... and also that clean up like this (for real
>     leaks) would be something for libgit.
> 
>     Michael
> 
> 
> Yeah you're rights guys, sorry for my fault, this cppcheck program is
> not the best at this momment, really sorry.

No need to feel overly sorry, but in general it helps if, in a commit
message or thereabout, you say something like "cppcheck found the
following (potential) errors".

Cheers,
Michael
