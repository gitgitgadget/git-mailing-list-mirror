From: Junio C Hamano <gitster@pobox.com>
Subject: Re: syntax for checking out specific tag on a remote
Date: Sat, 11 Aug 2007 19:01:28 -0700
Message-ID: <7vmywxjytj.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910708111833r6588557al1876bd6aaae38204@mail.gmail.com>
	<7v1we9leb9.fsf@assigned-by-dhcp.cox.net>
	<9e4733910708111850v6e9669c3i536fba49f63d0f10@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 12 04:01:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IK2lp-0005SZ-T9
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 04:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756249AbXHLCBa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 22:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756232AbXHLCBa
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 22:01:30 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:46572 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753934AbXHLCB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 22:01:29 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070812020128.NKBC7193.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sat, 11 Aug 2007 22:01:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id aq1U1X00a1kojtg0000000; Sat, 11 Aug 2007 22:01:29 -0400
In-Reply-To: <9e4733910708111850v6e9669c3i536fba49f63d0f10@mail.gmail.com>
	(Jon Smirl's message of "Sat, 11 Aug 2007 21:50:10 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55662>

"Jon Smirl" <jonsmirl@gmail.com> writes:

> On 8/11/07, Junio C Hamano <gitster@pobox.com> wrote:
>> "Jon Smirl" <jonsmirl@gmail.com> writes:
>>
>> > What's the syntax for checking out a specific tag on a remote?
>>
>> This depends on where you stored the tags you obtained from the
>> remote.  By default, "git fetch --tags" would store the tags in
>> a flat namespace; there is no "remote tag" namespace.
>
> I've been storing unrelated trees in the same git db. It never
> occurred to me that there was a single tag name space. So if two of my
> remotes both make a tag TEST then last one fetched will win? Are
> "remote tag" namespaces planned for the future?

There actually is no need to plan anything.

Typically people do not publish "private" tags to require such a
layout to differentiate tags from 47 different sources, so we
have never talked about this, but you can look into .git/config
file in your repository, and adjust [remote "foo"] fetch lines
to your specific taste.  e.g.

	[remote "a"]
        	fetch = +refs/heads/*:refs/remotes/a/*
                fetch = +refs/tags/*:refs/remote-tags/a/*

	[remote "b"]
        	fetch = +refs/heads/*:refs/remotes/b/*
                fetch = +refs/tags/*:refs/remote-tags/b/*
