From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git help stage" doesn't display git-stage man page
Date: Wed, 03 Dec 2008 00:14:36 -0800
Message-ID: <7vwsehfzf7.fsf@gitster.siamese.dyndns.org>
References: <7vvdu1hj41.fsf@gitster.siamese.dyndns.org>
 <87myfdn2ga.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Scott Chacon <schacon@gmail.com>
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Wed Dec 03 09:16:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7mu4-0001mJ-ND
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 09:16:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbYLCIOz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 03:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750845AbYLCIOz
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 03:14:55 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37040 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbYLCIOy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 03:14:54 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 13924833B1;
	Wed,  3 Dec 2008 03:14:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9952F833AD; Wed,
  3 Dec 2008 03:14:38 -0500 (EST)
In-Reply-To: <87myfdn2ga.fsf@iki.fi> (Teemu Likonen's message of "Wed, 03 Dec
 2008 09:27:17 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 75C8C620-C112-11DD-8DB2-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102224>

Teemu Likonen <tlikonen@iki.fi> writes:

> Junio C Hamano (2008-12-02 22:23 -0800) wrote:
>
>> * The 'master' branch has these since the last announcement
>>   in addition to the above.
>
>> Scott Chacon (1):
>>   Add a built-in alias for 'stage' to the 'add' command
>
> I think there's a minor user-interface defect:
>
>     $ git help stage
>     No manual entry for gitstage

The patch also breaks the promise made at 1.6.0 that prepending exec path
to $PATH allows you to use the dashed form.

	$ PATH=$(git --exec-path):$PATH
        $ git-stage -p
	xash: git-stage: cmd not found

> "git stage" is only a built-in alias but at some point it may become the
> primary staging command for new Git users and hence a kind of real Git
> command. I think "git help stage" should show the git-stage manual page
> (even though it only points to git-add(1)).

I do not think it would ever be _the_ primary command to add the contents
to the index; we are adding it as a training wheel.

When we had the "staging area" discussion, somehow people ended up with
this notion that you somehow *need to* use the same verb and noun.
I.e. "the index is now explained as the _staging area_.  Why isn't the
command to add contents to the staging area called git-stage?" was the
primary argument that lead to this thinking.

I do not think it adds much value to the system to be dogmatic and insist
that you _have to_ use the same verb and noun.  "You add your changes to
the staging area" is a perfectly natural way to explain what you are doing
and where the "add" in git-add command comes from.  It however is Ok to
allow people to use different spelling (i.e. the verb "stage").

In that sense, I think the intention of the patch to add "stage" as an
additional verb, while clearly marking it as a synonym to the primary
command "add", is aimed at the right place and strikes the right balance.

By the way, I think this should fix it, although it is very late and I
have no time to test it tonight myself.

---

 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git i/Makefile w/Makefile
index 9577d6f..5158197 100644
--- i/Makefile
+++ w/Makefile
@@ -320,6 +320,7 @@ BUILT_INS += git-merge-subtree$X
 BUILT_INS += git-peek-remote$X
 BUILT_INS += git-repo-config$X
 BUILT_INS += git-show$X
+BUILT_INS += git-stage$X
 BUILT_INS += git-status$X
 BUILT_INS += git-whatchanged$X
 
