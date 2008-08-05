From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Not going beyond symbolic links
Date: Mon, 4 Aug 2008 18:43:13 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808041839130.3299@nehalem.linux-foundation.org>
References: <20080721002354.GK10151@machine.or.cz> <20080721002508.26773.92277.stgit@localhost> <7v8wvpm9cl.fsf@gitster.siamese.dyndns.org> <7vej5543v5.fsf_-_@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0808041719380.3299@nehalem.linux-foundation.org>
 <7v8wvc2seh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 03:44:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQBbP-0002Bt-I9
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 03:44:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758847AbYHEBn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 21:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758650AbYHEBnZ
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 21:43:25 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55623 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758866AbYHEBnY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Aug 2008 21:43:24 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m751hE5G018966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 4 Aug 2008 18:43:15 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m751hD0i010677;
	Mon, 4 Aug 2008 18:43:14 -0700
In-Reply-To: <7v8wvc2seh.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.413 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91402>



On Mon, 4 Aug 2008, Junio C Hamano wrote:
> >
> > The rewritten 'has_symlink_leading_path()' should do ok, but it migth 
> > still be a huge performance downside to check all the paths for things 
> > like "git add -u".
> 
> Not yet.
> 
> I think this is a necessary "correctness" thing to do regardless of the
> performance impact, and adding the logic to stop at submodule boundary
> (aka gitlinks) should come before optimization.

Well, "performance" is a feature too, and it's not correct to say that "X 
should be fixed before optimization". If "X" slows things down, the 
question should be whether it really needs fixing..

Yes, we find symlinks when we do _new_ files, but is it really so bad to 
assume that existing directories that we have already added to the index 
are stable? It can easily be seen as a feature too that you can force git 
to ignore the symlink and see it as a real directory.

So that's why it would be interesting to hear about the performance 
impact. Because this is definitely not a black-and-white "one behavior is 
wrong and one behavior is right".

			Linus
