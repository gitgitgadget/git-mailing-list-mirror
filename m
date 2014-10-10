From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v4 0/3] Make 'git help everyday' work
Date: Fri, 10 Oct 2014 22:25:34 +0100
Message-ID: <1412976337-2476-1-git-send-email-philipoakley@iee.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 10 23:25:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xchh6-0008Rh-LB
	for gcvg-git-2@plane.gmane.org; Fri, 10 Oct 2014 23:25:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755258AbaJJVZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2014 17:25:42 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:46070 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751670AbaJJVZl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Oct 2014 17:25:41 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AoEKAHBOOFRZ8YyOPGdsb2JhbABggw5TWII2hQeBd8Frh08EAoEGFwEBBQEBAQE4OYQDAQEEVyMYFAQBAWgKAwkOE4g2DL9uAQEBAQYCAR+PYgsGAVCEUgWEYoFLkA6EPoQAjU2DGId2PC+BBwgXgSQBAQE
X-IPAS-Result: AoEKAHBOOFRZ8YyOPGdsb2JhbABggw5TWII2hQeBd8Frh08EAoEGFwEBBQEBAQE4OYQDAQEEVyMYFAQBAWgKAwkOE4g2DL9uAQEBAQYCAR+PYgsGAVCEUgWEYoFLkA6EPoQAjU2DGId2PC+BBwgXgSQBAQE
X-IronPort-AV: E=Sophos;i="5.04,694,1406588400"; 
   d="scan'208";a="648230636"
Received: from host-89-241-140-142.as13285.net (HELO localhost) ([89.241.140.142])
  by out1.ip06ir2.opaltelecom.net with ESMTP; 10 Oct 2014 22:25:39 +0100
X-Mailer: git-send-email 1.9.4.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is hopefully the final revision of the patch...
and integrates Junio's comments. 

I've eye-balled the man page and web page results, and corrected a few quote / back tick
items to be more consistent.

Re: [PATCH v3 1/3] doc: modernise everyday.txt wording and format in man page style
From: "Junio C Hamano" <gitster@pobox.com>
Sent: Tuesday, September 30, 2014 12:24 AM
Subject: Re: [PATCH v3 1/3] doc: modernise everyday.txt wording and format in man page style
> Philip Oakley <philipoakley@iee.org> writes:
> 
>> @@ -45,7 +58,7 @@ following commands.
>>  
>>    * linkgit:git-rebase[1] to maintain topic branches.
>>  
>> -  * linkgit:git-tag[1] to mark known point.
>> +  * linkgit:git-tag[1] to mark a known point.
> 
> I really appreciate your attention to details here.
> 
>> +<10> review commit logs; other forms to limit output can be
>>  combined and include `--max-count=10` (show 10 commits),
>>  `--until=2005-12-10`, etc.
> 
> s/--max-count=//; perhaps?
I've shown both in the update, as it's a help guide. How does it look?

> 
>> @@ -131,27 +145,34 @@ Clone the upstream and work on it.  Feed changes to upstream.::
>>  ------------
>>  $ git clone git://git.kernel.org/pub/scm/.../torvalds/linux-2.6 my2.6
>>  $ cd my2.6
>> +$ git checkout -b mine master <1>
>> +$ edit/compile/test; git commit -a -s <2>
>> +$ git format-patch master <3>
>> +$ git send-email --to="person <email@example.com>" 00*.patch <4>
>> +$ git pull <5>
> 
> This may be found somewhat questionable by some people, as "mine"
> does not build on the master at origin.  Insert "git checkout master"
> before this step to cause <5> update the pristine copy of their
> master, perhaps?  That way, the next step
I'd misunderstood this initially (confusion as to build start point).
I've added the checkout with a comment, and renumber those following.

> 
>> +$ git log -p ORIG_HEAD.. arch/i386 include/asm-i386 <6>
> 
> starts making more sense.
> 
>> +$ git fetch --tags <11>
>> ...
>> +<11> from time to time, obtain official tags from the `origin`
>>  and store them under `.git/refs/tags/`.
> 
> I am not sure if "fetch --tags" still needs to be taught, especially
> in a "quick guide" document, because "fetch" has auto-followed
> relevant tags for a long time since the original version of this
> document was written.
Done - removed.

> 
>> +<3> arrange `git push` to push all local branches to
>> +their corresponding branch of the mothership machine.
>> +<4> push will stash all our work away on `remotes/satellite/*`
>> +remote-tracking branches on the mothership machine.  You could use this
>>  as a back-up method.
> 
> The original mentions "a back-up method", but a larger benefit of
> this kind of settings is that it lets you pretend that mothership
> "fetched" from you.
> 
> We may want to say "You can use this to pretend as if the origin,
> aka mothership, ran 'git fetch' from you, aka satellite".  This is
> especially true because the next step <5> is about how to integrate
> your work done on 'satellite' into 'mothership' that cannot fetch
> from 'satellite' (imagine satellite is behind a NAT and it can only
> ssh out to mothership but not the other way around).
Text updated to include those points.

> 
>> -Integrator[[Integrator]]
>> +Integrator[[INTEGRATOR]]
>>  ------------------------
>>  
>>  A fairly central person acting as the integrator in a group
>> @@ -213,6 +235,9 @@ project receives changes made by others, reviews and integrates
>>  them and publishes the result for others to use, using these
>>  commands in addition to the ones needed by participants.
>>  
>> +This section can also be applied to a git-request-pull workflow,
>> +or the GitHub (www.github.com) pull-request flow.
> 
> Clarify which end of that workflow this can be applied, perhaps?
> E.g. "... also be used by the person who responds to 'git
> request-pull' or pull-request on GitHub to integrate others' work
> into your history".
Sorted, as below.

> 
> 
>> @@ -225,23 +250,26 @@ commands in addition to the ones needed by participants.
>>  
>>    * linkgit:git-push[1] to publish the bleeding edge.
>>  
>> +  * linkgit:git-request-pull[1] to create a summary of changes
>> +    for your upstream to pull.
>> +
> 
> This new item looks somewhat out of place, doesn't it?  It is
> because this is a participant item, not an integrator item.
The bullet item moved to Participant, and the text there updated.
> 
> Yes, I know a sub-area lieutenant would request a pull by the
> top-level maintainer, but when you interact with your 'upstream',
> you are not acting as an integrator.
> 
> If you really want to add request-pull to common 20-or-so commands,
> it would make more sense to do so in the participant's section and
> to explain that an sub-area lieutenant acts both as a participant
> and as an integrator.
Added text in line with your comment.

> 
> Thanks.

--

Philip Oakley (3):
  doc: modernise everyday.txt wording and format in man page style
  doc: Makefile regularise OBSOLETE_HTML list building
  Make 'git help everyday' work

 Documentation/Makefile             |   6 +-
 Documentation/everyday.txt         | 413 ---------------------------------
 Documentation/everyday.txto        |   9 +
 Documentation/git-push.txt         |   2 +-
 Documentation/git.txt              |   4 +-
 Documentation/gitcore-tutorial.txt |   2 +-
 Documentation/gitcvs-migration.txt |   2 +-
 Documentation/giteveryday.txt      | 455 +++++++++++++++++++++++++++++++++++++
 Documentation/gitglossary.txt      |   2 +-
 Documentation/gittutorial-2.txt    |   4 +-
 Documentation/gittutorial.txt      |   4 +-
 README                             |   2 +-
 builtin/help.c                     |   1 +
 13 files changed, 480 insertions(+), 426 deletions(-)
 delete mode 100644 Documentation/everyday.txt
 create mode 100644 Documentation/everyday.txto
 create mode 100644 Documentation/giteveryday.txt

-- 
1.9.4.msysgit.0
