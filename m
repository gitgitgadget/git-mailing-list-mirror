From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Creating objects manually and repack
Date: Fri, 4 Aug 2006 12:20:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608041218390.5167@g5.osdl.org>
References: <9e4733910608032043u689f431rc5408c6d89398142@mail.gmail.com>
 <Pine.LNX.4.64.0608032052210.4168@g5.osdl.org>
 <9e4733910608032124o5b5b69b5hda2eb8cb1e0ac959@mail.gmail.com>
 <Pine.LNX.4.64.0608032138330.4168@g5.osdl.org> <Pine.LNX.4.64.0608032150510.4168@g5.osdl.org>
 <9e4733910608040740x23a8b0cs3bc276ef9e6fb8f7@mail.gmail.com>
 <9e4733910608040750g3f72c07ct43f54347e47f25b4@mail.gmail.com>
 <Pine.LNX.4.64.0608040818270.5167@g5.osdl.org>
 <9e4733910608040841v7f4f27efra63e5ead2656e07@mail.gmail.com>
 <Pine.LNX.4.64.0608040945070.5167@g5.osdl.org>
 <9e4733910608041017v235da03ocd3eeeb0ba0e259b@mail.gmail.com>
 <Pine.LNX.4.64.0608041027530.5167@g5.osdl.org> <Pine.LNX.4.64.0608041052030.5167@g5.osdl.org>
 <7v64h8l5om.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 04 21:21:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G95Dz-0007CK-DC
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 21:20:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161376AbWHDTUo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 15:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161377AbWHDTUo
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 15:20:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46243 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161376AbWHDTUn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Aug 2006 15:20:43 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k74JKbnW006909
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 4 Aug 2006 12:20:38 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k74JKaAx011933;
	Fri, 4 Aug 2006 12:20:37 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64h8l5om.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.448 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.142 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24825>



On Fri, 4 Aug 2006, Junio C Hamano wrote:
> 
> That would only work *once*, because the resulting pack would
> now have blobs from two or more different files and you cannot
> tell them apart.

You don't care. You need to keep track of the blob names separately 
_anyway_: the pack information is not enough to re-create all the revision 
info.

So clearly, to create the tree and commit objects, the cvsimport really 
needs to keep track of the objects it has created, and what their 
relationship is, and it needs to do that separately. The pack-file just 
contains the contents, so that you only ever afterwards need to worry 
about the 20-byte SHA1, not the actual file itself.

> > To get a list of all object names in a pack-file, you'd basically do just
> > something like the appended.
> 
> git-show-index?

Yeah, that might be good.

		Linus
