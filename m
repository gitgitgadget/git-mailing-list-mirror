From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-diff-tree -M performance regression in 'next'
Date: Sun, 12 Mar 2006 17:31:39 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603121730310.3618@g5.osdl.org>
References: <20060311172818.GB32609@c165.ib.student.liu.se>
 <7voe0bdeyr.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0603120858230.3618@g5.osdl.org>
 <7vk6azcv9y.fsf@assigned-by-dhcp.cox.net> <7vwtezw4ye.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0603121700410.3618@g5.osdl.org> <Pine.LNX.4.64.0603121710110.3618@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 13 02:32:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIbuX-00085n-Jd
	for gcvg-git@gmane.org; Mon, 13 Mar 2006 02:31:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627AbWCMBbr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Mar 2006 20:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751880AbWCMBbr
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Mar 2006 20:31:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20874 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751643AbWCMBbq (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Mar 2006 20:31:46 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2D1VdDZ005339
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 12 Mar 2006 17:31:40 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2D1Vdqn021045;
	Sun, 12 Mar 2006 17:31:39 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0603121710110.3618@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17535>



On Sun, 12 Mar 2006, Linus Torvalds wrote:
>
> 	u64 value = *(u64 *)src;
> 	src += 8;
> 	hash = value % 4294967291u;

Btw, this assumes the "only hash every 8 bytes" at the source, in which 
case this is ok even on architectures that need aligned reads. For the 
non-aligned reads, you'd need your "shift the value" approach.

		Linus
