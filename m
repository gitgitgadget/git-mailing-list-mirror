From: Junio C Hamano <junkio@cox.net>
Subject: Re: Numeric constants as strings
Date: Mon, 19 Feb 2007 01:49:44 -0800
Message-ID: <7vbqjq8ojr.fsf@assigned-by-dhcp.cox.net>
References: <200702190916.35813.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 19 10:50:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJ59w-0000sJ-B2
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 10:50:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbXBSJtq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 04:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbXBSJtq
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 04:49:46 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:36687 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbXBSJtp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 04:49:45 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070219094945.URON22948.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Mon, 19 Feb 2007 04:49:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id RMpk1W00e1kojtg0000000; Mon, 19 Feb 2007 04:49:45 -0500
In-Reply-To: <200702190916.35813.andyparkins@gmail.com> (Andy Parkins's
	message of "Mon, 19 Feb 2007 09:16:34 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40111>

Andy Parkins <andyparkins@gmail.com> writes:

> I'm working on bringing my hash width literals patch up to
> date now that 1.5.0 has passed.

I do not want to risk discouraging public discussion on this
topic, but I am not sure if this is really worth it.

It is not like if/when we find SHA-1 is inadequate we would just
switch to SHA-256 and redefine HASH_BYTES from 20 to 32 and be
done with it.  With the need for backward compatibility, we
would probably end up changing "unsigned char sha1[20]" to
something that allows us to tell which hash function's result we
are talking about, like:

	struct {
	       	enum { SHA_1, SHA_256 } type;
               	union {
                        unsigned char sha1[20];
                        unsigned char sha256[32];
		} u;
	};
