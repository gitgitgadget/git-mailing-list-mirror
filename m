From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] rev-list: add "--full-objects" flag.
Date: Mon, 11 Jul 2005 20:21:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507112018560.17536@g5.osdl.org>
References: <20050703234629.GF13848@pasky.ji.cz> <42CBC822.30701@didntduck.org>
 <20050707144501.GG19781@pasky.ji.cz> <7vk6k2sfa4.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0507071158220.3293@g5.osdl.org> <20050707221443.GB7151@pasky.ji.cz>
 <Pine.LNX.4.58.0507071549330.25104@g5.osdl.org> <7vll4ifbq8.fsf_-_@assigned-by-dhcp.cox.net>
 <7vfyuqfa6r.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507071657140.25104@g5.osdl.org>
 <7vvf3mds9c.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507071841010.25104@g5.osdl.org>
 <7vy88ica8e.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507071928220.25104@g5.osdl.org>
 <m1pstrr8k1.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58.0507101517370.17536@g5.osdl.org>
 <m1irzh74m0.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58.0507110928070.17536@g5.osdl.org>
 <m13bqk26pp.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58.0507111810380.17536@g5.osdl.org>
 <m164v
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 12 05:24:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsBNG-0002Fw-9j
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 05:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262158AbVGLDXd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 23:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbVGLDVe
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 23:21:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18832 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262158AbVGLDVU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jul 2005 23:21:20 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6C3LDjA017215
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 11 Jul 2005 20:21:13 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6C3LCJp018812;
	Mon, 11 Jul 2005 20:21:12 -0700
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m164vg7nqo.fsf@ebiederm.dsl.xmission.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 11 Jul 2005, Eric W. Biederman wrote:
> 
> The question:
> Does git-upload-pack which gets it's list of objects
> with "git-rev-list --objects needed1 needed2 needed3 ^has1 ^has2 ^has3"
> get any history beyond the top of tree of each branch.  
> 
> As I read the code it does not.  

It does. It gets all the history necessary for each branch. git-rev-list
will walk the whole history until it hits commits that as been marked as
uninteresting (or the parents of commits that have been marked as
uninteresting), and those are the ones that the receiver already has, of
course.

So after you get a pack, you have all the history for all the branches you 
got.

A branch you _didn't_ get, you don't get any history for, of course, but 
that doesn't matter. You'll get that history if you ever pull the branch 
later.

			Linus
