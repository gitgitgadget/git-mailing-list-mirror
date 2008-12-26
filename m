From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: a few scenarios before I create my first repo [Scanned]
Date: Fri, 26 Dec 2008 02:07:46 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngl8f3i.klo.sitaramc@sitaramc.homelinux.net>
References: <BB5F02FD3789B54E8964D38D6775E718242D00@ALTMORE-SVR.altmore.local>
 <7vabajrcfn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 26 03:09:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LG28f-0007me-Rb
	for gcvg-git-2@gmane.org; Fri, 26 Dec 2008 03:09:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752368AbYLZCH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Dec 2008 21:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752541AbYLZCH5
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Dec 2008 21:07:57 -0500
Received: from main.gmane.org ([80.91.229.2]:37789 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752232AbYLZCH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Dec 2008 21:07:57 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LG27F-0004xv-Fc
	for git@vger.kernel.org; Fri, 26 Dec 2008 02:07:53 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Dec 2008 02:07:53 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Dec 2008 02:07:53 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103919>

On 2008-12-26, Junio C Hamano <gitster@pobox.com> wrote:
> What's [scanned]?
>
> "Conor Rafferty" <conor.rafferty@altmore.co.uk> writes:

>> (3) if I create a repo and commit the first baseline, can I later create
>> an ancestor commit to that baseline, if I subsequently find an older
>> version of the project lying around on the file system (or, same concept
>> i guess, if i find a project version that sits between say version v1.0
>> and v1.1 (where v1.0 is the parent tag of v1.1) can i interleave the
>> project files as say v1.01.
>
> You can graft the older ones behind the root commit and filter-branch the
> result to cast the graft in stone.  You are strongly recommended to do
> that in one repository first, and have reasonable level of confidence in
> the result before you publish it to other repositories, as running
> filter-branch to rewrite the history after people (or yourself) cloned the
> history to multiple places would cause trouble to thoese .

Considering the level of questions that Conor had, I thought
the following may be useful:

The way git works is that each commit is represented by a
sha-1 hash, which is an immutable 160-bit number that
"represents" that commit.  The hash of the parent commit(s),
if any, as well as the contents of the current "tree" are
inputs to this hash, so if you create or change a parent,
the hash will change.

The sanctity of these hashes is fundamental to the
distributedness of git, so when you do something like that,
you're causing problems to any other repos which "pull"ed
from you, or which you "push"ed to -- they thought your
"latest" commit had, say, hash "A", but now hash "A" no
longer exists in your repo and has been replaced by hash
"B".

I have not (yet) had occasion to use either grafting or
filter-branch, but I'm pretty sure someone would have a nice
tutorial somewhere they can point to...
