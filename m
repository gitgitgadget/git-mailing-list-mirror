From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] pack-objects: re-validate data we copy from elsewhere.
Date: Sat, 2 Sep 2006 10:43:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609021041170.27779@g5.osdl.org>
References: <20060830015122.GE22935@spearce.org>
 <9e4733910608291958l45c0257dla6e5ebd4176f7164@mail.gmail.com>
 <20060830031029.GA23967@spearce.org> <Pine.LNX.4.64.0608300124550.9796@xanadu.home>
 <7vzmdmh2lu.fsf@assigned-by-dhcp.cox.net> <44F871BA.3070303@gmail.com>
 <Pine.LNX.4.64.0609011129270.27779@g5.osdl.org> <7vveo741tc.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0609011721390.27779@g5.osdl.org> <7vd5ae3ox2.fsf@assigned-by-dhcp.cox.net>
 <20060902045246.GB25146@spearce.org> <7vwt8m1u6b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 02 19:44:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJZXH-00052T-NC
	for gcvg-git@gmane.org; Sat, 02 Sep 2006 19:44:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbWIBRoA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Sep 2006 13:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWIBRoA
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Sep 2006 13:44:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63657 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751219AbWIBRn7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Sep 2006 13:43:59 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k82HhrnW006716
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 2 Sep 2006 10:43:53 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k82HhqoZ030260;
	Sat, 2 Sep 2006 10:43:52 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwt8m1u6b.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.46 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.146 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26347>



On Sat, 2 Sep 2006, Junio C Hamano wrote:
> 
> The Linus's theory goes like this:
> 
>  (1) A bit in an existing pack was damaged somehow.  It might have
>      happened on the mothership machine when it was first created,
>      or after it was read and copied to the notebook via rsync.

NOTE! With the new loose object format, this will be true even of 
individually packed files (if you set "core.legacyheaders" to false). So 
checking the SHA1 of the pack-files is insufficient - at least for those 
loose objects.

So revalidating the individual objects will catch that case too, while 
revalidating the SHA1 of the old pack-files won't.

		Linus

-- 
VGER BF report: U 0.5
