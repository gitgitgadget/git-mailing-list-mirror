From: Marcel Partap <mpartap@gmx.net>
Subject: Re: Git ~unusable on slow lines :,'C
Date: Tue, 09 Oct 2012 19:19:05 +0200
Message-ID: <50745C89.7060707@gmx.net>
References: <50731B2A.6040104@gmx.net> <87lifgct3j.fsf@centaur.cmartin.tk> <50742F53.3050205@gmx.net> <CAJo=hJv+CtEcGFPhe2xPsfrPmdfOuakMovbk8-cJmFjOnwKWnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 09 19:19:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLdSp-0002Af-AH
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 19:19:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334Ab2JIRTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 13:19:17 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:42832 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755196Ab2JIRTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 13:19:16 -0400
Received: (qmail invoked by alias); 09 Oct 2012 17:19:13 -0000
Received: from unknown (EHLO [10.46.63.113]) [82.113.121.113]
  by mail.gmx.net (mp002) with SMTP; 09 Oct 2012 19:19:13 +0200
X-Authenticated: #724076
X-Provags-ID: V01U2FsdGVkX18RHFRuZBYRsBWSeJkE5ejkg2lbKJvkTFhP7lSsHr
	KU8Xn7JIFX76VF
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:13.0) Gecko/20120615 Thunderbird/13.0.1
In-Reply-To: <CAJo=hJv+CtEcGFPhe2xPsfrPmdfOuakMovbk8-cJmFjOnwKWnQ@mail.gmail.com>
X-Enigmail-Version: 1.4.1
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207329>

>>>> - git fetch should show the total amount of data it is about to
>>>> transfer!
>>> It can't, because it doesn't know.
>> The server side doesn't know at how much the objects *it just repacked
>> for transfer* weigh in?
> Actually it does.
Then, please, make it display it.

> What value is that to you?
The size that is to be transferred, and the total repository size.

> You asked for the repository. If you know its size is going to be ~105
> MiB you have two choices... continue to get the repository you asked
> for, or disconnect and give up.
> Either way the size doesn't help you.
Yes it does - when displayed, one could make an informed choice.
But it doesn't show this, just the object count.. and that is of low
expressiveness.
It so happened last week that I tried cloning a repository with a
seemingly moderate amount of objects and small code base. However, full
Java RE zips had been checked in and updated multiple times - suddenly
my monthly 3G traffic limit was exhausted. Needless to say without a
clue how much more data would follow, I aborted the transfer - and was
left with a net result of *zilch* bytes of code, and a line cut down to
ridiculous speed. Now I can't even sync up my Drupal copy.

> It would require a protocol modification to send a size estimate down
> to the client before the data in order to give the client a better
> progress meter than the object count (allowing it instead to track by
> bytes received).
Well, if it requires that, so be it. I fail to understand why this
wasn't considered before.

> But this has been seen as not very useful or worthwhile
> since it doesn't really help anyone do anything better.
Huh?

> So why change the protocol?
Sanity? Usability of git with slow lines?


> Git assumes that once it has commit X, all versions
> that predate X are already on the local workstation.
And that's true for all my repositories, since none of them was cloned
--shallow.

> This is a fundamental assumption that the entire protocol relies on.
What about --shallow, --depth?

> It is not trivial to change.
Many changes for the better are not trivial. And still worth it.

> We have been through this many times on the mailing
> list, please search the archives for "resumable clone".
Ok - yet that probably doesn't invalidate all arguments in favor of it.

> they should [...] host these bundle files [...]
> and users can download and resume these
Thanks for the tip, I will forward it to the server administrators.
However, this does not help to handle the huge amount of commits to
fetch that pile up within a couple of months.

> This is currently the best way to support resumable clone.
I wasn't even mentioning that, but that'd be nice to have aswell^^...

> If bundles are made once per month or after each
> major release its usually a manageable delta.
While downloading bundle delta files definitely is a plausible solution
- isn't that quite far from user friendly?

> If it did show you, what would you do?
Not try to checkout a repository full of JRE zips blindfolded?

> Declare defeat before it even
> starts to download and give up and start a thread about how Git
> requires too much bandwidth?
Kindly ask the author to locally rewrite his history and recreate the
repository with *LINKS* to JRE zips instead?
Not for a second did I doubt the efficiency of git's packing and
compression algorithms! That's why I'm quite amazed about the shear
existence of these issues of not showing the repository size before
downloading (or, IIUC, *anywhere*) and a protocol that is incapable of
resuming or partly fetching a repository, even though it obviously
provides means of negotiation between server and client.. Just boggles
me that within 7+ years of development this hasn't been addressed
(disclaimer: I do not claim to grok the protocol - not wanting to put
blame on anyone here :).

> Have you tried to shallow clone the repository in question?
No - would it allow me to fuse the two repositories afterwards? That'd
actually be quite cool and a good idea to instantly solve my current
problem... gonna try that, thx :)

#Regards!Marcel
