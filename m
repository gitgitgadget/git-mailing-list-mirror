From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Decompression speed: zip vs lzo
Date: Thu, 10 Jan 2008 14:03:19 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801101400550.3148@woody.linux-foundation.org>
References: <e5bfff550801091401y753ea883p8d08b01f2b391147@mail.gmail.com> <7v4pdmfw27.fsf@gitster.siamese.dyndns.org> <47855765.9090001@vilain.net> <alpine.LSU.1.00.0801092328580.31053@racer.site> <47856E8D.4010006@vilain.net> <4785A6DB.3080007@vilain.net>
 <20080110091607.GA17944@artemis.madism.org> <alpine.LFD.1.00.0801101332150.3054@xanadu.home> <alpine.LFD.1.00.0801101252030.3148@woody.linux-foundation.org> <478691EB.1080704@vilain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Thu Jan 10 23:06:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JD5WX-0004Jh-Qw
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 23:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753848AbYAJWEu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 17:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753755AbYAJWEt
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 17:04:49 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:50534 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753245AbYAJWEt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jan 2008 17:04:49 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0AM3KWu030087
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 10 Jan 2008 14:03:21 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0AM3JHE011469;
	Thu, 10 Jan 2008 14:03:19 -0800
In-Reply-To: <478691EB.1080704@vilain.net>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.723 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70103>



On Fri, 11 Jan 2008, Sam Vilain wrote:
> 
> For reference, 20 years of Perl with very deep deltas:
> 
> wilber:~/src/perl-preview$ du -sk .git
> 73274   .git
> wilber:~/src/perl-preview$ git-repack -a
> Counting objects: 244360, done.
> Compressing objects: 100% (55493/55493), done.
> Writing objects: 100% (244360/244360), done.
> Total 244360 (delta 181061), reused 244360 (delta 181061)
> wilber:~/src/perl-preview$ du -sk .git/objects/pack/
> 75389   .git/objects/pack/

Hmm. I'm not sure I understand what this was supposed to show?

You reused all the old deltas, and you did "du -sk" on two different 
things before/after (and didn't do a "-a -d" to repack the old pack 
either). So does the result actually have anything to do with any 
compression algorithm?

Use "-a -d -f" to repack a whole archive.

			Linus
