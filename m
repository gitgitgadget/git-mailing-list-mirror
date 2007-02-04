From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Use "-f" when adding files with odd names in t9200.
Date: Sat, 03 Feb 2007 17:09:30 -0800
Message-ID: <7vr6t6zq2d.fsf@assigned-by-dhcp.cox.net>
References: <1AAD2384-C52D-4D60-A948-4F14C9515B53@silverinsanity.com>
	<20070203181329.GA10192@179.242.249.10.in-addr.arpa>
	<7v4pq358q4.fsf@assigned-by-dhcp.cox.net>
	<F16FE131-CF33-4DD0-9A06-4A24C59C7623@silverinsanity.com>
	<7vabzv3qxi.fsf@assigned-by-dhcp.cox.net>
	<A9623793-111E-47F7-9709-1D569333C40C@silverinsanity.com>
	<7vlkje243u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Sun Feb 04 02:09:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDVss-0006BQ-2S
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 02:09:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbXBDBJc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 20:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751689AbXBDBJc
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 20:09:32 -0500
Received: from fed1rmmtai16.cox.net ([68.230.241.43]:64496 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751632AbXBDBJb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 20:09:31 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070204010931.NDNV1349.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sat, 3 Feb 2007 20:09:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id KD9X1W0021kojtg0000000; Sat, 03 Feb 2007 20:09:31 -0500
In-Reply-To: <7vlkje243u.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 03 Feb 2007 15:50:13 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38628>

Junio C Hamano <junkio@cox.net> writes:

> ... I suspect that this sequence may not work as
> expected:
>
> 	#!/bin/sh
>
> 	pathname='a pathname that canonicalize differently from original'
> 	rm -fr testrepo
> 	mkdir testrepo
>         cd testrepo
>         git init-db
> 	echo hello >"$pathname"
>         git add -f .
>         git ls-files -s "$pathname"

Addendum.

This is not to make any point but purely for my own education,
but I wonder what would happen on HFS+ to the following
sequence, which does not involve any git operation:

   #!/bin/sh
   LANG=C LC_ALL=C
   export LANG LC_ALL

   pathname='a pathname that canonicalize differently from original'
   rm -fr testrepo
   mkdir testrepo
   cd testrepo
   echo hello >"$pathname"
   /bin/ls | fgrep -e "$pathname"

Doesn't the grep fail to find the file that was successfully
created in the previous step?
