From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: [PATCH 0/6] http-push updates
Date: Mon, 13 Mar 2006 16:28:15 -0800
Message-ID: <20060314002815.GJ3997@reactrix.com>
References: <20060311041749.GB3997@reactrix.com> <7vek16udg6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 14 01:28:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIxOk-0002sk-Jv
	for gcvg-git@gmane.org; Tue, 14 Mar 2006 01:28:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713AbWCNA2X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Mar 2006 19:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751715AbWCNA2X
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Mar 2006 19:28:23 -0500
Received: from 194.37.26.69.virtela.com ([69.26.37.194]:49310 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1751710AbWCNA2X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Mar 2006 19:28:23 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id k2E0SFU0023106;
	Mon, 13 Mar 2006 16:28:16 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id k2E0SFfC023104;
	Mon, 13 Mar 2006 16:28:15 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vek16udg6.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17579>

On Sun, Mar 12, 2006 at 09:21:45PM -0800, Junio C Hamano wrote:

> Repository maintenance tasks:
> 
>  - create a new repository
>  - remove an unneeded branch and tag
>  - running repack

In a DAV-only server environment, it seems like there are a few
options for supporting these tasks:

- extend http-push with additional args and/or local config settings.
  This approach would be more efficient wrt packs than separate
  push and repack steps since packs will all need to be created locally
  and then sent; a combined repack/push operation would mean that new
  objects will only be sent once as part of a pack.

- add DAV versions of git-init-db/git-branch/git-repack

- extend git-init-db/git-branch/git-repack to be DAV-aware

I like option #1.

>  - create new branch (and new tag) -- I think you can already do this

Right - you can create locally and then push that branch/tag or
--all/--tags.

>  - (perhaps) running update-server-info

http-push already updates info/refs if it existed before the push 
(perhaps that behavior should also be based on a local config setting.)
I would plan to add support for updating objects/info/packs along with
pack/repack support.  That should be all the server-info there is to
update, right?

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
