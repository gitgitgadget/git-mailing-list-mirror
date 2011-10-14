From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: [BUG] git checkout <branch> allowed with uncommitted changes
Date: Fri, 14 Oct 2011 11:27:47 +0200
Message-ID: <4E980093.6040704@ira.uka.de>
References: <20111013145924.2113c142@ashu.dyn.rarus.ru> <loom.20111013T130924-792@post.gmane.org> <4E96D819.20905@op5.se> <loom.20111013T152144-60@post.gmane.org> <1318517194.4646.30.camel@centaur.lab.cmartin.tk> <loom.20111013T171530-970@post.gmane.org> <1318525486.4646.53.camel@centaur.lab.cmartin.tk> <loom.20111013T193054-868@post.gmane.org> <7vzkh44ug1.fsf@alter.siamese.dyndns.org> <loom.20111013T203610-130@post.gmane.org> <20111014013830.GA7258@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: arQon <arqon@gmx.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 14 11:27:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REe3N-0003yL-FI
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 11:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205Ab1JNJ1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 05:27:35 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:49032 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932152Ab1JNJ1e (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Oct 2011 05:27:34 -0400
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1REe2w-0004rW-MQ; Fri, 14 Oct 2011 11:27:28 +0200
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 25 
	id 1REe2w-0006h7-Fw; Fri, 14 Oct 2011 11:27:18 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.22) Gecko/20110907 SUSE/3.1.14 Thunderbird/3.1.14
In-Reply-To: <20111014013830.GA7258@sigill.intra.peff.net>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1318584448.289211000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183559>

On 14.10.2011 03:38, Jeff King wrote:
> On Thu, Oct 13, 2011 at 06:56:14PM +0000, arQon wrote:
>
>> I'll give a shot, though I don't know how good it'll be. Off the top of my
>> head, I don't see any good way to explain the inconsistency with LOCAL CHANGES
>> sometimes preventing switches and sometimes not, based on what is to the user
>> an arbitrary set of rules that has nothing to do with the *current state* of
>> the worktree, but rather the state of those files in prior commits.
>
> The rules are fairly straightforward.

They are. But what arQon is getting at is that the normal switchability 
depends on something that is often a game of chance: Did I change a file 
that is different between the two branches? That is only known by the 
user for branches not far removed.

Now the obvious answer is: It doesn't matter because git tells you. At 
the right time to act upon it. But git says "M file" instead of what 
'git status' would say: "#  modified:   file". Is there a reason for 
that? On one hand it should be familiar to svn users, on the other hand 
it is an inconsistency. And personally I always hated those cryptic 
status flags of svn

Another good point arQon made is that the case that you switched with 
forgotten local changes is more common than the case that you switched 
because you made changes in the wrong branch. If that were the case the 
warning that you have local changes should be more visible than that 
small "M file", at best something that looks similar to 'git status' output.

Now what really is more common depends on the individual. If you are a 
beginner or a semi-frequent user, then forgetting local changes is 
probably far more common, wheras most people on this mailing list would 
say its the other way round. It much depends on your commit frequency 
because the more often you commit, the less likely is that you would 
forget local changes.
