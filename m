From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH Second draft] Fast forward strategies allow, never, and only
Date: Tue, 18 Mar 2008 09:27:20 -0700 (PDT)
Message-ID: <m363vkvvzb.fsf@localhost.localdomain>
References: <402c10cd0803101959q619efa86pbd501e5e2cc018c2@mail.gmail.com>
	<402c10cd0803172127u480276c9s4f9d716b4912ad5e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Sverre Hvammen Johansen" <hvammen@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 20:42:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc4Ar-0002JK-3H
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 20:42:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755661AbYCSTcc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 15:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755658AbYCSTcc
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 15:32:32 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:33815 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755635AbYCSTc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 15:32:28 -0400
Received: by fk-out-0910.google.com with SMTP id 19so691362fkr.5
        for <git@vger.kernel.org>; Wed, 19 Mar 2008 12:32:26 -0700 (PDT)
Received: by 10.82.171.16 with SMTP id t16mr3290735bue.25.1205857642786;
        Tue, 18 Mar 2008 09:27:22 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.213.235])
        by mx.google.com with ESMTPS id l12sm21308798fgb.8.2008.03.18.09.27.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 18 Mar 2008 09:27:20 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m2IGRIBY024512;
	Tue, 18 Mar 2008 17:27:19 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m2IGR4dK024508;
	Tue, 18 Mar 2008 17:27:04 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <402c10cd0803172127u480276c9s4f9d716b4912ad5e@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77512>

"Sverre Hvammen Johansen" <hvammen@gmail.com> writes:

> New fast forward strategy "only" is introduced.  This new fast
> forward strategy prevents real merges.

I like this patch, and I think it can be useful.  You have added
explanation when each fast-forward option (strategy); very nice.

> FF strategy "only" fails if the specified heads and HEAD can not
> be reduced down to only one real parent.  The only allowed
> outcome is a fast forward unless HEAD is up to date with
> the specified heads.
> 
> This patch also uses the real heads found instead of those
> specified for real merges.  This means that merge startegies
> that only take two heads can now accept more than two heads
> if they can be reduced down to only two real heads.  However,
> fast-forward of head in combination with a real merge is
> handled as before.

But the difference between real heads and specified heads, and
reduction to one parent is not explained in commit message, nor in
documentation provided.

I'm not sure if this functionality shouldn't be separated into
another, separate patch... unless of course this follows cleaning up
the code.

I *GUESS* that if you do "git merge a b" and branches "a" and "b" both
point to the same commit, the merge (be it fast forward, forced merge,
or ordinary merge) is like you have specified "git merge a"... perhaps
with the only difference (but it is not specified) in the summary of
commit message (first line of commit message).

> See the documentation for further explanation of this feature.

Thanks.

The documentation is IMVHO in good enough state to be accepted into
git; it should be cleaned up a bit, and made better from the point of
writing style, but that I think can be done "in tree".  It is clean
enough to use, ebven if it could be better...

> diff --git a/Documentation/fast-forward-options.txt
> b/Documentation/fast-forward-options.txt

Word wrapped.

If you use mailer, please uncheck word wrap option. Best would be to
use git-send-email to send patches; on my private, single user Linux
machine I have configured sendmail to send emails through my GMail
account, I'm not sure if git-send-email support for SMTP sending is
enough...  

You should avoid sending from web interface, as it usually doesn't
have option to turn off word wrapping; additionally copy'n'paste can
turn tabs into spaces.  If you have to send patch from web interface,
send patch as attachement: "text/plain" (changing extension to *.txt
should help if web nterface tries to use "application/octet-stream"),
and if possible as "inline" attachement.

> new file mode 100644
> index 0000000..87fd0ae
> --- /dev/null
> +++ b/Documentation/fast-forward-options.txt
> @@ -0,0 +1,69 @@
> +FAST FORWARD OPTIONS
> +--------------------
> +
> +allow::
> +       Do not generate a merge commit if the merge resolved as a
> +       fast-forward, only update the branch pointer.  This is the
> +       default behavior.  This option is equivalent of '--ff' without
> +       any argument.
> +

Perhaps the sentence "This is the default behavior" should be at the
end, but I think as it is now is also good.

> +never::
> +       Generate a merge commit even if the merge resolved as a
> +       fast-forward.  This option is equivalent of '--no-ff'.
> +
> +only::
> +       Only allow a fast-forward.  The merge will fail unless HEAD is
> +       up to date or the merge resolved as a fast-forward.

I think s/merge resolved/merge resolves/, but I'm not native English
speaker.

> +
> +If your workflow is always to branch from the special branch
> +("master") when working on a topic and merge that back to "master", if
> +you happen to have worked only on a single topic and the "master" was
> +never advanced during the time you worked on that topic, merging the
> +topic back to "master" will result in a fast-forward.  When you look
> +back that history, you will not be able to tell where the topic
> +started and ended by following the ancestry chain of the "master"
> +branch.
> +
> +Using "never fast forward" policy on such a special branch will be a
> +way to make sure that all commits on the first-parent ancestry of that
> +special branch will be merges from something else.  From the history
> +you can determine where the topic started and ended.

The above two paragraphs are good explanation why one would want to
chose --ff=never, and when to use this fast-forward option.

Nevertheless the above description could be written better, and do not
use such long sentences.  Additionally perhaps the part about
--ff=never (or --no-ff) could have its own subsection header.

> +
> +The following shows two branches forked off from "master".  The branch
> +"master" have merged in changes from branch "topicA" twice and
> +"topicB" once:
> +
> +------------
> +         o---o---o---o---o  topicA
> +        /     \           \
> +    ---*-------*-------*---*  master
> +      /         \     /
> +                 o---o  topicB
> +------------
> +

Nice diagram.

> +The first merge of topicA or the only merge of topicB would have
> +resulted in a fast forward without '--ff=never'.  The last merge of
> +topicA would have failed with '--ff=only'.  Topic A consist of those
> +commits that can be reached from master^2 without passing through any
> +of the first-parent ancestries of master.
> +

here perhaps another subsection should be started, as the following
part delas with when to use --ff=only option.

> +However, if your workflow require a linear history for the special
> +branch ("master"), topic branches must be rebased before merging them
> +back to "master".  A pull or a merge from the "master branch of a
> +topic branch may accidentally introduce a merge commit that was not
> +already in the topic branch if the topic that were merged was not
> +properly rebased.  This will creating a none linear history.
> +
> +Using "only fast forward" policy ensures that whenever a pull or a
> +merge is performed it will fail unless the merge can be resolved as a
> +fast forward.  This will however not guarantee a linear history since
> +the topic branches that are merged in may have merge commits recorded.
> +You may therefor need to use this policy on the topic branches as
> +well.
> +

I'd mention here receive.denyNonFastForward option as a way to set
this globally for all branches, for public bare publishing
repositories; AFAIK for push and I think also for fetch.

I'm not sure if it is really needed.  As is is good enough.

> +"Only fast forward" policy on the "master" branch can be enforced by
> +setting the mergeoptions for that branch using git config:
> +
> +------------
> +% git config branch.master.mergeoptions --ff=only
> +------------

Isn't the above section generic, i.e. you can use above tip both to
force --ff=only (only fast forward for linear history), or --ff=never
(always mark merge/end of topic branch by merge commit)?


> diff --git a/t/t7601-merge-ff-options.sh b/t/t7601-merge-ff-options.sh

Very good!

-- 
Jakub Narebski
Poland
ShadeHawk on #git
