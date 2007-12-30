From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH WIP] sha1-lookup: make selection of 'middle' less
 aggressive
Date: Sun, 30 Dec 2007 11:58:02 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0712301150120.32517@woody.linux-foundation.org>
References: <7vd4soa3cw.fsf@gitster.siamese.dyndns.org> <7vtzm08l9w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 30 20:58:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J94JD-0006vQ-Qb
	for gcvg-git-2@gmane.org; Sun, 30 Dec 2007 20:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753756AbXL3T62 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2007 14:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753751AbXL3T62
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Dec 2007 14:58:28 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:32953 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753609AbXL3T62 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Dec 2007 14:58:28 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBUJw3qm004209
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 30 Dec 2007 11:58:04 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBUJw2IU020923;
	Sun, 30 Dec 2007 11:58:03 -0800
In-Reply-To: <7vtzm08l9w.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.489 required=5 tests=AWL,BAYES_00,INFO_TLD,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69378>



On Sun, 30 Dec 2007, Junio C Hamano wrote:
> 
> With this patch, we actually see slight improvements in
> execution time as well.  In the same partial kde repository
> (3.0GB pack, 95MB idx; the numbers are from the same machine as
> before, best of 5 runs):

Ok, I tried this a year ago, and never got any real improvement. And mine 
was buggy. See

	http://marc.info/?l=git&m=117537594112450&w=2

and I decided it wasn't worth it. Yours looks much better, and seems to 
get a real performance improvement, so go for it, but I doubt that the 
actual object lookup is really ever the main issue. I've never seen it 
stand out in the real profiles, although if it is able to cut down on IO 
(and your minor fault numbers are promising!), it might be more important 
than I'd otherwise think.

		Linus
