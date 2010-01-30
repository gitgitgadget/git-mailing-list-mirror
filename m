From: Ron Garret <ron1@flownet.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Sat, 30 Jan 2010 11:24:13 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-EBAD29.11241330012010@news.gmane.org>
References: <ron1-2E17EF.12204629012010@news.gmane.org> <op.u7a909hf4oyyg1@alvarezp-ws> <ron1-1F1799.13340029012010@news.gmane.org> <op.u7bfjni44oyyg1@alvarezp-ws> <ron1-0EE62E.14474929012010@news.gmane.org> <bd7fb2a884e55e176eea3002fd0c68dd@212.159.54.234> <ron1-A99355.16145629012010@news.gmane.org> <ron1-4F99DE.16184529012010@news.gmane.org> <7veil7pgb2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 30 20:25:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbIwT-00063N-Pa
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 20:25:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195Ab0A3TZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 14:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753173Ab0A3TZH
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 14:25:07 -0500
Received: from lo.gmane.org ([80.91.229.12]:54121 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752415Ab0A3TZG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 14:25:06 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NbIwK-0005xA-IA
	for git@vger.kernel.org; Sat, 30 Jan 2010 20:25:04 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 20:25:04 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 20:25:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138496>

In article <7veil7pgb2.fsf@alter.siamese.dyndns.org>,
 Junio C Hamano <gitster@pobox.com> wrote:

> Ron Garret <ron1@flownet.com> writes:
> 
> >> > > If I do a git reset --hard then I get the old version, but I lose my 
> >> > > HEAD pointer so that git diff doesn't give me what I want any more.
> 
> I think it would be helpful to point out one issue that may hurt you (and
> anybody who thinks "git update --tree" without --index is a good idea).
> 
> Keeping the index and HEAD in sync but matching the work tree files to
> that of a different commit has one major downside.  To git, a work tree
> file that does not exist in the index is a yet-to-be-added-untracked file
> (that is how and why "rm --cached file" works, for example).  It won't
> participate in the diff output (other than being treated as "no such file
> in the work tree version").
> 
> Suppose that you used to have a path in older revision, but not in the
> current revision.  You remove everything from the work tree and replace it
> with the files in the older revision, and you do not touch HEAD nor index.
> "git diff -R" appears to show "what changed since that older version and
> the latest", because it compares what is in the index relative to what is
> in the work tree.  Nice.
> 
> Not quite.  Since the index does not know that path you recently removed,
> you won't see that path.  If you run "git ls-files" for a list of files
> known to git, it wouldn't be shown either.
> 
> Your original "git checkout master^" is a valid and probably the optimal
> way to get a checkout of a older revision (which you could feed to your
> running Lisp interpreter, in addition to being able to run "less" and
> "make" on them).  Exactly because the index is updated to that of the
> older version, you won't lose the sight of the path that you removed in a
> later version, and you can review the change with "git diff -R master".
> 
> I think this is an XY problem that comes from your wanting to use "git
> diff" (compare work tree with index) instead of "git diff $commit", and
> that was because you wanted to use "HEAD" as a name of a commit.  If you
> used a branch name you originally came from, none of this desire to "keep
> index intact" or "keep HEAD intact" would have been necessary.

That's a very good point.

> But this is all tangent; I think you now know more about git to improve
> your IDE integration, without fighting with git but instead taking
> advantage of it.

I hope so :-)

Thanks to everyone who responded in this thread.  It's been very 
educational.  I am very impressed at how supportive this community is to 
a newcomer like me.

rg
