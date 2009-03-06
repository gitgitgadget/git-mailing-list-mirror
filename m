From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/3] bash completion: fix completion issues with fetch,
	pull, and push
Date: Fri, 6 Mar 2009 07:58:14 -0800
Message-ID: <20090306155814.GG16213@spearce.org>
References: <cover.1236314073.git.jaysoffian@gmail.com> <07bd381f7984117681504ce57c1f6c40aecafed3.1236314073.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 17:00:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfcT3-0000sX-Mt
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 17:00:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755651AbZCFP6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 10:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754753AbZCFP6R
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 10:58:17 -0500
Received: from george.spearce.org ([209.20.77.23]:33133 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753846AbZCFP6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 10:58:16 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id D144538211; Fri,  6 Mar 2009 15:58:14 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <07bd381f7984117681504ce57c1f6c40aecafed3.1236314073.git.jaysoffian@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112454>

Jay Soffian <jaysoffian@gmail.com> wrote:
> Sverre Rabbelier noticed a completion issue with push:
> 
>  $ git push ori<tab>
>  git push origin
> 
>  $ git push -f ori<tab>
>  git push -f origin/
> 
> Markus Heidelberg pointed out that the issue extends to fetch and pull.
> 
> The reason is that the current code naively assumes that if
> COMP_CWORD=2, it should complete a remote name, otherwise it should
> complete a refspec. This assumption fails if there are any --options.
> 
> This patch fixes that issue by instead scanning COMP_CWORDS to see if
> the remote has been completed yet (we now assume the first non-dashed
> argument is the remote). The new logic is factored into a function,
> shared by fetch, pull, and push.
> 
> The new function also properly handles '.' as the remote.
> 
> Signed-off-by: Jay Soffian <jaysoffian@gmail.com>

Acked-by: Shawn O. Pearce <spearce@spearce.org>


> ---
>  contrib/completion/git-completion.bash |  109 +++++++++++++++++--------------
>  1 files changed, 60 insertions(+), 49 deletions(-)

-- 
Shawn.
