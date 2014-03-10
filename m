From: David Lang <david@lang.hm>
Subject: Re: [RFC/WIP] Pluggable reference backends
Date: Mon, 10 Mar 2014 09:28:10 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1403100923110.16215@nftneq.ynat.uz>
References: <531D9B50.5030404@alum.mit.edu> <CAJo=hJtiPgByhk9M4ZKD98DARzgeU6z2mmw7fcLTEbBza-_h6A@mail.gmail.com> <20140310155230.GA29801@sigill.intra.peff.net> <87k3c2820l.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>,
	Vicent Marti <tanoku@gmail.com>,
	Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Mar 10 17:28:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN34N-0007fO-TG
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 17:28:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753686AbaCJQ2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 12:28:47 -0400
Received: from mail.lang.hm ([64.81.33.126]:35991 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753378AbaCJQ2q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 12:28:46 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id s2AGSADq001545;
	Mon, 10 Mar 2014 08:28:11 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <87k3c2820l.fsf@fencepost.gnu.org>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243772>

On Mon, 10 Mar 2014, David Kastrup wrote:

> Jeff King <peff@peff.net> writes:
>
>> On Mon, Mar 10, 2014 at 07:30:45AM -0700, Shawn Pearce wrote:
>>
>>>> * Store references in a SQLite database, to get correct transaction
>>>>   handling.
>>>
>>> No to SQLLite in git-core. Using it from JGit requires building
>>> SQLLite and a JNI wrapper, which makes JGit significantly less
>>> portable. I know SQLLite is pretty amazing, but implementing
>>> compatibility with it from JGit will be a big nightmare for us.
>>
>> That seems like a poor reason not to implement a pluggable feature for
>> git-core. If we implement it, then a site using only git-core can take
>> advantage of it. Sites with JGit cannot, and would use a different
>> pluggable storage mechanism that's supported by both. But if we don't
>> implement, it hurts people using only git-core, and it does not help
>> sites using JGit at all.
>
> Of course, the basic premise for this feature is "let's assume that our
> file and/or operating system suck at providing file system functionality
> at file name granularity".  There have been two historically approaches
> to that problem that are not independent: a) use Linux b) kick Linus.

As a note, if this is done properly, it could allow for plugins that connect to 
the underlying storage system (similar to the Facebook Mecurial change)

Even for those who don't have the $$$$$ storage arrays, there may be other 
storage specific hacks that can be done to detect that files haven't changed.

For example, with btrfs and you compile into a different directory thatn your 
source, you may be able to detect that things didn't change by the fact that the 
filesystem didn't have to do a rewrite of the parent node.

David Lang
