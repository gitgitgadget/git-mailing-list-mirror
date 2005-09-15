From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-diff-tree rename detection bug
Date: Thu, 15 Sep 2005 00:41:23 -0700
Message-ID: <7vek7qbwws.fsf@assigned-by-dhcp.cox.net>
References: <59a6e583050914094777c4fe96@mail.gmail.com>
	<7vwtljjzc3.fsf@assigned-by-dhcp.cox.net>
	<59a6e583050914114054b1564d@mail.gmail.com>
	<Pine.LNX.4.58.0509141321180.26803@g5.osdl.org>
	<17192.56103.803096.526568@cargo.ozlabs.ibm.com>
	<43290DA0.3030402@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Wayne Scott <wsc9tt@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 09:43:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFoNB-00041X-Lc
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 09:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030463AbVIOHla (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 03:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030468AbVIOHla
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 03:41:30 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:27598 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1030463AbVIOHl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2005 03:41:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050915074125.QPDY3588.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 15 Sep 2005 03:41:25 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43290DA0.3030402@zytor.com> (H. Peter Anvin's message of "Wed,
	14 Sep 2005 22:58:56 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8591>

"H. Peter Anvin" <hpa@zytor.com> writes:

> Paul Mackerras wrote:
>> I assume you're compiling git as 32-bit executables on your G5.  I
>> don't see any reason why the git binaries would need to be 64-bit.
>>
>
> Well, git seems to assume it can mmap() the entirety of any file under 
> its control, so a 64-bit git could handle larger files.
>
> Still, I'm using 32-bit git on ppc64.

Which is a valid thing to do because git also assumes that a
file offset fits within 32-bit as far as I know.  Each object in
a packfile should also fit in 32-bit offset and the size of one
packfile also needs to be within 32-bit offset.  I was unsure if
the last limitation would cause problems in the real life but we
will see in a couple of years ;-).
