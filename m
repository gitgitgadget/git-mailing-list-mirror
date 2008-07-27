From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCHv2] git-mv: Keep moved index entries inact
Date: Sun, 27 Jul 2008 15:41:42 +0200
Message-ID: <20080727134142.GA10151@machine.or.cz>
References: <20080721002354.GK10151@machine.or.cz> <20080721002508.26773.92277.stgit@localhost> <7v8wvpm9cl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 27 15:42:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KN6WN-0003LI-J4
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 15:42:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbYG0Nlq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 09:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbYG0Nlq
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 09:41:46 -0400
Received: from w241.dkm.cz ([62.24.88.241]:60859 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751863AbYG0Nlp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 09:41:45 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 06489393BAB4; Sun, 27 Jul 2008 15:41:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v8wvpm9cl.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90334>

On Fri, Jul 25, 2008 at 11:46:02PM -0700, Junio C Hamano wrote:
> Thanks.  I think I've managed to fix the rename_index_entry_at() in a
> satisfactory way, and also made builtin-mv to allow "mv -f symlink file"
> and "mv -f file symlink".

Oh, sorry, I didn't realize there were still problems with the original
one, I would try it on my own in that case.

> So my take on the above test piece is that after:
> 
> 	>moved
> 	mkdir dir
>         >dir/file
>         ln -s dir symlink
> 	git add moved dir symlink
> 
> This should fail, as it is an overwrite:
> 
> 	git mv moved symlink
> 
> and with "-f", the command should simply remove symlink and replace it
> with a regular file whose contents come from the original "moved".
> 
> IOW, what a symlink points at should not matter.

You convinced me, yes. (Especially since I started actually using
symlinks in some of my projects very recently and this would be the
exact semantic I would eventually expect as well.)

-- 
				Petr "Pasky" Baudis
As in certain cults it is possible to kill a process if you know
its true name.  -- Ken Thompson and Dennis M. Ritchie
