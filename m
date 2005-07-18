From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] git-revover-tags-script
Date: Sun, 17 Jul 2005 18:19:42 -0600
Message-ID: <m1d5phnext.fsf@ebiederm.dsl.xmission.com>
References: <m1u0iuo63i.fsf@ebiederm.dsl.xmission.com>
	<7vr7dy9rw4.fsf@assigned-by-dhcp.cox.net>
	<m1psthomf0.fsf@ebiederm.dsl.xmission.com>
	<7voe91jmc6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 02:20:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DuJMt-0004jf-4l
	for gcvg-git@gmane.org; Mon, 18 Jul 2005 02:20:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbVGRAUA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jul 2005 20:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbVGRAUA
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jul 2005 20:20:00 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:10732 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261455AbVGRAT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2005 20:19:59 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j6I0JhHN003438;
	Sun, 17 Jul 2005 18:19:43 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j6I0JgZX003433;
	Sun, 17 Jul 2005 18:19:42 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7voe91jmc6.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sun, 17 Jul 2005 11:53:29 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> ebiederm@xmission.com (Eric W. Biederman) writes:
>
>> What we care about are the tag objects, those are the only kind
>> that are verifiable and usable remotely.  
>>
>> Now that I know we do not pull tags currently with any of the
>> optimized transports, I would suggest taking the list of commit
>> objects we are transporting and for each commit look in the
>> remote repo/refs/tags and transferring every tag object we can find
>> that refers to that commit.
>
> I think if we have discovery mechanism of remote tags/heads, we
> do not need anything else.  You _could_ say something like:
>
>     $ git-list-remote --tags linux-2.6
>     9e734775f7c22d2f89943ad6c745571f1930105f	v2.6.12-rc2
>     26791a8bcf0e6d33f43aef7682bdb555236d56de	v2.6.12
>     ...
>     a339981ec18d304f9efeb9ccf01b1f04302edf32	v2.6.13-rc3
>     $ git-list-remote --tags linux-2.6 |
>       while read sha1 tag;
>       do
>           git fetch linux-2.6 tag $tag
>       done

Actually looking a little deeper unless I have misread
the code git-fetch-pack at least will only ask for commit
objects so git fetch will never return a tag object.

I have yet to find where it git-fetch-pack actually prints
objects out so I still may be something.

Eric
