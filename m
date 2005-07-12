From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] rev-list: add "--full-objects" flag.
Date: Mon, 11 Jul 2005 21:39:15 -0600
Message-ID: <m1wtnw66cc.fsf@ebiederm.dsl.xmission.com>
References: <20050703234629.GF13848@pasky.ji.cz>
	<20050707144501.GG19781@pasky.ji.cz>
	<7vk6k2sfa4.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507071158220.3293@g5.osdl.org>
	<20050707221443.GB7151@pasky.ji.cz>
	<Pine.LNX.4.58.0507071549330.25104@g5.osdl.org>
	<7vll4ifbq8.fsf_-_@assigned-by-dhcp.cox.net>
	<7vfyuqfa6r.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507071657140.25104@g5.osdl.org>
	<7vvf3mds9c.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507071841010.25104@g5.osdl.org>
	<7vy88ica8e.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507071928220.25104@g5.osdl.org>
	<m1pstrr8k1.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0507101517370.17536@g5.osdl.org>
	<m1irzh74m0.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0507110928070.17536@g5.osdl.org>
	<m13bqk26pp.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0507111810380.17536@g5.osdl.org>
	<m164vg7nqo.fsf@ebiederm.dsl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 12 05:39:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsBcO-0003iq-QP
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 05:39:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbVGLDjc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 23:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbVGLDjc
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 23:39:32 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:9107 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262288AbVGLDja (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2005 23:39:30 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j6C3dGAu022357;
	Mon, 11 Jul 2005 21:39:16 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j6C3dFMQ022354;
	Mon, 11 Jul 2005 21:39:15 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507112018560.17536@g5.osdl.org> (Linus
 Torvalds's message of "Mon, 11 Jul 2005 20:21:12 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Mon, 11 Jul 2005, Eric W. Biederman wrote:
>> 
>> The question:
>> Does git-upload-pack which gets it's list of objects
>> with "git-rev-list --objects needed1 needed2 needed3 ^has1 ^has2 ^has3"
>> get any history beyond the top of tree of each branch.  
>> 
>> As I read the code it does not.  
>
> It does. It gets all the history necessary for each branch. git-rev-list
> will walk the whole history until it hits commits that as been marked as
> uninteresting (or the parents of commits that have been marked as
> uninteresting), and those are the ones that the receiver already has, of
> course.

Ok.  So the intention is sane then.

Looking closer it appears that commit_list_insert is recursive
and that is what I missed.

> So after you get a pack, you have all the history for all the branches you 
> got.
>
> A branch you _didn't_ get, you don't get any history for, of course, but 
> that doesn't matter. You'll get that history if you ever pull the branch 
> later.

Right.  Things work well if you have all of the history.


Eric
