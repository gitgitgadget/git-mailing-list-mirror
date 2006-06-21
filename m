From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: packs and trees
Date: Tue, 20 Jun 2006 20:54:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606202046290.5498@g5.osdl.org>
References: <9e4733910606192257y1516e966t848a3b1e29e5667f@mail.gmail.com> 
 <46a038f90606192313l16b16132r1523f5e05ae1566a@mail.gmail.com> 
 <Pine.LNX.4.64.0606201102410.3377@localhost.localdomain>
 <46a038f90606201241x3dec242dicde245a24c3ab9ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Jon Smirl <jonsmirl@gmail.com>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 21 05:54:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FstnF-0000GI-Vb
	for gcvg-git@gmane.org; Wed, 21 Jun 2006 05:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWFUDyP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 23:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbWFUDyP
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 23:54:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42175 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750806AbWFUDyO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jun 2006 23:54:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5L3s2gt020990
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 20 Jun 2006 20:54:03 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5L3s1D0007470;
	Tue, 20 Jun 2006 20:54:02 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90606201241x3dec242dicde245a24c3ab9ab@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.77__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22235>



On Wed, 21 Jun 2006, Martin Langhoff wrote:
> 
> If you are asking about the ext3 performance problems, I think Linus
> discussed that a while ago, why unpacked repos are slow (in addition
> to huge), and there were some suggestions of using hashed directory
> indexes.

Yes. I think most distros still default to nonhashed directories, but for 
any large-directory case you really want to turn on hashing. 

I forget the exact details, it's somethng like

	tune2fs -O dir_index

or something to turn it on (if I remember correctly, that will only affect 
any directories then created after that, but you can effect that by just 
doing a "git repack -a -d" which will remove all old object directories, 
and now subsequent directories will be done with indexing on).

Personally, I just ended up using packs extensively, so I think I'm still 
running without indexing on all my machines ;)

		Linus
