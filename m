From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Thu, 29 Nov 2007 14:36:15 -0800
Message-ID: <7vd4tsvfvk.fsf@gitster.siamese.dyndns.org>
References: <20071127150229.GA14859@laptop> <20071127160423.GA22807@laptop>
	<Pine.LNX.4.64.0711271617350.27959@racer.site>
	<20071128000731.GD9174@efreet.light.src>
	<7v8x4jb295.fsf@gitster.siamese.dyndns.org>
	<fcaeb9bf0711280036p33583824ge59af93bbe3f0a78@mail.gmail.com>
	<7vfxyq2c9b.fsf@gitster.siamese.dyndns.org>
	<fcaeb9bf0711281917p56cc4228m6c401286439e2a34@mail.gmail.com>
	<alpine.LFD.0.99999.0711290905510.9605@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Nov 29 23:37:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixs0N-0005Al-Sr
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 23:37:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760989AbXK2Wg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 17:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762589AbXK2Wg0
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 17:36:26 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:37067 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761678AbXK2WgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 17:36:25 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id C4BD12FB;
	Thu, 29 Nov 2007 17:36:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 24BA49B2A3;
	Thu, 29 Nov 2007 17:36:40 -0500 (EST)
In-Reply-To: <alpine.LFD.0.99999.0711290905510.9605@xanadu.home> (Nicolas
	Pitre's message of "Thu, 29 Nov 2007 09:09:42 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66567>

Nicolas Pitre <nico@cam.org> writes:

> On Thu, 29 Nov 2007, Nguyen Thai Ngoc Duy wrote:
>
>> There won't be a stage when only porcelain git-foos are in $(bindir)?
>> I could stop working on the relevant patch then.
>
> Well, I personally found your effort really nice.  I think Junio is 
> overly cautious in this case, and I would prefer to see the number of 
> git commands in the default path drop rather sooner than later.

I agree with the first sentence.  And yes I am playing it safe, and at
the same time I do not think the "default" really matters as much as
people think.

If people are really serious about reducing the number of commands in
the path, I would expect fixes and bugreports saying "I am setting
gitexecdir different from bindir in _my_ installation when I build git,
and here are the things that does not work if I do so".  Within the span
of more than 20 months (77cb17e9 introduced gitexecdir in Jan 2006), I
do not think there was a single such report or patch, other than the
message from Nguyen that started this thread.

Which means one of two things (1) we got everything right and there is
nothing to fix, other than changing the default like Nguyen's patch
does, or (2) nobody is interested in moving git-foo out of their PATH
for _his_ own use, but pushing changes that would affect _other_ people
without testing.

I am of course hoping that (1) is the case.  And it could be that in
open-source settings often the silent majority is content with what's
already there, and that many people who are indeed interested in moving
git-foo out of their PATH are doing so happily without telling the
others of their success.

But it still worries me.

And people's scripts, especially old/unmaintained ones that google still
knows about, are worrysome too.  Didn't we just see a message that says
"git-update-cache in a script I picked up from google does not work" on
the list?
