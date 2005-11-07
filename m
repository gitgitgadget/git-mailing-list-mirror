From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] merge-recursive: Only print relevant rename messages
Date: Mon, 07 Nov 2005 15:54:57 -0800
Message-ID: <7v64r4qai6.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>
	<Pine.LNX.4.64.0511070848440.3193@g5.osdl.org>
	<20051107231944.GA11327@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 08 00:57:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZGpL-0007lu-J5
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 00:55:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030200AbVKGXy7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Nov 2005 18:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030201AbVKGXy7
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Nov 2005 18:54:59 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:46538 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1030200AbVKGXy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2005 18:54:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051107235433.HUGG4527.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 7 Nov 2005 18:54:33 -0500
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20051107231944.GA11327@c165.ib.student.liu.se> (Fredrik
	Kuivinen's message of "Tue, 8 Nov 2005 00:19:44 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11294>

Fredrik Kuivinen <freku045@student.liu.se> writes:

> @@ -178,7 +181,7 @@ def mergeFile(oPath, oSha, oMode, aPath,
>              sha = bSha
>      else:
>          if aSha != oSha and bSha != oSha:
> -            merge = True
> +            merge = MERGE_TRIVIAL

The rest looks good to me, but are you sure about this part?  I
have a feeling that the above "and" should be "or", meaning, we
check to see if there is _any_ change, and default to TRIVIAL,
but later we would find that we need a real merge and then
promote it to MERGE_3WAY.
