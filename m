From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux 2.6.15-rc2
Date: Thu, 24 Nov 2005 11:57:20 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511241154340.13959@g5.osdl.org>
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org>
 <200511240737.59153.tomlins@cam.org> <4385BAFC.7070906@op5.se>
 <Pine.LNX.4.64.0511241037400.13959@g5.osdl.org> <7v4q61suhi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, Ed Tomlinson <tomlins@cam.org>,
	git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 24 20:58:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfNDr-0005wx-D0
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 20:57:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbVKXT5c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 14:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbVKXT5c
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 14:57:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62102 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751393AbVKXT5b (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Nov 2005 14:57:31 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAOJvLnO032700
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 24 Nov 2005 11:57:21 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAOJvK3H009107;
	Thu, 24 Nov 2005 11:57:20 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4q61suhi.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.56__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12714>



On Thu, 24 Nov 2005, Junio C Hamano wrote:
> 
> Performance perceived by cloners is helped by
> 
>     $ mkdir -p .git/pack-cache
>     $ git-rev-list --objects --all | git-pack-objects .git/pack-cache/pack

That really doesn't work very well. I push to that tree often several 
times a day, and you'd have to re-do the cache each time.

So it would be much better if git-pack-objects would just always cache its 
output in .git/pack-cache - along with some logic to just get rid of old 
ones regularly.

Since git-pack-objects has to generate the pack _anyway_, it might as well 
save it away when it does - so that if you have lots of people doing 
clones or pulling, you'd only need to run it once for a particular set of 
objects, and you'd not have to do any extra (or unnecessary) maintenance.

		Linus
