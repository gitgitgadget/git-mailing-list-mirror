From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 30 Jun 2008 15:51:47 -0700
Message-ID: <20080630155147.009a24b7.akpm@linux-foundation.org>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
	<7vbq4j748l.fsf@gitster.siamese.dyndns.org>
	<7vr6d8apjx.fsf@gitster.siamese.dyndns.org>
	<7vhcdyfe9u.fsf@gitster.siamese.dyndns.org>
	<7vabjm1a0q.fsf@gitster.siamese.dyndns.org>
	<7vr6crj0jk.fsf@gitster.siamese.dyndns.org>
	<7vmyn4hr8f.fsf@gitster.siamese.dyndns.org>
	<7vmymsjz6x.fsf@gitster.siamese.dyndns.org>
	<7vabijxhk4.fsf@gitster.siamese.dyndns.org>
	<7vwslhg8qe.fsf@gitster.siamese.dyndns.org>
	<7vhccfiksy.fsf@gitster.siamese.dyndns.org>
	<7vod6k6zg4.fsf@gitster.siamese.dyndns.org>
	<7v4p7xwsfp.fsf@gitster.siamese.dyndns.org>
	<7v3anb19n7.fsf@gitster.siamese.dyndns.org>
	<7vwskjazql.fsf@gitster.siamese.dyndns.org>
	<7vk5ggipuw.fsf@gitster.siamese.dyndns.org>
	<7vej6l3lp7.fsf@gitster.siamese.dyndns.org>
	<7vod5kd3im.fsf@gitster.siamese.dyndns.org>
	<7v3amv1e8n.fsf@gitster.siamese.dyndns.org>
	<1214834970.3382.4.camel@gaara.bos.redhat.com>
	<7vabh2vaav.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: krh@redhat.com, git@vger.kernel.org, sfr@canb.auug.org.au,
	pasky@suse.cz
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 00:54:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDSGA-0007fp-1g
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 00:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763410AbYF3WxN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 18:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763327AbYF3WxM
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 18:53:12 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37763 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762986AbYF3WxL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jun 2008 18:53:11 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5UMpmJI030890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 30 Jun 2008 15:51:49 -0700
Received: from akpm.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m5UMplUh029726;
	Mon, 30 Jun 2008 15:51:47 -0700
In-Reply-To: <7vabh2vaav.fsf@gitster.siamese.dyndns.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
X-Spam-Status: No, hits=-2.823 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86958>

On Mon, 30 Jun 2008 15:15:52 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Some people rely on (or at least "like") the convenience of being able to
> create a single-liner file in .git/branches/ to easily add, and remove
> such a file to easily remove where they integrate from.  This is
> especially so when they have dozens of source repositories to fetch from.
> I do not think we want to remove support for .git/branches as a way to
> specify fetch sources (this is why I am CC'ing Andrew who I know uses
> branches, and Stephen who is also a heavy integrator even though I do not
> know if he is in branches camp or uses more modern style), but they now
> have to do an extra "mkdir .git/branches" after "git init" to continue
> their workflow if we adopt the change you are proposing here.  It is not a
> big deal, but it still is a backward incompatible change.

I do find the more compact format of .git/branches/git-foo to be
convenient.  For example, my scripts go looking in there for the URL
and add that to the patch changelog so that people can reconstruct -mm's
git-foo.patch from the relevant git tree.

That being said,

- It wouldn't bother me to have to type `mkdir .git/branches' after
  `git init'!

- It's bad to have the same info in two places, and to have to
  support two different ways of doing the same thing for ever.  So I
  could understand a wish to remove .git/branches/ support completely. 
  I'll cope :)

  For me the biggest part of migrating would be working out what on
  earth the format of the new files is.  Maybe it's documented
  somewhere undiscoverable, dunno.
