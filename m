From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/2] Fix "git diff" setup code
Date: Fri, 14 Sep 2007 12:46:51 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0709141238290.16478@woody.linux-foundation.org>
References: <20070905234941.GA643@nomad.office.altlinux.org>
 <20070906022539.GG18160@spearce.org> <20070906101648.GD6665@basalt.office.altlinux.org>
 <20070909044648.GH18160@spearce.org> <7vir6fjmuv.fsf@gitster.siamese.dyndns.org>
 <20070913035137.GM3099@spearce.org> <7vr6l2gxyw.fsf@gitster.siamese.dyndns.org>
 <20070914000108.GE3619@basalt.office.altlinux.org> <7vr6l2f6k1.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.999.0709131850060.16478@woody.linux-foundation.org>
 <20070914024303.GH3619@basalt.office.altlinux.org>
 <alpine.LFD.0.999.0709132123570.16478@woody.linux-foundation.org>
 <alpine.LFD.0.999.0709141002360.16478@woody.linux-foundation.org>
 <alpine.LFD.0.999.0709141014130.16478@woody.linux-foundation.org>
 <7v4phxaz3o.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.999.0709141129451.16478@woody.linux-foundation.org>
 <7vodg59i4x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: "Dmitry V. Levin" <ldv@altlinux.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 14 21:47:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWH8A-0006YW-LK
	for gcvg-git-2@gmane.org; Fri, 14 Sep 2007 21:47:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756129AbXINTrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2007 15:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753284AbXINTrG
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 15:47:06 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:36319 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752736AbXINTrF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Sep 2007 15:47:05 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l8EJki7g020649
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 14 Sep 2007 12:46:45 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l8EJkhkD021394;
	Fri, 14 Sep 2007 12:46:44 -0700
In-Reply-To: <7vodg59i4x.fsf@gitster.siamese.dyndns.org>
X-Spam-Status: No, hits=-3.239 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.34__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58183>



On Fri, 14 Sep 2007, Junio C Hamano wrote:
> 
> Sorry, my explanation only explains about missing setup_done()
> when --no-index is used, but does not explain _if_ you actually
> found that setup_done() was not called for you when you did a
> real life test.  Was it only from code inspection, or did you
> hit a case where setup_done() is not run?

Hmm. Mea culpa. What seems to have happened is that I ran things under 
gdb, and noticed that the default rename_limit hadn't been correctly set: 
but now that I look more at it, that particular session was probably from 
"git runstatus", not "git diff".

So yeah, ignore my 1/2. It was almost certainly based on a bogus debugging 
session, before I noticed that wt-status.c doesn't use the normal diff 
stuff at all..

			Linus
