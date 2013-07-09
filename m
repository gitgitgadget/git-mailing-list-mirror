From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Feature request: "author branch" in commit object
Date: Tue, 9 Jul 2013 22:46:36 +0100
Organization: OPDS
Message-ID: <E66A4CB66EF64CE5A46851045BFB48FA@PhilipOakley>
References: <CADL+T9YGtvFrzStxJW64OJEV6H0BroMbkVCJdsDwWDaUWd91zQ@mail.gmail.com><vpqehbgrnrx.fsf@anie.imag.fr><CADL+T9Z=SrVyMMnYk3M7Dmb4c5xGiQtCTiDYaceKwB2-51TV-g@mail.gmail.com> <7vppuzfrde.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>,
	"Git List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Ed Hutchins" <eh@demeterr.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 23:46:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uwfjj-0007yd-LH
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 23:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753463Ab3GIVqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 17:46:12 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:15437 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752704Ab3GIVqK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jul 2013 17:46:10 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AuENAEuD3FFOl3AH/2dsb2JhbABbgwmJRbhDBAEDAYEaF3SCHgUBAQQBCAEBLh4BASELAgMFAgEDFQELJRQBBBoGBxcGAQkJCAIBAgMBCIdwCroPjwFqgxBrA4hthgyaJIMSOw
X-IPAS-Result: AuENAEuD3FFOl3AH/2dsb2JhbABbgwmJRbhDBAEDAYEaF3SCHgUBAQQBCAEBLh4BASELAgMFAgEDFQELJRQBBBoGBxcGAQkJCAIBAgMBCIdwCroPjwFqgxBrA4hthgyaJIMSOw
X-IronPort-AV: E=Sophos;i="4.87,1030,1363132800"; 
   d="scan'208";a="415635688"
Received: from host-78-151-112-7.as13285.net (HELO PhilipOakley) ([78.151.112.7])
  by out1.ip04ir2.opaltelecom.net with SMTP; 09 Jul 2013 22:46:07 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230009>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Wednesday, July 03, 2013 7:08 PM
[catching up on old emails]
> Ed Hutchins <eh@demeterr.com> writes:
>
>> I'm not trying to change the way git does things (which works
>> perfectly
>> well), I'm asking for some extra information to be added to the
>> commit
>> so that analysis of the ancestry graph can be tied to the branch
>> topics
>> that the original author was working from. Currently if you have a
>> rebase-branch/ff-merge-to-master workflow, the graph of commits looks
>> like a single user produced all of the code. It would be very useful
>> for
>> both forensic and display purposes to categorize those commits by
>> their
>> original topics, but that history is lost in such a workflow.
>
> I am not following that "a single user" part. As long as these
> topics are done by different people, the authorship remains
> separate, no matter what the shape of the graph is.
>
> It all depends on what you show on the graph other than a circle and
> connecting lines, but I presume at least you would show the subject
> line. The graph would clearly show which groups of commits tackle
> what problems in your history, even if you excessively linearlized
> it by rebasing. You need subjects / commit log messages that are
> better than "bugfix", of course, for it to work, though.
>
>> Arguing that branch names are local and thus meaningless misses
>> the point: branches are *names* which were meaningful to the
>> author at the time the branch was being worked on.
>
> That is not necessarily true.
>
> Most of my commits start their life on a single branch that is named
> after a very broad theme (or even on a detached HEAD) that ends up
> touching different parts of the system and then later split into
> separate topic branches that are named after more detailed single
> issues. The name of the branch that happened to have been used to
> create them have almost no meaning after I am done with multiple and
> independent (but related in the larger scheme of things) topics.
>
> It is not just misleading but is actively wrong to recording the
> name of the original branch in commits and carrying them forward via
> rebase. If you want a record of what a group of commits were about,
> the right time to do so is when you merge.

While the general arguments are true that in the main one shouldn't
embed whatever random branch name was used into the commit messages,
there are some workflows and some production (corporate) environments
where adding a relevant branch name is suitable for that environment.

If the existing branch name is poor then the user should do a rebase to
transfer it to a better branch name, and then the 'git filter-branch'
command would be the obvious method to add a "Developed-on: <branch>"
final 'signoff line'.

The 'git filter-branch' man page already includes an example for adding
an acked by, which can easily be modified.

--
If you need to add Acked-by lines to, say, the last 10 commits (none of
which is a merge), use this command:

git filter-branch --msg-filter '
        cat &&
        echo "Acked-by: Bugs Bunny <bunny@bugzilla.org>"
' HEAD~10..HEAD
--

I'll leave it to Ed to automate it as a script.... (and possibly making 
sure it's idempotent so only the final branch name is retained, etc.)

>
> Projects that care about the shape of the ancestry graph have an
> obvious option of not excessively/unnecessarily linearlizing their
> history. We even have the "--no-ff" mode of merge to create an
> otherwise unnecessary merge to mark the point where a topic is
> merged to the mainline, so that merge log messages can say what
> topic was merged (and also you can even have "merge.log").
>
> Cleaning up a messy history created on a topic branch before
> presenting to others by lineralizing is one thing. It is a good
> practice. Requiring any update to fast-forward on top of the tip of
> the project is quite different. It does not make your history any
> easier to read. A topic that has been working fine on top of last
> week's trunk can have a subtle interaction with the work done by
> others on the trunk since it forked, and rebasing it on top of
> today's trunk, just before pushing it out on the trunk, risks
> breaking the topic in a subtle way without the person who does such
> a rebase without noticing, making later bisection harder.
>
> Any option to encourage such an artificially linear history _is_
> actively detrimental.
> --

Philip
The boss may not always be right, but she is the boss. 
