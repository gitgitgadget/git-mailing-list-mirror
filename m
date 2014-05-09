From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] How to keep a project's canonical history correct.
Date: Fri, 09 May 2014 14:05:44 -0700
Message-ID: <xmqqk39uwtlj.fsf@gitster.dls.corp.google.com>
References: <xmqq4n119wgk.fsf@gitster.dls.corp.google.com>
	<1399615721-566-1-git-send-email-ischis2@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Stephen P. Smith" <ischis2@cox.net>
X-From: git-owner@vger.kernel.org Fri May 09 23:05:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WirzR-0006HI-NY
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 23:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757714AbaEIVFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 17:05:52 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59640 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757463AbaEIVFt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 17:05:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8B3611715C;
	Fri,  9 May 2014 17:05:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=anfpBkiR1jr+981EndxjXrs79B0=; b=tTy7wx7fd9rbELnXqF/k
	+ayigJ/x2odwXNjAb0FT4DzVZ3mONYxSBzhp60veh4A5dlj8+JcrZNk68D0RgzCZ
	DOuyWzUHfW6bvOnAjHp0/HEr8sEfLVFb7TdGkrMjUufbD6c0NDG5Ucc7E+rIHV0T
	qMI3kw73ctgO2C0cakAqLoY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=KOgTqpzpEBY7eZwA6lN096FikOpZus4GCDvx1SBQTzCNKb
	IfoszE6lVZ86CZeg3bl2LjIuiFGiJpIxyGSSeM4ef3tjduBzxvC9JZ0WQ7lZOmZa
	jkAXZfhM4upaxiksIm0AdZk8NZLAnYtpem+VAespWdyAc6PAUtm45tuE07IGM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 805751715B;
	Fri,  9 May 2014 17:05:48 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BE3D417158;
	Fri,  9 May 2014 17:05:45 -0400 (EDT)
Importance: high
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B04D571C-D7BD-11E3-97B4-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248639>

"Stephen P. Smith" <ischis2@cox.net> writes:

> During the mail thread about "Pull is mostly evil" a user asked how
> the first parent could become reversed.
>
> This howto explains how the first parent can get reversed when viewed
> by the project and then explains a method to keep the history correct.
>
> Signed-off-by: Stephen P. Smith <ischis2@cox.net>
> ---

I needed a few tweaks on top while queuing.  You will find the
result on 'pu' after I push it out.

In addition to one typofix ("because" lacking "c"), here are what I
did:

 - Typeset concrete command e.g. `git pull` in monospace.

 - The second and subsequent paragraphs continued with "+" need to
   be flushed to the left; leaving them indented will format them in
   monospace (see "with `git pull --rebase` or something").

 - Be more explicit in describing 'trunk' being 'the first-parent
   chain' in the text.

 - Refer to a newer article that discusses this exact topic.

 - De-emphasize 'fix-bug-12345' in "Merge fix-bug-12345" log message.

 - Describe what the final history illustration shows.


Unless you have objections to the below (or suggestions for better
alternatives), there is no need to resend the patch.

Thanks.

diff --git a/Documentation/howto/keep-canonical-history-correct.txt b/Documentation/howto/keep-canonical-history-correct.txt
index 5979a79..35d48ef 100644
--- a/Documentation/howto/keep-canonical-history-correct.txt
+++ b/Documentation/howto/keep-canonical-history-correct.txt
@@ -38,12 +38,12 @@ central repository:
     ---o---o---A---X---Y---Z
 ------------
 
-Now, if you "git push" at this point, beause your history that leads
+Now, if you `git push` at this point, because your history that leads
 to `C` lacks `X`, `Y` and `Z`, it will fail.  You need to somehow make
 the tip of your history a descendant of `Z`.
 
 One suggested way to solve the problem is "fetch and then merge", aka
-"git pull". When you fetch, your repository will have a history like
+`git pull`. When you fetch, your repository will have a history like
 this:
 
 ------------
@@ -65,8 +65,9 @@ you will create a merge `M` and make the history look like this:
 repository.  Such a merge `M` does not lose any commit in both
 histories, so in that sense it may not be wrong, but when people want
 to talk about "the authoritative canonical history that is shared
-among the project participants", i.e. "the trunk", the way they often
-use is to do:
+among the project participants", i.e. "the trunk", they often view
+it as "commits you see by following the first-parent chain", and use
+this command to view it:
 
 ------------
     $ git log --first-parent
@@ -91,11 +92,11 @@ did `X` and then `Y` and then `Z` and merged a change that consists of
 two commits `B` and `C` that achieves a single goal.  You may have
 worked on fixing the bug #12345 with these two patches, and the merge
 `M'` with swapped parents can say in its log message "Merge
-'fix-bug-12345'". Having a way to tell "git pull" to create a merge
+fix-bug-12345". Having a way to tell `git pull` to create a merge
 but record the parents in reverse order may be a way to do so.
 
 Note that I said "achieves a single goal" above, because this is
-important.  "swapping the merge order" only covers a special case
+important.  "Swapping the merge order" only covers a special case
 where the project does not care too much about having unrelated
 things done on a single merge but cares a lot about first-parent
 chain.
@@ -111,7 +112,7 @@ There are multiple schools of thought about the "trunk" management.
     ---o---o---A---X---Y---Z---B---C
 ------------
 +
-    with `git pull --rebase` or something.
+with `git pull --rebase` or something.
 
  2. Some projects tolerate merges in their history, but do not worry
     too much about the first-parent order, and allow fast-forward
@@ -190,7 +191,7 @@ and push it back to the central repository.
 
 It is very much possible that while you are merging topic-b and
 topic-c, somebody again advanced the history in the central repository
-to put `W` on top of `Z`, and make your "git push" fail.
+to put `W` on top of `Z`, and make your `git push` fail.
 
 In such a case, you would rewind to discard `M` and `N`, update the
 tip of your 'master' again and redo the two merges:
@@ -202,6 +203,8 @@ tip of your 'master' again and redo the two merges:
     $ git merge topic-c
 ------------
 
+The procedure will result in a history that looks like this:
+
 ------------
 		 C0--C1--------------C2
 		/                     \
@@ -210,4 +213,4 @@ tip of your 'master' again and redo the two merges:
 		 B0--B1---------B2
 ------------
 
-See http://git-blame.blogspot.com/2012/03/fun-with-first-parent.html
+See also http://git-blame.blogspot.com/2013/09/fun-with-first-parent-history.html
