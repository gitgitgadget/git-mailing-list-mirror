From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add NEED_WORK_TREE for more commands
Date: Sat, 27 Oct 2007 13:42:16 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710271335190.4362@racer.site>
References: <20071027081910.GA23381@laptop>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1010463030-1193488936=:4362"
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 27 14:43:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ill0L-0002Z5-2c
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 14:43:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752706AbXJ0Mmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2007 08:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752586AbXJ0Mmx
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 08:42:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:47764 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752555AbXJ0Mmw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 08:42:52 -0400
Received: (qmail invoked by alias); 27 Oct 2007 12:42:50 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 27 Oct 2007 14:42:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/3gbEoMQ73WXciYDtx3Ot30mpO8nLqxgxo3vEI1I
	j/799gYAGvGBKe
X-X-Sender: gene099@racer.site
In-Reply-To: <20071027081910.GA23381@laptop>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62487>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1010463030-1193488936=:4362
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 27 Oct 2007, Nguyễn Thái Ngọc Duy wrote:

> +		{ "annotate", cmd_annotate, RUN_SETUP | NEED_WORK_TREE },
> +		{ "blame", cmd_blame, RUN_SETUP | NEED_WORK_TREE },

Both can be sensibly run without a work tree: "git blame <commit> <file>"

> +		{ "format-patch", cmd_format_patch, RUN_SETUP | NEED_WORK_TREE },

This can be run without work tree in any case, methinks.  AFAICT 
format-patch only ever uses information from the object database.

> +		{ "ls-files", cmd_ls_files, RUN_SETUP | NEED_WORK_TREE },

That has already been commented on.

> +		{ "reset", cmd_reset, RUN_SETUP | NEED_WORK_TREE },

"git reset --soft HEAD <commit>" makes sense in a bare repository.

> +		{ "update-index", cmd_update_index, RUN_SETUP | NEED_WORK_TREE },

That has been coommented on, too.

I agree that there are modes for these commands (except format-patch), in 
which they want a work-tree, but they have other modes, too, so IMHO it 
should be solved a la 6d9ba67b(Commands requiring a work tree must not run 
in GIT_DIR).  You'll see that ls-files already has some special handling 
here, and this could be refactorised to requires_work_tree(), which should 
make the code much more elegant.

Ciao,
Dscho

--8323584-1010463030-1193488936=:4362--
