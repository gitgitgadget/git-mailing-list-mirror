From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] checkout: fix attribute handling in checkout all
Date: Mon, 13 Aug 2007 13:12:49 -0700
Message-ID: <7vtzr3fb26.fsf@assigned-by-dhcp.cox.net>
References: <11869508753328-git-send-email-prohaska@zib.de>
	<118695087531-git-send-email-prohaska@zib.de>
	<7veji8ifs2.fsf@assigned-by-dhcp.cox.net>
	<7vfy2ogdvl.fsf@assigned-by-dhcp.cox.net>
	<86eji7lww5.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Aug 13 22:16:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKgHj-0004MX-27
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 22:13:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031813AbXHMUMz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Aug 2007 16:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031761AbXHMUMx
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 16:12:53 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:33808 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S943209AbXHMUMv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2007 16:12:51 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070813201251.YTMM325.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Mon, 13 Aug 2007 16:12:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id bYCp1X00U1kojtg0000000; Mon, 13 Aug 2007 16:12:50 -0400
In-Reply-To: <86eji7lww5.fsf@lola.quinscape.zz> (David Kastrup's message of
	"Mon, 13 Aug 2007 09:24:42 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55780>

David Kastrup <dak@gnu.org> writes:

>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>     $ git update-ref --no-deref HEAD $(git rev-parse v1.5.3-rc4^0)
>
> Is there a fundamental difference to using
>
> git-symbolic-ref HEAD $(git rev-parse v1.5.3-rc4^0)
>
> here?

The symbolic-ref command is about setting the HEAD to "point at
a(nother) ref".  There is no point talking about "fundamental
difference" here --- the latter is plain wrong, feeding
rev-parse output (which is an object name) as its second
parameter.

Did you mean to ask about the difference between "git-update-ref
HEAD $param" with or without --no-deref?

With --no-deref, it makes the HEAD detached even when HEAD is a
symref that points at a ref, e.g. "refs/heads/master".  Without
that option, it updates the ref that is pointed at by the HEAD
symref.
