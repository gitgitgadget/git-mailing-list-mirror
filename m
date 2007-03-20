From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git 1.5.1-rc1 doesn't like empty files
Date: Mon, 19 Mar 2007 22:41:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703192237100.6730@woody.linux-foundation.org>
References: <1174361424.3143.42.camel@dv>  <Pine.LNX.4.64.0703192148430.6730@woody.linux-foundation.org>
 <1174367312.3143.75.camel@dv>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Alexander Litvinov <litvinov2004@gmail.com>
To: Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Tue Mar 20 06:41:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTX63-00048u-Fy
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 06:41:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbXCTFlU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 01:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751551AbXCTFlU
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 01:41:20 -0400
Received: from smtp.osdl.org ([65.172.181.24]:47830 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750934AbXCTFlT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 01:41:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2K5fBcD024235
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Mar 2007 22:41:11 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2K5fAqR026856;
	Mon, 19 Mar 2007 21:41:10 -0800
In-Reply-To: <1174367312.3143.75.camel@dv>
X-Spam-Status: No, hits=-0.475 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42713>



On Tue, 20 Mar 2007, Pavel Roskin wrote:
> 
> .git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391 is the same 9
> bytes:  30 78 9c 03 00 00 00 00 01

Ahh.. You have

	[core]
		legacyheaders = false

don't you? If you didn't, you should see a 15-byte object, not a 9-byte 
one.

And yes, I can reproduce this with that "core.legacyheaders=false" 
setting. It seems that config option is simply broken, and we never 
noticed, because almost nobody uses it.

Alexander - do you happen to have that "legacyheaders" setting too? Maybe 
that explains your pack corruption?

		Linus
