From: David Kastrup <dak@gnu.org>
Subject: Re: Empty directories...
Date: Wed, 18 Jul 2007 07:56:03 +0200
Message-ID: <85d4yqz24s.fsf@lola.goethe.zz>
References: <85lkdezi08.fsf@lola.goethe.zz>
	<7v8x9ea1rg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 07:56:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IB2WF-0001xv-P5
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 07:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbXGRF4L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 01:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751740AbXGRF4J
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 01:56:09 -0400
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:39573 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751389AbXGRF4H (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jul 2007 01:56:07 -0400
Received: from mail-in-13-z2.arcor-online.net (mail-in-13-z2.arcor-online.net [151.189.8.30])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id B75652D485E;
	Wed, 18 Jul 2007 07:56:05 +0200 (CEST)
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net [151.189.21.48])
	by mail-in-13-z2.arcor-online.net (Postfix) with ESMTP id A07391B8E02;
	Wed, 18 Jul 2007 07:56:05 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-042-236.pools.arcor-ip.net [84.61.42.236])
	by mail-in-08.arcor-online.net (Postfix) with ESMTP id 843A9332661;
	Wed, 18 Jul 2007 07:56:04 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id B4B671C3ACCE; Wed, 18 Jul 2007 07:56:03 +0200 (CEST)
In-Reply-To: <7v8x9ea1rg.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Tue\, 17 Jul 2007 19\:23\:15 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3690/Wed Jul 18 05:08:02 2007 on mail-in-08.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52828>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> or has somebody a better idea or interface or rationale?  I understand
>> that there are use cases where one does not bother about empty
>> directories, but for a _content_ tracker, not tracking directories
>> because they are empty seems quite serious.
>
> No objections as long as a patch is cleanly made without
> regression.  It's just nobody agreed that it is "quite serious"
> yet so far, and no fundamental reason against it.

Thanks.  It certainly is not serious for the Linux kernel source, but
seems awkward for quite a few situations.  Anyway, what is your take
on the situation I described?

That creating some directory hierarchy (happening to contain empty
directories) with some external program, adding and committing it,
then switching to a different branch (or maybe doing a git-reset
--hard) leaves a skeleton of empty directories around?

I find this almost worse than not being able to put them into the
repository: you can't get rid of them anymore either!

I'd be tempted to propose that git should remove empty subdirectories
when cleaning up a removed tree in the working directory, even though
that violates the principle to not delete anything it isn't tracking.
But since you can't get it to track the stuff in the first place...

But the real fix would be to track them.

Does some trick work possibly at checkin time, like putting an empty
file into every empty directory, adding to the index, then removing
all empty files explicitly from the index and then checking in, or is
this hopeless to work around with from the user side without affecting
the repository itself?

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
