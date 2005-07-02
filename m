From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Tags
Date: Sat, 02 Jul 2005 14:42:51 -0700
Message-ID: <42C70A5B.9070606@zytor.com>
References: <Pine.LNX.4.21.0506301403300.30848-100000@iabervon.org> <Pine.LNX.4.58.0506301302410.14331@ppc970.osdl.org> <42C454B2.6090307@zytor.com> <Pine.LNX.4.58.0506301344070.14331@ppc970.osdl.org> <42C462CD.9010909@zytor.com> <Pine.LNX.4.58.0506301432500.14331@ppc970.osdl.org> <42C46B86.8070006@zytor.com> <m13bqyk4uh.fsf_-_@ebiederm.dsl.xmission.com> <42C5714A.1020203@zytor.com> <m1u0jef8z9.fsf@ebiederm.dsl.xmission.com> <42C5C75F.4040100@zytor.com> <m1ll4qf7mg.fsf@ebiederm.dsl.xmission.com> <42C5DA77.4030107@zytor.com> <m1hdfdg0aa.fsf@ebiederm.dsl.xmission.com> <42C6D318.8050108@zytor.com> <m1k6k9drfk.fsf@ebiederm.dsl.xmission.com> <42C6D5AD.9070304@zytor.com> <m1fyuxdpq4.fsf@ebiederm.dsl.xmission.com> <42C7043C.9080904@zytor.com> <Pine.LNX.4.58.0507021432370.8247@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 02 23:43:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Doplv-00044R-45
	for gcvg-git@gmane.org; Sat, 02 Jul 2005 23:43:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbVGBVn2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jul 2005 17:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVGBVn2
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jul 2005 17:43:28 -0400
Received: from terminus.zytor.com ([209.128.68.124]:18636 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261287AbVGBVnV
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 2 Jul 2005 17:43:21 -0400
Received: from [172.27.0.18] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j62Lgpk4023461
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 2 Jul 2005 14:42:52 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507021432370.8247@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.85.1, clamav-milter version 0.85 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.0 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> Note that the fact that you use a common object store does not mean that 
> everything should be common.
> 
> I still contend that tags and branches and things like that should be 
> personal. A "gitforge" thing should _not_ try to unify tags. Instead, give 
> people their own private area for keeping their own private references 
> (you can limit it to just a few kilobytes per person, so you might as well 
> just consider it to be part of their "user information" thing along with 
> whatever other preferences they have).
> 
> Then, they call all share the objects, and there's never any confusion
> about tags - everybody has their own tags, and you add a few simple
> operations like "copy user xxx's tag to my tag-space, and start a new 
> branch from that".
> 
> There're really no downsides. The only thing you need to have is some nice
> tag-browser (and some simple permission model where developers can say
> "others can read my tag" or "this tag is visible only to me" - the object 
> store may be shared, but if nobody can see your pointers into the object 
> store, you effectively have a totally private branch - which might be 
> what some people want).
> 
> There's really never any reason to make tags global. Even in the case of
> the kernel, people don't want to see a tag like "v2.6.12". They want to
> see what _I_ tagged v2.6.12, so implicit in that whole thing is very much
> that they want to see _my_ tags. Again, it's a _browsing_ issue, not a
> "tags should be global" issue. They should be visible and easily 
> fetchable.
> 

OK, so let me retell what I think I hear you say:

- Store all the tags in the object store; they may conflict.
- Let each source user have a set of refs, and provide a method for the 
end user to select which refs to get.

In other words, the only way (other than knowing what GPG keys to trust) 
to distinguish between your "v2.6.12" and J. Random Hacker's "v2.6.12" 
is that the former is referenced by *your* refs as opposed to JRH's 
refs.  This also means the refs cannot be uniquely rebuilt from the 
object storage.

	-hpa
