From: Petr Baudis <pasky@suse.cz>
Subject: Re: Merging submodules
Date: Mon, 4 Aug 2008 15:40:53 +0200
Message-ID: <20080804134053.GK10151@machine.or.cz>
References: <20080731130626.GQ32184@machine.or.cz> <20080731170123.79e0d3e9@pc09.procura.nl> <8aa486160807310824h25c9630dxc25b156e80fcdb29@mail.gmail.com> <20080731201530.067be667@pc09.procura.nl> <8aa486160807311203o3fb4deb8u4a5ae57818c76fab@mail.gmail.com> <20080801090422.55c6a45f@pc09.procura.nl> <8aa486160808010252j540a28cdw6e48027396da5248@mail.gmail.com> <20080801123523.33c37e08@pc09.procura.nl> <8aa486160808010434g7f3c187arc107b994e737cd74@mail.gmail.com> <20080804152443.4418b3e0@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Santi =?iso-8859-2?Q?B=E9jar?= <sbejar@gmail.com>,
	Brian Gernhardt <benji@silverinsanity.com>,
	Git List <git@vger.kernel.org>,
	Lars Noschinski <lars-2008-1@usenet.noschinski.de>
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Mon Aug 04 15:42:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQ0K0-0007Xv-JM
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 15:42:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597AbYHDNk4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 09:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752090AbYHDNk4
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 09:40:56 -0400
Received: from w241.dkm.cz ([62.24.88.241]:58710 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751810AbYHDNkz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 09:40:55 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 34036393B489; Mon,  4 Aug 2008 15:40:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080804152443.4418b3e0@pc09.procura.nl>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91350>

On Mon, Aug 04, 2008 at 03:24:43PM +0200, H.Merijn Brand wrote:
> I do have to work with the repo, and that is more important than having
> a perfect repo.

You might consider adopting a (relatively?) common strategy when
importing historical projects: Actually start the history from scratch
(git init && git add . && git commit -m"Initial commit") and fine-tune
your historical import in a separate repository. Then, provide a script
that people interested in the old history can run and it will graft the
imported history to your pure-git history.

Conceptually, it should be pretty simple:

	git fetch git://perl-company.nl/sccs-import.git
	echo initial_git_commit_sha1 last_imported_commit_sha1 \
		>>$(git rev-parse --git-dir)/info/grafts

Example of a fine-tuned script:

	http://repo.or.cz/w/elinks.git?a=blob;f=contrib/grafthistory.sh

If you find out that the import is not perfect later on, you can just
redo it, refetch and rewrite the info/grafts line.

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
