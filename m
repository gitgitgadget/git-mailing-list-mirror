From: Tomas Mraz <t8m@centrum.cz>
Subject: Re: [Gnu-arch-users] Re: [GNU-arch-dev] [ANNOUNCEMENT] /Arch/
	embraces `git'
Date: Thu, 21 Apr 2005 12:21:16 +0200
Message-ID: <1114078877.5886.37.camel@perun.redhat.usu>
References: <200504201000.DAA04988@emf.net> <877jixfjxw.fsf@star.lifl.fr>
	 <1114036849.5880.61.camel@perun.redhat.usu> <86d5soa42h.fsf@speedy.lifl.fr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: gnu-arch-dev@lists.seyza.com, talli@museatech.net,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 12:17:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOYkI-0005D2-F5
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 12:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVDUKV2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 06:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVDUKV2
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 06:21:28 -0400
Received: from admin.kkcable.cz ([213.29.14.23]:49851 "EHLO admin.kkcable.cz")
	by vger.kernel.org with ESMTP id S261243AbVDUKVT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 06:21:19 -0400
Received: by admin.kkcable.cz (Postfix, from userid 1007)
	id 0C6D060735; Thu, 21 Apr 2005 12:21:19 +0200 (CEST)
Received: from admin.kkcable.cz (admin.kkcable.cz [213.29.14.23])
	by admin.kkcable.cz (Postfix) with SMTP id 39E0B60659;
	Thu, 21 Apr 2005 12:21:18 +0200 (CEST)
To: Denys Duchier <duchier@ps.uni-sb.de>
In-Reply-To: <86d5soa42h.fsf@speedy.lifl.fr>
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2005-04-21 at 11:09 +0200, Denys Duchier wrote:
> Tomas Mraz <t8m@centrum.cz> writes:
> 
> > If we suppose the maximum number of stored blobs in the order of milions
> > probably the optimal indexing would be 1 level [0:2] indexing or 2
> > levels [0:1] [2:3]. However it would be necessary to do some
> > benchmarking first before setting this to stone.
> 
> As I have suggested in a previous message, it is trivial to implement adaptive
> indexing: there is no need to hardwire a specific indexing scheme.  Furthermore,
> I suspect that the optimal size of subkeys may well depend on the filesystem.
> My experiments seem to indicate that subkeys of length 2 achieve an excellent
> compromise between discriminatory power and disk footprint on ext2.
> 
> Btw, if, as you indicate above, you do believe that a 1 level indexing should
> use [0:2], then it doesn't make much sense to me to also suggest that a 2 level
> indexing should use [0:1] as primary subkey :-)

Why do you think so? IMHO we should always target a similar number of
files/subdirectories in a directories of the blob archive. So If I
always suppose that the archive would contain at most 16 millions of
files then the possible indexing schemes are either 1 level with key
length 3 (each directory would contain ~4096 files) or 2 level with key
length 2 (each directory would contain ~256 files).
Which one is better could be of course filesystem and hardware
dependent.

Of course it might be best to allow adaptive indexing but I think that
first some benchmarking should be made and it's possible that some fixed
scheme could be chosen as optimal.

-- 
Tomas Mraz <t8m@centrum.cz>

