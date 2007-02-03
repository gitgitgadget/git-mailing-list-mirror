From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Use "-f" when adding files with odd names in t9200.
Date: Sat, 03 Feb 2007 11:42:11 -0800
Message-ID: <7v4pq358q4.fsf@assigned-by-dhcp.cox.net>
References: <1AAD2384-C52D-4D60-A948-4F14C9515B53@silverinsanity.com>
	<20070203181329.GA10192@179.242.249.10.in-addr.arpa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Sat Feb 03 20:42:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDQm7-0003aQ-LZ
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 20:42:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbXBCTmO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 14:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbXBCTmO
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 14:42:14 -0500
Received: from fed1rmmtai14.cox.net ([68.230.241.45]:52313 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751384AbXBCTmN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 14:42:13 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070203194212.URKU4586.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sat, 3 Feb 2007 14:42:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id K7iC1W00K1kojtg0000000; Sat, 03 Feb 2007 14:42:12 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38590>

Brian Gernhardt <benji@silverinsanity.com> writes:

> Without -f, the UTF-8 named files are ignored (supposedly via
> .gitignore) on systems with a different UTF-8 encoding.
> This patch makes the test pass on OS X on HFS+, in particular.
>
> Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
> ---
>  
>  I still think that the behavior of git-add here is an error.  The file
>  is NOT in any ignore file and so should not be marked as such.

Can you describe why git-add finds the (presumably mangled by
HFS) path in ".gitignore"?  If we had some default pattern in
info/exclude that is installed in the trash test repository I
would understand that a mangled path could happen to match it,
but I do not think we do not have any exclude pattern by
default.

Unless/until you know why git-add thinks it is ignored,...

>  However,
>  this allows me to finally use "make test && sudo make install".

... I think this change means you are installing something the
existing test knows to be broken, which is not very pretty.
