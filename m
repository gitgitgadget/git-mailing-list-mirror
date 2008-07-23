From: Ingo Molnar <mingo@elte.hu>
Subject: Re: q: faster way to integrate/merge lots of topic branches?
Date: Wed, 23 Jul 2008 15:17:36 +0200
Message-ID: <20080723131736.GA9100@elte.hu>
References: <20080723130518.GA17462@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 15:18:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLeEw-0003Fh-CG
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 15:18:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752463AbYGWNRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 09:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752413AbYGWNRq
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 09:17:46 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:38487 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751704AbYGWNRq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 09:17:46 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1KLeDq-0007JA-GK
	from <mingo@elte.hu>
	for <git@vger.kernel.org>; Wed, 23 Jul 2008 15:17:44 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 2BD783E21AB; Wed, 23 Jul 2008 15:17:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080723130518.GA17462@elte.hu>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx2: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0092]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89647>


* Ingo Molnar <mingo@elte.hu> wrote:

> I have thought of using the last CommitDate of the topic branch and 
> compare it with the last CommitDate of the master branch [and i can 
> trust those values] - that would be a lot faster - but maybe i'm 
> missing something trivial that makes that approach unworkable. It 
> would also be nice to have a builtin shortcut for that instead of 
> having to go via "git-log --pretty=fuller" to dump the CommitDate 
> field.

hm, this method would be fragile if done purely within my integration 
script, as the timestamp of the head would have to be updated 
atomically, while always merging all the topic branches in one such 
transaction. (so that the timestamps do not get out of sync and a topic 
branch is not skipped by accident)

So i guess it's better to just create a separate .git/refs/merge-cache/ 
hierarchy with timestamps of last merged branches and their head sha1 
... but maybe i'm banging on open doors?

	Ingo
