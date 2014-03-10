From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC/WIP] Pluggable reference backends
Date: Mon, 10 Mar 2014 17:14:02 +0100
Message-ID: <87k3c2820l.fsf@fencepost.gnu.org>
References: <531D9B50.5030404@alum.mit.edu>
	<CAJo=hJtiPgByhk9M4ZKD98DARzgeU6z2mmw7fcLTEbBza-_h6A@mail.gmail.com>
	<20140310155230.GA29801@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Shawn Pearce <spearce@spearce.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>,
	Vicent Marti <tanoku@gmail.com>,
	Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 10 17:14:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN2qD-0001H1-EU
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 17:14:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753796AbaCJQOG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 12:14:06 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:40725 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753737AbaCJQOE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 12:14:04 -0400
Received: from localhost ([127.0.0.1]:39762 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WN2q2-0003N0-PC; Mon, 10 Mar 2014 12:14:03 -0400
Received: by lola (Postfix, from userid 1000)
	id 6C99AE047A; Mon, 10 Mar 2014 17:14:02 +0100 (CET)
In-Reply-To: <20140310155230.GA29801@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 10 Mar 2014 11:52:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243771>

Jeff King <peff@peff.net> writes:

> On Mon, Mar 10, 2014 at 07:30:45AM -0700, Shawn Pearce wrote:
>
>> > * Store references in a SQLite database, to get correct transaction
>> >   handling.
>> 
>> No to SQLLite in git-core. Using it from JGit requires building
>> SQLLite and a JNI wrapper, which makes JGit significantly less
>> portable. I know SQLLite is pretty amazing, but implementing
>> compatibility with it from JGit will be a big nightmare for us.
>
> That seems like a poor reason not to implement a pluggable feature for
> git-core. If we implement it, then a site using only git-core can take
> advantage of it. Sites with JGit cannot, and would use a different
> pluggable storage mechanism that's supported by both. But if we don't
> implement, it hurts people using only git-core, and it does not help
> sites using JGit at all.

Of course, the basic premise for this feature is "let's assume that our
file and/or operating system suck at providing file system functionality
at file name granularity".  There have been two historically approaches
to that problem that are not independent: a) use Linux b) kick Linus.

Option b) has been fairly successful over quite a bit of time, but at
the current point of time, it has become harder to aim that kick on a
single person and/or where it counts.

The database approach is an alternative approach based on kicking an
alternate set of people, namely database rather than operating system
providers, based on the assumption that the former have softer behinds
(the backend-based approach) making them more sensitive to kicking.

So the database approach is most promising on the "what are we going to
do if our operating system vendor won't bother with sensible file system
performance" angle.  Which isn't doing total system architecture a
favor.

Personally, I have little sympathy for helping subpar systems, keeping
them on life support while they are in turn trying to squish the better
systems.

But then it is not me doing the actual work, so this is no more than an
idle reflection.

-- 
David Kastrup
