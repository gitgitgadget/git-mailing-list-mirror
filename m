From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 0/4] diff text conversion filter
Date: Mon, 06 Oct 2008 08:29:10 +0200
Message-ID: <48E9B036.6090805@viscovery.net>
References: <1222567618-22156-1-git-send-email-Matthieu.Moy@imag.fr> <20080928041040.GA24214@coredump.intra.peff.net> <vpqd4io1tla.fsf@bauges.imag.fr> <20080928161106.GA30199@coredump.intra.peff.net> <vpqk5ctfyp6.fsf@bauges.imag.fr> <20080930164545.GA20305@sigill.intra.peff.net> <20081005214114.GA21875@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 06 08:30:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kmjc7-0006cP-6R
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 08:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752779AbYJFG3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 02:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752773AbYJFG3Q
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 02:29:16 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:6207 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752690AbYJFG3P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 02:29:15 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Kmjah-0006lz-F6; Mon, 06 Oct 2008 08:29:11 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 105C64FB; Mon,  6 Oct 2008 08:29:11 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20081005214114.GA21875@coredump.intra.peff.net>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97563>

Jeff King schrieb:
> On Tue, Sep 30, 2008 at 12:45:45PM -0400, Jeff King wrote:
> 
>> I am about 90% done cleaning it up for preparation (there is a bit of
>> refactoring, and I want to make sure I get that just right). I'll post
>> it in the next day or so.
> 
> Sorry, I didn't get a chance to look at this until today. Patch series
> will follow. It is still missing documentation updates and tests, but I
> wanted to get you something to look at (and as I am proposing a new
> meaning for "diff driver", I would be curious to hear the general
> comments).
> 
> This is on top of 'next', because it would otherwise conflict with the
> funcname pattern changes there.

Does the series in any way change whether plumbing and porcelain invoke
the external diff drivers? I have this particular use-case, which I'd like
that still works:

- In .git/info/attributes I have specified a diff driver:

    *.doc   diff=docdiff

  The driver runs a script that literally loads the two version of the
  file into MS Word and uses Word's diffing capability.

- git-gui should not use the diff driver. That is, plumbing should bypass
  the diff driver and say "Binary files differ". [*]

- Running 'git diff foo.doc', i.e. porcelain, from a command line should
  use the diff driver.

[*] I would not mind seeing a simplified textual diff in git-gui.

-- Hannes
