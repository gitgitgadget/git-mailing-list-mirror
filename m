From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Be more careful about updating refs
Date: Tue, 15 Jan 2008 16:02:22 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801151600140.2806@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0801151546560.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 01:03:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEvkl-0005bZ-PH
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 01:03:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbYAPADH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 19:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751589AbYAPADG
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 19:03:06 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:45198 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751379AbYAPADD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jan 2008 19:03:03 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0G02NCw031587
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 15 Jan 2008 16:02:24 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0G02MHo010352;
	Tue, 15 Jan 2008 16:02:23 -0800
In-Reply-To: <alpine.LFD.1.00.0801151546560.2806@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.719 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70579>



On Tue, 15 Jan 2008, Linus Torvalds wrote:
> 
> This makes write_ref_sha1() more careful: it actually checks the SHA1 of 
> the ref it is updating, and refuses to update a ref with an object that it 
> cannot find.

Side note: this breaks some tests, because those tests do things like

	git update-ref refs/heads/master 1111111111111111111111111111111111111111 &&
		test 1111111111111111111111111111111111111111 = $(cat .git/refs/heads/master)

which obviously won't work. I didn't update the tests, because I'm an evil 
person who just finds it very onerous to touch tests, and I particularly 
hate tests that turn out to be wrong.

(Pet peeve on mine: people fixing assert()'s by changing the source-code, 
without ever asking themselves whether maybe the assert itself was the 
bug).

		Linus
