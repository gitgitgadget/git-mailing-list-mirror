From: Matt Porter <mporter@kernel.crashing.org>
Subject: Re: cogito: linux-2.6 merge fails due to cg-rm
Date: Mon, 2 May 2005 10:20:34 -0700
Message-ID: <20050502102034.B21716@cox.net>
References: <20050502101250.A21716@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon May 02 19:23:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSedS-00031m-0b
	for gcvg-git@gmane.org; Mon, 02 May 2005 19:23:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbVEBRY2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 13:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVEBRXT
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 13:23:19 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:46061 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261461AbVEBRWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2005 13:22:25 -0400
Received: from liberty.homelinux.org ([68.2.41.86]) by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050502172224.NLWE7629.fed1rmmtao01.cox.net@liberty.homelinux.org>
          for <git@vger.kernel.org>; Mon, 2 May 2005 13:22:24 -0400
Received: (from mmporter@localhost)
	by liberty.homelinux.org (8.9.3/8.9.3/Debian 8.9.3-21) id KAA22107
	for git@vger.kernel.org; Mon, 2 May 2005 10:20:35 -0700
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050502101250.A21716@cox.net>; from mporter@kernel.crashing.org on Mon, May 02, 2005 at 10:12:50AM -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, May 02, 2005 at 10:12:50AM -0700, Matt Porter wrote:
> These kept showing up as "needs merged" even though I explicitly
> tried to cg-rm them or "update-cache --remove" them. It turns out
> that cg-rm is 'rm -f'ing the files before calling update-cache.
> By touching each file, and then modifying cg-rm as follows, I
> was able to complete the merge. I'm not sure yet if this is the
> proper fix to the cogito script. It at least made update-cache
> happy for this remove case.

Looking a bit further, I see the cg-Xmergefile also removes the
file before update-cache --remove which doesn't seem to work. This
seems to be the actual culprit during the merge, but cg-rm needed
fixed to manually fix without calling git commands directly.

-Matt
