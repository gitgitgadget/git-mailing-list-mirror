From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [test failure] Re: t4114 binary file becomes symlink
Date: Sat, 18 Jul 2009 16:18:45 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907181612390.13838@localhost.localdomain>
References: <20090718134551.GC16708@vidovic> <20090718135649.GA6759@sigill.intra.peff.net> <20090718141658.GE16708@vidovic> <20090718153148.GA9367@sigill.intra.peff.net> <7veisd3k31.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 19 01:20:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSJCd-0005Z6-RY
	for gcvg-git-2@gmane.org; Sun, 19 Jul 2009 01:20:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753965AbZGRXT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2009 19:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753938AbZGRXT1
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jul 2009 19:19:27 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50765 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753915AbZGRXT0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jul 2009 19:19:26 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6INIkI7009209
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 18 Jul 2009 16:18:48 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6INIjTR020439;
	Sat, 18 Jul 2009 16:18:46 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7veisd3k31.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.964 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123542>



On Sat, 18 Jul 2009, Junio C Hamano wrote:
> 
> The unpack_trees() machinery places a special marker df_conflict_entry
> to signal that no blob exists at "foo", but it will become a directory
> that may have somthing underneath it, namely "foo/bar".
> 
> Passing that df_conflict_entry marker to merged_entry() happens to remove
> the "foo" in the end because the df_conflict_entry does not have any name
> (hence the "error" message) and its addition in add_index_entry() is
> rejected, but it is wrong.

Ack. This looks like a really old bug.

That whole 'df_conflict_entry' always confused me.

		Linus
