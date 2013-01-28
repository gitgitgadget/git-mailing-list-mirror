From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH/RFC] mingw: rename WIN32 cpp macro to NATIVE_WINDOWS
Date: Mon, 28 Jan 2013 18:29:22 +0000
Message-ID: <5106C382.20009@ramsay1.demon.co.uk>
References: <50EB8EB5.6080204@gmail.com> <CALxABCYHRp17rcoOca1xWG9S19fq2rotz8FEKo09jNdrgMLiyQ@mail.gmail.com> <CALxABCavvW77djKQnbQsjCBcahmMfrP24SDz609NG-94_ifZ9Q@mail.gmail.com> <50F303D8.20709@gmail.com> <50F5A435.5090408@ramsay1.demon.co.uk> <20130120101007.GD16339@elie.Belkin> <50FEDB08.6030901@ramsay1.demon.co.uk> <51031C43.5030307@gmail.com> <7v38xo3irh.fsf@alter.siamese.dyndns.org> <51032481.4030707@redhat.com> <20130126010359.GH3341@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Eric Blake <eblake@redhat.com>, Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Stephen & Linda Smith <ischis2@cox.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 19:31:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TztTv-0002sr-6u
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 19:30:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977Ab3A1Sai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 13:30:38 -0500
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:52211 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938Ab3A1Sag (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 13:30:36 -0500
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 618D76F832C;
	Mon, 28 Jan 2013 18:30:34 +0000 (GMT)
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 93B6A6F812A;	Mon, 28 Jan 2013 18:30:33 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta010.tbr.inty.net (Postfix) with ESMTP;	Mon, 28 Jan 2013 18:30:31 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <20130126010359.GH3341@elie.Belkin>
X-MDF-HostID: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214849>

Jonathan Nieder wrote:
> Throughout git, it is assumed that the WIN32 preprocessor symbol is
> defined on native Windows setups (mingw and msvc) and not on Cygwin.
> On Cygwin, most of the time git can pretend this is just another Unix
> machine, and Windows-specific magic is generally counterproductive.
> 
> Unfortunately Cygwin *does* define the WIN32 symbol in some headers.
> Best to rely on a new git-specific symbol NATIVE_WINDOWS instead,
> defined as follows:
> 
> 	#if defined(WIN32) && !defined(__CYGWIN__)
> 	# define NATIVE_WINDOWS
> 	#endif
> 
> After this change, it should be possible to drop the
> CYGWIN_V15_WIN32API setting without any negative effect.
> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

If we go with this approach, could we prefix the symbol name with GIT_
in order to reduce the global namespace pollution?

eg GIT_NATIVE_WINDOWS, or GIT_NATIVE_WIN32 or just GIT_WIN32.
(Yeah, I'm not good at choosing names!)

ATB,
Ramsay Jones
