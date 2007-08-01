From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] git-sh-setup.sh: make GIT_EDITOR/core.editor/VISUAL/EDITOR accept commands
Date: Thu, 02 Aug 2007 01:55:38 +0200
Message-ID: <85wswex11h.fsf@lola.goethe.zz>
References: <7v7iof3uc5.fsf@assigned-by-dhcp.cox.net>
	<S1752294AbXHAWCj/20070801220239Z+281@vger.kernel.org>
	<85ejimrjb2.fsf@lola.goethe.zz>
	<7vy7gu3kuh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 01:56:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGO3R-0004Bu-JV
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 01:56:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570AbXHAX4b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 19:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751618AbXHAX4b
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 19:56:31 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:35398 "EHLO
	mail-in-03.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751570AbXHAX4a (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Aug 2007 19:56:30 -0400
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net [151.189.8.13])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id 59B932CB347;
	Thu,  2 Aug 2007 01:56:29 +0200 (CEST)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id 47B8C12DE74;
	Thu,  2 Aug 2007 01:56:29 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-017-069.pools.arcor-ip.net [84.61.17.69])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 228BA36E86A;
	Thu,  2 Aug 2007 01:56:29 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 6CDDC1C3E076; Thu,  2 Aug 2007 01:55:38 +0200 (CEST)
In-Reply-To: <7vy7gu3kuh.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Wed\, 01 Aug 2007 16\:18\:14 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54501>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> David Kastrup <dak@gnu.org> writes:
>>
>>> The previous code only allowed specifying a single executable rather
>>> than a complete command like "emacsclient --alternate-editor vi" in
>>
>> Oops, won't apply cleanly.  I found that I had already made a
>> different (trivial) patch previously.  Let me try again and fold that
>> patch in manually.
>
> It is not just "won't apply".  What if GIT_DIR had spaces (which
> is fine) and single-quotes in it?  Wouldn't it percolate down to
> $@ because it becomes the leading directory of the temporary
> file name?  And you quote '"$@"' and eval it, now what happens?

The eval removes the outer single quotes and then evaluates the
remaining "$@" which leaves the original argument structure completely
intact: What got passed into git_editor as 3 arguments will remain as
3 arguments, and even multiple embedded spaces in one argument will
get preserved perfectly.

If you don't believe me, throw whatever you want at it.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
