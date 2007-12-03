From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Incorrect git-blame result if I use full path to file
Date: Mon, 3 Dec 2007 10:13:51 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712031012280.8458@woody.linux-foundation.org>
References: <3665a1a00712021652tbdfe9d1tdc4575d225bfed36@mail.gmail.com> <7vhcj0seok.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.9999.0712030922250.8458@woody.linux-foundation.org> <Pine.LNX.4.64.0712031807410.27959@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Anatol Pomozov <anatol.pomozov@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 03 19:22:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzFw3-0000u2-QR
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 19:22:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbXLCSWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 13:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751552AbXLCSWF
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 13:22:05 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:48823 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751551AbXLCSWE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Dec 2007 13:22:04 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB3IDq0r012092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 3 Dec 2007 10:13:53 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB3IDpn4011496;
	Mon, 3 Dec 2007 10:13:52 -0800
In-Reply-To: <Pine.LNX.4.64.0712031807410.27959@racer.site>
X-Spam-Status: No, hits=-2.724 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66944>



On Mon, 3 Dec 2007, Johannes Schindelin wrote:
> 
> I have the slight suspicion that this could break diff --no-index.

Quite possible.

> And it does not contain any symlink resolution, right?

That's correct, and by design. If you give a path where the absolute part 
of the path contains some symlink that eventually gets you to the right 
point, you get screwed. That's part of why I'd _prefer_ to do the "die()" 
part, so that you get screwed with a nice error message, rather than being 
screwed by getting unexpected results!

			Linus
