From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Don't define _XOPEN_SOURCE on MacOSX and FreeBSD as it is too restricting
Date: Fri, 22 Dec 2006 00:37:41 -0800
Message-ID: <7v4pro5nsa.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0612201524230.3576@woody.osdl.org>
	<caf068570612201636g75180138r223aef7c42f69a50@mail.gmail.com>
	<7vtzzq3wo6.fsf@assigned-by-dhcp.cox.net>
	<caf068570612201654s3949202cl55bd21307ca59453@mail.gmail.com>
	<7vodpy3vxi.fsf@assigned-by-dhcp.cox.net>
	<86vek6vyc7.fsf@blue.stonehenge.com>
	<caf068570612201735o776e01a8he2e9ab90fc2ee4f@mail.gmail.com>
	<20061221103938.GA7055@fiberbit.xs4all.nl>
	<20061221112835.GA7713@fiberbit.xs4all.nl>
	<7v64c492fv.fsf@assigned-by-dhcp.cox.net>
	<20061222075142.GA9595@fiberbit.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Terje Sten Bjerkseth <terje@bjerkseth.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Rocco Rutte <pdmef@gmx.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 09:37:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxfuU-0008A9-6n
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 09:37:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945958AbWLVIhn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 03:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945977AbWLVIhn
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 03:37:43 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:35783 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945958AbWLVIhm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 03:37:42 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061222083742.JLOL25875.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Fri, 22 Dec 2006 03:37:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1kcz1W0041kojtg0000000; Fri, 22 Dec 2006 03:37:00 -0500
To: Marco Roeland <marco.roeland@xs4all.nl>
In-Reply-To: <20061222075142.GA9595@fiberbit.xs4all.nl> (Marco Roeland's
	message of "Fri, 22 Dec 2006 08:51:42 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35146>

Marco Roeland <marco.roeland@xs4all.nl> writes:

> On Thursday December 21st 2006 at 16:52 Junio C Hamano wrote:
>
>> Personally, I think hiding interfaces such as strXXX and memXXX
>> based on _XOPEN_SOURCE level is already a bug in the system
>> header implementation.  The symbols that begin with str are
>> already reserved by the standard and I do not see any point
>> in the system headers to try avoiding namespace contamination.
>> 
>> But we are not in the business of fixing the system headers.
>
> ;-)
>
> Perhaps the idea behind this might be that it allows you to easier
> develop software that really only uses interfaces strictly defined in
> some "standards" to be always available on compliant platforms. That's
> all I could think of why you ever would want to do it like this yes.

(offtopic) Yeah, but my point was that ANSI C reserves _all_
symbols that begin with str ("Names reserved for expansion"),
not just a specific set of functions like strcmp, strcpy, etc.,
so if a program tries to be compliant with it, it cannot use,
for example, strncasecmp (was that the symbol we had trouble
with?)  for its own purpose anyway -- which means the system
header implementation should not have to worry about namespace
pollution.  I do not see any reason for them to hide
strncasecmp, for example.

> On Apple compiling git works fine both with and without
> _XOPEN_SOURCES_EXTENDED. But looking in the headers, in contrast to the
> _XOPEN_SOURCE define which restricts functionality to some predefined
> set, the _XOPEN_SOURCES_EXTENDED only adds functionality and doesn't
> remove it. So I thought it might be best to keep as much symbols as
> possible to be the same for all platforms for future expandibility.
>
> Probably FreeBSD behaves the same with respect to
> _XOPEN_SOURCE_EXTENDED. Will check later today.

Ok, thanks.
