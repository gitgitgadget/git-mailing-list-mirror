From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Fix memleak and the implementation of remove_file in
	builtin-rm.c
Date: Fri, 26 Sep 2008 08:28:23 -0700
Message-ID: <20080926152823.GA17470@spearce.org>
References: <87k5d1v71l.fsf@cup.kalibalik.dk> <20080925201245.GB3959@blimp.localhost> <20080925201734.GA18315@blimp.localhost> <20080925202237.GB18315@blimp.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 17:29:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjFG8-00021s-P4
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 17:29:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922AbYIZP2Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 11:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751903AbYIZP2Y
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 11:28:24 -0400
Received: from george.spearce.org ([209.20.77.23]:47321 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841AbYIZP2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 11:28:24 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 4CB3A38360; Fri, 26 Sep 2008 15:28:23 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080925202237.GB18315@blimp.localhost>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96869>

Alex Riesen <raa.lkml@gmail.com> wrote:
> It is the same as in merge-recursive, but they're so small so unless
> we get a special file with such random routines there is no much point
> exporting it. Actually, we do seem to have such a file: dir.c. It is
> already plagued by file_exists kind of things, why not remove_path...

Yea.  I'm thinking remove_path should migrate to dir.c.  Hell,
we already have rm -rf as remove_dir_recursively() in dir.c.
remove_path is its long-lost soul mate.  I'm not applying this
builtin-rm fix, and am hoping you'll rewrite it around a move
of remove_path to dir.c...  ;-)
 
> diff --git a/builtin-rm.c b/builtin-rm.c
> index fdac34f..910a34d 100644
> --- a/builtin-rm.c
> +++ b/builtin-rm.c
> @@ -31,22 +31,18 @@ static void add_list(const char *name)
>  
>  static int remove_file(const char *name)
>  {


-- 
Shawn.
