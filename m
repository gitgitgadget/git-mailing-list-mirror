From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Newbie question regarding 3way merge order.
Date: Sat, 31 Jan 2009 00:32:57 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngo771p.b1i.sitaramc@sitaramc.homelinux.net>
References: <871vulda2r.fsf@gigli.quasi.internal>
 <slrngo6eat.s1d.sitaramc@sitaramc.homelinux.net>
 <87vdrwbofv.fsf@gigli.quasi.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 31 01:34:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LT3oi-0003M4-HI
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 01:34:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752811AbZAaAdM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 19:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752258AbZAaAdL
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 19:33:11 -0500
Received: from main.gmane.org ([80.91.229.2]:35118 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751023AbZAaAdK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 19:33:10 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LT3nI-0006HM-0r
	for git@vger.kernel.org; Sat, 31 Jan 2009 00:33:08 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 31 Jan 2009 00:33:08 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 31 Jan 2009 00:33:08 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107892>

On 2009-01-30, Raimund Berger <raimund.berger@gmail.com> wrote:

> E.g. with A, B and ancestor C, the merging and conflict resolution
> algorithm had to be completely symmetric if diff(A,C)+diff(B,C) applied
> to C should always be the same as diff(B,C)+diff(A,C) applied to C.

> So I'm really asking if that is a fact upon which I can rely.

I've always relied on it :-)  Or, to put it another way,
I've never come been bitten by this issue.

> An interesting hint. Up to now, I assumed that rebase would always
> perform implicit merging strategies. I mean what else would one expect

It does.

> in the above picture to happen when rebasing A on B? I'd assume it'd
> produce the same tree as a merge of A into B, by employing exactly the
> same machinery. E.g. fast forward of C to B, then merge A in. So that,
> effectively, the only difference between rebase and merge is just commit
> history but not (tree) content.

This is also true.  For example, "git help pull" offers an
option to use rebase instead of merge.

> From reading the rebase man page though it seems that merging machinery
> has to be explicitly requested via '-m'. Which makes me wonder how the
> default rebase actually works.

No.  I think the documentation is not sufficiently clear.
Everything else in "git help rebase" (look for the string
"strateg") tells me that the default, if you don't specify
anything at all, is the recursive merge strategy.  Since
"-s" implies "-m", I'm not sure what -- if anything -- is
achived by "-m" all by itself.

When I get some time I'm planning to look at the test
scripts and simulate them without "-m" to see what
differences there are; I'd assume a test script set up to
test the proper operation of rebase --merge should be using
a test case whose result differs if you dont use --merge!

> Mathematically speaking, if A1 and A2 commute with regard to a binary
> operation, A1 ... An do as well. So I'd still think the latter question
> boils down to the commutativity question above *iff* rebase actually
> does an implicit merge by default. Which I'm now led to question.

Rebase *does* do an implicit merge by default (as far as the
tree that results is concerned, which you mentioned right at
the start), I'm pretty sure of it.

Perhaps someone with more git smarts will chip in with
something more concrete.
