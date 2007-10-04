From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-init: don't base core.filemode on the ability to chmod.
Date: Thu, 04 Oct 2007 01:21:02 -0700
Message-ID: <7vir5nb89d.fsf@gitster.siamese.dyndns.org>
References: <20071003105501.GD7085@admingilde.org>
	<470388DC.4040504@viscovery.net>
	<20071003231941.GA20800@admingilde.org>
	<Pine.LNX.4.64.0710040053380.28395@racer.site>
	<470482A2.3080907@op5.se> <7vr6kbbdph.fsf@gitster.siamese.dyndns.org>
	<20071004071751.GD20800@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Thu Oct 04 10:21:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdLxR-0000kf-63
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 10:21:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752966AbXJDIVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 04:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752164AbXJDIVM
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 04:21:12 -0400
Received: from rune.pobox.com ([208.210.124.79]:37015 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752530AbXJDIVL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 04:21:11 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id C61B4141323;
	Thu,  4 Oct 2007 04:21:30 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id F131614182A;
	Thu,  4 Oct 2007 04:21:25 -0400 (EDT)
In-Reply-To: <20071004071751.GD20800@admingilde.org> (Martin Waitz's message
	of "Thu, 4 Oct 2007 09:17:51 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59928>

Martin Waitz <tali@admingilde.org> writes:

> hoi :)
>
> On Wed, Oct 03, 2007 at 11:23:22PM -0700, Junio C Hamano wrote:
>> filemode = !( (st1.st_mode & S_IXUSR)
>>         	/* we did not ask for x-bit -- bogus FS */
>> 	    || chmod(path, st1.st_mode & S_IXUSR)
>>         	/* it does not let us flip x-bit -- bogus FS */
>> 	    || lstat(path, &st2)
>>         	/* it does not let us read back -- bogus FS */
>> 	    || (st1.st_mode == st2.st_mode)
>> 	        /* it forgets we flipped -- bogus FS */
>> 	    );
>
> that looks good.

FWIW, I did not mean it to be an example for preferred
indentation nor code layout, but as a better way to explain what
the logic is computing.

I do not think git on Cygwin nor WinGit creates $GIT_DIR/config
with executable bit set.  Is this pretty much a workaround only
for vfat-on-Linux ?
