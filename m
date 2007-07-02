From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: being nice to patch(1)
Date: Mon, 2 Jul 2007 14:56:01 -0700
Message-ID: <20070702145601.a0dcef0f.akpm@linux-foundation.org>
References: <20070702125450.28228edd.akpm@linux-foundation.org>
	<alpine.LFD.0.98.0707021409510.9434@woody.linux-foundation.org>
	<20070702142557.eba61ccd.akpm@linux-foundation.org>
	<alpine.LFD.0.98.0707021436300.9434@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, quilt-dev@nongnu.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jul 02 23:56:33 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5Tsm-000358-NI
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 23:56:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755744AbXGBV4V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 17:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755716AbXGBV4V
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 17:56:21 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:55757 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755680AbXGBV4U (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Jul 2007 17:56:20 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l62Lu75u010027
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 2 Jul 2007 14:56:08 -0700
Received: from akpm.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id l62Lu1Ki013553;
	Mon, 2 Jul 2007 14:56:01 -0700
In-Reply-To: <alpine.LFD.0.98.0707021436300.9434@woody.linux-foundation.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
X-Spam-Status: No, hits=-2.712 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51413>

On Mon, 2 Jul 2007 14:40:36 -0700 (PDT)
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> 
> 
> On Mon, 2 Jul 2007, Andrew Morton wrote:
> > 
> > Thing is, changelog-followed-by-diff is a fairly standard format used by
> > quilt and other such toys.
> 
> Sure. And if a tool ends up eating the changelog as a diff, then that tool 
> is broken. I really do think that this is a "patch" bug - I really don't 
> think that that was a valid traditional diff with the four spaces at the 
> head of the line.
> 
> Of course, if the changelog-followed-by-diff doesn't have any indentation 
> or escaping at all, the changelog entry itself *could* actually have a 
> real unified diff in it, and the tool would be unable to tell where the 
> actual patch starts.

erk, yes, sometimes people do like to quote a hunk of diff in the changelog
and yes, hell doth break loose.

> But at least "git show" and friends indent the changelog on purpose, 
> exactly so that there is never any chance that there could be any real 
> ambiguity, and this really was a "patch" bug as far as I can tell. 
> Happily, one that is easy to work around, by just telling patch to always 
> consider the patch a unified diff.

I'm afraid indenting the changelog with leading spaces doesn't help -
patch(1) still tries to apply the diff.

I guess quilt-and-friends could (should) strip away all text prior to the
first ^--- before feeding to patch(1).  That would reliably remove all
git changelog text.
